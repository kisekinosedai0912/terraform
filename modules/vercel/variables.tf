variable "services" {
    type = map(object({
        framework      = string
        root_directory = string
        repo           = string
    }))
}

variable "domains" {
    type = list(string)
    default = []
}