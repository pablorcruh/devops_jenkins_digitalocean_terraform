resource "digitalocean_ssh_key" "pablo" {
	name = "pablo"
	public_key = file("./server_keys/id_rsa.pub")
}
