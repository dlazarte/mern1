# syntax=docker/dockerfile:1

# Comments are provided throughout this file to help you get started.
# If you need more help, visit the Dockerfile reference guide at
# https://docs.docker.com/go/dockerfile-reference/

FROM node:alpine

RUN echo '@community http://nl.alpinelinux.org/alpine/v3.15/community' >> /etc/apk/repositories && \
    apk update && apk upgrade && \
    # DEPENDENCIES #############################################################
    apk add --update git && \
    # NODEJS ###################################################################
    apk add --update nodejs-current@community npm@community && \
    # CLEAN UP #################################################################
    rm -rf /var/cache/apk/*


WORKDIR /app

# Download dependencies as a separate step to take advantage of Docker's caching.
# Leverage a cache mount to /root/.local/share/pnpm/store to speed up subsequent builds.
# Leverage a bind mounts to package.json and pnpm-lock.yaml to avoid having to copy them into
# into this layer.
#RUN --mount=type=bind,source=package.json,target=package.json \
#    --mount=type=bind,source=pnpm-lock.yaml,target=pnpm-lock.yaml \
#    --mount=type=cache,target=/root/.local/share/pnpm/store \
#    pnpm install --prod --frozen-lockfile

# Run the application as a non-root user.
USER node

# Copy the rest of the source files into the image.
COPY . .

# Expose the port that the application listens on.
EXPOSE 3001

# Run the application.
CMD ["npm", "start"]


