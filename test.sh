#!/bin/sh
eval "`curl -fsSL import.pw`"
import "import.pw/assert@2.1.1"
source ./netstring.sh

assert_equal "$(printf "0:," | netstring_decode)" ""
assert_equal "$(netstring_encode < /dev/null)" "0:,"
assert_equal "$(printf "12:hello world!," | netstring_decode)" "hello world!"
assert_equal "$(printf "hello world!" | netstring_encode)" "12:hello world!,"
assert_equal "$(printf $'3: \n ,' | netstring_decode)" $' \n '

it="$(mktemp)"
printf '3:foo,0:,3:bar,' > "$it"
exec 5< "$it"
assert_equal "$(netstring_decode <&5)" "foo"
assert_equal "$(netstring_decode <&5)" ""
assert_equal "$(netstring_decode <&5)" "bar"
