output "certificate_arn" {
    description = "Self-signed cert ARN"
    value = aws_acm_certificate.self_signed.arn
}