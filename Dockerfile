FROM python:3.10.9-slim-bullseye

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Install Git
RUN apt-get update && apt-get install -y git && apt-get clean

# Checkout the pdfposter project
ARG GIT_COMMIT=master
RUN git clone https://gitlab.com/pdftools/pdfposter.git
WORKDIR /pdfposter
RUN git checkout ${GIT_COMMIT}

# Install pdfposter
RUN python3 setup.py install

# Entry point to keep the container running
ENTRYPOINT ["/usr/local/bin/pdfposter"]