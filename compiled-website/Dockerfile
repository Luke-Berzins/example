FROM haskell:9.4 as builder

WORKDIR /app

# Install system dependencies
RUN apt-get update && \
    apt-get install -y \
    libgmp-dev \
    zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy build files
COPY compiled-website.cabal ./
COPY app ./app
COPY src ./src
COPY config ./config
COPY content ./content
COPY templates ./templates

# Build the site generator
RUN cabal update && \
    cabal build --only-dependencies -j4 && \
    cabal build

# Generate the static site
RUN cabal run site build

# Second stage - nginx to serve the static files
FROM nginx:alpine

# Copy the generated static site from the builder
COPY --from=builder /app/_site /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]