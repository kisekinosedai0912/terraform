terraform {
    required_providers {
        vercel = {
            source = "vercel/vercel"
            version = ">= 4.8"        
        }
        cloudflare = {
            source = "cloudflare/cloudflare"
            version = "~> 5"
        }
        infisical ={
            source = "infisical/infisical"
            version = "0.18.0"
        }
    }
}   