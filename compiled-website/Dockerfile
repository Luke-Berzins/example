FROM jaspervdj/hakyll:latest

WORKDIR /site

# Copy only the source files we need
COPY content ./content
COPY templates ./templates
COPY app ./app
COPY compiled-website.cabal ./

# Command to watch for changes
CMD ["cabal", "run", "site", "watch", "--host=0.0.0.0"]
FROM haskell:9.4

WORKDIR /app

# Install system dependencies
RUN apt-get update && \
    apt-get install -y \
    libgmp-dev \
    zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

# Create a directory just for dependency installation
RUN mkdir -p /opt/build
WORKDIR /opt/build

# Copy only files needed for dependency installation
COPY compiled-website.cabal ./
COPY cabal.project* ./

# Install dependencies into a separate layer
RUN cabal update && \
    cabal build --only-dependencies && \
    cabal clean

# Switch back to app directory for actual build
WORKDIR /app

# Copy the rest of the application
COPY . .

EXPOSE 8000

CMD ["cabal", "run", "site", "watch", "--host=0.0.0.0"]