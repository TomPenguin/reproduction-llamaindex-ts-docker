# builder
FROM --platform=linux/amd64 node:18.3.0-slim as builder
WORKDIR /work/src
COPY package*.json ./
RUN npm install
COPY index.ts tsconfig.json ./
RUN npm run build
COPY test/data/05-versions-space.pdf ./build/test/data/05-versions-space.pdf

# executor
FROM --platform=linux/amd64 node:18.3.0-slim
COPY package*.json ./
RUN npm install --omit=dev && npm cache clean --force
COPY --from=builder /work/src/build /var/task
WORKDIR /var/task
CMD ["index.js"]
