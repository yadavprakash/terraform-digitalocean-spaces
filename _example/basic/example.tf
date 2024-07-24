provider "digitalocean" {

}

module "spaces" {
  source        = "./../../"
  name          = "spaces"
  environment   = "test"
  acl           = "private"
  force_destroy = false
  region        = "nyc3"

}

