#!/bin/bash
#ddev-generated

tickCharacter="${CLR_GRN}✓${CLR_END}"

# Function to print success message with green tick
function successMessage() {
  printf "\n${CLR_GRN}${1} ${tickCharacter}${CLR_END}\n"
}

# Function to print info message in yellow
function infoMessage() {
  printf "\n${CLR_YEL}${1}${CLR_END}\n"
}

# Function to print info message and countdown
function infoMessageCountdown() {
  local message=$1
  local countdown=$2

  # error if we don't have both args
  if [ -z "$message" ] || [ -z "$countdown" ]; then
    errorMessage "Both message and countdown are required."
    exit 1
  fi

  for ((i=$countdown; i>=0; i--)); do
    printf "\r${CLR_YEL}${message} ${i}...${CLR_END}"
    sleep 1  # Pause for 1 second
  done

  printf "\n"  # Move to a new line after the countdown finishes
}

# Function to print error message
function errorMessage() {
  printf "\n${CLR_RED}Error: ${1}${CLR_END}\n"
}
