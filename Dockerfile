# Build stage
FROM golang:1.24-alpine AS builder
WORKDIR /app
COPY go.mod ./
RUN go mod download
COPY . .
RUN go build -o go-service main.go

# Run stage
FROM alpine:latest
WORKDIR /app
COPY --from=builder /app/go-service .
EXPOSE 8081
HEALTHCHECK --interval=30s --timeout=3s CMD curl -f http://localhost:8081/api/health || exit 1
CMD ["./go-service"]