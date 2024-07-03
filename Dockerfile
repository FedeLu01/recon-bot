# Use an official Python runtime as a parent image
FROM python:3.10-alpine

# Set the working directory in the container
WORKDIR /app

# Install dependencies and tools, including Go
RUN apk add --no-cache \
    curl \
    git \
    bash

# Install Go
ENV GOLANG_VERSION 1.22.5
RUN curl -L -o /tmp/go.tar.gz https://golang.org/dl/go$GOLANG_VERSION.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf /tmp/go.tar.gz && \
    rm /tmp/go.tar.gz

# Set Go environment variables
ENV GOPATH=/go
ENV PATH=$GOPATH/bin:/usr/local/go/bin:$PATH

# Verify Go installation
RUN /usr/local/go/bin/go version

# Tool installing
RUN /usr/local/go/bin/go install -v github.com/projectdiscovery/dnsx/cmd/dnsx@latest && \
    /usr/local/go/bin/go install -v github.com/tomnomnom/anew@latest && \
    /usr/local/go/bin/go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest && \
    /usr/local/go/bin/go install -v github.com/projectdiscovery/notify/cmd/notify@latest && \
    /usr/local/go/bin/go install -v github.com/s0md3v/smap/cmd/smap@latest 

# Copy the current directory contents into the container at /app
COPY . /app

# Copy the domain-recon directory into the container
COPY /opt/domain-recon /app/domain-recon

# Install required dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Run the Python script in an infinite loop
CMD ["python3", "app.py"]
