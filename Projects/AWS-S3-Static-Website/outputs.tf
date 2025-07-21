# Output the S3 static website endpoint URL
output "website_url" {
  value       = aws_s3_bucket_website_configuration.static-website-config.website_endpoint
  description = "URL to access the static website hosted on S3"
}
