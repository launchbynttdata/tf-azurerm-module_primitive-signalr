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

variable "resource_group_name" {
  description = "(Require) Resource group name of the SignalR Service"
  type        = string
  nullable    = false
}

variable "signalr_location" {
  description = "(Require) Location of the SignalR Service"
  type        = string
  nullable    = false
}

variable "signalr_name" {
  description = "(Require) Name of the signalr to create"
  type        = string
  nullable    = false
}

variable "public_network_access_enabled" {
  description = "(Optional) Indicates whether public network access is allowed"
  type        = bool
  default     = true
}

variable "connectivity_logs_enabled" {
  description = "(Optional) Indicates whether to enable connectivity logs"
  type        = bool
  default     = false
}

variable "http_request_logs_enabled" {
  description = "(Optional) Indicates whether to enable http request logs"
  type        = bool
  default     = false
}

variable "live_trace_enabled" {
  description = "(Optional) Indicated whether to enable live traces"
  type        = bool
  default     = false
}

variable "messaging_logs_enabled" {
  description = "(Optional) Indicates whether to enable messaging logs"
  type        = bool
  default     = false
}

variable "service_mode" {
  description = "(Optional) The service mode of the SignalR Service"
  type        = string
  default     = "Default"
}

variable "sku_name" {
  description = "(Optional) The SKU of the SignalR Service"
  type        = string
  default     = "Free_F1"
}

variable "sku_capacity" {
  description = "(Optional) The capacity of the SKU"
  type        = number
  default     = 1
}

variable "cors_allowed_origins" {
  description = "(Optional) The allowed origins for CORS, separated by comma"
  type        = list(string)
  default     = []
}

variable "upstream_endpoint" {
  description = "(Optional) The upstream endpoint configuration"
  type = object({
    category_pattern = optional(list(string))
    event_pattern    = optional(list(string))
    hub_pattern      = optional(list(string))
    url_template     = optional(string)
  })
  default = null
}

variable "private_endpoint_id" {
  description = "(Optional) The ID of the private endpoint"
  type        = string
  default     = null
}

variable "tags" {
  description = "(Optional) A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}
