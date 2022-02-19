FROM node:14
RUN (curl -Ls https://cli.doppler.com/install.sh || wget -qO- https://cli.doppler.com/install.sh) | sh
RUN mkdir -p /home/node/app/node_modules && chown -R node:node /home/node/app
WORKDIR /home/node/app
COPY package*.json ./
USER node
RUN npm install
COPY --chown=node:node . .
RUN npm run build:server
ENTRYPOINT ["doppler", "run", "--"]
EXPOSE 4000
CMD ["node", "server/dist/index.js"]