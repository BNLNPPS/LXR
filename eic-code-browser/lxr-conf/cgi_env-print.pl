#!/usr/bin/perl -T
# to enable this script in lxr/.htaccess
# then run this script through
# https://acode-browser2.usatlas.bnl.gov/lxr/cgi_env-print.pl on a web browser.

print "Content-type:text/html\r\n\r\n";
print '<html>';
print '<head>';
print '<title>Print list of CGI parameters</title>';
print '</head>';
print '<body>';
print "<br>A list of all CGI environment variables (just in case you want to know) :<br>\n";

foreach $key (sort keys(%ENV)) {
print "export $key=$ENV{$key}<br>\n";
}

print '</body>';
print '</html>';
1;
