resource "aws_cloudwatch_log_group" "log_group" {
  name = var.log_group_name
  # Optionally, you can add more configurations like retention_in_days
}