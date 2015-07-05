use strict;
use warnings;
use utf8;
use Getopt::Long qw/:config auto_help/;
<% block load_modules -> { %>
use '<% $module %>';

my $c = <% $module %>->bootstrap;
<% } %>

