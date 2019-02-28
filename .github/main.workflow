workflow "New workflow" {
  on = "push"
  resolves = [
    "App 1 changes",
    "App 2 changes",
    "Install dependencies App1",
    "Install dependencies App2"
  ]
}

action "Filters for GitHub Actions" {
  uses = "actions/bin/filter@712ea355b0921dd7aea27d81e247c48d0db24ee4"
  args = "branch feature*"
}

action "Install dependencies App1" {
  uses = "nuxt/actions-yarn@master"
  needs = ["App 1 changes"]
  args = "install"
}

action "Install dependencies App2" {
  uses = "nuxt/actions-yarn@master"
  needs = ["App 2 changes"]
  args = "install"
}

action "App 1 changes" {
  uses = "nuxt/actions-yarn@master"
  needs = ["Filters for GitHub Actions"]
  args = "--silent app-changed @mono/app1"
}

action "App 2 changes" {
  uses = "nuxt/actions-yarn@master"
  needs = ["Filters for GitHub Actions"]
}
