# Netstrings: https://cr.yp.to/proto/netstrings.txt
# Inspired by: https://gist.github.com/benstiglitz/7237812

# 'hello' -> '5:hello,'
netstring_encode() {
  local data="$(cat)"
  local byte_count="$(printf "%s" "$data" | wc -c)"
  printf "%s:%s," "${byte_count}" "$data"
}

# '5:hello,' -> 'hello'
netstring_decode() {
  local byte_count
  IFS='' read -d: byte_count || return $?
  if [ "${byte_count}" -ne 0 ]; then
    read_bytes "${byte_count}" || return $?
  fi
  local comma="$(read_bytes 1)"
  if [ "${comma}" != "," ]; then
    echo "netstring_decode: invalid netstring terminator \`${comma}\`" >&2
    return 1
  fi
}

read_bytes() {
  LANG=C IFS= read -r -d '' -n "$1" char
  printf "%s" "${char}"
}
