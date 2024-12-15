# Función para leer el archivo de entrada
leer_numeros <- function(archivo) {
  # Verificar si el archivo existe
  if (!file.exists(archivo)) {
    stop("Error: El archivo no existe.")
  }
  
  # Leer los números del archivo y convertirlos en un vector de enteros
  numeros <- as.integer(readLines(archivo))
  return(numeros)
}

# Función para calcular estadísticas
calcular_estadisticas <- function(numeros) {
  media <- mean(numeros, na.rm = TRUE)
  mediana <- median(numeros, na.rm = TRUE)
  desviacion_estandar <- sd(numeros, na.rm = TRUE)
  
  # Verificar alta variabilidad
  if (desviacion_estandar > 10) {
    cat("Alta variabilidad detectada: la desviación estándar es mayor que 10.\n")
  }
  
  return(list(media = media, mediana = mediana, desviacion_estandar = desviacion_estandar))
}

# Función para calcular el cuadrado de los números usando sapply()
calcular_cuadrados <- function(numeros) {
  cuadrados <- sapply(numeros, function(x) x^2)
  return(cuadrados)
}

# Función para escribir resultados en el archivo de salida
escribir_resultados <- function(archivo_salida, estadisticas, cuadrados) {
  # Crear el contenido del archivo
  resultados <- c(
    "Resultados del análisis de números:",
    paste("Media:", round(estadisticas$media, 2)),
    paste("Mediana:", estadisticas$mediana),
    paste("Desviación estándar:", round(estadisticas$desviacion_estandar, 2)),
    "\nCuadrados de los números:",
    paste(cuadrados, collapse = ", ")
  )
  
  # Escribir los resultados en el archivo
  writeLines(resultados, archivo_salida)
}

# Script principal
procesar_numeros <- function(archivo_entrada, archivo_salida) {
  # Leer los números del archivo
  numeros <- leer_numeros(archivo_entrada)
  
  # Calcular estadísticas
  estadisticas <- calcular_estadisticas(numeros)
  
  # Calcular los cuadrados de los números
  cuadrados <- calcular_cuadrados(numeros)
  
  # Escribir los resultados en el archivo de salida
  escribir_resultados(archivo_salida, estadisticas, cuadrados)
  
  cat("El análisis se ha completado y los resultados se han guardado en", archivo_salida, "\n")
}

# Ejecutar el script con el archivo de entrada y salida
archivo_entrada <- "numeros.txt"
archivo_salida <- "resultados.txt"
procesar_numeros(archivo_entrada, archivo_salida)
