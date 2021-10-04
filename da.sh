#!/usr/bin/env bash

# da up [maildev db]
# da down
# da do [harbormaster] [$DA_CLI]
# da do db
# da do db bash
da() {
  mkdir -p ~/.da/.da-home/
  if [[ $1 == "do" ]]; then
    shift
    da_exec "$@"
  else
    USER=foo docker-compose -f docker-compose.yml -f docker-compose.override.yml "$@"
  fi
}

da_exec() {
  local where=${1:-long_service}
  if [[ $where == "ls" ]]; then
    where="long_service"
  fi

  local cmd=${2:-""}
  if [[ -z "$2" ]]; then
    cmd='$DA_CLI';
  fi
  da exec "$where" sh -lic "$cmd"
}

compdef da=docker-compose
