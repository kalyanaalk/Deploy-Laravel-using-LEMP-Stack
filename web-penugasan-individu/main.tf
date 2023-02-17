provider "digitalocean" {
  token = "dop_v1_075f5786097747c4412c096c6a47cbaa8bb1535902c9ad80eb812c37dae4d88f"
}

resource "digitalocean_droplet" "web" {
  image  = "ubuntu-20-04-x64"
  name   = "web-droplet"
  region = "sgp1"

  connection {
    type        = "ssh"
    user        = "root"
    private_key = file("~/.ssh/id_rsa")
    timeout     = "2m"
  }
}
