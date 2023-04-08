
# Terraform Remote Template Renderer

## About

A module that aims to provide an easy solution to render templated files for the terraform github provider.

## TOC

- 🪧 [About](#about)
- 🛠️ [Usage](#usage)
- 🤝 [Contribution](#contribution)
- 🏗️ [Built With](#built-with)
- 📝 [License](#license)


## Usage

Example usage

```terraform
module "templated_readme" {
  source       = "github.com/codingones/terraform-remote-template-renderer"
  template_url = "https://raw.githubusercontent.com/codingones/templates/main/readme/README_terraform_module.md"
  template_variables = {
    MODULE_NAME = "Terraform Remote Template Renderer"
    ABOUT   = "A module that aims to provide an easy solution to render templated files for the terraform github provider."
  }
}

output "result" {
  value = module.remote_template_renderer.rendered
}

```

## Contribution

This repository is not open to external contribution yet. 
I you'd like to please send me an email.

## Built With

### Languages & Frameworks

- [Terraform](https://www.terraform.io/) is an open-source infrastructure-as-code tool that enables provisioning, management, and versioning of cloud, on-premises, and third-party resources using declarative configuration files.

## License

See the [LICENSE.md](./LICENSE.md) of the repository.
