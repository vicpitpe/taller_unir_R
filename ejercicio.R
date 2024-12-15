# Paso 1: Configuración inicial
set.seed(123)  # Asegurar reproducibilidad

# Crear los vectores
energia <- c(rep("Renovable", 10), rep("No Renovable", 10))
consumo <- c(50, 60, NA, 40, 55, 65, NA, 70, 45, NA, 
             80, NA, 90, 85, 75, 100, 95, NA, 110, 105)
costo_kwh <- c(rep(0.12, 10), rep(0.15, 10))

# Paso 2: Limpieza de datos
# Calcular la mediana de consumo para cada tipo de energía
medianas_consumo <- tapply(consumo, energia, function(x) median(x, na.rm = TRUE))

# Reemplazar valores NA con la mediana correspondiente
consumo_limpio <- ifelse(is.na(consumo) & energia == "Renovable", medianas_consumo["Renovable"],
                   ifelse(is.na(consumo) & energia == "No Renovable", medianas_consumo["No Renovable"], 
                          consumo))

# Paso 3: Creación del dataframe
df_consumo <- data.frame(
  energia = energia,
  consumo = consumo_limpio,
  costo_kwh = costo_kwh
)

# Paso 4: Cálculos
# Calcular el costo total diario
df_consumo$costo_total <- df_consumo$consumo * df_consumo$costo_kwh

# Calcular el total de consumo y costo por tipo de energía
totales <- aggregate(cbind(consumo, costo_total) ~ energia, data = df_consumo, sum)

# Calcular el consumo promedio diario por tipo de energía
promedios <- aggregate(consumo ~ energia, data = df_consumo, mean)

# Agregar columna de ganancia simulando un aumento de precio del 10%
df_consumo$ganancia <- df_consumo$costo_total * 1.1

# Paso 5: Resumen
# Ordenar el dataframe por la columna costo_total en orden descendente
df_ordenado <- df_consumo[order(-df_consumo$costo_total), ]

# Calcular el total de consumo y costo por tipo de energía
total_consumo <- tapply(df_consumo$consumo, df_consumo$energia, sum)
total_costos <- tapply(df_consumo$costo_total, df_consumo$energia, sum)

# Extraer las tres filas con mayor costo_total
top_3_costos <- head(df_ordenado, 3)

# Crear la lista resumen
resumen_energia <- list(
  dataframe_ordenado = df_ordenado,
  total_consumo_por_tipo = total_consumo,
  total_costos_por_tipo = total_costos,
  top_3_costos = top_3_costos
)

# Mostrar el resumen final
print(resumen_energia)
