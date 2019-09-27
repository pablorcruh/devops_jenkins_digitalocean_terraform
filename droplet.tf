resource "digitalocean_droplet" "jenkins" {
	image = "ubuntu-18-04-x64"
	name = "example"
	region = "nyc1"
	size = "512mb"
	private_networking = true
	user_data = "${file("userdata.yaml")}"
	ssh_keys = ["${digitalocean_ssh_key.pablo.fingerprint}"]

    connection {
        type = "ssh"
        host = "${digitalocean_droplet.jenkins.ipv4_address}"
        private_key = "${file("mykey")}"
        port = 22
        timeout = "3m"
        user = "root"
    }

	provisioner "file" {
        source = "${var.file_path}/docker-compose.yml"
        destination = "/home/docker-compose.yml"
    }

    provisioner "remote-exec" {
      inline = [
        "cd /home",
        "mkdir jenkins_home",
        "useradd jenkins",
        "chown jenkins:jenkins jenkins_home -R"
      ]
    }
}

output "ip" {
    value = "${digitalocean_droplet.jenkins.ipv4_address}"
}