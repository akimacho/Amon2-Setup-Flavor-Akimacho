use 5.006;
use strict;
use warnings;
use Module::Build;

my $class = Module::Build->subclass(code => <<'EOF');
    sub ACTION_copy {
        my $self = shift;
        use FindBin;
        use File::ShareDir qw/dist_dir/;
        use File::Copy::Recursive qw/rcopy/;
        my $source = "$FindBin::Bin" . "/Akimacho/";
        my $path = dist_dir('Amon2') . '/flavor/Akimacho';
        print "[copy]:\n from : $source\n to : $path\n";
        rcopy($source, $path);
    }
EOF

my %args = (
    module_name         => 'Amon2::Setup::Flavor::Akimacho',
    license             => 'artistic_2',
    dist_author         => q{akimacho <me@example.com>},
    dist_version_from   => 'lib/Amon2/Setup/Flavor/Akimacho.pm',
    release_status      => 'stable',
    configure_requires => {
        'Module::Build' => 0,
    },
    build_requires => {
        'Test::More' => 0,
    },
    requires => {
        #'ABC'              => 1.6,
        #'Foo::Bar::Module' => 5.0401,
    },
    dist_abstract => 'Akimacho',
    add_to_cleanup     => [ 'Amon2-Setup-Flavor-Akimacho-*' ],
    create_makefile_pl => 'traditional',
);

my $builder = $class->new(%args);

$builder->add_build_element('copy');
$builder->create_build_script();
