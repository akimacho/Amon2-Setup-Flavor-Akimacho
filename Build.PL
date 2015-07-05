use 5.006;
use strict;
use warnings;
use Module::Build;

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
    share_dir => 'share',
    dist_abstract => 'share',
    add_to_cleanup     => [ 'Amon2-Setup-Flavor-Akimacho-*' ],
    create_makefile_pl => 'traditional',
);

my $builder = Module::Build->new(%args);
$builder->create_build_script();
