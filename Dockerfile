# Build stage
FROM golang:1.22-alpine AS builder
WORKDIR /app
COPY go.mod ./
COPY go.sum ./ 2>/dev/null || :
RUN go mod download
COPY . .
RUN go build -o go-service main.go

# Run stage
FROM alpine:latest
WORKDIR /app
COPY --from=builder /app/go-service .
EXPOSE 8080
HEALTHCHECK --interval=30s --timeout=3s CMD curl -f http://localhost:8080/api/health || exit 1
CMD ["./go-service"]