output "log_group_arn" {
  value       = aws_cloudwatch_log_group.log_group.arn
  description = "The ARN of the CloudWatch Log Group"
}