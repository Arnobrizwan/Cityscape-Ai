import os
import torch
import networkx as nx
import geopandas as gpd
from torch_geometric.data import Data
from torch_geometric.nn import GCNConv
import torch.nn.functional as F
import warnings

# ✅ Enable CUDA for Windows (RTX), MPS for Mac, CPU fallback
device = torch.device("cuda" if torch.cuda.is_available() else "mps" if torch.backends.mps.is_available() else "cpu")
print(f"🖥️ Using device: {device}")

# ✅ Load Extracted Data from ML Directory
ml_folder_path = "ML/"
checkpoint_folder = os.path.join(ml_folder_path, "checkpoints")
os.makedirs(checkpoint_folder, exist_ok=True)

# ✅ Initialize Graph
G = nx.Graph()

# ✅ Load Road Network
roads_path = os.path.join(ml_folder_path, "Roads/kuala_lumpur_roads.geojson")
try:
    roads_gdf = gpd.read_file(roads_path).to_crs(epsg=3857)
    for _, row in roads_gdf.iterrows():
        if hasattr(row.geometry, 'coords'):
            coords = list(row.geometry.coords)
            for i in range(len(coords) - 1):
                G.add_edge(coords[i], coords[i + 1], weight=row.get("length", 1))
    print(f"✅ Successfully loaded road network with {len(G.edges)} edges")
except Exception as e:
    print(f"❌ Error loading road network: {e}")
    G = nx.Graph()

# ✅ Define All 18 Features
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

# ✅ Load Features Once for Better Performance
def map_features_to_nodes(G, file_path):
    try:
        gdf = gpd.read_file(file_path).to_crs(epsg=3857)
        return {(geom.centroid.x, geom.centroid.y) for geom in gdf.geometry if geom}
    except Exception as e:
        print(f"⚠️ Warning: Failed to process {file_path}: {e}")
        return set()

preloaded_features = {key: map_features_to_nodes(G, os.path.join(ml_folder_path, path)) for key, path in feature_files.items()}

# ✅ Assign Node Features
node_features = [[int((x, y) in preloaded_features[feature]) for feature in feature_files] for x, y in G.nodes]

print(f"✅ Completed feature mapping for {len(G.nodes)} nodes")
if len(G.nodes) == 0:
    print("❌ Error: Graph has no nodes. Exiting...")
    exit(1)

# ✅ Convert to PyTorch Geometric Format
# ✅ Ensure edge indices are valid
node_mapping = {node: idx for idx, node in enumerate(G.nodes)}
mapped_edges = [(node_mapping[u], node_mapping[v]) for u, v in G.edges]

# ✅ Convert to PyTorch tensor
edge_index = torch.tensor(mapped_edges, dtype=torch.long).T.contiguous().to(device)

# ✅ Ensure edges are within valid range
if not all(0 <= u < len(G.nodes) and 0 <= v < len(G.nodes) for u, v in mapped_edges):
    raise ValueError("❌ Error: Edge indices out of valid range.")

x = torch.tensor(node_features, dtype=torch.float).to(device)
graph_data = Data(x=x, edge_index=edge_index).to(device)

# ✅ Define GNN Model
class GNNModel(torch.nn.Module):
    def __init__(self, in_features, hidden_dim, out_features):
        super(GNNModel, self).__init__()
        self.conv1 = GCNConv(in_features, hidden_dim)
        self.conv2 = GCNConv(hidden_dim, out_features)

    def forward(self, data):
        x, edge_index = data.x, data.edge_index
        return self.conv2(F.relu(self.conv1(x, edge_index)), edge_index)

# ✅ Load Checkpoints
checkpoint_files = [f for f in os.listdir(checkpoint_folder) if f.startswith("checkpoint_")]
latest_checkpoint = max(checkpoint_files, key=lambda x: int(x.split("_")[-1].split(".")[0]), default=None) if checkpoint_files else None
model = GNNModel(in_features=x.shape[1], hidden_dim=64, out_features=1).to(device)
optimizer = torch.optim.Adam(model.parameters(), lr=0.01)

if latest_checkpoint:
    model.load_state_dict(torch.load(os.path.join(checkpoint_folder, latest_checkpoint)))
    start_epoch = int(latest_checkpoint.split("_")[-1].split(".")[0]) + 1
else:
    start_epoch = 0

# ✅ Train Model for 100 Epochs (Full Training)
for epoch in range(start_epoch, 100):
    model.train()
    optimizer.zero_grad()
    loss = F.mse_loss(model(graph_data), torch.rand(len(G.nodes), 1).to(device))
    loss.backward()
    optimizer.step()
    
    # ✅ Save Checkpoints Every 5 Epochs
    if epoch % 5 == 0:
        checkpoint_path = os.path.join(checkpoint_folder, f"checkpoint_{epoch}.pth")
        torch.save(model.state_dict(), checkpoint_path)
        print(f"📌 Epoch {epoch}: Loss = {loss.item():.4f} | Checkpoint saved.")

# ✅ Save Final Model
torch.save(model.state_dict(), os.path.join(ml_folder_path, "trained_gnn_model.pth"))
print("🎉 Training Complete & Model Saved!")

# ✅ GPU Memory Usage Check (Run after training)
print(f"📊 Final GPU Memory Usage: {torch.cuda.memory_allocated() / 1024**2:.2f} MB")
