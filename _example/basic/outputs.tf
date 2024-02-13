output "name" {
  description = "The name of the spaces module."
  value       = module.spaces.name
}

output "urn" {
  description = "The Uniform Resource Name (URN) of the spaces module."
  value       = module.spaces.urn
}

output "region" {
  description = "The region where the spaces module is deployed."
  value       = module.spaces.region
}

output "bucket_domain_name" {
  description = "The domain name associated with the storage bucket in the spaces module."
  value       = module.spaces.bucket_domain_name
}
