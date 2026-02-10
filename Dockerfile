FROM node:18-alpine

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

ENV PORT=5006
EXPOSE 5006

CMD ["npm", "start"]
