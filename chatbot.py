import os
import torch
import dotenv
import google.generativeai as genai
from sentence_transformers import SentenceTransformer
from sklearn.metrics.pairwise import cosine_similarity

# ✅ Load environment variables
dotenv.load_dotenv()
GEMINI_API_KEY = os.getenv("GOOGLE_API_KEY")
if not GEMINI_API_KEY:
    raise ValueError("❌ Gemini_API_Key not found in .env file!")

# ✅ Configure Gemini API
genai.configure(api_key=GEMINI_API_KEY)

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

# ✅ Embed documents once
print("🔄 Embedding knowledge base...")
doc_chunks, doc_sources = load_knowledge_base()
embedder = SentenceTransformer("all-MiniLM-L6-v2")
embeddings = embedder.encode(doc_chunks, convert_to_tensor=True)

# ✅ QA logic using retrieval
def answer_question(query, top_k=3):
    query_embedding = embedder.encode(query, convert_to_tensor=True)
    # Convert to CPU if needed
    if query_embedding.device.type != "cpu":
        query_embedding = query_embedding.cpu()
        embeddings_cpu = embeddings.cpu()
    else:
        embeddings_cpu = embeddings
    # Compute cosine similarity
    cos_scores = cosine_similarity([query_embedding.numpy()], embeddings_cpu.numpy())[0]
    top_indices = cos_scores.argsort()[-top_k:][::-1]
    # Prepare context and source references
    context = "\n\n".join([doc_chunks[i] for i in top_indices])
    sources_used = [doc_sources[i] for i in top_indices]
    prompt = f"""
You are a helpful assistant answering questions about a smart AI-powered urban system named Cityscape-Ai.
Use the context below to answer the question. If the answer is not in the context, say "I don't know".
Context:
{context}
Question: {query}
Answer:
"""
    try:
        # Updated to use the correct model name format
        model = genai.GenerativeModel("gemini-1.5-pro")
        response = model.generate_content(prompt)
        answer = response.text.strip()
    except Exception as e:
        # More descriptive error handling
        answer = f"⚠️ Gemini API error: {str(e)}"
        # Try fallback model if primary fails
        try:
            fallback_model = genai.GenerativeModel("gemini-1.0-pro")
            fallback_response = fallback_model.generate_content(prompt)
            answer = fallback_response.text.strip()
        except Exception as fallback_e:
            answer = f"⚠️ Gemini API error: Primary model failed with: {str(e)}. Fallback model failed with: {str(fallback_e)}"
    return answer

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