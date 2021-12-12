resource "aws_route53_zone" "mydomain-com" {
  name = "mydomain.com"
}

resource "aws_route53_record" "server1-record" {
  zone_id = aws_route53_zone.mydomain-com.zone_id
  name    = "server1.mydomain.com"
  type    = "A"
  ttl     = "300"
  records = ["${aws_eip.example-eip.public_ip}"]
}

resource "aws_route53_record" "www-record" {
  zone_id = aws_route53_zone.mydomain-com.zone_id
  name    = "www.mydomain.com"
  type    = "A"
  ttl     = "300"
  records = ["4.4.4.4"]
}

resource "aws_route53_record" "mail-record" {
  zone_id = aws_route53_zone.mydomain-com.zone_id
  name    = "mydomain.com"
  type    = "MX"
  ttl     = "300"
  records = [
    "1 aspmx.l.google.com.",
    "5 alt1.aspmx.l.google.com.",
    "5 alt2.aspmx.l.google.com."
  ]
}

// display the name servers that can be used in another registar service
output "route53_name_servers" {
  value = aws_route53_zone.mydomain-com.name_servers
}