FROM node:14 AS builder

WORKDIR /app
COPY package.json package-lock.json ./


RUN npm install
COPY . .
RUN npm run build
FROM node:14-alpine
WORKDIR /app

COPY --from=builder /app/.next ./.next
COPY --from=builder /app/public ./public
COPY package.json package-lock.json ./

RUN npm install --only=production
EXPOSE 3000
CMD ["npm", "start"]
