#!/usr/bin/env bash
# color-msg.sh — print a message in color
# Usage:
#   ./color-msg.sh "Hello" red
#   ./color-msg.sh "Build OK" green bold
#   ./color-msg.sh "Careful!" yellow
#   ./color-msg.sh "Oops!" red underline

msg="${1:-Hello, world!}"
color="${2:-green}"
style="${3:-normal}"

# Detect color support
if [ -t 1 ] && command -v tput >/dev/null 2>&1 && [ "$(tput colors)" -ge 8 ]; then
  RESET="$(tput sgr0)"
  BOLD="$(tput bold)"
  UNDERLINE="$(tput smul)"
  # Basic colors
  declare -A FG=(
    [black]="$(tput setaf 0)"  [red]="$(tput setaf 1)"
    [green]="$(tput setaf 2)"  [yellow]="$(tput setaf 3)"
    [blue]="$(tput setaf 4)"   [magenta]="$(tput setaf 5)"
    [cyan]="$(tput setaf 6)"   [white]="$(tput setaf 7)"
  )
else
  # Fallback ANSI codes (works on most terminals)
  RESET=$'\033[0m'
  BOLD=$'\033[1m'
  UNDERLINE=$'\033[4m'
  declare -A FG=(
    [black]=$'\033[30m'  [red]=$'\033[31m'
    [green]=$'\033[32m'  [yellow]=$'\033[33m'
    [blue]=$'\033[34m'   [magenta]=$'\033[35m'
    [cyan]=$'\033[36m'   [white]=$'\033[37m'
  )
fi

# Normalize inputs
color="${color,,}"      # lower-case
style="${style,,}"

# Pick style prefix
case "$style" in
  bold)       STYLE="$BOLD" ;;
  underline)  STYLE="$UNDERLINE" ;;
  normal|"")  STYLE="" ;;
  *)          STYLE="" ;;
esac

# Resolve color (default to green if unknown)
C="${FG[$color]:-${FG[green]}}"

printf '%b%s%b\n' "${STYLE}${C}" "$msg" "$RESET"

