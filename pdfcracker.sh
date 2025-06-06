#!/usr/bin/env bash

# Color codes
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
PURPLE='\033[1;35m'
CYAN='\033[1;36m'
NC='\033[0m' # No Color

# Banner
show_banner() {
  clear
  echo -e "${PURPLE}"
  echo -e "▛▀▖▛▀▖▛▀▘▞▀▖         ▌        "
  echo -e "▙▄▘▌ ▌▙▄ ▌  ▙▀▖▝▀▖▞▀▖▌▗▘▞▀▖▙▀▖"
  echo -e "▌  ▌ ▌▌  ▌ ▖▌  ▞▀▌▌ ▖▛▚ ▛▀ ▌  "
  echo -e "▘  ▀▀ ▘  ▝▀ ▘  ▝▀▘▝▀ ▘ ▘▝▀▘▘  "
  echo -e "${NC}"
  echo -e "${BLUE}=========================================${NC}"
  echo -e "${CYAN}       PDF Password Cracker Tool${NC}"
  echo -e "${BLUE}=========================================${NC}"
  echo -e "${YELLOW}         Created by Alienkrishn${NC}"
  echo -e "${BLUE}         GitHub: github.com/Anon4You${NC}"
  echo -e "${BLUE}=========================================${NC}\n"
}

# Usage information
usage() {
  show_banner
  echo -e "${YELLOW}Usage:${NC}"
  echo -e "  $0 <pdf_file> <password_list_file>"
  echo -e "\n${YELLOW}Options:${NC}"
  echo -e "  <pdf_file>           Path to password protected PDF file"
  echo -e "  <password_list_file> Path to wordlist file"
  echo -e "\n${YELLOW}Example:${NC}"
  echo -e "  $0 secret.pdf passwords.txt"
  exit 1
}

# Check dependencies
check_deps() {
  if ! command -v qpdf &> /dev/null; then
    echo -e "${RED}[!] Error: qpdf is not installed${NC}"
    echo -e "${YELLOW}Install it with:${NC}"
    echo -e "Termux: pkg install qpdf"
    echo -e "Linux:  sudo apt-get install qpdf"
    exit 1
  fi
}

# Main cracking function
crack_pdf() {
  local pdf_file=$1
  local wordlist=$2

  total_passwords=$(wc -l < "$wordlist")
  current_password=0
  found=0

  echo -e "\n${GREEN}[+] Target PDF: $pdf_file${NC}"
  echo -e "${YELLOW}[i] Wordlist: $wordlist${NC}"
  echo -e "${YELLOW}[i] Total passwords to try: $total_passwords${NC}"
  echo -e "${BLUE}=========================================${NC}"

  start_time=$(date +%s)
  
  while IFS= read -r password || [ -n "$password" ]; do
    current_password=$((current_password + 1))
    percentage=$((current_password * 100 / total_passwords))
    
    # Progress bar
    printf "\r${CYAN}[${BLUE}"
    for ((i=0; i<percentage/2; i++)); do printf "■"; done
    printf "${CYAN}] ${percentage}%% ${YELLOW}Trying: '${password}'${NC}"
    
    if qpdf --password="$password" --decrypt "$pdf_file" /dev/null &>/dev/null; then
      found=1
      end_time=$(date +%s)
      duration=$((end_time - start_time))
      echo -e "\n\n${GREEN}[✓] PASSWORD FOUND: '${password}'${NC}"
      echo -e "${GREEN}[✓] Time taken: ${duration} seconds${NC}"
      echo -e "${GREEN}[✓] Attempts: ${current_password}/${total_passwords}${NC}"
      echo -e "${BLUE}=========================================${NC}"
      
      # Extract the PDF with found password
      output_file="${pdf_file%.*}_unlocked.pdf"
      qpdf --password="$password" --decrypt "$pdf_file" "$output_file"
      echo -e "${GREEN}[✓] Unlocked PDF saved as: $output_file${NC}"
      break
    fi
  done < "$wordlist"

  if [ $found -eq 0 ]; then
    end_time=$(date +%s)
    duration=$((end_time - start_time))
    echo -e "\n\n${RED}[✗] PASSWORD NOT FOUND IN WORDLIST${NC}"
    echo -e "${YELLOW}[i] Time taken: ${duration} seconds${NC}"
    echo -e "${YELLOW}[i] Total attempts: ${current_password}${NC}"
    echo -e "${BLUE}=========================================${NC}"
    exit 1
  fi
}

# Main execution
main() {
  # Check dependencies
  check_deps
  
  # Check arguments
  if [ $# -ne 2 ]; then
    usage
  fi

  pdf_file="$1"
  wordlist="$2"

  # Validate files
  if [ ! -f "$pdf_file" ]; then
    echo -e "${RED}[!] PDF file not found: $pdf_file${NC}"
    usage
  fi

  if [ ! -f "$wordlist" ]; then
    echo -e "${RED}[!] Wordlist not found: $wordlist${NC}"
    usage
  fi

  show_banner
  crack_pdf "$pdf_file" "$wordlist"
}

main "$@"