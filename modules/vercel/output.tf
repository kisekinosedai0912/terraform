output "project_ids" {
    description = "Vercel project IDs keyed by service name"
    value = {
        for name, project in vercel_project.service : name => project.id
    }
}

output "project_names" {
    description = "Vercel project names keyed by service name"
    value = {
        for name, project in vercel_project.service : name => project.name
    }
}

output "project_details" {
    description = "Useful metadata for each created Vercel project"
    value = {
        for name, project in vercel_project.service : name => {
            id             = project.id
            name           = project.name
            framework      = project.framework
            root_directory = project.root_directory
        }
    }
}

output "domain_names" {
    description = "List of domains of the apps deployed"
    value = {
        for name, project in vercel_vercel_project_domain.pj-domain : domain => project.domain
    }
}