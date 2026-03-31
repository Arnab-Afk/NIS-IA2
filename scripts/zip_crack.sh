#!/usr/bin/env bash
set -euo pipefail

SAMPLES_DIR="samples"
RESULTS_DIR="results"
WORDLIST="scripts/wordlist_custom.txt"
ZIP_FILE="${SAMPLES_DIR}/protected.zip"
ZIP_HASH_FILE="${SAMPLES_DIR}/protected_zip.hash"

mkdir -p "${SAMPLES_DIR}/protected" "${RESULTS_DIR}"
echo "Confidential lab file" > "${SAMPLES_DIR}/protected/secret.txt"

if ! command -v john >/dev/null 2>&1; then
  echo "john command not found. Install John the Ripper first."
  exit 1
fi

if command -v zip >/dev/null 2>&1; then
  # Uses a weak password intentionally for classroom demonstration.
  zip -j -P "letmein" "${ZIP_FILE}" "${SAMPLES_DIR}/protected/secret.txt" >/dev/null
else
  echo "zip command not found. Create ${ZIP_FILE} manually with password: letmein"
fi

if command -v zip2john >/dev/null 2>&1; then
  zip2john "${ZIP_FILE}" > "${ZIP_HASH_FILE}"
else
  echo "zip2john not found in PATH. Try: /path/to/john/run/zip2john ${ZIP_FILE} > ${ZIP_HASH_FILE}"
  exit 1
fi

john --wordlist="${WORDLIST}" "${ZIP_HASH_FILE}" | tee -a "${RESULTS_DIR}/session_output.log"
john --show "${ZIP_HASH_FILE}" | tee -a "${RESULTS_DIR}/cracked.txt"

echo "ZIP cracking demo complete."
