import osmnx as ox
import geopandas as gpd
import time
import logging
import os

# Configure logging
logging.basicConfig(level=logging.INFO, format="%(asctime)s - %(levelname)s - %(message)s")

# Define the city to extract data
city_name = "Kuala Lumpur, Malaysia"

# Define output folder
output_folder = "ML/"

# Create subfolders for better organization
subfolders = ["Roads", "Buildings", "Landuse", "Transport", "Utilities", "Environment"]
for folder in subfolders:
    os.makedirs(os.path.join(output_folder, folder), exist_ok=True)

# Function to safely extract data
def extract_and_save(tag, filename, category="General"):
    try:
        print(f"🔍 Extracting {tag} data...")
        data = ox.features_from_place(city_name, tags=tag)
        file_path = os.path.join(output_folder, category, filename)
        data.to_file(file_path, driver="GeoJSON")
        print(f"✅ {tag} data saved: {file_path}\n")
    except Exception as e:
        logging.error(f"❌ Failed to extract {tag} data: {e}")

    # Sleep to prevent rate limiting
    time.sleep(5)

### ✅ Step 1: Extract Road Network (Roads)
print("🚀 Extracting road network...")
road_graph = ox.graph_from_place(city_name, network_type="drive")
nodes, edges = ox.graph_to_gdfs(road_graph)
road_file = os.path.join(output_folder, "Roads", "kuala_lumpur_roads.geojson")
edges.to_file(road_file, driver="GeoJSON")
print(f"✅ Road network saved: {road_file}\n")
time.sleep(5)

### ✅ Step 2: Extract Road-Based Traffic Data (Fix for traffic issue)
print("🚀 Extracting traffic-related data (Speed limits, lanes)...")
traffic_data = ox.features_from_place(city_name, tags={"highway": True, "maxspeed": True, "lanes": True})
traffic_file = os.path.join(output_folder, "Roads", "kuala_lumpur_road_traffic.geojson")
traffic_data.to_file(traffic_file, driver="GeoJSON")
print(f"✅ Traffic data saved: {traffic_file}\n")
time.sleep(5)

### ✅ Step 3-18: Extract Other Features
extract_and_save({"building": True}, "kuala_lumpur_buildings.geojson", "Buildings")
extract_and_save({"landuse": True}, "kuala_lumpur_landuse.geojson", "Landuse")
extract_and_save({"amenity": True}, "kuala_lumpur_pois.geojson", "Utilities")
extract_and_save({"leisure": "park", "natural": True}, "kuala_lumpur_environment.geojson", "Environment")
extract_and_save({"waterway": True, "natural": "water"}, "kuala_lumpur_water.geojson", "Environment")
extract_and_save({"railway": True}, "kuala_lumpur_railways.geojson", "Transport")
extract_and_save({"power": True}, "kuala_lumpur_power.geojson", "Utilities")
extract_and_save({"amenity": ["hospital", "clinic", "pharmacy"]}, "kuala_lumpur_healthcare.geojson", "Utilities")
extract_and_save({"amenity": ["fire_station", "police"]}, "kuala_lumpur_emergency.geojson", "Utilities")
extract_and_save({"amenity": "parking"}, "kuala_lumpur_parking.geojson", "Transport")
extract_and_save({"amenity": ["recycling", "waste_disposal"]}, "kuala_lumpur_waste.geojson", "Utilities")
extract_and_save({"public_transport": True}, "kuala_lumpur_public_transport.geojson", "Transport")
extract_and_save({"highway": "bus_stop"}, "kuala_lumpur_bus_stops.geojson", "Transport")
extract_and_save({"railway": ["station", "subway_entrance"]}, "kuala_lumpur_train_stations.geojson", "Transport")
extract_and_save({"highway": ["cycleway", "footway"]}, "kuala_lumpur_bicycle_paths.geojson", "Transport")
extract_and_save({"highway": "street_lamp"}, "kuala_lumpur_streetlights.geojson", "Utilities")
extract_and_save({"flood_prone": "yes", "ele": True}, "kuala_lumpur_flood_zones.geojson", "Environment")

print("\n🎉 All urban data for Kuala Lumpur extracted successfully!")