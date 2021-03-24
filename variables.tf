variable "vpc_configuration" {
  type = object({
    cidr_block = string
    subnets = list(object({
      name       = string
      cidr_block = string
      public     = bool
    }))
  })
  default = {
    cidr_block = "10.0.0.0/16"
    subnets = [
      {
        name       = "private-a"
        cidr_block = "10.0.0.0/19"
        public     = false
      },
      {
        name       = "private-b"
        cidr_block = "10.0.32.0/19"
        public     = false
      },
      {
        name       = "private-c"
        cidr_block = "10.0.64.0/19"
        public     = false
      },
      {
        name       = "public-a"
        cidr_block = "10.0.128.0/19"
        public     = true
      },
      {
        name       = "public-b"
        cidr_block = "10.0.160.0/19"
        public     = true
      },
      {
        name       = "public-c"
        cidr_block = "10.0.192.0/19"
        public     = true
      },
    ]
  }
}
