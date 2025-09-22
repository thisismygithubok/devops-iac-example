### Route 53 Resources ###

# R53 - Hosted Zone
resource "aws_route53_zone" "public_zone" {
    name = "${var.hosted_zone_name}"
    comment = "Hosted Zone for DevOps Challenge"
}

# R53 - DNS Record - Alias - IPv4
resource "aws_route53_record" "devops_challenge_webserver_r53_ipv4" {
    zone_id = aws_route53_zone.public_zone.id
    name = "www.${var.hosted_zone_name}"
    type = "A"
    
    alias {
        name = var.public_alb_dns_name
        zone_id = var.public_alb_dns_zone_id
        evaluate_target_health = true
    }
}

# R53 - DNS Record - Alias - IPv6
resource "aws_route53_record" "devops_challenge_webserver_r53_ipv6" {
    zone_id = aws_route53_zone.public_zone.id
    name = "www.${var.hosted_zone_name}"
    type = "AAAA"
    
    alias {
        name = var.public_alb_dns_name
        zone_id = var.public_alb_dns_zone_id
        evaluate_target_health = true
    }
}