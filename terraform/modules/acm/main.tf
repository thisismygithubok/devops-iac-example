### Certificate Resources ###

# Generate Private Key
resource "tls_private_key" "private_key" {
    algorithm = "RSA"
    rsa_bits = 2048
}

# Generate Self-Signed Cert
resource "tls_self_signed_cert" "self_signed_cert" {
    private_key_pem = tls_private_key.private_key.private_key_pem
    validity_period_hours = 8760 # 1 year
    allowed_uses = [
        "key_encipherment",
        "digital_signature",
        "server_auth"
    ]

    subject {
        common_name = "www.${var.domain_name}"
        organization = "DevOps Challenge, LLC"
    }
}

# ACM - Import Self-Signed Cert
resource "aws_acm_certificate" "self_signed" {
    private_key = tls_private_key.private_key.private_key_pem
    certificate_body = tls_self_signed_cert.self_signed_cert.cert_pem
}