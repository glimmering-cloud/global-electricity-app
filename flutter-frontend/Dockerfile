FROM cirrusci/flutter:latest AS build
WORKDIR /app
RUN chown -R 1001:1001 /sdks/flutter && \
    git config --global --add safe.directory /sdks/flutter
RUN useradd -m -r -u 1001 flutteruser && chown flutteruser:flutteruser /app
USER flutteruser
COPY --chown=flutteruser:flutteruser . .
RUN flutter pub get
RUN flutter config --enable-web
RUN flutter build web

FROM node:16-slim AS serve
RUN npm install -g http-server
WORKDIR /app
COPY --from=build /app/build/web .
EXPOSE 3000
CMD ["http-server", ".", "-p", "3000", "--cors"]
