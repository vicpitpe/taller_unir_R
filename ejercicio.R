# Instalar y cargar librerías
if (!require("dplyr")) install.packages("dplyr")
if (!require("tidyr")) install.packages("tidyr")

library(dplyr)
library(tidyr)

# Cargar el dataset mtcars
data(mtcars)
df <- as.data.frame(mtcars)

# Seleccionar columnas mpg, cyl, hp, gear y filtrar filas donde cyl > 4
df_filtered <- df %>%
  select(mpg, cyl, hp, gear) %>%
  filter(cyl > 4)

print(df_filtered)

# Ordenar por hp en forma descendente y renombrar mpg a consumo y hp a potencia
df_ordered <- df_filtered %>%
  arrange(desc(hp)) %>%
  rename(consumo = mpg, potencia = hp)

print(df_ordered)

# Crear la columna eficiencia y agrupar por cyl para calcular métricas
df_aggregated <- df_ordered %>%
  mutate(eficiencia = consumo / potencia) %>%
  group_by(cyl) %>%
  summarise(
    consumo_medio = mean(consumo, na.rm = TRUE),
    potencia_maxima = max(potencia, na.rm = TRUE)
  )

print(df_aggregated)

# Crear un nuevo dataframe para tipo_transmision
tipo_transmision <- data.frame(
  gear = c(3, 4, 5),
  tipo_transmision = c("Manual", "Automática", "Semiautomática")
)

# Realizar un left_join con el dataframe principal
df_joined <- df_ordered %>%
  left_join(tipo_transmision, by = "gear")

print(df_joined)

# Transformar a formato largo
df_long <- df_joined %>%
  pivot_longer(
    cols = c(consumo, potencia, eficiencia),
    names_to = "medida",
    values_to = "valor"
  )

print(df_long)

# Identificar y manejar duplicados
df_long_clean <- df_long %>%
  group_by(cyl, gear, tipo_transmision, medida) %>%
  summarise(valor = mean(valor, na.rm = TRUE), .groups = "drop")

print(df_long_clean)

# Transformar de nuevo a formato ancho
df_wide <- df_long_clean %>%
  pivot_wider(
    names_from = medida,
    values_from = valor
  )

print(df_wide)
