FROM bitwalker/alpine-elixir:latest

WORKDIR /app

EXPOSE 4000

ENV PORT=4000
ENV MIX_ENV=prod
ENV SECRET_KEY_BASE=${SECRET_KEY_BASE}

COPY --from=build-context . .

RUN apk add --no-cache \
    erlang \
    elixir \
    git \
    make \
    gcc \
    libc-dev \
    zlib-dev \
    openssl-dev \
    sqlite-dev \
    icu

RUN mix deps.get --only-packages

RUN escript -e "mix compile"

USER root
CMD ["elixir", "phx.server"]