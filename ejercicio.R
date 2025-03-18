Requisitos
Usar el dataset nottem incluido en R.
Analizar la serie temporal para detectar patrones de tendencia, estacionalidad y valores atípicos.
Evaluar la estacionariedad de la serie temporal.
Documentar todo el proceso en un archivo .R o .Rmd y subirlo a un repositorio público en GitHub.
Instrucciones
Este proyecto debe ser desarrollado localmente en tu ordenador utilizando RStudio. Una vez hayas completado el código, selecciona la opción “Cargar repositorio GitHub” para subir únicamente el archivo .R o .Rmd en el que desarrollaste el proyecto.

1.   Carga del dataset:

Usa el dataset nottem incluido en R.
Inspecciona la estructura del dataset y grafica la serie temporal:
# Cargar el dataset
data("nottem")

# Inspeccionar la estructura
print(class(nottem))
print(summary(nottem))

# Graficar la serie temporal
plot(nottem, main = "Temperaturas Mensuales en Nottingham (1920-1939)",
     xlab = "Año", ylab = "Temperatura", col = "blue")
2.   Exploración y preparación de datos:

Descompón la serie temporal para identificar componentes de tendencia, estacionalidad y aleatoriedad.
3.   Análisis de estacionariedad:

Usa gráficos ACF/PACF para identificar patrones de autocorrelación.
Realiza la prueba de Dickey-Fuller para evaluar la estacionariedad de la serie.
4.   Transformación de la serie (si es necesario):

Si la serie no es estacionaria, aplica una diferenciación para convertirla.
Verifica nuevamente la estacionariedad.
5.   Detección de valores atípicos:

Identifica posibles valores atípicos en la serie temporal usando gráficos de caja y visualizaciones.
