import os
import torch
import dotenv
import numpy as np
from sentence_transformers import SentenceTransformer, InputExample, losses
from torch.utils.data import DataLoader
import logging
from datetime import datetime

# Setup logging
logging.basicConfig(format='%(asctime)s - %(message)s',
                    datefmt='%Y-%m-%d %H:%M:%S',
                    level=logging.INFO)

# Load environment variables
dotenv.load_dotenv()

def load_knowledge_base(kb_folder="kb"):
    """Load documents from knowledge base folder"""
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

def create_training_pairs(chunks, sources):
    """Create semantic similarity pairs from knowledge base chunks"""
    training_examples = []
    
    # Group chunks by source file
    source_to_chunks = {}
    for chunk, source in zip(chunks, sources):
        if source not in source_to_chunks:
            source_to_chunks[source] = []
        source_to_chunks[source].append(chunk)
    
    # Create positive pairs (chunks from same source)
    for source, chunks_list in source_to_chunks.items():
        if len(chunks_list) > 1:
            for i in range(len(chunks_list)):
                # Pair with another chunk from same file
                j = (i + 1) % len(chunks_list)  # Next chunk or wrap to first
                training_examples.append(InputExample(texts=[chunks_list[i], chunks_list[j]], label=0.9))
    
    # Create some negative pairs (chunks from different sources)
    source_names = list(source_to_chunks.keys())
    if len(source_names) > 1:
        for i, source1 in enumerate(source_names[:-1]):
            source2 = source_names[i+1]
            # Take first chunk from each source for negative pair
            if source_to_chunks[source1] and source_to_chunks[source2]:
                training_examples.append(InputExample(
                    texts=[source_to_chunks[source1][0], source_to_chunks[source2][0]],
                    label=0.3
                ))
    
    # Create question-answer pairs if there are Q&A style content
    for chunk in chunks:
        if "?" in chunk:
            # Simple heuristic to identify questions and answers
            sentences = chunk.split(". ")
            for i, sentence in enumerate(sentences):
                if "?" in sentence and i < len(sentences) - 1:
                    # Pair question with following sentence (potential answer)
                    training_examples.append(InputExample(
                        texts=[sentence, sentences[i+1]],
                        label=0.95
                    ))
    
    return training_examples

def fine_tune_model(base_model_name="all-MiniLM-L6-v2", epochs=10, batch_size=16):
    """Fine-tune a sentence transformer model on Cityscape-AI domain data"""
    logging.info(f"🚀 Starting fine-tuning of {base_model_name} model")
    
    # Load base model
    model = SentenceTransformer(base_model_name)
    
    # Load knowledge base
    chunks, sources = load_knowledge_base()
    logging.info(f"📚 Loaded {len(chunks)} document chunks from {len(set(sources))} files")
    
    # Create training examples
    train_examples = create_training_pairs(chunks, sources)
    logging.info(f"🔄 Created {len(train_examples)} training pairs")
    
    if len(train_examples) < 10:
        logging.warning("⚠️ Very few training examples. Fine-tuning may not be effective.")
        return None
    
    # Create data loader
    train_dataloader = DataLoader(train_examples, shuffle=True, batch_size=batch_size)
    
    # Use cosine similarity loss
    train_loss = losses.CosineSimilarityLoss(model)
    
    # Train the model
    logging.info(f"🏋️ Training for {epochs} epochs with batch size {batch_size}")
    model.fit(
        train_objectives=[(train_dataloader, train_loss)],
        epochs=epochs,
        warmup_steps=100,
        show_progress_bar=True
    )
    
    # Create model output directory
    output_dir = "ML/trained_embeddings_model"
    os.makedirs(output_dir, exist_ok=True)
    
    # Save the model
    model.save(output_dir)
    logging.info(f"💾 Model saved to {output_dir}")
    
    return model

if __name__ == "__main__":
    print("🔧 Starting embedding model fine-tuning for Cityscape-AI...")
    fine_tune_model(epochs=5)  # Use fewer epochs for faster training
    print("✅ Fine-tuning complete! The model is saved to ML/trained_embeddings_model")