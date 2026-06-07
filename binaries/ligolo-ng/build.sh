#!/usr/bin/env bash

# Build for Linux
GOOS=linux GOARCH=amd64 go build -o agent cmd/agent/main.go
GOOS=linux GOARCH=386 go build -o agent86 cmd/agent/main.go
GOOS=linux GOARCH=amd64 go build -o proxy cmd/proxy/main.go

# Build for Windows
GOOS=windows GOARCH=386 go build -o agent86.exe cmd/agent/main.go
GOOS=windows GOARCH=amd64 go build -o agent.exe cmd/agent/main.go
GOOS=windows GOARCH=amd64 go build -o proxy.exe cmd/proxy/main.go
GOOS=windows GOARCH=386 go build -o proxy86.exe cmd/proxy/main.go
