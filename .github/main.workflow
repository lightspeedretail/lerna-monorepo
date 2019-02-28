workflow "App1 Workflow" {
  on = "repository_dispatch"
  resolves = ["GitHub Action for npm"]
}

workflow "App2 Workflow" {
  on = "repository_dispatch"
  resolves = ["GitHub Action for npm-1"]
}

workflow "Feature Common" {
  on = "push"
  resolves = ["Trigger Apps WF"]
}

action "Features" {
  uses = "actions/bin/filter@712ea355b0921dd7aea27d81e247c48d0db24ee4"
  args = "branch feature*"
}

action "test" {
  uses = "nuxt/actions-yarn@master"
  args = "test"
  needs = ["Features"]
}

action "typecheck" {
  uses = "nuxt/actions-yarn@master"
  args = "typecheck"
  needs = ["Features"]
}

action "lint" {
  uses = "nuxt/actions-yarn@master"
  args = "lint"
  needs = ["Features"]
}

action "Trigger Apps WF" {
  uses = "swinton/httpie.action@8ab0a0e926d091e0444fcacd5eb679d2e2d4ab3d"
  needs = ["lint", "typecheck", "test"]
  args = ["--auth-type=jwt", "--auth=$PAT", "POST", "api.github.com/repos/$GITHUB_REPOSITORY/dispatches", "Accept:application/vnd.github.everest-preview+json", "event_type=demo"]
  secrets = ["PAT"]
}

action "app1 changed?" {
  uses = "./.github/actions/app-changed"
  args = "@mono/app1"
}

action "GitHub Action for npm" {
  uses = "actions/npm@59b64a598378f31e49cb76f27d6f3312b582f680"
  args = "--version"
  needs = ["app1 changed?"]
}

action "App2 changed" {
  uses = "./.github/actions/app-changed"
  args = "@mono/app2"
}

action "GitHub Action for npm-1" {
  uses = "actions/npm@59b64a598378f31e49cb76f27d6f3312b582f680"
  needs = ["App2 changed"]
  args = "--version"
}
