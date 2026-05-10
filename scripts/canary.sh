#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"
ENV_FILE="$ROOT_DIR/.env"

set_weights() {
    local v1_params="$1"
    local v2_params="$2"
    V1_PARAMS="$v1_params" V2_PARAMS="$v2_params" \
        docker compose -f "$ROOT_DIR/docker-compose.yml" up -d --force-recreate --no-deps nginx
    echo "Applied: V1=${v1_params} | V2=${v2_params}"
}

cmd="${1:-}"

case "$cmd" in
    start)
        echo "Canary start: 90% v1 / 10% v2"
        set_weights "weight=9" "weight=1"
        ;;
    promote)
        pct="${2:-}"
        case "$pct" in
            30)  set_weights "weight=7" "weight=3"  ;;
            50)  set_weights "weight=5" "weight=5"  ;;
            75)  set_weights "weight=1" "weight=3"  ;;
            100) set_weights "backup"   "weight=1"  ;;
            *)
                echo "Usage: $0 promote [30|50|75|100]"
                exit 1
                ;;
        esac
        echo "Traffic promoted to ${pct}% v2"
        ;;
    rollback)
        echo "ROLLBACK: 100% traffic to v1"
        set_weights "weight=1" "down"
        ;;
    status)
        echo "Current weights:"
        cat "$ENV_FILE"
        ;;
    *)
        echo "Usage: $0 {start|promote <30|50|75|100>|rollback|status}"
        exit 1
        ;;
esac
