terraform {
  required_providers {
    http = {
      source  = "hashicorp/http"
      version = "3.4.5"
    }

    google = {
      source  = "hashicorp/google"
      version = "6.12.0"
    }
  }
}

variable "actor" {
  type        = string
  description = "The existing bluesky handle that we want the DID from."
}

variable "handle" {
  type        = string
  description = "The desired verified handle."
}

variable "domain" {
  type        = string
  description = "The domain we are using for our new Bluesky handle with verification."
}

variable "cloud_dns_zone" {
  type = string
}

variable "project" {
  type = string
}

data "http" "user_lookup" {
  url = "https://public.api.bsky.app/xrpc/app.bsky.actor.getProfile?actor=${var.actor}"
}

resource "google_dns_record_set" "txt" {
  name         = "_atproto.${var.handle}.${var.domain}."
  type         = "TXT"
  ttl          = 300
  managed_zone = var.cloud_dns_zone
  project      = var.project

  rrdatas = [
    "did=${jsondecode(data.http.user_lookup.response_body).did}"
  ]
}

output "response" {
  value = jsondecode(data.http.user_lookup.response_body).did
}