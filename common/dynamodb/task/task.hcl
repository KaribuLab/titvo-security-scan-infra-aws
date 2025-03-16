locals {
  hash_key           = "scan_id"
  ttl_attribute_name = "ttl"
  ttl_enabled        = true
  attributes = [
    {
      name = "scan_id"
      type = "S"
    }
  ]
}