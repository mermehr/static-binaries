# Patch Gocat for 32-bit Linux
sed -i 's/syscall.SYS_GETSOCKOPT/0/g' internal/network/sctp.go
sed -i 's/syscall.SYS_SETSOCKOPT/0/g' internal/network/sctp.go

echo "Building Gocat 386..."
CGO_ENABLED=0 GOOS=linux GOARCH=386 go build -ldflags="-s -w" -o ../binaries/gocat-linux-386 .

# Cleanup Gocat so git status isn't messy
git checkout internal/network/sctp.go
