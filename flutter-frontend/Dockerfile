FROM cirrusci/flutter:latest AS build
WORKDIR /app
COPY . .
RUN flutter pub get
RUN flutter config --enable-web
RUN flutter build web

FROM node:16-slim AS serve
RUN npm install -g http-server
WORKDIR /app
COPY --from=build /app/build/web .
EXPOSE 3000
CMD ["http-server", ".", "-p", "3000", "--cors"]