# builder
FROM --platform=linux/amd64 node:18.3.0-slim as builder
WORKDIR /work/src
COPY package.json package-lock.json tsconfig.json index.ts ./
RUN npm install
RUN npm run build

# executor
FROM --platform=linux/amd64 node:18.3.0-slim
COPY --from=builder /work/src/build /var/task
WORKDIR /var/task
CMD ["index.js"]
