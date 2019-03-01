workflow "New workflow" {
  on = "push"
  resolves = [
    "docker build",
    "GitHub Action for Docker",
  ]
}

action "docker build" {
  uses = "actions/docker/cli@8cdf801b322af5f369e00d85e9cf3a7122f49108"
  args = "build -f gomplate-ci-build/Dockerfile -t hairyhenderson/gomplate-ci-build gomplate-ci-build"
}

action "GitHub Action for Docker" {
  uses = "actions/docker/cli@8cdf801b322af5f369e00d85e9cf3a7122f49108"
  args = "version"
}
