ARG ALPINE_VERSION=3.15.0
ARG PUPPETEER_VERSION=10.0.0

FROM alpine:${ALPINE_VERSION} as base

FROM base as packages

# Installs latest Chromium (92) package.
RUN apk add --no-cache \
      chromium \
      nss \
      freetype \
      harfbuzz \
      ca-certificates \
      ttf-freefont \
      nodejs \
      yarn \
      bash

FROM packages as puppeteer

ARG PUPPETEER_VERSION

# Tell Puppeteer to skip installing Chrome. We'll be using the installed package.
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser

# Puppeteer v10.0.0 works with Chromium 92.
RUN yarn add puppeteer@${PUPPETEER_VERSION}

# Add user so we don't need --no-sandbox.
RUN addgroup --system pptruser \
    && adduser --system --shell /bin/bash --gecos pptruser pptruser \
    && mkdir --parents /home/pptruser/Downloads /app /screenshots \
    && chown --recursive pptruser:pptruser /home/pptruser \
    && chown --recursive pptruser:pptruser /app \
    && chown --recursive pptruser:pptruser /screenshots

ENV SCREENSHOTS_PATH=/screenshots

# Run everything after as non-privileged user.
USER pptruser

WORKDIR /app

FROM puppeteer as production

COPY entrypoint.sh /entrypoint.sh

USER root

ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]

CMD ["node"]
