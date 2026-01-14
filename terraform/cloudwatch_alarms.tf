resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name          = "HighCPUUtilization"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "CPU > 80% for 2 minutes"
  dimensions = {
    InstanceId = aws_instance.portfolio_ec2.id
  }
}

resource "aws_cloudwatch_log_metric_filter" "error_filter" {
  name           = "FlaskAppErrors"
  log_group_name = "portfolio-docker"

  pattern = "ERROR"

  metric_transformation {
    name      = "FlaskErrorCount"
    namespace = "PortfolioApp"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "error_alarm" {
  alarm_name          = "FlaskErrorAlarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "FlaskErrorCount"
  namespace           = "PortfolioApp"
  period              = 60
  statistic           = "Sum"
  threshold           = 5
}

