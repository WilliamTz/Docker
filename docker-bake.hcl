group "default" {
  targets = ["web"]
}

target "web" {
  context = "."
  dockerfile = "Dockerfile"
  tags = ["DOCKER_pepebotella911/my-image:latest"]
}
