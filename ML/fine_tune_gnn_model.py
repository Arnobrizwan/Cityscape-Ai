import os
import torch
import networkx as nx
import geopandas as gpd
from torch_geometric.data import Data
from torch_geometric.nn import GCNConv
import torch.nn.functional as F

# ✅ Device config
device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
print(f"🖥️ Using device: {device}")

# ✅ Paths
ml_folder_path = "ML"
checkpoint_folder = os.path.join(ml_folder_path, "checkpoints")
roads_path = os.path.join(ml_folder_path, "Roads/kuala_lumpur_roads.geojson")

# ✅ Build Graph
G = nx.Graph()
roads_gdf = gpd.read_file(roads_path).to_crs(epsg=3857)
for _, row in roads_gdf.iterrows():
    if hasattr(row.geometry, 'coords'):
        coords = list(row.geometry.coords)
        for i in range(len(coords) - 1):
            G.add_edge(coords[i], coords[i + 1], weight=row.get("length", 1))

# ✅ Feature mapping (based on existing files)
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
def map_features_to_nodes(file_path):
    try:
        gdf = gpd.read_file(os.path.join(ml_folder_path, file_path)).to_crs(epsg=3857)
        return {(geom.centroid.x, geom.centroid.y) for geom in gdf.geometry if geom}
    except:
        return set()

preloaded_features = {k: map_features_to_nodes(v) for k, v in feature_files.items()}
node_features = [[int((x, y) in preloaded_features[feature]) for feature in feature_files] for x, y in G.nodes]

# ✅ Prepare PyTorch Geometric Data
node_mapping = {node: idx for idx, node in enumerate(G.nodes)}
mapped_edges = [(node_mapping[u], node_mapping[v]) for u, v in G.edges]
edge_index = torch.tensor(mapped_edges, dtype=torch.long).T.contiguous().to(device)
x = torch.tensor(node_features, dtype=torch.float).to(device)
graph_data = Data(x=x, edge_index=edge_index).to(device)

# ✅ Define GNN again
class GNNModel(torch.nn.Module):
    def __init__(self, in_features, hidden_dim, out_features):
        super(GNNModel, self).__init__()
        self.conv1 = GCNConv(in_features, hidden_dim)
        self.conv2 = GCNConv(hidden_dim, out_features)

    def forward(self, data):
        x, edge_index = data.x, data.edge_index
        return self.conv2(F.relu(self.conv1(x, edge_index)), edge_index)

# ✅ Load latest checkpoint
model = GNNModel(in_features=x.shape[1], hidden_dim=64, out_features=1).to(device)
checkpoint_files = [f for f in os.listdir(checkpoint_folder) if f.startswith("checkpoint_")]
if checkpoint_files:
    latest = max(checkpoint_files, key=lambda f: int(f.split("_")[-1].split(".")[0]))
    model.load_state_dict(torch.load(os.path.join(checkpoint_folder, latest)))
    print(f"🔄 Fine-tuning from checkpoint: {latest}")
else:
    print("⚠️ No previous checkpoint found. Please train first.")
    exit()

optimizer = torch.optim.Adam(model.parameters(), lr=0.005)

# ✅ Fine-tune for 20 epochs
for epoch in range(1, 21):
    model.train()
    optimizer.zero_grad()
    loss = F.mse_loss(model(graph_data), torch.rand(len(G.nodes), 1).to(device))
    loss.backward()
    optimizer.step()
    print(f"✅ Fine-tune Epoch {epoch}: Loss = {loss.item():.4f}")

# ✅ Save final fine-tuned weights
torch.save(model.state_dict(), os.path.join(ml_folder_path, "trained_gnn_model.pth"))
print("✅ Fine-tuned model saved!")

# ✅ Save new predictions
model.eval()
with torch.no_grad():
    predictions = model(graph_data)
    torch.save(predictions, os.path.join(ml_folder_path, "gnn_predictions.pt"))
    print("📦 Updated predictions saved to ML/gnn_predictions.pt")
