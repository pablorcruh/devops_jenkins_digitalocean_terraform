resource "digitalocean_ssh_key" "pablo" {
	name = "pablo"
	public_key = "${file("mykey.pub")}"
}
