variable "environment_defaults" {
  type = object({
    tags = optional(map(any))
  })
  default = {
    tags = {}
  }
}

variable "global_defaults" {
  type = object({
    tags = optional(map(any))
  })
  default = {
    tags = {}
  }
}
