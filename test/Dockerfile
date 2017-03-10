FROM node:latest

WORKDIR /var/tests

COPY package.json ./
RUN npm install

COPY *.js ./

CMD ["npm","run","test"]

