package <% $module %>::Web::Dispatcher;
use strict;
use warnings;
use utf8;
use Amon2::Web::Dispatcher::RouterBoom;
use Module::Find qw(useall);

useall("<% $module %>::Web::C");
base "<% $module %>::Web::C";

get '/' => 'Root#index';

1;
