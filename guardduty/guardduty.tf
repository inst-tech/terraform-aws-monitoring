data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

resource "aws_guardduty_detector" "guardduty" {
  enable                       = true
  finding_publishing_frequency = "FIFTEEN_MINUTES"
  tags                         = var.default_tags
}

resource "aws_guardduty_organization_configuration" "guardduty" {
  auto_enable = true
  detector_id = aws_guardduty_detector.guardduty.id
}

module "guardduty" {
  source            = "../eventbridge"
  actions           = var.actions
  default_tags      = var.default_tags
  event_detail_type = "AWS GuardDuty event findings"
  event_name        = "guardduty_findings"
  prefix            = var.prefix
}

data "aws_iam_policy_document" "guardduty_put_findings" {
  statement {
    sid = "Allow PutObject"
    actions = [
      "s3:PutObject"
    ]

    resources = [
      "${aws_s3_bucket.guardduty.arn}/*"
    ]

    principals {
      type        = "Service"
      identifiers = ["guardduty.amazonaws.com"]
    }
  }

  statement {
    sid = "Allow GetBucketLocation"
    actions = [
      "s3:GetBucketLocation"
    ]

    resources = [
      aws_s3_bucket.guardduty.arn
    ]

    principals {
      type        = "Service"
      identifiers = ["guardduty.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "guardduty_encrypt_findings" {

  statement {
    sid = "Allow GuardDuty to encrypt findings"
    actions = [
      "kms:GenerateDataKey"
    ]

    resources = [
      "arn:aws:kms:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:key/*"
    ]

    principals {
      type        = "Service"
      identifiers = ["guardduty.amazonaws.com"]
    }
  }

  statement {
    sid = "Allow all users to modify/delete key (test only)"
    actions = [
      "kms:*"
    ]

    resources = [
      "arn:aws:kms:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:key/*"
    ]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
  }

}

resource "aws_s3_bucket" "guardduty" {
  bucket_prefix = "guardduty-findings"
  acl           = "private"
  force_destroy = true
}

resource "aws_s3_bucket_policy" "guardduty" {
  bucket = aws_s3_bucket.guardduty.id
  policy = data.aws_iam_policy_document.guardduty_put_findings.json
}

resource "aws_kms_key" "guardduty" {
  description             = "Temporary key for AccTest of TF"
  deletion_window_in_days = 7
  policy                  = data.aws_iam_policy_document.guardduty_encrypt_findings.json
}

resource "aws_guardduty_publishing_destination" "guardduty" {
  detector_id     = aws_guardduty_detector.guardduty.id
  destination_arn = aws_s3_bucket.guardduty.arn
  kms_key_arn     = aws_kms_key.guardduty.arn

  depends_on = [
    aws_s3_bucket_policy.guardduty,
  ]
}
