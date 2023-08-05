# if we have file[1] be a string, and file[2] be an actual file
# uploads() will return true as one of them is a file
# but $foo = params("file") fill return file[1].

# for some reason ls didn't work but ls . did. same with whoami

my $str = 'ARGV';

while (<$str>) {
    print;
}