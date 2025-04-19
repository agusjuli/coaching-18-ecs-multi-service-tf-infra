// modules/s3/main.tf
resource "aws_s3_bucket" "upload_bucket" {
  bucket = "ecs-service-upload-bucket-${random_id.bucket_id.hex}"
  force_destroy = true
}

resource "random_id" "bucket_id" {
  byte_length = 4
}




