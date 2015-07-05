package <% $module %>::Model;
use Mouse;
use <% $module %>::DB;
use <% $module %>::DB::Schema;

has 'connect_info' => (
    is => 'ro',
    isa => 'ArrayRef',
    required => 1,
);

has 'db' => (
    is => 'ro',
    isa => 'U2::DB',
    required => 1,
    lazy_build => 1,
);

my $schema = <% $module %>::DB::Schema->instance;

sub _build_db {
    my $self = shift;
    <% $module %>::DB->new(
        schema => $schema,
        connect_info => [@{$self->connect_info}],
        # I suggest to enable following lines if you are using mysql.
        # on_connect_do => [
        #     'SET SESSION sql_mode=STRICT_TRANS_TABLES;',
        # ],
    )
}

__PACKAGE__->meta->make_immutable();
