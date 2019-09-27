resource "digitalocean_domain" "jenkins" {
  name = "${var.domain}"
}

resource "digitalocean_record" "www" {
  domain = "${digitalocean_domain.jenkins.name}"
  name = "jenkins"
  type = "A"
  value = "${digitalocean_droplet.jenkins.ipv4_address}"
}