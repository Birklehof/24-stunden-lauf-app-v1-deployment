# Build the nextjs site
FROM node:16 AS builder

# Install git
RUN apt-get -y update
RUN apt-get -y install git

WORKDIR /birklehof-24-stunden-lauf
ENV NEXT_TELEMETRY_DISABLED 1

# Download the code from github and copy the config file

RUN git clone --depth=1 -b main https://github.com/Birklehof/24-stunden-lauf.git .
COPY .env.local .env.local

RUN yarn install

CMD yarn dotenv -e .env.local yarn prisma migrate deploy --force; yarn dotenv -e .env.local yarn prisma db seed --force
