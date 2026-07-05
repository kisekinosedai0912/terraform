variable "services" {
    type = map(object({
		framework = string
		root_directory = string
		repo = string
		branch = string
    }))
}

variable "vercel_api_token" {
    type = string
    sensitive = true
}

variable "domains" {
    type = list(string)
    default = []
}