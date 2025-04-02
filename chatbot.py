import os
import torch
import dotenv
import google.generativeai as genai
from sentence_transformers import SentenceTransformer
from sklearn.metrics.pairwise import cosine_similarity
import logging

# Configure logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

# ✅ Load environment variables
dotenv.load_dotenv()
GEMINI_API_KEY = os.getenv("GOOGLE_API_KEY")
if not GEMINI_API_KEY:
    raise ValueError("❌ Gemini_API_KEY not found in .env file!")

# ✅ Configure Gemini API
genai.configure(api_key=GEMINI_API_KEY)

# ✅ Load GNN predictions (NEW - added safely)
gnn_predictions_path = "ML/gnn_predictions.pt"
gnn_prediction_text = ""

if os.path.exists(gnn_predictions_path):
    gnn_tensor = torch.load(gnn_predictions_path, map_location="cpu")
    predictions = gnn_tensor.squeeze().tolist()
    top_indices = sorted(range(len(predictions)), key=lambda i: predictions[i], reverse=True)[:5]
    gnn_prediction_text = "\nTop 5 predicted high-risk nodes by GNN model:\n" + \
        "\n".join([f"• Node {i} → Risk Score: {predictions[i]:.3f}" for i in top_indices])
    logging.info("✅ GNN predictions loaded and added to context.")
else:
    logging.warning("⚠️ GNN predictions not found, skipping GNN insight injection.")

# ✅ Load RL predictions (NEW - safely injected)
rl_predictions_path = "ML/rl_predictions.pt"
rl_prediction_text = ""

if os.path.exists(rl_predictions_path):
    try:
        rl_data = torch.load(rl_predictions_path, map_location="cpu")
        edge = rl_data.get("edge", ("N/A", "N/A"))
        q_val = rl_data["q_values"][rl_data["recommended_action"]].item()
        rl_prediction_text = (
            f"RL model recommends prioritizing the road segment between {edge[0]} and {edge[1]} "
            f"with a Q-value of {q_val:.4f} for optimal traffic control."
        )
        logging.info("✅ RL predictions loaded and added to context.")
    except Exception as e:
        rl_prediction_text = "⚠️ Error loading RL predictions."
        logging.error(f"RL predictions error: {e}")
else:
    rl_prediction_text = "⚠️ RL predictions not available."
    logging.warning("⚠️ RL predictions file not found.")

# ✅ Load and chunk knowledge base
def load_knowledge_base(kb_folder="kb"):
    kb_docs = {}
    for file in os.listdir(kb_folder):
        if file.endswith(".txt"):
            with open(os.path.join(kb_folder, file), "r", encoding="utf-8") as f:
                kb_docs[file] = f.read()
    if not kb_docs:
        raise ValueError("❌ No knowledge base files found in the 'kb' folder!")
    chunks = []
    sources = []
    for filename, content in kb_docs.items():
        for paragraph in content.split("\n\n"):
            paragraph = paragraph.strip()
            if paragraph:
                chunks.append(paragraph)
                sources.append(filename)
    return chunks, sources

# ✅ Use the fine-tuned model if available, otherwise use the base model
def load_embedder():
    fine_tuned_path = "ML/trained_embeddings_model"
    if os.path.exists(fine_tuned_path):
        logging.info("🔍 Loading fine-tuned embedding model...")
        return SentenceTransformer(fine_tuned_path)
    else:
        logging.info("⚠️ Fine-tuned model not found, using default model...")
        return SentenceTransformer("all-MiniLM-L6-v2")

# ✅ Embed documents once
print("🔄 Embedding knowledge base...")
doc_chunks, doc_sources = load_knowledge_base()
embedder = load_embedder()
embeddings = embedder.encode(doc_chunks, convert_to_tensor=True)

# ✅ QA logic using retrieval
def answer_question(query, top_k=3):
    logging.info(f"Query: {query}")
    
    query_embedding = embedder.encode(query, convert_to_tensor=True)
    query_embedding = query_embedding.cpu()
    embeddings_cpu = embeddings.cpu()

    cos_scores = cosine_similarity([query_embedding.numpy()], embeddings_cpu.numpy())[0]
    top_indices = cos_scores.argsort()[-top_k:][::-1]

    for i, idx in enumerate(top_indices):
        logging.info(f"Match {i+1} (score: {cos_scores[idx]:.4f}): {doc_chunks[idx][:100]}...")

    context = "\n\n".join([doc_chunks[i] for i in top_indices])
    sources_used = [doc_sources[i] for i in top_indices]

    prompt = f"""
You are a helpful assistant answering questions about a smart AI-powered urban system named Cityscape-Ai.
Use the context below to answer the question. If the answer is not in the context, say "I don't know".

Context:
{context}

AI Model Insights:
{gnn_prediction_text if gnn_prediction_text else 'GNN predictions not available.'}
{rl_prediction_text if rl_prediction_text else 'RL predictions not available.'}

Question: {query}

Answer:
"""
    try:
        model = genai.GenerativeModel("gemini-1.5-pro")
        response = model.generate_content(prompt)
        return response.text.strip()
    except Exception as e:
        logging.error(f"Gemini API error: {str(e)}")
        return f"⚠️ Gemini API error: {str(e)}"

# ✅ Run chatbot loop
if __name__ == "__main__":
    print("🤖 Chatbot is ready! Ask me about Cityscape-Ai 🚦 (type 'exit' to quit)")
    while True:
        user_input = input("\n🧠 You: ")
        if user_input.lower() in ["exit", "quit"]:
            print("👋 Goodbye!")
            break
        try:
            response = answer_question(user_input)
            print(f"\n💬 Bot: {response}")
        except Exception as e:
            print(f"⚠️ Error: {e}")
