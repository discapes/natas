#!/usr/bin/perl
use CGI;
use v5.36;
$ENV{'TMPDIR'}="/home/miika/code/github/natas/natas31";

print <<END;
Content-Type: text/html; charset=iso-8859-1

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN">
<head>
<!-- This stuff in the header has nothing to do with the level -->
<!-- Bootstrap -->
<link href="bootstrap-3.3.6-dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="http://natas.labs.overthewire.org/css/level.css">
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/jquery-ui.css" />
<link rel="stylesheet" href="http://natas.labs.overthewire.org/css/wechall.css" />
<script src="http://natas.labs.overthewire.org/js/jquery-1.9.1.js"></script>
<script src="http://natas.labs.overthewire.org/js/jquery-ui.js"></script>
<script src=http://natas.labs.overthewire.org/js/wechall-data.js></script><script src="http://natas.labs.overthewire.org/js/wechall.js"></script>
<script>var wechallinfo = { "level": "natas31", "pass": "<censored>" };</script>
<script src="sorttable.js"></script>
</head>
<script src="bootstrap-3.3.6-dist/js/bootstrap.min.js"></script>

<!-- morla/10111 -->
<style>
#content {
    width: 900px;
}
.btn-file {
    position: relative;
    overflow: hidden;
}
.btn-file input[type=file] {
    position: absolute;
    top: 0;
    right: 0;
    min-width: 100%;
    min-height: 100%;
    font-size: 100px;
    text-align: right;
    filter: alpha(opacity=0);
    opacity: 0;
    outline: none;
    background: white;
    cursor: inherit;
    display: block;
}

</style>


<h1>natas31</h1>
<div id="content">
END

my $cgi = CGI->new;
# $cgi->param('file') refers to a file object which 
# can be opened with <$file>, but if converted into a string
# , outputs the file's original name
say "type of file: " . ref $cgi->param('file'); 
# turns out $cgi->upload() doesn't do anything other than return the fd?
# so is $cgi->upload() the same as $cgi->param('file')?

# The upload method was added to CGI.pm in Version 2.47. Prior to this you could use the value returned by param (in this case $file) as a file handle in order to read from the file; if you use it as a string it returns the name of the file. This actually still works, but there are conflicts with strict mode and other problems, so upload is the preferred way to get a file handle now. Be sure that you pass upload the name of the file according to param, and not a different name (e.g., the name the user supplied, the name with nonalphanumeric characters replaced with underscores, etc.). docstore.mik.ua/orelly/linux/cgi/ch05_02.htm
if ( $cgi->param('file')) {
    my $file = $cgi->param('file');
    print '<table class="sortable table table-hover table-striped">';
    my $i=0;
    while (<$file>) {
        sleep 3;
        my @elements=split /,/, $_;

        if($i==0){ # header
            print "<tr>";
            foreach(@elements){
                print "<th>".$cgi->escapeHTML($_)."</th>";   
            }
            print "</tr>";
        }
        else{ # table content
            print "<tr>";
            foreach(@elements){
                print "<td>".$cgi->escapeHTML($_)."</td>";   
            }
            print "</tr>";
        }
        $i+=1;
    }
    print '</table>';
}
else{
print <<END;

<form action="index.pl" method="post" enctype="multipart/form-data">
    <h2> CSV2HTML</h2>
    <br>
    We all like .csv files.<br>
    But isn't a nicely rendered and sortable table much cooler?<br>
    <br>
    Select file to upload:
    <span class="btn btn-default btn-file">
        Browse <input type="file" name="file">
    </span>    
    <input type="submit" value="Upload" name="submit" class="btn">
</form> 
END
}

print <<END;
<div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>
</body>
</html>
END
