# John the Ripper - Password Security Assessment

## Team Members
- Name 1 (Roll No.)
- Name 2 (Roll No.)
- Name 3 (Roll No.)

## Objective
Demonstrate how John the Ripper can identify weak passwords by cracking:
- Unix-style password hashes (MD5-crypt, SHA-256-crypt, SHA-512-crypt)
- A password-protected ZIP archive

This project is for security education and authorized testing only.

## Repository Structure

```text
john-the-ripper-demo/
|
|-- README.md
|-- scripts/
|   |-- generate_hashes.sh
|   |-- crack_hashes.sh
|   |-- zip_crack.sh
|   `-- wordlist_custom.txt
|-- samples/
|   |-- password_hashes.txt
|   |-- protected.zip
|   `-- protected_zip.hash
|-- results/
|   |-- cracked.txt
|   `-- session_output.log
|-- docs/
|   `-- screenshots/
`-- requirements.txt
```

## Prerequisites

Install these tools in Linux/Kali/WSL:
- `john` (John the Ripper Jumbo)
- `zip2john` (bundled with JtR Jumbo)
- `openssl`
- `zip`

### Ubuntu/Kali installation example

```bash
sudo apt update
sudo apt install -y john zip openssl
```

Check installation:

```bash
john --list=build-info
zip2john --help || true
openssl version
```

## Setup Instructions

1. Clone the repository.
2. Open a terminal at the repository root.
3. (Linux/WSL) Make scripts executable:

```bash
chmod +x scripts/*.sh
```

## Usage

### 1. Generate sample hashes

```bash
./scripts/generate_hashes.sh
cat samples/password_hashes.txt
```

### 2. Run dictionary attack on hashes

```bash
./scripts/crack_hashes.sh
cat results/cracked.txt
```

This script runs:

```bash
john --wordlist=scripts/wordlist_custom.txt samples/password_hashes.txt
john --show samples/password_hashes.txt
```

### 3. Crack a password-protected ZIP file

```bash
./scripts/zip_crack.sh
```

Equivalent core commands:

```bash
zip2john samples/protected.zip > samples/protected_zip.hash
john --wordlist=scripts/wordlist_custom.txt samples/protected_zip.hash
john --show samples/protected_zip.hash
```

## Results

Current demo artifacts are stored in:
- `results/cracked.txt`
- `results/session_output.log`

Sample outcome:
- Cracked users: `alice`, `bob`, `charlie`
- Weak passwords recovered: `secret123`, `admin123`, `letmein`

## Notes for Evaluators

- `samples/protected.zip` is included as a placeholder file in git.
- To produce a real encrypted archive for the demo, run `scripts/zip_crack.sh` in an environment with `zip` + `zip2john`.
- All credentials/passwords in this repository are intentionally weak and synthetic.

## References

- John the Ripper official site: https://www.openwall.com/john/
- Openwall JtR Jumbo docs: https://github.com/openwall/john
- Common wordlist source (RockYou): https://github.com/brannondorsey/naive-hashcat/releases/download/data/rockyou.txt

## Submission Checklist

- [ ] Add real team names and roll numbers.
- [ ] Add screenshots to `docs/screenshots/` (optional).
- [ ] Record your own terminal run and replace sample logs if required.
- [ ] Ensure repository access permissions are correct for evaluators.
