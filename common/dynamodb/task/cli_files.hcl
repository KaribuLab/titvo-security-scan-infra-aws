locals {
  hash_key           = "file_id"
  ttl_attribute_name = "ttl"
  ttl_enabled        = true

  attributes = [
    {
      name = "file_id"
      type = "S"
    },
    {
      name = "batch_id"
      type = "S"
    }
  ]

  global_secondary_indexes = [
    {
      name            = "batch_id_gsi"
      hash_key        = "batch_id"
      projection_type = "ALL"
    },
  ]
}