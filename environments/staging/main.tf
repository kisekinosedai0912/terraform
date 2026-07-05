module "vercel" {
    source = "../../modules/vercel"
    services = var.services
    domains = var.domains
}