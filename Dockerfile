FROM golang:1.19-buster AS builder
WORKDIR /app
COPY go.* ./
RUN go mod download
COPY cmd/*.go ./
RUN go build -o /webhk

# Create a new release build stage
FROM gcr.io/distroless/base-debian10

# Set the working directory to the root directory path
WORKDIR /

# Copy over the binary built from the previous stage
COPY --from=builder /webhk /webhk
EXPOSE 8080
ENTRYPOINT ["/webhk"]