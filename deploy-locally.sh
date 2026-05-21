#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HOST="${AIISP_HOST:-127.0.0.1}"
PORT="${AIISP_PORT:-4173}"
OPEN_BROWSER="${AIISP_OPEN_BROWSER:-1}"
RUNTIME_DIR="$ROOT_DIR/.runtime"
PID_FILE="$RUNTIME_DIR/aiisp-site.pid"
LOG_FILE="$RUNTIME_DIR/aiisp-site.log"
SITE_DIR="$ROOT_DIR/_site"
URL="http://$HOST:$PORT/"

mkdir -p "$RUNTIME_DIR"

stop_existing_server() {
  if [[ ! -f "$PID_FILE" ]]; then
    return
  fi

  local old_pid
  old_pid="$(cat "$PID_FILE" 2>/dev/null || true)"
  if [[ -n "$old_pid" ]] && kill -0 "$old_pid" 2>/dev/null; then
    printf 'Stopping existing AIISP preview server (pid %s)...\n' "$old_pid"
    kill "$old_pid" 2>/dev/null || true
    for _ in {1..30}; do
      if ! kill -0 "$old_pid" 2>/dev/null; then
        break
      fi
      sleep 0.1
    done
    if kill -0 "$old_pid" 2>/dev/null; then
      kill -9 "$old_pid" 2>/dev/null || true
    fi
  fi
  rm -f "$PID_FILE"
}

ensure_port_free() {
  if ! command -v lsof >/dev/null 2>&1; then
    return
  fi

  local listeners
  listeners="$(lsof -tiTCP:"$PORT" -sTCP:LISTEN 2>/dev/null || true)"
  if [[ -n "$listeners" ]]; then
    printf 'Port %s is already in use by process(es): %s\n' "$PORT" "$listeners" >&2
    printf 'Stop that process or run with AIISP_PORT=<free-port>.\n' >&2
    exit 1
  fi
}

build_with_static_fallback() {
  cd "$ROOT_DIR"
  if [[ -f Gemfile ]] && command -v bundle >/dev/null 2>&1; then
    bundle exec jekyll build --strict_front_matter
    return
  fi

  if command -v jekyll >/dev/null 2>&1; then
    jekyll build --strict_front_matter
    return
  fi

  printf 'Jekyll not found; using static copy fallback.\n'
  rm -rf "$SITE_DIR"
  mkdir -p "$SITE_DIR"
  cp index.html "$SITE_DIR/index.html"
  cp spec.html "$SITE_DIR/spec.html"
  cp README.md "$SITE_DIR/README.md"
  cp GOVERNANCE.md "$SITE_DIR/GOVERNANCE.md"
  cp CONTRIBUTING.md "$SITE_DIR/CONTRIBUTING.md"
  cp CODE_OF_CONDUCT.md "$SITE_DIR/CODE_OF_CONDUCT.md"
  cp SECURITY.md "$SITE_DIR/SECURITY.md"
  cp CHANGELOG.md "$SITE_DIR/CHANGELOG.md"
  cp LICENSE "$SITE_DIR/LICENSE"
  cp -R LICENSES "$SITE_DIR/LICENSES"
  cp -R spec "$SITE_DIR/spec"
  cp -R examples "$SITE_DIR/examples"
  cp -R reference "$SITE_DIR/reference"
  mkdir -p "$SITE_DIR/paper"
  cp -R paper/v1 "$SITE_DIR/paper/v1"
  cp -R paper/v2 "$SITE_DIR/paper/v2"
  find "$SITE_DIR" -name .DS_Store -delete
  find "$SITE_DIR" -name '*.tex' -delete
}

validate_build() {
  local missing=0
  local required_paths=(
    "$SITE_DIR/index.html"
    "$SITE_DIR/spec.html"
    "$SITE_DIR/spec/aiisp-2.md"
    "$SITE_DIR/spec/schemas/aiisp-2/index.html"
    "$SITE_DIR/examples/aiisp-2/index.html"
    "$SITE_DIR/paper/v1/index.html"
    "$SITE_DIR/paper/v2/index.html"
  )

  for required_path in "${required_paths[@]}"; do
    if [[ ! -e "$required_path" ]]; then
      printf 'Missing built path: %s\n' "$required_path" >&2
      missing=1
    fi
  done

  if find "$SITE_DIR" -name '*.tex' -print -quit | grep -q .; then
    printf 'Build contains LaTeX source files; refusing to serve.\n' >&2
    missing=1
  fi

  if [[ "$missing" -ne 0 ]]; then
    exit 1
  fi
}

start_server() {
  if ! command -v python3 >/dev/null 2>&1; then
    printf 'python3 is required to serve the local preview.\n' >&2
    exit 1
  fi

  : > "$LOG_FILE"
  local server_pid
  server_pid="$(
    python3 - "$PORT" "$HOST" "$SITE_DIR" "$LOG_FILE" <<'PY'
import subprocess
import sys

port, host, site_dir, log_file = sys.argv[1:]
log = open(log_file, "ab", buffering=0)
process = subprocess.Popen(
    [
        sys.executable,
        "-m",
        "http.server",
        port,
        "--bind",
        host,
        "--directory",
        site_dir,
    ],
    stdin=subprocess.DEVNULL,
    stdout=log,
    stderr=subprocess.STDOUT,
    start_new_session=True,
    close_fds=True,
)
print(process.pid)
PY
  )"
  printf '%s\n' "$server_pid" > "$PID_FILE"

  for _ in {1..60}; do
    if ! kill -0 "$server_pid" 2>/dev/null; then
      printf 'Preview server exited during startup. Log:\n' >&2
      cat "$LOG_FILE" >&2
      exit 1
    fi
    if curl -fsS "$URL" >/dev/null 2>&1; then
      return
    fi
    sleep 0.2
  done

  printf 'Preview server did not respond at %s. Log:\n' "$URL" >&2
  cat "$LOG_FILE" >&2
  exit 1
}

smoke_check() {
  local paths=(
    /
    /spec.html
    /spec/schemas/aiisp-2/
    /examples/aiisp-2/
    /paper/v1/
    /paper/v2/
    /reference/
  )

  for route in "${paths[@]}"; do
    curl -fsS "$URL${route#/}" >/dev/null
  done
}

open_site() {
  if [[ "$OPEN_BROWSER" == "0" ]]; then
    return
  fi

  if command -v open >/dev/null 2>&1; then
    open "$URL"
  elif command -v xdg-open >/dev/null 2>&1; then
    xdg-open "$URL" >/dev/null 2>&1 || true
  else
    printf 'No browser opener found. Open %s manually.\n' "$URL"
  fi
}

printf 'Building AIISP site...\n'
build_with_static_fallback
validate_build
stop_existing_server
ensure_port_free
start_server
smoke_check
printf 'AIISP site is running at %s\n' "$URL"
printf 'Server log: %s\n' "$LOG_FILE"
open_site
