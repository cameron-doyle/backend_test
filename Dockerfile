# Build and asset versioning stage
FROM node:20-alpine AS builder

ARG BUILD_VERSION
WORKDIR /app

# Install dependencies (prod only) so we can reuse node_modules later
COPY package*.json ./
RUN npm ci --omit=dev

# Copy application source
COPY . .

# Rename frontend assets with BUILD_VERSION for cache busting
RUN mv public/main.js public/main.$BUILD_VERSION.js \
  && mv public/style.css public/style.$BUILD_VERSION.css \
  && sed -i "s/main.js/main.$BUILD_VERSION.js/" public/index.html \
  && sed -i "s/style.css/style.$BUILD_VERSION.css/" public/index.html


# Runtime stage: Node.js + Express server
FROM node:20-alpine
WORKDIR /app

ENV NODE_ENV=production
ENV PORT=8080

# Reuse dependencies from builder
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/package*.json ./

# Copy server and processed static assets
COPY --from=builder /app/server.js ./
COPY --from=builder /app/public ./public

EXPOSE 8080

CMD ["npm", "start"]