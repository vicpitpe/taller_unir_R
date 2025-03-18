# Cargar las librerías necesarias
library(tseries)
library(ggplot2)

# 1. Carga del dataset
data("AirPassengers")

# Inspeccionar la estructura del dataset
print(class(AirPassengers))   # Verifica que es una serie temporal (ts)
print(summary(AirPassengers)) # Resumen estadístico
print(start(AirPassengers))   # Inicio de la serie
print(end(AirPassengers))     # Fin de la serie
print(frequency(AirPassengers)) # Frecuencia: 12 (mensual)

# 2. Exploración inicial
# Graficar la serie temporal
plot(AirPassengers, main="Serie Temporal de AirPassengers", ylab="Número de Pasajeros", xlab="Año")

# Calcular estadísticas descriptivas básicas
mean(AirPassengers)
sd(AirPassengers)

# 3. Análisis de tendencia y estacionalidad
# Descomponer la serie temporal
decomposed <- decompose(AirPassengers)
plot(decomposed)

# 4. Análisis de estacionariedad
# Gráficos de autocorrelación
acf(AirPassengers, main="ACF de AirPassengers")
pacf(AirPassengers, main="PACF de AirPassengers")

# Prueba de Dickey-Fuller aumentada
adf.test(AirPassengers)

# Si la serie no es estacionaria, realizar una diferenciación simple
diff_AirPassengers <- diff(AirPassengers)
adf.test(diff_AirPassengers)

# 5. Detección de valores atípicos
# Visualizar posibles valores atípicos
boxplot(AirPassengers, main="Boxplot de AirPassengers")

# 6. Interpretación de resultados
# Resumen de tendencias, estacionalidades y ciclos observados
summary(decomposed)

# Guardar el script en un archivo .R o .Rmd y subirlo a GitHub
