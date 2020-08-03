resource "digitalocean_droplet" "jenkins" {
	image = "ubuntu-18-04-x64"
	name = "ServerJenkins"
	region = "nyc1"
	size = "1gb"
	private_networking = true
	user_data = file("userdata.yaml")
	ssh_keys = [digitalocean_ssh_key.key.fingerprint]

    connection {
        type = "ssh"
        host = digitalocean_droplet.jenkins.ipv4_address
        private_key = file("./server_keys/id_rsa")
        port = 22
        timeout = "3m"
        user = "root"
    }

	provisioner "file" {
        source = "${var.file_path}/docker-compose.yml"
        destination = "/home/docker-compose.yml"
    }

  provisioner "file" {
        source = "${var.file_path}/docker"
        destination = "/home/docker"
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
    value = digitalocean_droplet.jenkins.ipv4_address
}
