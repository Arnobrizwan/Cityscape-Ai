import os
import torch
from torch_geometric.data import Data
from train_gnn_model import GNNModel, device  # Import model & device

# ✅ Load Trained Model
ml_folder_path = "ML/"
model_path = os.path.join(ml_folder_path, "trained_gnn_model.pth")

if not os.path.exists(model_path):
    raise FileNotFoundError(f"❌ Model file not found: {model_path}")

model = GNNModel(in_features=18, hidden_dim=64, out_features=1).to(device)
model.load_state_dict(torch.load(model_path, map_location=device))
model.eval()

# ✅ Generate Dummy Graph Data (for testing)
num_nodes = 100  # Change based on actual dataset
num_features = 18  # Ensure this matches training
x = torch.rand(num_nodes, num_features).to(device)  # Random test features
edge_index = torch.randint(0, num_nodes, (2, num_nodes * 2)).to(device)  # Random edges

test_graph_data = Data(x=x, edge_index=edge_index).to(device)

# ✅ Make Predictions
with torch.no_grad():
    predictions = model(test_graph_data)
    print(f"✅ Model Output Shape: {predictions.shape}")
    print(f"📊 First 5 Predictions:\n{predictions[:5]}")
