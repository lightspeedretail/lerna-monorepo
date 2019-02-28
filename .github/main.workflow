workflow "New workflow" {
  on = "push"
  resolves = ["app1 version", "app2 version"]
}

action "Features" {
  uses = "actions/bin/filter@712ea355b0921dd7aea27d81e247c48d0db24ee4"
  args = "branch feature*"
}

action "App1 changed" {
  uses = "./.github/actions/app-changed"
  needs = ["Features"]
  args = "@mono/app1"
}

action "App2 Changed" {
  uses = "./.github/actions/app-changed"
  needs = ["Features"]
  args = "@mono/app2"
}

action "app1 version" {
  uses = "actions/npm@59b64a598378f31e49cb76f27d6f3312b582f680"
  needs = ["App1 changed"]
  args = "--version"
}

action "app2 version" {
  uses = "actions/npm@59b64a598378f31e49cb76f27d6f3312b582f680"
  needs = ["App2 Changed"]
  args = "--version"
}
