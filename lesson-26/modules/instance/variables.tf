variable "type" {
  type    = string
  default = "t2.micro"
}

variable "instance_count" {
  type    = number
  default = 1
}

variable "key_name" {
  type        = string
  description = "description"
}

variable "name" {
  type = string
}

variable "nginx_port" {
  type    = number
  default = 8181
}

variable "security_group_id" {
  type        = string
  default     = ""
  description = "SG ID"

  validation {
    condition     = var.security_group_id == "" || startswith(var.security_group_id, "sg-")
    error_message = "Security Group Id must start with the prefix sg-."
  }
}
variable "disk_size" {
  type    = number
  default = 10
}
variable "disk_type" {
  type    = string
  default = "gp2"

  validation {
    condition     = var.disk_type == "gp2" || var.disk_type == "gp3" || var.disk_type == "standard"
    error_message = "Valid disk types only gp2, gp3 or standard."
  }
}
variable "create_ssm_role" {
  type    = string
  default = "false"
}
