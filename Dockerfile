# syntax=docker/dockerfile:1

# 🔧 Etapa 1: Builder - instala dependencias y construye la app
FROM node:lts-alpine AS builder
WORKDIR /src

# Copiar archivos necesarios para instalar dependencias
COPY package.json package-lock.json ./

# 🧪 Etapa 2: Test - corre las pruebas unitarias
FROM node:lts-alpine AS test
WORKDIR /test

# Copiar código fuente y dependencias desde builder

# Instalar herramientas de testing (si ya no están en node_modules)
# Si usas npm ci arriba, esto puede no ser necesario. Solo si quieres aislar devDependencies.

# Ejecutar pruebas (ajusta si usas otra herramienta)
CMD ["test"]

# 🚀 Etapa 3: Release - imagen final para producción
