resource "aws_cloudwatch_metric_alarm" "web_server-alarm" {
  alarm_name          = "Web-Server-Alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = 0.99
  alarm_description   = "Monitors the web server for CPU usage"
  # alarm_actions = [ aws_sns_topic.clw-topic.arn ]
}
