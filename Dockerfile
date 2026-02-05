# ---- Build Stage ---------------------------------------------------------
FROM cgr.dev/chainguard/python:latest-dev AS builder

USER root

RUN echo "https://apk.cgr.dev/extra-packages" | tee -a /etc/apk/repositories

# Create install prefix and give ownership to nonroot
RUN mkdir -p /install && chown -R nonroot:nonroot /install

# Install system dependencies for Pillow + ffmpeg
# Chainguard uses apk-compatible packages
RUN apk update && apk add --no-cache \
    py3-pillow \
    ffmpeg \
    build-base \
    zlib-dev \
    tiff-dev \
    freetype-dev \
    lcms2-dev \
    openjpeg-dev \
    libwebp-dev \
    harfbuzz-dev \
    fribidi-dev \
    libvips	

# Install Copyparty + deps into a local directory
RUN pip install --no-cache-dir \
    --prefix=/usr \
    copyparty \
	argon2-cffi \
	pyftpdlib \
	pyopenssl \
	paramiko \
	mutagen \
	rawpy \
	pyvips 

# ---- Final Stage ---------------------------------------------------------
FROM cgr.dev/chainguard/python:latest

# Copy only the built Python environment
COPY --from=builder /usr /usr
COPY config.conf /home/nonroot/config.conf

USER nonroot

RUN mkdir -p /home/nonroot/data

# Create runtime directory
WORKDIR /app

EXPOSE 3923
# Run Copyparty with explicit args
CMD ["/usr/bin/copyparty", "-c", "$PRTY_CONFIG"]
