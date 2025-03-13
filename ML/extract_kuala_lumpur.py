import osmnx as ox
import geopandas as gpd
import time
import logging

# Configure logging
logging.basicConfig(level=logging.INFO, format="%(asctime)s - %(levelname)s - %(message)s")

# Define the city to extract data
city_name = "Kuala Lumpur, Malaysia"

# Define output folder
output_folder = "ML/"

# Function to safely extract data
def extract_and_save(tag, filename):
    try:
        print(f"🔍 Extracting {tag} data...")
        data = ox.features_from_place(city_name, tags=tag)
        data.to_file(f"{output_folder}{filename}", driver="GeoJSON")
        print(f"✅ {tag} data saved: {output_folder}{filename}\n")
    except Exception as e:
        logging.error(f"❌ Failed to extract {tag} data: {e}")

    # Sleep to prevent rate limiting
    time.sleep(2)

### ✅ Step 1: Extract Road Network
print("🚀 Extracting road network...")
road_graph = ox.graph_from_place(city_name, network_type="drive")
nodes, edges = ox.graph_to_gdfs(road_graph)
edges.to_file(f"{output_folder}kuala_lumpur_roads.geojson", driver="GeoJSON")
print(f"✅ Road network saved: {output_folder}kuala_lumpur_roads.geojson\n")
time.sleep(2)

### ✅ Step 2-18: Extract Other Features
extract_and_save({"building": True}, "kuala_lumpur_buildings.geojson")
extract_and_save({"landuse": True}, "kuala_lumpur_landuse.geojson")
extract_and_save({"amenity": True}, "kuala_lumpur_pois.geojson")
extract_and_save({"highway": ["bus_stop", "traffic_signals", "crossing"]}, "kuala_lumpur_traffic.geojson")
extract_and_save({"leisure": "park", "natural": True}, "kuala_lumpur_environment.geojson")
extract_and_save({"waterway": True, "natural": "water"}, "kuala_lumpur_water.geojson")
extract_and_save({"railway": True}, "kuala_lumpur_railways.geojson")
extract_and_save({"power": True}, "kuala_lumpur_power.geojson")
extract_and_save({"amenity": ["hospital", "clinic", "pharmacy"]}, "kuala_lumpur_healthcare.geojson")
extract_and_save({"amenity": ["fire_station", "police"]}, "kuala_lumpur_emergency.geojson")
extract_and_save({"amenity": "parking"}, "kuala_lumpur_parking.geojson")
extract_and_save({"amenity": ["recycling", "waste_disposal"]}, "kuala_lumpur_waste.geojson")
extract_and_save({"public_transport": True}, "kuala_lumpur_public_transport.geojson")
extract_and_save({"highway": "bus_stop"}, "kuala_lumpur_bus_stops.geojson")
extract_and_save({"railway": ["station", "subway_entrance"]}, "kuala_lumpur_train_stations.geojson")
extract_and_save({"highway": ["cycleway", "footway"]}, "kuala_lumpur_bicycle_paths.geojson")
extract_and_save({"highway": "street_lamp"}, "kuala_lumpur_streetlights.geojson")
extract_and_save({"flood_prone": "yes", "ele": True}, "kuala_lumpur_flood_zones.geojson")


print("\n🎉 All urban data for Kuala Lumpur extracted successfully!")
