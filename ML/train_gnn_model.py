import os
import torch
import networkx as nx
import geopandas as gpd
from torch_geometric.data import Data
from torch_geometric.nn import GCNConv
import torch.nn.functional as F
import warnings

# Suppress specific pyogrio warnings
warnings.filterwarnings("ignore", message="driver GeoJSON does not support open option DTYPE")
warnings.filterwarnings("ignore", message="unsupported OGR type")

# ✅ Load Extracted Data from ML Directory
ml_folder_path = "ML/"  # Ensure this matches your directory
checkpoint_folder = os.path.join(ml_folder_path, "checkpoints")
os.makedirs(checkpoint_folder, exist_ok=True)  # Create folder if not exists

# ✅ Initialize Graph
G = nx.Graph()

# ✅ Load Road Network
roads_path = os.path.join(ml_folder_path, "Roads/kuala_lumpur_roads.geojson")

try:
    roads_gdf = gpd.read_file(roads_path)
    if roads_gdf.crs is None or roads_gdf.crs.is_geographic:
        roads_gdf = roads_gdf.to_crs(epsg=3857)

    for _, row in roads_gdf.iterrows():
        if hasattr(row.geometry, 'coords'):
            coords = list(row.geometry.coords)
            for i in range(len(coords) - 1):
                G.add_edge(coords[i], coords[i + 1], weight=row.get("length", 1))

    print(f"✅ Successfully loaded road network with {len(G.edges)} edges")

except Exception as e:
    print(f"❌ Error loading road network: {e}")
    G = nx.Graph()  

# ✅ Load Features from GeoJSON Files
feature_files = {
    "landuse": "Landuse/kuala_lumpur_landuse.geojson",
    "buildings": "Buildings/kuala_lumpur_buildings.geojson",
    "railways": "Transport/kuala_lumpur_railways.geojson",
    "parking": "Transport/kuala_lumpur_parking.geojson",
    "bicycle_paths": "Transport/kuala_lumpur_bicycle_paths.geojson",
    "bus_stops": "Transport/kuala_lumpur_bus_stops.geojson",
    "train_stations": "Transport/kuala_lumpur_train_stations.geojson",
    "public_transport": "Transport/kuala_lumpur_public_transport.geojson",
    "emergency": "Utilities/kuala_lumpur_emergency.geojson",
    "streetlights": "Utilities/kuala_lumpur_streetlights.geojson",
    "pois": "Utilities/kuala_lumpur_pois.geojson",
    "healthcare": "Utilities/kuala_lumpur_healthcare.geojson",
    "waste": "Utilities/kuala_lumpur_waste.geojson",
    "power": "Utilities/kuala_lumpur_power.geojson",
    "water": "Environment/kuala_lumpur_water.geojson",
    "environment": "Environment/kuala_lumpur_environment.geojson",
    "flood_zones": "Environment/kuala_lumpur_flood_zones.geojson",
    "road_traffic": "Roads/kuala_lumpur_road_traffic.geojson",
}

# ✅ Map Features to Nodes
def map_features_to_nodes(G, file_path):
    try:
        gdf = gpd.read_file(file_path)
        if gdf.crs is None or gdf.crs.is_geographic:
            gdf = gdf.to_crs(epsg=3857)

        feature_set = set()
        for geom in gdf.geometry:
            if geom and hasattr(geom, 'centroid'):
                point = geom.centroid
                feature_set.add((point.x, point.y))

        return feature_set
    except Exception as e:
        print(f"⚠️ Warning: Failed to process {file_path}: {e}")
        return set()

# ✅ Assign Node Features
node_features = []
for node in G.nodes:
    x, y = node
    node_feature_vector = [(x, y) in map_features_to_nodes(G, os.path.join(ml_folder_path, path)) for path in feature_files.values()]
    node_features.append(node_feature_vector)

print(f"✅ Completed feature mapping for {len(G.nodes)} nodes")

if len(G.nodes) == 0:
    print("❌ Error: Graph has no nodes. Cannot proceed with training.")
    exit(1)

# ✅ Convert Data to PyTorch Geometric Format
edge_index = torch.tensor(list(G.edges), dtype=torch.long).t().contiguous()
x = torch.tensor(node_features, dtype=torch.float)

print(f"📊 Graph stats: {len(G.nodes)} nodes, {len(G.edges)} edges, {x.shape[1]} features per node")

# ✅ Create Graph Data Object
graph_data = Data(x=x, edge_index=edge_index)
print(f"📊 Graph Data Loaded: {graph_data}")

# ✅ Define Graph Neural Network (GNN)
class GNNModel(torch.nn.Module):
    def __init__(self, in_features, hidden_dim, out_features):
        super(GNNModel, self).__init__()
        self.conv1 = GCNConv(in_features, hidden_dim)
        self.conv2 = GCNConv(hidden_dim, out_features)

    def forward(self, data):
        x, edge_index = data.x, data.edge_index
        x = F.relu(self.conv1(x, edge_index))
        x = self.conv2(x, edge_index)
        return x

# ✅ Use Apple MPS if available
device = torch.device("mps" if torch.backends.mps.is_available() else "cpu")
print(f"🖥️ Using device: {device}")

# ✅ Initialize Model & Optimizer
model = GNNModel(in_features=x.shape[1], hidden_dim=64, out_features=1).to(device)
optimizer = torch.optim.Adam(model.parameters(), lr=0.01)

# ✅ Dummy Target Data
target = torch.rand(len(G.nodes), 1).to(device)

# ✅ Move Data to Device
graph_data = graph_data.to(device)

# ✅ Resume Training from Checkpoint if Available
latest_checkpoint = max(
    [os.path.join(checkpoint_folder, f) for f in os.listdir(checkpoint_folder) if f.startswith("checkpoint_")],
    default=None,
    key=os.path.getctime,
)

start_epoch = 0
if latest_checkpoint:
    print(f"🔄 Resuming training from {latest_checkpoint}")
    model.load_state_dict(torch.load(latest_checkpoint))
    start_epoch = int(latest_checkpoint.split("_")[-1].split(".")[0]) + 1

# ✅ Train GNN Model (20 Epochs for Faster Training)
print("🚀 Training Graph Neural Network (GNN)...")
for epoch in range(start_epoch, 20):  # Reduced from 100 to 20
    model.train()
    optimizer.zero_grad()
    out = model(graph_data)
    loss = F.mse_loss(out, target)
    loss.backward()
    optimizer.step()

    # ✅ Save checkpoint every 5 epochs
    if epoch % 5 == 0:
        checkpoint_path = os.path.join(checkpoint_folder, f"checkpoint_{epoch}.pth")
        torch.save(model.state_dict(), checkpoint_path)
        print(f"📌 Checkpoint saved at Epoch {epoch}")

    if epoch % 2 == 0:  # Print loss every 2 epochs
        print(f"✅ Epoch {epoch}: Loss = {loss.item():.4f}")

# ✅ Save the Final Model
model_save_path = os.path.join(ml_folder_path, "trained_gnn_model.pth")
torch.save(model.state_dict(), model_save_path)
print(f"🎉 GNN Model Training Complete & Saved to {model_save_path}!")