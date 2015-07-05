use strict;
use warnings;
use Test::More;
<% block load_modules -> { %>
use_ok '<% $module %>';
use_ok '<% $module %>::Model';
use_ok '<% $module %>::DB';

my $obj = <% $module %>->context;
isa_ok $obj, '<% $module %>';
<% } %>

done_testing;
