locals {
  hash_key = "repository_id"

  attributes = [
    {
      name = "repository_id"
      type = "S"
    },
    {
      name = "user_id"
      type = "S"
    },
  ]

  global_secondary_indexes = [
    {
      name            = "user_id_gsi"
      hash_key        = "user_id"
      projection_type = "ALL"
    }
  ]
}
