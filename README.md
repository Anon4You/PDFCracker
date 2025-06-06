# PDF Password Cracker Tool

## Description

A powerful yet simple PDF password recovery tool designed for security professionals and ethical hackers. This tool brute-forces password-protected PDF files using a wordlist approach with visual feedback.

## Features

- 🔐 PDF-specific password cracking using `qpdf`
- 🎨 Colorful terminal interface with custom ASCII art
- 📊 Real-time progress tracking with percentage
- ⏱️ Time elapsed and attempts counter
- 💾 Auto-saves unlocked PDF when password found
- ✔️ Comprehensive error checking and user feedback
- 📝 Clean, well-commented code

## Installation

### Requirements
- Bash environment
- `qpdf` utility

### Termux
```bash
pkg install qpdf
git clone https://github.com/Anon4You/PDFCracker.git
cd PDFCracker
chmod +x pdfcracker.sh
```

### Linux
```bash
sudo apt-get install qpdf
git clone https://github.com/Anon4You/PDFCracker.git
cd PDFCracker
chmod +x pdfcracker.sh
```

## Usage

### Basic Syntax
```bash
./pdfcracker.sh <PDF_FILE> <WORDLIST>
```

### Examples

1. Basic usage:
```bash
./pdfcracker.sh secret.pdf passwords.txt
```

2. Using default wordlist (if you have one):
```bash
./pdfcracker.sh secret.pdf common_passwords.txt
```

3. Show help menu:
```bash
./pdfcracker.sh
```

## Wordlist Tips

1. Create custom wordlists:
```bash
crunch 6 8 1234567890 -o custom_wordlist.txt
```

2. Popular wordlists:
- [rockyou.txt](https://github.com/brannondorsey/naive-hashcat/releases/download/data/rockyou.txt)
- [SecLists](https://github.com/danielmiessler/SecLists)

## Performance Tips

1. Sort your wordlist by most likely passwords first
2. Use smaller wordlists for initial testing
3. Consider using GPU-accelerated tools for very large wordlists

## Legal Disclaimer

This tool is intended for:
- Legal password recovery
- Educational purposes
- Security research

Always ensure you have proper authorization before attempting to crack any password-protected files.

## License

MIT License

## Credits

**Created by:** Alienkrishn  
**GitHub:** [github.com/Anon4You](https://github.com/Anon4You)

---

For feature requests or bug reports, please open an issue on the [GitHub repository](https://github.com/Anon4You/PDFCracker/issues).