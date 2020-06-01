data aws_region "current" {}

data aws_caller_identity "current" {}

data aws_iam_policy_document "config" {

  statement {
    sid    = "ConfigLogs"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["config.amazonaws.com"]
    }
    actions = [
      "s3:PutObject"
    ]
    resources = [
      "arn:aws:s3:::${var.org_name}-audit-config-${data.aws_region.current.name}/*"
    ]
  }

  statement {
    sid    = "ConfigGetACL"
    effect = "Allow"
    actions = [
      "s3:GetBucketAcl"
    ]
    resources = [
      "arn:aws:s3:::${var.org_name}-audit-config-${data.aws_region.current.name}/*"
    ]
    principals {
      type        = "Service"
      identifiers = ["config.amazonaws.com"]
    }
  }

  statement {
    sid    = "OrgAccount"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = formatlist("arn:aws:iam::%s:root", var.account_ids)
    }
    actions = [
      "s3:PutObject"
    ]
    resources = [
      "arn:aws:s3:::${var.org_name}-audit-config-${data.aws_region.current.name}/*"
    ]
  }

  statement {
    sid    = "OrgAccountAcl"
    effect = "Allow"
    actions = [
      "s3:GetBucketAcl",
      "s3:PutBucketAcl"
    ]
    resources = [
      "arn:aws:s3:::${var.org_name}-audit-config-${data.aws_region.current.name}/*"
    ]
    principals {
      type        = "AWS"
      identifiers = formatlist("arn:aws:iam::%s:root", var.account_ids)
    }
  }
}