#!/usr/bin/env bash

# Build for Linux
GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -ldflags -s -o chisel
GOOS=linux GOARCH=386 CGO_ENABLED=0 go build -ldflags -s -o chisel86

# Build for Windows
GOOS=windows GOARCH=386 go build -o chisel86.exe
GOOS=windows GOARCH=amd64 go build -o chisel.exe
