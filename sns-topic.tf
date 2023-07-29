resource "aws_sns_topic" "clw-topic" {
    name = "Web-Server_Threshold_Topic"
    delivery_policy = <<EOF
       {
        "http": {
            "defaultHealthyRetryPolicy": {
            "minDelayTarget": 20,
            "maxDelayTarget": 20,
            "numRetries": 3,
            "numMaxDelayRetries": 0,
            "numNoDelayRetries": 0,
            "numMinDelayRetries": 0,
            "backoffFunction": "linear"
            },
            "disableSubscriptionOverrides": false,
            "defaultRequestPolicy": {
            "headerContentType": "text/plain; charset=UTF-8"
            }
  }
}
EOF
    provisioner "local-exec" {
    command = "aws sns subscribe --topic-arn ${self.arn} --protocol email --notification-endpoint ${var.your_email} --region ${var.region}"
  }

}

resource "sns_topic_policy" "topic-policy" {
    arn = aws_sns_topic.clw-topic.arn
    policy = data.aws_iam_policy_document.web-server-topic
}

data "aws_iam_policy_document" "web-server-topic" {
    policy_id = "__default_policy_ID"

    statement {
      actions = [
        "SNS:GetTopicAttributes",
        "SNS:SetTopicAttributes",
        "SNS:AddPermission",
        "SNS:RemovePermission",
        "SNS:DeleteTopic",
        "SNS:Subscribe",
        "SNS:ListSubscriptionsByTopic",
        "SNS:Publish"
      ] 

      condition {
        test = "StringEquals"
        variable = "AWS:SourceOwner"
        values = [
            var.account_id
        ]
      }   

      effect = "Allow"

      principals {
        type = "AWS"
        identifiers = [ "*" ]
      }

      resources = [
        aws_sns_topic.clw-topic.arn,
      ]

      sid = "__default_statement_ID"

    }
}