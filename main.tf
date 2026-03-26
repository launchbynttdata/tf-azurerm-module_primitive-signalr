// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

resource "azurerm_signalr_service" "signalr" {
  name                = var.signalr_name
  location            = var.signalr_location
  resource_group_name = var.resource_group_name

  public_network_access_enabled = var.public_network_access_enabled
  connectivity_logs_enabled     = var.connectivity_logs_enabled
  http_request_logs_enabled     = var.http_request_logs_enabled
  messaging_logs_enabled        = var.messaging_logs_enabled
  service_mode                  = var.service_mode

  sku {
    name     = var.sku_name
    capacity = var.sku_capacity
  }

  dynamic "cors" {
    for_each = var.cors_allowed_origins != null ? ["cors"] : []
    content {
      allowed_origins = var.cors_allowed_origins
    }
  }

  dynamic "live_trace" {
    for_each = var.live_trace_enabled == true ? ["live_trace"] : []
    content {
      enabled                   = true
      messaging_logs_enabled    = var.messaging_logs_enabled
      connectivity_logs_enabled = var.connectivity_logs_enabled
      http_request_logs_enabled = var.http_request_logs_enabled
    }
  }

  dynamic "upstream_endpoint" {
    for_each = var.upstream_endpoint != null ? ["upstream_endpoint"] : []
    content {
      category_pattern = upstream_endpoint.value["category_pattern"]
      event_pattern    = upstream_endpoint.value["event_pattern"]
      hub_pattern      = upstream_endpoint.value["hub_pattern"]
      url_template     = upstream_endpoint.value["url_template"]
    }
  }

  tags = merge(local.tags, { resource_name = var.signalr_name })

  lifecycle {
    ignore_changes = [sku[0].capacity]
  }
}

resource "azurerm_signalr_service_network_acl" "acl" {
  for_each           = var.network_acl != null ? toset(["network_acl"]) : []
  signalr_service_id = azurerm_signalr_service.signalr.id
  default_action     = var.network_acl.default_action

  public_network {
    allowed_request_types = var.network_acl.allowed_request_types != null ? var.network_acl.allowed_request_types : null
  }

  dynamic "private_endpoint" {
    for_each = var.private_endpoints != null ? var.private_endpoints : []
    content {
      id                    = private_endpoint.value.private_endpoint_id
      allowed_request_types = private_endpoint.value.allowed_request_types
    }
  }

}
