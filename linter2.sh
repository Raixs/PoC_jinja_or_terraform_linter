#!/bin/bash

TMPDIR=/tmp/linter

# Verifica si un archivo contiene sintaxis Jinja
contains_jinja() {
  local file="$1"
  grep -q -E "{%|{{|}}" "$file"
}

# Verifica si un archivo contiene sintaxis Terraform
contains_terraform() {
  local file="$1"
  grep -q -E 'resource|data|provider|module|output|variable|locals|terraform' "$file"
}

# Comprueba que se haya proporcionado un archivo como argumento
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <path_to_file.tf>"
  exit 1
fi

file="$1"

# Comprueba si el archivo contiene sintaxis Jinja y Terraform
if contains_jinja "$file" && contains_terraform "$file"; then
  echo "The file '$file' contains both Jinja and Terraform syntax."
  j2lint "$file"
  ansible-playbook -e src_file=$file -e TMPDIR=$TMPDIR mock_play.yml
  tflint --chdir "$TMPDIR" --filter "$file"
elif contains_jinja "$file"; then
  echo "The file '$file' contains Jinja syntax."
elif contains_terraform "$file"; then
  echo "The file '$file' contains Terraform syntax."
  file_directory=$(dirname "$file")
  file_basename=$(basename "$file")
  tflint --chdir "$file_directory" --filter "$file_basename"
else
  echo "The file '$file' does not contain Jinja or Terraform syntax."
fi
