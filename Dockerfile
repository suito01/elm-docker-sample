FROM nginx:1.17.4

LABEL maintainer "suito01 <suito.y@gmail.com>"

# setup nodejs for npm
RUN set -x \
    && apt-get update \
    && apt-get install -y \
    gnupg=2.2.12-1+deb10u1 \
    curl=7.64.0-4 \
    && curl -sL https://deb.nodesource.com/setup_10.x | bash - \
    && apt-get install -y nodejs \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy source file
WORKDIR /usr/local/src/elm-docker-sample
COPY index.html package.json package-lock.json elm.json /usr/local/src/elm-docker-sample/
COPY src/ /usr/local/src/elm-docker-sample/src/
COPY js/ /usr/local/src/elm-docker-sample/js/

# Transpile
RUN set -x && npm install
RUN set -x && npm run build
RUN set -x && rm -rf /usr/share/nginx/html/* && cp -p dist/* /usr/share/nginx/html/

# Publish on 80 ports
EXPOSE 80