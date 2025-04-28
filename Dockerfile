# Build stage
FROM golang:1.24-alpine AS builder
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN go build -o go-service main.go

# Run stage
FROM alpine:latest
WORKDIR /app
COPY --from=builder /app/go-service .
EXPOSE 8080
CMD ["./go-service"]