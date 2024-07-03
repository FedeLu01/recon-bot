# Use an official Python runtime as a parent image
FROM python:3.10-alpine

# Set the working directory in the container
WORKDIR /app

# Install dependencies and tools, including Go
RUN apk add --no-cache \
    curl \
    git \
    golang 

# Declaring env variable with discord token
ENV DISCORD_TOKEN=<token>

# Tool installing
RUN go install -v github.com/projectdiscovery/dnsx/cmd/dnsx@latest && \
    go install -v github.com/tomnomnom/anew@latest && \
    go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest && \
    go install -v github.com/projectdiscovery/notify/cmd/notify@latest && \
    go install -v github.com/s0md3v/smap/cmd/smap@latest 


# Copy the current directory contents into the container at /app
COPY . /app

# fix this
COPY /opt/domain-recon /app 

# Install required dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Run the Python script in an infinite loop
CMD ["python3", "app.py"]
