locals {
  prefix     = "${var.environment}-${var.app_name}"
  tag_prefix = "${var.environment}:${var.app_name}"
}
