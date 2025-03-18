# Cargar librerías necesarias
library(ggplot2)
library(cluster)

# 1. Carga del dataset
dataset <- read.csv("Mall_Customers.csv")
head(dataset)

# 2. Exploración y limpieza de datos
dim(dataset)
str(dataset)
summary(dataset)

# Renombrar columnas
names(dataset) <- c("CustomerID", "Genre", "Age", "AnnualIncome", "SpendingScore")

# Codificar Genre como variable numérica
dataset$Genre <- ifelse(dataset$Genre == "Male", 1, 0)

# Normalizar variables numéricas
dataset$AnnualIncome <- scale(dataset$AnnualIncome)
dataset$SpendingScore <- scale(dataset$SpendingScore)

# 3. Exploración de variables
# Histogramas
ggplot(dataset, aes(x=Age)) + geom_histogram(binwidth=5, fill="blue", color="black")
ggplot(dataset, aes(x=AnnualIncome)) + geom_histogram(binwidth=5, fill="green", color="black")
ggplot(dataset, aes(x=SpendingScore)) + geom_histogram(binwidth=5, fill="red", color="black")

# Diagramas de caja
ggplot(dataset, aes(x=factor(Genre), y=Age)) + geom_boxplot()
ggplot(dataset, aes(x=factor(Genre), y=AnnualIncome)) + geom_boxplot()
ggplot(dataset, aes(x=factor(Genre), y=SpendingScore)) + geom_boxplot()

# 4. Entrenamiento de modelos de clustering
# K-Means
set.seed(123)
wss <- sapply(2:6, function(k) kmeans(dataset[, c("AnnualIncome", "SpendingScore")], k, nstart=10)$tot.withinss)
plot(2:6, wss, type="b", pch=19, frame=FALSE, xlab="Número de Clusters", ylab="Suma de Cuadrados Interna")

# Número óptimo de clusters
optimal_k <- 3
kmeans_model <- kmeans(dataset[, c("AnnualIncome", "SpendingScore")], optimal_k, nstart=10)
dataset$KMeansCluster <- kmeans_model$cluster

# Clustering jerárquico
dist_matrix <- dist(dataset[, c("AnnualIncome", "SpendingScore")])
hclust_model <- hclust(dist_matrix, method="ward.D")
plot(hclust_model)
rect.hclust(hclust_model, k=optimal_k, border="red")
dataset$HierarchicalCluster <- cutree(hclust_model, k=optimal_k)

# 5. Evaluación de modelos
silhouette_kmeans <- silhouette(kmeans_model$cluster, dist_matrix)
silhouette_hierarchical <- silhouette(dataset$HierarchicalCluster, dist_matrix)
mean(silhouette_kmeans[, 3])
mean(silhouette_hierarchical[, 3])

# 6. Análisis descriptivo de segmentos
aggregate(dataset[, c("Age", "AnnualIncome", "SpendingScore")], by=list(dataset$KMeansCluster), FUN=mean)
aggregate(dataset[, c("Age", "AnnualIncome", "SpendingScore")], by=list(dataset$HierarchicalCluster), FUN=mean)

# 7. Visualización
ggplot(dataset, aes(x=AnnualIncome, y=SpendingScore, color=factor(KMeansCluster))) + geom_point() + labs(title="K-Means Clustering")
ggplot(dataset, aes(x=AnnualIncome, y=SpendingScore, color=factor(HierarchicalCluster))) + geom_point() + labs(title="Clustering Jerárquico")
