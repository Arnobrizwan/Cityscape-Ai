import os
import torch
import random
import numpy as np
import networkx as nx
import torch.nn as nn
import torch.nn.functional as F
from collections import deque
import geopandas as gpd

# ✅ Road network
road_path = "ML/Roads/kuala_lumpur_roads.geojson"
roads_gdf = gpd.read_file(road_path).to_crs(epsg=3857)
G = nx.Graph()
for _, row in roads_gdf.iterrows():
    if hasattr(row.geometry, 'coords'):
        coords = list(row.geometry.coords)
        for i in range(len(coords) - 1):
            G.add_edge(coords[i], coords[i + 1], weight=row.get("length", 1))

# ✅ Environment
class TrafficEnvironment:
    def __init__(self, G):
        self.G = G
        self.reset()

    def reset(self):
        self.traffic = {edge: random.randint(1, 10) for edge in self.G.edges}
        self.state = np.array(list(self.traffic.values()), dtype=np.float32)
        return self.state

    def step(self, action):
        edge = list(self.G.edges)[action]
        self.traffic[edge] = max(1, self.traffic[edge] - random.randint(1, 3))
        reward = -sum(self.traffic.values())
        next_state = np.array(list(self.traffic.values()), dtype=np.float32)
        return next_state, reward, False

    def action_space(self):
        return len(self.G.edges)

    def state_dim(self):
        return len(self.G.edges)

# ✅ DQN model
class DQN(nn.Module):
    def __init__(self, input_dim, output_dim):
        super(DQN, self).__init__()
        self.fc1 = nn.Linear(input_dim, 128)
        self.fc2 = nn.Linear(128, 64)
        self.out = nn.Linear(64, output_dim)

    def forward(self, x):
        x = F.relu(self.fc1(x))
        x = F.relu(self.fc2(x))
        return self.out(x)

# ✅ Fine-tuning logic
def fine_tune_rl():
    env = TrafficEnvironment(G)
    model = DQN(env.state_dim(), env.action_space()).cuda()
    checkpoint_path = "ML/traffic_rl_model.pth"

    if os.path.exists(checkpoint_path):
        model.load_state_dict(torch.load(checkpoint_path))
        print("🔄 Loaded existing RL model for fine-tuning.")
    else:
        print("❌ No existing RL model found. Run initial training first.")
        return

    optimizer = torch.optim.Adam(model.parameters(), lr=0.0005)
    memory = deque(maxlen=10000)
    gamma = 0.99
    epsilon = 0.2
    epsilon_min = 0.05
    epsilon_decay = 0.99
    batch_size = 64

    for episode in range(20):
        state = torch.tensor(env.reset(), dtype=torch.float32).cuda()
        total_reward = 0

        for step in range(50):
            if random.random() < epsilon:
                action = random.randint(0, env.action_space() - 1)
            else:
                with torch.no_grad():
                    action = torch.argmax(model(state)).item()

            next_state_np, reward, done = env.step(action)
            next_state = torch.tensor(next_state_np, dtype=torch.float32).cuda()
            memory.append((state, action, reward, next_state))
            state = next_state
            total_reward += reward

            if len(memory) >= batch_size:
                batch = random.sample(memory, batch_size)
                states, actions, rewards, next_states = zip(*batch)

                states = torch.stack(states)
                actions = torch.tensor(actions, dtype=torch.int64).cuda()
                rewards = torch.tensor(rewards, dtype=torch.float32).cuda()
                next_states = torch.stack(next_states)

                q_values = model(states).gather(1, actions.unsqueeze(1)).squeeze()
                next_q_values = model(next_states).max(1)[0]
                targets = rewards + gamma * next_q_values

                loss = F.mse_loss(q_values, targets.detach())
                optimizer.zero_grad()
                loss.backward()
                optimizer.step()

        epsilon = max(epsilon_min, epsilon * epsilon_decay)
        print(f"✅ Fine-Tune Episode {episode}: Reward = {total_reward:.2f}, Epsilon = {epsilon:.2f}")

    # ✅ Save model
    torch.save(model.state_dict(), "ML/traffic_rl_model.pth")
    print("📦 Fine-tuned RL model saved to ML/traffic_rl_model.pth")

    # ✅ Save RL predictions (based on a final state)
    model.eval()
    with torch.no_grad():
        final_state = torch.tensor(env.reset(), dtype=torch.float32).cuda()
        predicted_q_values = model(final_state)
        best_action = torch.argmax(predicted_q_values).item()
        torch.save({
            "q_values": predicted_q_values.cpu(),
            "recommended_action": best_action,
            "edge": list(G.edges)[best_action]
        }, "ML/rl_predictions.pt")
        print("📈 RL predictions saved to ML/rl_predictions.pt")

if __name__ == "__main__":
    fine_tune_rl()
