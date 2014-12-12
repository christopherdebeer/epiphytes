FROM dockerfile/nodejs

ADD package.json /var/app/

RUN cd /var/app && npm install

ADD src* /var/app/src/
ADD public* /var/app/public/

ENV AWS_ACCESS_KEY_ID AKIAI3TE2KLVIZ37LRUA
ENV AWS_SECRET_ACCESS_KEY 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

RUN npm install -g coffee-script
RUN npm install -g http-server
RUN npm install -g browserify 

RUN cd /var/app && npm run generate-assets
RUN cd /var/app && npm run compile

ENV VIRTUAL_HOST wired200.datagotchi.com
EXPOSE 3001

CMD coffee /var/app/src/server.coffee
