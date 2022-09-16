# Multistage Dockerfile
# Tag the name of stage with as ...
FROM node:16-alpine as builder

# Regular stuff to prep for building
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .

# We're  interested in the outcome of npm run build, to feed it into nginx
# It's stored in /app/build
RUN npm run build


# Start new stage
FROM nginx

# Copy result from previous stage
# (dest folder taken from nginx documenatation)
COPY --from=builder /app/build /usr/share/nginx/html

# Default command need not be overridden