FROM node:20

WORKDIR /nodejs
RUN apt update \
    && apt install nginx -y \
    && npm install pm2 -g \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*

COPY package*.json ./
RUN npm install

COPY nginx.conf /etc/nginx/nginx.conf
COPY . /nodejs

EXPOSE 8080
CMD ["sh", "-c", "nginx && pm2-runtime start index.js -i max"]