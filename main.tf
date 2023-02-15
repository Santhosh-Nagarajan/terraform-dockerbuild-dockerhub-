terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.1"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.2.1"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}
provider "null" {
  # Configuration options
}


# Pulls the image
/*
resource "docker_image" "httpd" {
  name = var.image
}
*/

resource "docker_image" "zoo" {
  name = "san"
  build {
    context = "."
    tag     = [var.tag]
    build_arg = {
      foo : "san"
    }
    label = {
      author : "zoo"
    }
  }
}


# docker cmds 
resource "null_resource" "demo" {
  provisioner "local-exec" {
    command = " docker tag ${var.tag} santhoshsp/httpd:v1 && docker login -u ${var.username} -p ${var.password} && docker push santhoshsp/httpd:v1"
  }
}

/*

# Create a container
resource "docker_container" "dockerhub" {
  image = docker_image.httpd.image_id
  name  = "dockerhub"
}
*/
