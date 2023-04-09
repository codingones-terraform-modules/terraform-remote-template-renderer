terraform {
  required_providers {
    http = {
      source = "hashicorp/http"
    }
    external = {
      source = "hashicorp/external"
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

data "external" "replace_variables" {
  program = ["bash", "${path.module}/replace_variables.sh", "${jsonencode(data.http.remote_template.response_body)}", "${jsonencode(var.template_variables)}"]
}

output "rendered" {
  value = replace(data.external.replace_variables.result["content"], "/(<!-- VARIABLES[\\s\\S]*?-->)/", "")

  depends_on = [data.external.replace_variables]
}