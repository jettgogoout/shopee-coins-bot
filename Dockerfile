FROM alpine:3.16.1 AS linlee
LABEL org.opencontainers.image.description="Get Shopee coins everyday"
LABEL org.opencontainers.image.licenses="MIT"
# These labels are set by CI
# LABEL org.opencontainers.image.title
# LABEL org.opencontainers.image.version
# LABEL org.opencontainers.image.authors
# LABEL org.opencontainers.image.url
# LABEL org.opencontainers.image.source
# LABEL org.opencontainers.image.created
# LABEL org.opencontainers.image.documentation
# LABEL org.opencontainers.image.revision


# Install required packages and add a non-root user
USER root
RUN apk add --no-cache chromium chromium-chromedriver nodejs tini \
    && adduser -u 1000 -H -D bot


# Add app
USER bot
COPY dist /app


USER bot
ENV TZ="Asia/Taipei"
ENV CHROME_BIN=/usr/bin/chromium-browser
ENV CHROME_PATH=/usr/lib/chromium/
WORKDIR /app
ENTRYPOINT [ "tini", "--", "node", "index.js" ]


# Another image that contains CJK font
FROM linlee
USER root
RUN apk add --no-cache font-noto-cjk
