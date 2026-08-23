# Issue #182. This repo has no NestJS API, React dashboard, MongoDB, or
# Redis to containerize — none of that exists here (see docs/adr/0004).
# The one real service is the Flutter *web* build (this app also ships
# Android/iOS, but those aren't Docker-relevant). Multi-stage, same shape
# the issue asks for: a lean build stage, and a tiny production image
# that only carries the compiled static output.
#
# Not verified with a real `docker build` — this environment has no
# Docker daemon available. The image/base/commands below are the
# standard, widely-used pattern for containerized Flutter web builds;
# still worth a real dry run before relying on this in production.

# ---- Stage 1: build ----
FROM ghcr.io/cirruslabs/flutter:stable AS build
WORKDIR /app
COPY pubspec.yaml pubspec.lock ./
RUN flutter pub get
COPY . .
RUN flutter build web --release

# ---- Stage 2: production ----
FROM nginx:alpine AS production
COPY --from=build /app/build/web /usr/share/nginx/html
COPY docker/nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
HEALTHCHECK --interval=30s --timeout=3s --start-period=10s \
  CMD wget -q --spider http://localhost/ || exit 1
