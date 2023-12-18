FROM ghcr.io/getzola/zola:v0.18.0 as zola

COPY . /blog
WORKDIR /blog

RUN ["zola", "build"]


FROM ghcr.io/static-web-server/static-web-server:2

ENV SERVER_LOG_LEVEL="info"
COPY --from=zola /blog/public /public
