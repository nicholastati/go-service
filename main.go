package main

import (
    "fmt"
    "log"
    "net/http"
)

func healthHandler(w http.ResponseWriter, r *http.Request) {
    fmt.Fprintf(w, "Service is healthy!")
}

func main() {
    http.HandleFunc("/api/health", healthHandler)
    log.Println("Starting server on :8081")
    if err := http.ListenAndServe(":8081", nil); err != nil {
        log.Fatal(err)
    }
}