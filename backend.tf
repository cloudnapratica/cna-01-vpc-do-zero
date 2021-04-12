terraform {
  backend "remote" {
    organization = "cloudnapratica"

    workspaces {
      name = "cna-01"
    }
  }
}
