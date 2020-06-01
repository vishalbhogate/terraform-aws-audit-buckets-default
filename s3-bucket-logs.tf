resource aws_s3_bucket "logs" {
  bucket = "${var.org_name}-audit-config-${data.aws_region.current.name}"
  acl    = "Private"
  #policy

  lifecycle {
    ignore_changes = [versioning, grant]
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  lifecycle_rule {
    id      = "ARCHVING"
    enabled = true

    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    transition {
      days          = var.s3_days_until_glacier
      storage_class = "GLACIER"
    }
  }
}
