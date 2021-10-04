#!/usr/bin/env bash

# hma up [maildev db]
# hma down
# hma do [harbormaster] [$HM_CLI]
# hma do db
# hma do db bash
hma() {
  [ -d ~/.da/.da-home/ ]  || mkdir -p ~/.da/.da-home/
  if [[ $1 == "do" ]]; then
    shift
    hma_exec "$@"
  else
    USER=foo docker-compose -f docker-compose.yml -f docker-compose.override.yml "$@"
  fi
}

hma_exec() {
  local where=${1:-long_service}
  if [[ $where == "ls" ]]; then
    where="long_service"
  fi

  local cmd=${2:-""}
  if [[ -z "$2" ]]; then
    cmd='$HM_CLI';
  fi
  hma exec "$where" sh -lic "$cmd"
}

compdef hma=docker-compose
