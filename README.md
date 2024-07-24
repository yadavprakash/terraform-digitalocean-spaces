# Terraform Infrastructure as Code (IaC) - digitalocean spaces Module


## Table of Contents
- [Introduction](#introduction)
- [Usage](#usage)
- [Module Inputs](#module-inputs)
- [Module Outputs](#module-outputs)
- [Authors](#authors)
- [License](#license)

## Introduction
This Terraform module creates structured spaces for digitalocean resources with specific attributes.

## Usage

- Use the module by referencing its source and providing the required variables.

## Example: basic
You can use this module in your Terraform configuration like this:
```hcl
module "spaces" {
  source        = "git::https://github.com/yadavprakash/terraform-digitalocean-spaces.git?ref=v1.0.0"
  name          = "spaces"
  environment   = "test"
  acl           = "private"
  force_destroy = false
  region        = "nyc3"

}

```
## Example: complete
You can use this module in your Terraform configuration like this:
```hcl
module "spaces" {
  source        = "git::https://github.com/yadavprakash/terraform-digitalocean-spaces.git?ref=v1.0.0"
  name          = "spaces"
  environment   = "test"
  acl           = "private"
  force_destroy = false
  region        = "nyc3"

  cors_rule = [
    {
      allowed_headers = ["*"]
      allowed_methods = ["PUT", "POST"],
      allowed_origins = ["https://www.example.com"],
      expose_headers  = ["ETag"],
      max_age_seconds = 3000
    }
  ]

  lifecycle_rule = [
    {
      enabled                                = true
      abort_incomplete_multipart_upload_days = 10
      expiration = [
        {
          date                         = "2024-01-12"
          days                         = 50
          expired_object_delete_marker = true
        }
      ]
      noncurrent_version_expiration_days = 10

    }
  ]

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "IPAllow",
        "Effect" : "Deny",
        "Principal" : "*",
        "Action" : "s3:*",
        "Resource" : [
          "arn:aws:s3:::spaces-name",
          "arn:aws:s3:::spaces-name/*"
        ],
        "Condition" : {
          "NotIpAddress" : {
            "aws:SourceIp" : "0.0.0.0/0"
          }
        }
      }
    ]
  })
}

```
Please ensure you specify the correct 'source' path for the module.

## Module Inputs

- `name` : Name  (e.g. `app` or `cluster`).
- `environment` : Environment (e.g. `prod`, `dev`, `staging`).
- `label_order` : Label order, e.g. `name`,`application`.
- `managedby` : ManagedBy, eg 'yadavprakash'
- `region` : The region to create spaces.
- `acl` : Canned ACL applied on bucket creation (private or public-read).

## Module Outputs
- This module currently does not provide any outputs.

# Examples
For detailed examples on how to use this module, please refer to the '[example](https://github.com/yadavprakash/terraform-digitalocean-spaces/tree/master/_example)' directory within this repository.

## Authors
Your Name
Replace '[License Name]' and '[Your Name]' with the appropriate license and your information. Feel free to expand this README with additional details or usage instructions as needed for your specific use case.

## License
This project is licensed under the MIT License - see the [LICENSE](https://github.com/yadavprakash/terraform-digitalocean-spaces/blob/master/LICENSE) file for details.



<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.7.3 |
| <a name="requirement_digitalocean"></a> [digitalocean](#requirement\_digitalocean) | >= 2.34.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_digitalocean"></a> [digitalocean](#provider\_digitalocean) | >= 2.34.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_labels"></a> [labels](#module\_labels) | git::https://github.com/yadavprakash/terraform-digitalocean-labels.git | v1.0.0 |

## Resources

| Name | Type |
|------|------|
| [digitalocean_spaces_bucket.spaces](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/spaces_bucket) | resource |
| [digitalocean_spaces_bucket_policy.foobar](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/spaces_bucket_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acl"></a> [acl](#input\_acl) | Canned ACL applied on bucket creation (private or public-read). | `string` | `null` | no |
| <a name="input_cors_rule"></a> [cors\_rule](#input\_cors\_rule) | CORS Configuration specification for this bucket | <pre>list(object({<br>    allowed_headers = list(string)<br>    allowed_methods = list(string)<br>    allowed_origins = list(string)<br>    expose_headers  = list(string)<br>    max_age_seconds = number<br>  }))</pre> | `null` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Whether to create the resources. Set to `false` to prevent the module from creating any resources. | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment (e.g. `prod`, `dev`, `staging`). | `string` | `""` | no |
| <a name="input_expiration"></a> [expiration](#input\_expiration) | Specifies a time period after which applicable objects expire (documented below). | `list(any)` | `[]` | no |
| <a name="input_force_destroy"></a> [force\_destroy](#input\_force\_destroy) | Unless true, the bucket will only be destroyed if empty (Defaults to false). | `bool` | `false` | no |
| <a name="input_label_order"></a> [label\_order](#input\_label\_order) | Label order, e.g. `name`,`application`. | `list(any)` | <pre>[<br>  "name",<br>  "environment"<br>]</pre> | no |
| <a name="input_lifecycle_rule"></a> [lifecycle\_rule](#input\_lifecycle\_rule) | A configuration of object lifecycle management (documented below). | `list(any)` | `[]` | no |
| <a name="input_name"></a> [name](#input\_name) | Name  (e.g. `app` or `cluster`). | `string` | `""` | no |
| <a name="input_policy"></a> [policy](#input\_policy) | The text of the policy. | `any` | `null` | no |
| <a name="input_region"></a> [region](#input\_region) | The region to create spaces. | `string` | `"blr1"` | no |
| <a name="input_versioning"></a> [versioning](#input\_versioning) | A state of versioning (documented below). | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket_domain_name"></a> [bucket\_domain\_name](#output\_bucket\_domain\_name) | The FQDN of the bucket (e.g. bucket-name.nyc3.digitaloceanspaces.com). |
| <a name="output_name"></a> [name](#output\_name) | The name of the bucket. |
| <a name="output_region"></a> [region](#output\_region) | The name of the region. |
| <a name="output_urn"></a> [urn](#output\_urn) | The uniform resource name for the bucket. |
<!-- END_TF_DOCS -->