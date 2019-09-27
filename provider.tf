variable "do_token" {}
variable "file_path" {}
provider "digitalocean" {
	token = var.do_token
}
