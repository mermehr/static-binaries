# Static binaries

A collection of statically linked, stripped binaries for penetration testing and red teaming. These tools are built to be drop-and-execute ready on minimal target environments (containers, IoT, hardened servers) without requiring external libraries.

**I'll add to this list as I go and include build scripts for strangeties I encounter.**

- Tested on:
  - arch current, alpine 3.20, ubuntu 20.04
  - windows server 2016, windows 10, wine

| Binaries / Files         | Version | System      | Arch        |  |
| ------------------------------------------------------------ | ------- | ----------- | ----------- | ----------- |
| [ligolo-ng](binaries/ligolo-ng)  | 0.8.2   | Linux / Windows | amd64 / 386 | [GitHub](https://github.com/nicocha30/ligolo-ng) |
| [kerbrute](binaries/kerbrute) | 1.0.3   | Linux / Windows | amd64 / 386 | [GitHub](https://github.com/ropnop/kerbrute/releases) |
| [chisel](binaries/chisel)        | 1.11.3  | Linux / Windows | amd64 / 386 | [GitHub](https://github.com/jpillora/chisel) |
| [gocat](binaries/gocat)        | 2.14    | Linux / Windows | amd64 / 386 | [GitHub](https://github.com/ibrahmsql/Gocat) |
| [ptunnel-ng](binaries/ptunnel-ng)   | 1.43    | Linux   | amd64 / 386 | [GitHub](https://github.com/utoni/ptunnel-ng) |
| [socat](binaries/socat)         | 1.8.0  | Linux  | amd64 / 386 | [dest-unreach](http://www.dest-unreach.org/socat/) |
| [GNU netcat](binaries/nc) (nc) | 0.7.1   | Linux / Windows | amd64 / 386 | [Sourceforge](https://sourceforge.net/projects/netcat/files/netcat/0.7.1/) |
| [Nmap ncat](binaries/ncat)                 | 7.93    | Linux / Windows | amd64 / 386 | [Nmap](https://nmap.org/ncat/) |
| [busybox](binaries/busybox)        | 1.35.0  | Linux  | amd64 / 386 | [GitHub](https://github.com/mirror/busybox) |
| [go-winapsearch](binaries/windapsearch) | 0.3.1   | Linux / Windows | amd64       | [GitHub](https://github.com/ropnop/go-windapsearch) |
| [pspy](binaries/pspy)      | 1.2.1   | Linux  | amd64 / 386 | [GitHub](https://github.com/DominicBreuker/pspy) |
| [tmux](binaries/tmux)                | 3.5a   | Linux  | amd64 / 386 | [GitHub](https://github.com/tmux/tmux) |
| [amass](binaries/amass)             | 5.0.1   | Linux  | amd64 / 386 | [GitHub](https://github.com/owasp-amass) |
| [curl](binaries/curl)                | 8.17.0  | Linux  | amd64 / 386 | [GitHub](https://github.com/curl/curl) |
| [htop](binaries/htop)            | 3.4.1   | Linux  | amd64 / 386 | [GitHub](https://github.com/htop-dev/htop) |

---

## Build Notes

**A couple of odd builds. I left the cosponsoring Docker build files in the respective binaries directory.**

- `curl` - Disabled everything heavy (LDAP, RTMP, etc) to ensure clean static build.
- `htop` - Disabled unicode/mouse to make it more portable.
  - `top` in `busybox` is safer, but if you have a decent shell on the target, this static `htop` will work fine.
- `ptunnel-ng` - Had to injected `netinet/in.h` at the very top of ptunnel.h so libc definitions take precedence over kernel definitions (`linux/in6.h`)
- `gocat` 386 only -  Had to break as SCTP support as `SYS_GETSOCKOPT/SETSOCKOPT` don't exist on `linux/386`, but TCP/UDP/HTTP will work fine.
  - Use`gobuild-linux-386.sh` in `bin/gocat/` to patch and build locally.
- `socat` - This was built for pivoting so I disabled problematic libraries (`readline`, `tcp_wrappers`), and forced a static link with OpenSSL support. Who needs extra security and fancy command history?

### **Further reducing Size (UPX)**

If a binary is too large for file transfer limits, use UPX to pack it.

```bash
upx --best --lzma binary_name
```
