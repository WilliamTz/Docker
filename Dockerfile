# syntax=docker/dockerfile:1

# 🔧 Etapa 1: Builder - instala dependencias y construye la app
FROM node:lts-alpine AS builder
WORKDIR /src

# Copiar archivos necesarios para instalar dependencias
COPY package.json package-lock.json ./

# Instalar dependencias
RUN npm ci

# Copiar el resto del código y construir
COPY . .
RUN npm run build

# 🧪 Etapa 2: Test - corre las pruebas unitarias
FROM node:lts-alpine AS test
WORKDIR /test

# Copiar código fuente y dependencias desde builder
COPY --from=builder /src ./

# Instalar herramientas de testing (si ya no están en node_modules)
# Si usas npm ci arriba, esto puede no ser necesario. Solo si quieres aislar devDependencies.
RUN npm install

# Ejecutar pruebas (ajusta si usas otra herramienta)
CMD ["npm", "test"]

# 🚀 Etapa 3: Release - imagen final para producción
FROM node:lts-alpine AS release
WORKDIR /app

# Copiar solo la app construida (sin node_modules ni código fuente)
COPY --from=builder /src/build ./

EXPOSE 3000
CMD ["node", "."]
