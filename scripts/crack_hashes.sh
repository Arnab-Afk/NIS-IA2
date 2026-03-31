#!/usr/bin/env bash
set -euo pipefail

HASH_FILE="samples/password_hashes.txt"
WORDLIST="scripts/wordlist_custom.txt"
RESULTS_DIR="results"
LOG_FILE="${RESULTS_DIR}/session_output.log"
CRACKED_FILE="${RESULTS_DIR}/cracked.txt"

mkdir -p "${RESULTS_DIR}"

if [[ ! -f "${HASH_FILE}" ]]; then
  echo "Hash file not found. Run scripts/generate_hashes.sh first."
  exit 1
fi

if ! command -v john >/dev/null 2>&1; then
  echo "john command not found. Install John the Ripper first."
  exit 1
fi

{
  echo "[+] Starting dictionary attack at $(date)"
  john --wordlist="${WORDLIST}" "${HASH_FILE}"
  echo "[+] Showing cracked credentials"
  john --show "${HASH_FILE}"
} | tee "${LOG_FILE}"

john --show "${HASH_FILE}" > "${CRACKED_FILE}"

echo "Saved logs to ${LOG_FILE}"
echo "Saved cracked summary to ${CRACKED_FILE}"
