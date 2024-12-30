FROM haskell:9.4

WORKDIR /app

# Install system dependencies
RUN apt-get update && \
    apt-get install -y \
    libgmp-dev \
    zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy only the package configuration files first
COPY compiled-website.cabal ./
COPY cabal.project* ./

# Install dependencies (this layer will be cached if dependencies don't change)
RUN cabal update && \
    cabal build --only-dependencies

# Copy the rest of the application
COPY . .

# Build the application
RUN cabal build

# Expose the development server port
EXPOSE 8000

# Command to run the site
CMD ["cabal", "run", "site", "watch", "--host=0.0.0.0"]
