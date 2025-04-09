# Use official Flutter image
FROM ghcr.io/cirruslabs/flutter:stable AS build

# Set working directory
WORKDIR /app

# Copy source code
COPY . .

# Fix Flutter permission issue (THIS LINE IS CRUCIAL)
RUN chown -R root:root /sdks/flutter && chmod -R a+w /sdks/flutter

# Safe directory config for git
RUN git config --global --add safe.directory /sdks/flutter

# Enable web support and get dependencies
RUN flutter config --enable-web
RUN flutter pub get

# Build Flutter web
RUN flutter build web

# Serve built app with Nginx
FROM nginx:alpine
COPY --from=build /app/build/web /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]