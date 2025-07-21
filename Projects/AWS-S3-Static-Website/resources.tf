# -----------------------------------------------------------------------------
# Create an S3 bucket for static website hosting
# -----------------------------------------------------------------------------
resource "aws_s3_bucket" "static-web-bucket-name" {
  bucket = "jagadishv-static-website-bucket-${var.aws_region}"
}

# -----------------------------------------------------------------------------
# Allow public access by modifying the S3 bucket public access block settings
# -----------------------------------------------------------------------------
resource "aws_s3_bucket_public_access_block" "static-web-bucket-acces" {
  bucket = aws_s3_bucket.static-web-bucket-name.id

  # Disable all blocking options so we can allow public read access
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# -----------------------------------------------------------------------------
# Upload index.html to the S3 bucket
# -----------------------------------------------------------------------------
resource "aws_s3_object" "index" {
  bucket       = aws_s3_bucket.static-web-bucket-name.id
  key          = "index.html"
  source       = "index.html"        # Local path to the file
  content_type = "text/html"
}

# -----------------------------------------------------------------------------
# Upload error.html to the S3 bucket
# -----------------------------------------------------------------------------
resource "aws_s3_object" "error" {
  bucket       = aws_s3_bucket.static-web-bucket-name.id
  key          = "error.html"
  source       = "error.html"
  content_type = "text/html"
}

# -----------------------------------------------------------------------------
# Enable static website hosting configuration on the S3 bucket
# -----------------------------------------------------------------------------
resource "aws_s3_bucket_website_configuration" "static-website-config" {
  bucket = aws_s3_bucket.static-web-bucket-name.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

# -----------------------------------------------------------------------------
# Attach a bucket policy to allow public read access to all objects
# Depends on public access block being correctly configured
# -----------------------------------------------------------------------------
resource "aws_s3_bucket_policy" "public_read" {
  bucket = aws_s3_bucket.static-web-bucket-name.id

  # Define the policy to allow public read access to all objects
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Principal = "*",
        Action    = "s3:GetObject",
        Resource  = "${aws_s3_bucket.static-web-bucket-name.arn}/*"
      }
    ]
  })

  # Ensure this policy is only applied after public access block is set
  depends_on = [
    aws_s3_bucket_public_access_block.static-web-bucket-acces
  ]
}
