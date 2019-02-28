FROM node:11-slim

LABEL version="1.0.0"
LABEL repository="https://github.com/lightspeedretail/lerna-monorepo"
LABEL homepage="https://github.com/lightspeedretail/lerna-monorepo"
LABEL maintainer="jorisdesmedt-ls"

LABEL com.github.actions.name="GitHub Action to check if an app has changed"
LABEL com.github.actions.description="Wraps the lerna CLI and check if an app has changed"
LABEL com.github.actions.icon="package"
LABEL com.github.actions.color="yellow"

RUN yarn global add lerna

COPY "entrypoint.sh" "/entrypoint.sh"

ENTRYPOINT ["/entrypoint.sh"]