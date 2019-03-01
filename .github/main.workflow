workflow "New workflow" {
  on = "push"
  resolves = ["r.j3ss.co/img"]
}

action "r.j3ss.co/img" {
  uses = "docker://r.j3ss.co/img"
  args = "build -f gomplate-ci-build/Dockerfile gomplate-ci-build"
}
