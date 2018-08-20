# netstring

[Netstring](https://cr.yp.to/proto/netstrings.txt) encoding and decoding
functions for shell scripts.

These functions operate over `stdin` and `stdout` so that `NULL` bytes [are
not lost](https://unix.stackexchange.com/a/174017/102771) in the process.

## Example

```bash
#!/bin/sh
eval "`curl -sfLS import.pw`"

import netstring@1.0.0

printf "12:hello world!," | netstring_decode
# hello world!

printf "hello world!" | netstring_encode
# 12:hello world!,
```
