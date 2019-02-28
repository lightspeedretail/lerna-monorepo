workflow "New workflow" {
  on = "push"
  resolves = ["Check for changes"]
}

action "Filters for GitHub Actions" {
  uses = "actions/bin/filter@712ea355b0921dd7aea27d81e247c48d0db24ee4"
  args = "branch feature*"
}

action "Install dependencies" {
  uses = "nuxt/actions-yarn@master"
  needs = ["Filters for GitHub Actions"]
  args = "install"
}

action "Check for changes" {
  uses = "nuxt/actions-yarn@master"
  args = "lerna:changed"
  needs = ["Install dependencies"]
}
