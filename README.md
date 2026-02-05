# copyparty-docker

A secure, minimal Docker container for [copyparty](https://github.com/9001/copyparty) built on [Chainguard's Python images](https://images.chainguard.dev/directory/image/python/overview).

## Features

- **Minimal & Secure**: Based on Chainguard images for a reduced attack surface and little to no known vulnerabilities.
- **Hardened**: Runs as a non-root user (`65532`) with dropped capabilities and `no-new-privileges`.
- **Customizable**: Easy to configure via environment variables and Docker Compose.

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)

## Quick Start

1. **Clone the repository**:
   ```bash
   git clone https://github.com/thimbleforth/copyparty-docker.git
   cd copyparty-docker
   ```

2. **Configure your storage directory**:
   Edit the `.env` file and set `STORAGEDIR` to the path where you want copyparty to store its data.
   ```dotenv
   STORAGEDIR=/path/to/your/data
   ```

3. **Build and start the container**:
   ```bash
   docker compose up -d
   ```

4. **Access copyparty**:
   Open your browser and navigate to `http://localhost:3923`.

## Configuration

The following environment variables can be configured in the `.env` file:

| Variable | Description | Default |
|----------|-------------|---------|
| `STORAGEDIR` | Path on the host machine where data will be stored. | Required |

## Security

This setup is designed with security in mind:
- **Chainguard Base Image**: Uses a distroless-like Python image which contains only the essential components to run Python.
- **Capabilities Dropped**: All Linux capabilities are dropped (`cap_drop: ALL`).
- **No New Privileges**: Prevents processes from gaining new privileges via `setuid` or `setgid` binaries.
- **Non-Root User**: Runs as `UID 65532` (nonroot).

## Usage Details

- **Port**: The application listens on port `3923`.
- **Data Volume**: The host directory specified in `STORAGEDIR` is mounted to `/home/nonroot/data` in the container.
- **Commands**: The container runs `copyparty -v -r /home/nonroot/data` by default.

## License

Refer to the [copyparty license](https://github.com/9001/copyparty/blob/master/LICENSE) for application details.
