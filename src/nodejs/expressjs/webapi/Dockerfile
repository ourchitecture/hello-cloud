FROM docker.io/library/node:17.0.1-alpine3.12 as base

FROM base as dependencies

WORKDIR /app

COPY package.json yarn.lock .yarnrc /app/
COPY .yarn/ /app/.yarn/

RUN yarn --frozen-lockfile

FROM dependencies as production

COPY . /app/

WORKDIR /app

ENTRYPOINT [ "node", "./index.js" ]
