#######################################
# define the provider for the first region
#######################################
provider "aws" {
  region  = var.first_region
}

#######################################
# define the provider for the second region
#######################################
provider "aws" {
  alias   = "second_region"
  region  = var.second_region
}
