group "default" {
  targets = ["web"]
}

target "web" {
  context = "."
  dockerfile = "Dockerfile"
  tags = ["DOCKER_USERNAME/my-image:latest"]
}
