---
tags:
- sentence-transformers
- sentence-similarity
- feature-extraction
- generated_from_trainer
- dataset_size:144
- loss:CosineSimilarityLoss
base_model: sentence-transformers/all-MiniLM-L6-v2
widget:
- source_sentence: ⸻
  sentences:
  - '📄 File: kuala_lumpur_flood_zones.geojson

    • Highlights high-risk flood areas and elevation data.

    • Critical for climate adaptation and hazard mapping.'
  - "Training Overview\n\t•\tEpisodes: 100\n\t•\tState: Simulated traffic levels across\
    \ all road edges\n\t•\tAction: Choose one edge to optimize\n\t•\tReward: Negative\
    \ of total traffic (lower traffic = higher reward)\n\t•\tGoal: Minimize cumulative\
    \ traffic over time"
  - To reduce overall congestion by intelligently prioritizing road segments (edges)
    for optimization based on simulated traffic conditions.
- source_sentence: 'Title: Reinforcement Learning (RL) Model Summary – Cityscape-Ai'
  sentences:
  - Kuala Lumpur Road Traffic
  - These features form the knowledge base and are used by GNN and RL models to answer
    urban planning queries and optimize traffic in the Cityscape-Ai project.
  - This dataset includes 18 types of urban features extracted from Kuala Lumpur,
    Malaysia using OpenStreetMap data. Each feature is stored as a GeoJSON file and
    used to support AI models for urban analysis and traffic optimization.
- source_sentence: "Training Info:\n\t•\tNodes: 101,489\n\t•\tEdges: 109,738\n\t•\t\
    Epochs: 100\n\t•\tLoss: Mean Squared Error (MSE) with synthetic targets\n\t•\t\
    Device: CUDA/MPS/CPU fallback for compatibility"
  sentences:
  - 'Model Output:

    Predicts a continuous value per node (e.g., importance, traffic potential, influence).'
  - '📄 File: kuala_lumpur_pois.geojson

    • Covers restaurants, banks, schools, offices, etc.

    • Boosts semantic understanding of surrounding road segments.'
  - "How It Works:\n\t•\tEach road intersection is treated as a node, and road segments\
    \ as edges.\n\t•\t18 features were preprocessed and assigned to nodes as binary\
    \ indicators (e.g., presence of a bus stop = 1).\n\t•\tA two-layer Graph Convolutional\
    \ Network (GCN) was used to learn from the graph’s structure and node features."
- source_sentence: The presence of power infrastructure such as substations and high-voltage
    lines in Cityscape-Ai enables urban resilience planning. It allows identification
    of critical power zones that must remain accessible during traffic rerouting,
    disaster events, or maintenance operations.
  sentences:
  - 2. Buildings
  - Kuala Lumpur Healthcare
  - 'Title: Traffic Optimization Strategies in Cityscape-Ai'
- source_sentence: '🗺️ Land Use

    4. Land Use Zones – Areas categorized by residential, commercial, parkland, etc.'
  sentences:
  - Kuala Lumpur Water
  - '🚌 Transport Infrastructure

    5. Railways – Rail lines and metro tracks.

    6. Bus Stops – Designated bus boarding points.

    7. Train Stations – Metro and railway station entries.

    8. Public Transport Systems – General transit infrastructure.

    9. Bicycle Paths & Footways – Dedicated cycling and walking lanes.

    10. Parking Areas – Urban parking facilities.'
  - 4. GNN-RL Fusion for Smarter Control
pipeline_tag: sentence-similarity
library_name: sentence-transformers
---

# SentenceTransformer based on sentence-transformers/all-MiniLM-L6-v2

This is a [sentence-transformers](https://www.SBERT.net) model finetuned from [sentence-transformers/all-MiniLM-L6-v2](https://huggingface.co/sentence-transformers/all-MiniLM-L6-v2). It maps sentences & paragraphs to a 384-dimensional dense vector space and can be used for semantic textual similarity, semantic search, paraphrase mining, text classification, clustering, and more.

## Model Details

### Model Description
- **Model Type:** Sentence Transformer
- **Base model:** [sentence-transformers/all-MiniLM-L6-v2](https://huggingface.co/sentence-transformers/all-MiniLM-L6-v2) <!-- at revision c9745ed1d9f207416be6d2e6f8de32d1f16199bf -->
- **Maximum Sequence Length:** 256 tokens
- **Output Dimensionality:** 384 dimensions
- **Similarity Function:** Cosine Similarity
<!-- - **Training Dataset:** Unknown -->
<!-- - **Language:** Unknown -->
<!-- - **License:** Unknown -->

### Model Sources

- **Documentation:** [Sentence Transformers Documentation](https://sbert.net)
- **Repository:** [Sentence Transformers on GitHub](https://github.com/UKPLab/sentence-transformers)
- **Hugging Face:** [Sentence Transformers on Hugging Face](https://huggingface.co/models?library=sentence-transformers)

### Full Model Architecture

```
SentenceTransformer(
  (0): Transformer({'max_seq_length': 256, 'do_lower_case': False}) with Transformer model: BertModel 
  (1): Pooling({'word_embedding_dimension': 384, 'pooling_mode_cls_token': False, 'pooling_mode_mean_tokens': True, 'pooling_mode_max_tokens': False, 'pooling_mode_mean_sqrt_len_tokens': False, 'pooling_mode_weightedmean_tokens': False, 'pooling_mode_lasttoken': False, 'include_prompt': True})
  (2): Normalize()
)
```

## Usage

### Direct Usage (Sentence Transformers)

First install the Sentence Transformers library:

```bash
pip install -U sentence-transformers
```

Then you can load this model and run inference.
```python
from sentence_transformers import SentenceTransformer

# Download from the 🤗 Hub
model = SentenceTransformer("sentence_transformers_model_id")
# Run inference
sentences = [
    '🗺️ Land Use\n4. Land Use Zones – Areas categorized by residential, commercial, parkland, etc.',
    '🚌 Transport Infrastructure\n5. Railways – Rail lines and metro tracks.\n6. Bus Stops – Designated bus boarding points.\n7. Train Stations – Metro and railway station entries.\n8. Public Transport Systems – General transit infrastructure.\n9. Bicycle Paths & Footways – Dedicated cycling and walking lanes.\n10. Parking Areas – Urban parking facilities.',
    'Kuala Lumpur Water',
]
embeddings = model.encode(sentences)
print(embeddings.shape)
# [3, 384]

# Get the similarity scores for the embeddings
similarities = model.similarity(embeddings, embeddings)
print(similarities.shape)
# [3, 3]
```

<!--
### Direct Usage (Transformers)

<details><summary>Click to see the direct usage in Transformers</summary>

</details>
-->

<!--
### Downstream Usage (Sentence Transformers)

You can finetune this model on your own dataset.

<details><summary>Click to expand</summary>

</details>
-->

<!--
### Out-of-Scope Use

*List how the model may foreseeably be misused and address what users ought not to do with the model.*
-->

<!--
## Bias, Risks and Limitations

*What are the known or foreseeable issues stemming from this model? You could also flag here known failure cases or weaknesses of the model.*
-->

<!--
### Recommendations

*What are recommendations with respect to the foreseeable issues? For example, filtering explicit content.*
-->

## Training Details

### Training Dataset

#### Unnamed Dataset

* Size: 144 training samples
* Columns: <code>sentence_0</code>, <code>sentence_1</code>, and <code>label</code>
* Approximate statistics based on the first 144 samples:
  |         | sentence_0                                                                        | sentence_1                                                                         | label                                                          |
  |:--------|:----------------------------------------------------------------------------------|:-----------------------------------------------------------------------------------|:---------------------------------------------------------------|
  | type    | string                                                                            | string                                                                             | float                                                          |
  | details | <ul><li>min: 3 tokens</li><li>mean: 28.2 tokens</li><li>max: 122 tokens</li></ul> | <ul><li>min: 3 tokens</li><li>mean: 28.28 tokens</li><li>max: 134 tokens</li></ul> | <ul><li>min: 0.3</li><li>mean: 0.86</li><li>max: 0.9</li></ul> |
* Samples:
  | sentence_0                                                                                                                                                                                            | sentence_1                                                                                                                                                                                                                                                                                                      | label            |
  |:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-----------------|
  | <code>5. Train & Rail (kuala_lumpur_railways.geojson, kuala_lumpur_train_stations.geojson)<br>	•	Train lines (geometry) and stations (points) integrated for modeling transit-heavy corridors.</code> | <code>6. Streetlights (kuala_lumpur_streetlights.geojson)<br>	•	Road safety proxy in lower-lit or dense areas.<br>	•	Enhances safety-aware road prioritization models.</code>                                                                                                                                   | <code>0.9</code> |
  | <code>⸻</code>                                                                                                                                                                                        | <code>Purpose</code>                                                                                                                                                                                                                                                                                            | <code>0.9</code> |
  | <code>Kuala Lumpur Railways</code>                                                                                                                                                                    | <code>Railway lines and infrastructure including tracks and logistics corridors are used by Cityscape-Ai to support multimodal transportation models. This helps integrate train schedules and capacities into the overall traffic simulation and optimize coordination between road and rail transport.</code> | <code>0.9</code> |
* Loss: [<code>CosineSimilarityLoss</code>](https://sbert.net/docs/package_reference/sentence_transformer/losses.html#cosinesimilarityloss) with these parameters:
  ```json
  {
      "loss_fct": "torch.nn.modules.loss.MSELoss"
  }
  ```

### Training Hyperparameters
#### Non-Default Hyperparameters

- `per_device_train_batch_size`: 16
- `per_device_eval_batch_size`: 16
- `num_train_epochs`: 5
- `multi_dataset_batch_sampler`: round_robin

#### All Hyperparameters
<details><summary>Click to expand</summary>

- `overwrite_output_dir`: False
- `do_predict`: False
- `eval_strategy`: no
- `prediction_loss_only`: True
- `per_device_train_batch_size`: 16
- `per_device_eval_batch_size`: 16
- `per_gpu_train_batch_size`: None
- `per_gpu_eval_batch_size`: None
- `gradient_accumulation_steps`: 1
- `eval_accumulation_steps`: None
- `torch_empty_cache_steps`: None
- `learning_rate`: 5e-05
- `weight_decay`: 0.0
- `adam_beta1`: 0.9
- `adam_beta2`: 0.999
- `adam_epsilon`: 1e-08
- `max_grad_norm`: 1
- `num_train_epochs`: 5
- `max_steps`: -1
- `lr_scheduler_type`: linear
- `lr_scheduler_kwargs`: {}
- `warmup_ratio`: 0.0
- `warmup_steps`: 0
- `log_level`: passive
- `log_level_replica`: warning
- `log_on_each_node`: True
- `logging_nan_inf_filter`: True
- `save_safetensors`: True
- `save_on_each_node`: False
- `save_only_model`: False
- `restore_callback_states_from_checkpoint`: False
- `no_cuda`: False
- `use_cpu`: False
- `use_mps_device`: False
- `seed`: 42
- `data_seed`: None
- `jit_mode_eval`: False
- `use_ipex`: False
- `bf16`: False
- `fp16`: False
- `fp16_opt_level`: O1
- `half_precision_backend`: auto
- `bf16_full_eval`: False
- `fp16_full_eval`: False
- `tf32`: None
- `local_rank`: 0
- `ddp_backend`: None
- `tpu_num_cores`: None
- `tpu_metrics_debug`: False
- `debug`: []
- `dataloader_drop_last`: False
- `dataloader_num_workers`: 0
- `dataloader_prefetch_factor`: None
- `past_index`: -1
- `disable_tqdm`: False
- `remove_unused_columns`: True
- `label_names`: None
- `load_best_model_at_end`: False
- `ignore_data_skip`: False
- `fsdp`: []
- `fsdp_min_num_params`: 0
- `fsdp_config`: {'min_num_params': 0, 'xla': False, 'xla_fsdp_v2': False, 'xla_fsdp_grad_ckpt': False}
- `tp_size`: 0
- `fsdp_transformer_layer_cls_to_wrap`: None
- `accelerator_config`: {'split_batches': False, 'dispatch_batches': None, 'even_batches': True, 'use_seedable_sampler': True, 'non_blocking': False, 'gradient_accumulation_kwargs': None}
- `deepspeed`: None
- `label_smoothing_factor`: 0.0
- `optim`: adamw_torch
- `optim_args`: None
- `adafactor`: False
- `group_by_length`: False
- `length_column_name`: length
- `ddp_find_unused_parameters`: None
- `ddp_bucket_cap_mb`: None
- `ddp_broadcast_buffers`: False
- `dataloader_pin_memory`: True
- `dataloader_persistent_workers`: False
- `skip_memory_metrics`: True
- `use_legacy_prediction_loop`: False
- `push_to_hub`: False
- `resume_from_checkpoint`: None
- `hub_model_id`: None
- `hub_strategy`: every_save
- `hub_private_repo`: None
- `hub_always_push`: False
- `gradient_checkpointing`: False
- `gradient_checkpointing_kwargs`: None
- `include_inputs_for_metrics`: False
- `include_for_metrics`: []
- `eval_do_concat_batches`: True
- `fp16_backend`: auto
- `push_to_hub_model_id`: None
- `push_to_hub_organization`: None
- `mp_parameters`: 
- `auto_find_batch_size`: False
- `full_determinism`: False
- `torchdynamo`: None
- `ray_scope`: last
- `ddp_timeout`: 1800
- `torch_compile`: False
- `torch_compile_backend`: None
- `torch_compile_mode`: None
- `dispatch_batches`: None
- `split_batches`: None
- `include_tokens_per_second`: False
- `include_num_input_tokens_seen`: False
- `neftune_noise_alpha`: None
- `optim_target_modules`: None
- `batch_eval_metrics`: False
- `eval_on_start`: False
- `use_liger_kernel`: False
- `eval_use_gather_object`: False
- `average_tokens_across_devices`: False
- `prompts`: None
- `batch_sampler`: batch_sampler
- `multi_dataset_batch_sampler`: round_robin

</details>

### Framework Versions
- Python: 3.12.9
- Sentence Transformers: 3.4.1
- Transformers: 4.50.0
- PyTorch: 2.6.0+cu118
- Accelerate: 1.6.0
- Datasets: 3.5.0
- Tokenizers: 0.21.1

## Citation

### BibTeX

#### Sentence Transformers
```bibtex
@inproceedings{reimers-2019-sentence-bert,
    title = "Sentence-BERT: Sentence Embeddings using Siamese BERT-Networks",
    author = "Reimers, Nils and Gurevych, Iryna",
    booktitle = "Proceedings of the 2019 Conference on Empirical Methods in Natural Language Processing",
    month = "11",
    year = "2019",
    publisher = "Association for Computational Linguistics",
    url = "https://arxiv.org/abs/1908.10084",
}
```

<!--
## Glossary

*Clearly define terms in order to be accessible across audiences.*
-->

<!--
## Model Card Authors

*Lists the people who create the model card, providing recognition and accountability for the detailed work that goes into its construction.*
-->

<!--
## Model Card Contact

*Provides a way for people who have updates to the Model Card, suggestions, or questions, to contact the Model Card authors.*
-->