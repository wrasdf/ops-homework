FROM node:8.8-slim

ENV NODE=$NODE
WORKDIR /app
ADD . /app
RUN ["npm", "install"]

EXPOSE 3000
CMD node index.js
