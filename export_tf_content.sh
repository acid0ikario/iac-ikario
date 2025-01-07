#!/bin/bash

# Archivo de salida donde se guardará el contenido
output_file="terraform_content.txt"

# Limpiar archivo de salida si ya existe
echo "" > "$output_file"

# Función para recorrer archivos .tf y escribir contenido en el archivo de salida
process_tf_files() {
  local dir="$1"
  
  # Iterar sobre los archivos .tf
  for tf_file in $(find "$dir" -type f -name "*.tf" | sort); do
    echo "$tf_file" >> "$output_file"  # Escribir la ruta del archivo
    echo "$(cat "$tf_file")" >> "$output_file"  # Escribir el contenido del archivo
    echo >> "$output_file"  # Agregar una línea en blanco entre archivos
  done
}

# Directorio principal
base_dir="$(pwd)"

# Procesar los archivos en el directorio terraform
process_tf_files "$base_dir"

# Confirmación de finalización
echo "Contenido exportado a $output_file"
