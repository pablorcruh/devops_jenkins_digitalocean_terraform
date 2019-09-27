variable "do_token" {}
variable "file_path" {}
variable "domain" {}
provider "digitalocean" {
	token = var.do_token
}
