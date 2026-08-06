# tf-azurerm-module_primitive-signalr

[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![License: CC BY-NC-ND 4.0](https://img.shields.io/badge/License-CC_BY--NC--ND_4.0-lightgrey.svg)](https://creativecommons.org/licenses/by-nc-nd/4.0/)

## Overview

This module is managed via the Launch Terraform skeleton.

## Usage

See [examples/complete](examples/complete) for a full working example.

## Module Development

### Pre-Requisites

The following commands should be available on your system:

- `asdf` or `mise`
- `make`
- `python3` (for pre-commit)

Additionally, your `git` user and email must be configured. Run the `make configure` command from the root of the repository to ensure that you meet these requirements.

### Pre-Commit hooks

The [.pre-commit-config.yaml](.pre-commit-config.yaml) file defines `pre-commit` hooks for Terraform formatting, validation, documentation generation, and detect-secrets. Hooks are installed when you run `make configure`. Go linting runs via `make lint` in local development and CI, not via pre-commit.

### Terratest examples

Post-deploy tests in `tests/post_deploy_functional/` and `tests/post_deploy_functional_readonly/` target `examples/complete` via an explicit folder constant in each `main_test.go`. Adding another example requires a new test entry point or updating that constant; it is not picked up automatically.

### Local Validation

You should validate the changes you make to any module locally, prior to pushing your changes in a branch to GitHub.

1. Ensure that you have run `make configure` successfully.
2. Ensure you are signed into the appropriate cloud provider (e.g. Azure) for the module under test in your current console session.
3. Run the Terraform and Golang linters:

```
make lint
```

4. Once linters pass, run integration tests (apply, test, destroy):

```
make test
```

The pre-commit validations, as well as the `make lint` and `make test` targets, are performed in CI. Running them locally before opening a PR helps ensure a smooth review.

### Review & Merge Process

Open a Pull Request to the default (`main`) branch. The PR title must follow [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/#specification) format to merge and to drive semantic versioning.

Ensure CI workflows pass, address review feedback, and obtain approvals required by `CODEOWNERS`.

### Automatic Updates

Shared configuration and workflow files are largely managed through [launch-terraform-skeleton](https://github.com/launchbynttdata/launch-terraform-skeleton). Avoid one-off edits to copied skeleton files in this repository unless necessary (for example `.gitignore` entries for generated artifacts). Use `copier check-update` / `copier update` when refreshing from the skeleton.


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.3 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.117 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_signalr_service.signalr](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/signalr_service) | resource |
| [azurerm_signalr_service_network_acl.acl](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/signalr_service_network_acl) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_connectivity_logs_enabled"></a> [connectivity\_logs\_enabled](#input\_connectivity\_logs\_enabled) | Indicates whether to enable connectivity logs | `bool` | `false` | no |
| <a name="input_cors_allowed_origins"></a> [cors\_allowed\_origins](#input\_cors\_allowed\_origins) | The allowed origins for CORS, separated by comma. The default is set to ["*"] which will allow all origins | `list(string)` | <pre>[<br/>  "*"<br/>]</pre> | no |
| <a name="input_http_request_logs_enabled"></a> [http\_request\_logs\_enabled](#input\_http\_request\_logs\_enabled) | Indicates whether to enable http request logs | `bool` | `false` | no |
| <a name="input_live_trace_enabled"></a> [live\_trace\_enabled](#input\_live\_trace\_enabled) | Indicates whether to enable live traces | `bool` | `false` | no |
| <a name="input_messaging_logs_enabled"></a> [messaging\_logs\_enabled](#input\_messaging\_logs\_enabled) | Indicates whether to enable messaging logs | `bool` | `false` | no |
| <a name="input_network_acl"></a> [network\_acl](#input\_network\_acl) | The SignalR network ACL configuration | <pre>object({<br/>    default_action        = string<br/>    allowed_request_types = list(string)<br/>  })</pre> | `null` | no |
| <a name="input_private_endpoints"></a> [private\_endpoints](#input\_private\_endpoints) | The private endpoints for the SignalR network ACL | <pre>list(object({<br/>    private_endpoint_id   = string<br/>    allowed_request_types = list(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Indicates whether public network access is allowed | `bool` | `true` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Resource group name of the SignalR Service | `string` | n/a | yes |
| <a name="input_service_mode"></a> [service\_mode](#input\_service\_mode) | The service mode of the SignalR Service. Possible values are Default, Classic, and Serverless | `string` | `"Default"` | no |
| <a name="input_signalr_location"></a> [signalr\_location](#input\_signalr\_location) | Location of the SignalR Service | `string` | n/a | yes |
| <a name="input_signalr_name"></a> [signalr\_name](#input\_signalr\_name) | Name of the signalr to create | `string` | n/a | yes |
| <a name="input_sku_capacity"></a> [sku\_capacity](#input\_sku\_capacity) | The capacity of the SKU.  See [the documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/signalr_service#capacity-1) for possible values. | `number` | `1` | no |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | The SKU of the SignalR Service. Possible values are Free\_F1, Standard\_S1, Premium\_P1, and Premium\_P2 | `string` | `"Free_F1"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |
| <a name="input_upstream_endpoint"></a> [upstream\_endpoint](#input\_upstream\_endpoint) | The upstream endpoint configuration | <pre>object({<br/>    category_pattern = optional(list(string))<br/>    event_pattern    = optional(list(string))<br/>    hub_pattern      = optional(list(string))<br/>    url_template     = optional(string)<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_location"></a> [location](#output\_location) | n/a |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | n/a |
| <a name="output_signalr_id"></a> [signalr\_id](#output\_signalr\_id) | n/a |
| <a name="output_signalr_name"></a> [signalr\_name](#output\_signalr\_name) | n/a |
<!-- END_TF_DOCS -->
