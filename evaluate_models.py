import os
import numpy as np
import pandas as pd
from sentence_transformers import SentenceTransformer
from sklearn.metrics.pairwise import cosine_similarity
import matplotlib.pyplot as plt
import seaborn as sns
from datetime import datetime

def load_test_queries():
    """Load or create test queries relevant to Cityscape-AI"""
    # These should be questions that are relevant to your knowledge base
    test_queries = [
        "What is Cityscape-AI?",
        "How does Cityscape-AI help with traffic management?",
        "Can Cityscape-AI reduce pollution in cities?",
        "What technologies does Cityscape-AI use?",
        "How does Cityscape-AI handle emergency situations?",
        # Add more relevant test queries
    ]
    return test_queries

def load_knowledge_base(kb_folder="kb"):
    """Load documents from knowledge base folder"""
    kb_docs = {}
    for file in os.listdir(kb_folder):
        if file.endswith(".txt"):
            with open(os.path.join(kb_folder, file), "r", encoding="utf-8") as f:
                kb_docs[file] = f.read()
    
    chunks = []
    sources = []
    for filename, content in kb_docs.items():
        for paragraph in content.split("\n\n"):
            paragraph = paragraph.strip()
            if paragraph:
                chunks.append(paragraph)
                sources.append(filename)
    
    return chunks, sources

def evaluate_model(model_name, chunks, queries, top_k=3):
    """Evaluate a model on retrieval performance"""
    model = SentenceTransformer(model_name)
    chunk_embeddings = model.encode(chunks, convert_to_tensor=True)
    
    results = []
    
    for query in queries:
        query_embedding = model.encode(query, convert_to_tensor=True)
        
        # Convert to CPU if needed
        if query_embedding.device.type != "cpu":
            query_embedding = query_embedding.cpu()
            chunk_embeddings_cpu = chunk_embeddings.cpu()
        else:
            chunk_embeddings_cpu = chunk_embeddings
            
        # Calculate similarities
        similarities = cosine_similarity([query_embedding.numpy()], chunk_embeddings_cpu.numpy())[0]
        
        # Get top-k matches
        top_indices = similarities.argsort()[-top_k:][::-1]
        top_scores = [similarities[i] for i in top_indices]
        
        # Store results
        results.append({
            'query': query,
            'top_scores': top_scores,
            'avg_score': np.mean(top_scores)
        })
    
    return results

def compare_models():
    """Compare base model vs fine-tuned model"""
    # Load test data
    test_queries = load_test_queries()
    chunks, _ = load_knowledge_base()
    
    print(f"📊 Evaluating models on {len(test_queries)} test queries...")
    
    # Define models to compare
    models = {
        "Base Model": "all-MiniLM-L6-v2",
        "Fine-tuned Model": "ML/trained_embeddings_model"
    }
    
    # Skip fine-tuned model if it doesn't exist
    if not os.path.exists(models["Fine-tuned Model"]):
        print("⚠️ Fine-tuned model not found. Run train_embeddings_model.py first.")
        models = {"Base Model": models["Base Model"]}
    
    # Evaluate each model
    results = {}
    for model_name, model_path in models.items():
        print(f"Evaluating {model_name}...")
        results[model_name] = evaluate_model(model_path, chunks, test_queries)
    
    # Create comparison dataframe
    comparison_data = []
    for query_idx, query in enumerate(test_queries):
        for model_name in results:
            comparison_data.append({
                'Query': query,
                'Model': model_name,
                'Average Score': results[model_name][query_idx]['avg_score']
            })
    
    comparison_df = pd.DataFrame(comparison_data)
    
    # Generate output directory
    output_dir = "ML/evaluation_results"
    os.makedirs(output_dir, exist_ok=True)
    
    # Save results to CSV
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    csv_path = f"{output_dir}/model_comparison_{timestamp}.csv"
    comparison_df.to_csv(csv_path, index=False)
    print(f"💾 Results saved to {csv_path}")
    
    # Create visualization if matplotlib is available
    try:
        plt.figure(figsize=(12, 8))
        sns.barplot(x='Query', y='Average Score', hue='Model', data=comparison_df)
        plt.xticks(rotation=45, ha='right')
        plt.tight_layout()
        plt.title('Retrieval Performance Comparison')
        img_path = f"{output_dir}/model_comparison_{timestamp}.png"
        plt.savefig(img_path)
        print(f"📈 Visualization saved to {img_path}")
    except:
        print("⚠️ Could not generate visualization. Make sure matplotlib and seaborn are installed.")
    
    # Print summary
    print("\n📋 Summary:")
    for model_name in results:
        avg_scores = [r['avg_score'] for r in results[model_name]]
        print(f"{model_name}: Average similarity score = {np.mean(avg_scores):.4f}")
    
    return comparison_df

if __name__ == "__main__":
    print("🔍 Starting model evaluation...")
    compare_models()
    print("✅ Evaluation complete!")