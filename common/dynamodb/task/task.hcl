locals {
  hash_key           = "scan_id"
  ttl_attribute_name = "ttl"
  ttl_enabled        = false
  attributes = [
    {
      name = "scan_id"
      type = "S"
    }
  ]
}