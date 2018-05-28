FROM elixir:1.6.0-slim

MAINTAINER Jack Marchant "jack@jackmarchant.com"

RUN apt-get update && \
    apt-get install -y inotify-tools && \
    mix local.hex --force && \
    mix local.rebar --force