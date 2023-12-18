FROM ghcr.io/getzola/zola:v0.17.2 as zola

COPY . /blog
WORKDIR /blog

RUN ["zola", "build"]


FROM ghcr.io/static-web-server/static-web-server:2

COPY --from=zola /blog/public /public
