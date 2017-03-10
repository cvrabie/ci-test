FROM node:latest

WORKDIR /var/app
COPY package.json ./
RUN npm install --production
COPY *.js ./

EXPOSE 3000
CMD ["npm","run","start"]
