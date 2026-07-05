# project name
resource "vercel_project" "services" {
    for_each = var.services

    name = each.key
    framework = each.value.framework
    root_directory = each.value.root_directory
    git_repository = {
        type = "github"
        repo = each.value.repo
    }
}

# project domains in vercel
resource "vercel_project_domain" "pj-domain" {
    for_each = var.domains
    
    project_id = vercel_project.services[each.key].id
    domain  = each.value.domain
}