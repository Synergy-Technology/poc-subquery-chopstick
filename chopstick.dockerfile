FROM node:latest
RUN apt-get update && apt-get install -y build-essential curl git
RUN apt-get update
# Install Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

ENV PATH="/root/.cargo/bin:${PATH}"
RUN rustup update nightly
RUN rustup target add wasm32-unknown-unknown --toolchain nightly

WORKDIR /app
RUN git clone --recurse-submodules https://github.com/Synergy-Technology/chopsticks.git

WORKDIR /app/chopsticks
RUN yarn
RUN yarn build-wasm
RUN yarn dev

