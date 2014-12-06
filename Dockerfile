FROM dockerfile/nodejs

ADD package.json /var/app/

RUN cd /var/app && npm install

ADD src* /var/app/src/
ADD public* /var/app/public/

RUN npm install -g coffee-script
RUN npm install -g http-server
RUN npm install -g browserify 

RUN cd /var/app && npm run generate-assets
RUN cd /var/app && npm run compile

ENV VIRTUAL_HOST wired200.datagotchi.com
EXPOSE 3001

CMD coffee /var/app/src/server.coffee
