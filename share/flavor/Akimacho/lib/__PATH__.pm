package <% $module %>;
use strict;
use warnings;
use utf8;
our $VERSION='0.01';
use 5.008001;
use <% $module %>::DB::Schema;
use <% $module %>::DB;

use parent qw/Amon2/;
# Enable project local mode.
__PACKAGE__->make_local_context();

my $schema = <% $module %>::DB::Schema->instance;

sub model {
    my $c = shift;
    if (!exists $c->{db}) {
        my $connect_info = $c->config->{DBI}
            or die "Missing configuration about DBI";
        $c->{model} = <% $module %>::Model->new(
            connect_info => $connect_info,
        );
    }
    $c->{model};
}

1;
__END__

=head1 NAME

<% $module %> - <% $module %>

=head1 DESCRIPTION

This is a main context class for <% $module %>

=head1 AUTHOR

<% $module %> authors.

