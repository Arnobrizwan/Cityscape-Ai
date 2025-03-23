import torch
import os
import geopandas as gpd
import networkx as nx
from train_rl_model import DQN, TrafficEnvironment

# ✅ Load road network (same as in training)
road_path = "ML/Roads/kuala_lumpur_roads.geojson"
roads_gdf = gpd.read_file(road_path).to_crs(epsg=3857)

G = nx.Graph()
for _, row in roads_gdf.iterrows():
    if hasattr(row.geometry, 'coords'):
        coords = list(row.geometry.coords)
        for i in range(len(coords) - 1):
            u, v = coords[i], coords[i + 1]
            G.add_edge(u, v, weight=row.get("length", 1))

# ✅ Setup device
device = torch.device("cuda" if torch.cuda.is_available() else "cpu")

# ✅ Load trained model
model_path = "ML/traffic_rl_model.pth"
env = TrafficEnvironment(G)
state_dim = env.state_dim()
action_dim = env.action_space()

model = DQN(state_dim, action_dim).to(device)
model.load_state_dict(torch.load(model_path, map_location=device))
model.eval()


# ✅ Run one test episode
state = env.reset()
done = False
total_reward = 0

print("🚦 Running test episode...\n")
for step in range(50):  # you can also set a max step count
    state_tensor = torch.tensor(state, dtype=torch.float32).unsqueeze(0).to(device)
    with torch.no_grad():
        action = model(state_tensor).argmax().item()
    next_state, reward, done = env.step(action)
    total_reward += reward
    state = next_state

print(f"✅ Test episode completed. Total Reward: {total_reward:.2f}")
