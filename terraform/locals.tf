locals {
  domain_name = "jeevancyriac.com"

  app_name    = "joke-generator"
  description = "Joke generator app"

  default_tags = {
    env         = "prod"
    managed_by  = "terraform"
    description = local.description
    project     = local.app_name
  }
}