locals {
  hash_key = "user_id"

  attributes = [
    {
      name = "user_id"
      type = "S"
    },
    { 
      name = "email"
      type = "S"
    }
  ]
  global_secondary_indexes = [
    {
      name            = "EmailIndex"
      hash_key        = "email"
      projection_type = "ALL"
      billing_mode    = "PAY_PER_REQUEST"
    }
  ]
}
