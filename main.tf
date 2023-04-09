terraform {
  required_providers {
    http = {
      source = "hashicorp/http"
    }
  }
}

variable "template_url" {
  type        = string
  description = "The URL to fetch the remote template file."
}

variable "template_variables" {
  type        = map(string)
  description = "A map of variables to be used in the template."
}

data "http" "remote_template" {
  url = var.template_url
}

locals {
  remote_template_content = data.http.remote_template.body
}

resource "local_file" "temp_remote_template" {
  content  = local.remote_template_content
  filename = "${path.module}/temp_remote_template.tmpl"
}

locals {
  rendered_content         = templatefile("${path.module}/temp_remote_template.tmpl", var.template_variables)
  cleaned_template_content = replace(local.remote_template_content, "/(<!-- VARIABLES[\\s\\S]*?-->)/", "")
}

output "rendered" {
  value      = local.cleaned_template_content
  depends_on = [local_file.temp_remote_template]
}
