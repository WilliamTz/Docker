# syntax=docker/dockerfile:1

# 🔧 Etapa 1: Builder - instala dependencias y construye la app
FROM node:lts-alpine AS builder
WORKDIR /src

# Instalar dependencias usando caché
RUN npm ci

# Copiar todo y construir
COPY . .
RUN --mount=type=cache,target=/root/.npm \
    npm run build

# 🧪 Etapa 2: Test - corre las pruebas unitarias
FROM node:lts-alpine AS test
WORKDIR /test

# Copiar código fuente y dependencias desde builder
COPY --from=builder /src ./

# Instalar jest o tus herramientas de testing (si no están ya en devDependencies)
RUN npm install --only=dev

# Ejecutar pruebas (ajusta el comando si usas otra herramienta)
CMD ["npm", "test"]

# 🚀 Etapa 3: Release - imagen final para producción
FROM node:lts-alpine AS release
WORKDIR /app

# Copiar solo la app construida (sin código fuente, ni tests, ni node_modules innecesarios)
COPY --from=builder /src/build ./

EXPOSE 3000
CMD ["node", "."]
