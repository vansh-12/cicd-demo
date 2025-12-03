FROM node:20-alpine AS build
WORKDIR /usr/src/app
COPY package*.json ./
RUN if [ -f package-lock.json ]; then npm ci --production; else npm install --production; fi
COPY src ./src

FROM node:20-alpine AS runtime
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
WORKDIR /usr/src/app
COPY --from=build /usr/src/app/node_modules ./node_modules
COPY --from=build /usr/src/app/src ./src
COPY package*.json ./
ENV NODE_ENV=production
ENV PORT=3000
EXPOSE 3000
USER appuser
HEALTHCHECK --interval=15s --timeout=3s --start-period=5s --retries=3 CMD wget -qO- http://127.0.0.1:3000/health || exit 1
CMD ["node","src/index.js"]
