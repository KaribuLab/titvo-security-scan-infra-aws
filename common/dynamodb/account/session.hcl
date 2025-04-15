locals {
  hash_key           = "session_id"
  ttl_attribute_name = "ttl"
  ttl_enabled        = true

  attributes = [
    {
      name = "session_id"
      type = "S"
    },
  ]
}
