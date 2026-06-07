#!/usr/bin/env bash

# Build for Linux
GOOS=linux GOARCH=amd64 go build -o chisel
GOOS=linux GOARCH=386 go build -o chisel86

# Build for Windows
GOOS=windows GOARCH=386 go build -o chisel86.exe
GOOS=windows GOARCH=amd64 go build -o chisel.exe
