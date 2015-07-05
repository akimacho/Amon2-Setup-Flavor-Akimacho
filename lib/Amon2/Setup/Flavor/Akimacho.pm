package Amon2::Setup::Flavor::Akimacho;
use strict;
use warnings;
use parent qw(Amon2::Setup::Flavor);

our $VERSION = '0.01';

sub _build_xslate {
    my $self = shift;
    use File::Spec;
    my $xslate = Text::Xslate->new(
        syntax => 'Kolon',
        type   => 'text',
        tag_start => '<%',
        tag_end   => '%>',
        line_start => '%%',
        path => [
            File::Spec->catdir(File::ShareDir::dist_dir('Amon2'), 'flavor'),
            File::Spec->catdir(File::ShareDir::dist_dir('Amon2-Setup-Flavor-Akimacho'), 'flavor'),
        ],
        module => [
            'Amon2::Util' => ['random_string'],
        ],
    );
    $xslate;
}

sub run {
    my $self = shift;

    # write code.
    $self->render_file(
        "tmpl/index.tx",
        "Akimacho/tmpl/index.tx"
    );
    $self->render_file(
        "tmpl/include/layout.tx",
        "Akimacho/tmpl/include/layout.tx"
    );
    $self->render_file(
        'lib/<<PATH>>.pm',
        "Akimacho/lib/__PATH__.pm"
    );
    $self->render_file(
        'lib/<<PATH>>/Model.pm',
        "Akimacho/lib/__PATH__/Model.pm"
    );
    $self->render_file(
        'lib/<<PATH>>/Web.pm',
        "Akimacho/lib/__PATH__/Web.pm"
    );
    $self->render_file(
        'lib/<<PATH>>/Web/Dispatcher.pm',
        "Akimacho/lib/__PATH__/Web/Dispatcher.pm"
    );
    $self->render_file(
        'lib/<<PATH>>/Web/C/Root.pm',
        "Akimacho/lib/__PATH__/Web/C/Root.pm"
    );
    $self->render_file(
        'lib/<<PATH>>/Web/Plugin/Session.pm',
        'Basic/lib/__PATH__/Web/Plugin/Session.pm'
    );
    $self->render_file(
        'lib/<<PATH>>/Web/View.pm',
        'Minimum/lib/__PATH__/Web/View.pm'
    );
    $self->render_file(
        'lib/<<PATH>>/Web/ViewFunctions.pm',
        'Minimum/lib/__PATH__/Web/ViewFunctions.pm'
    );
    $self->render_file(
        'lib/<<PATH>>/DB.pm',
        'Basic/lib/__PATH__/DB.pm'
    );
    $self->render_file(
        'lib/<<PATH>>/DB/Schema.pm',
        'Basic/lib/__PATH__/DB/Schema.pm'
    );
    $self->render_file(
        'lib/<<PATH>>/DB/Row.pm',
        'Basic/lib/__PATH__/DB/Row.pm'
    );
    $self->render_file(
        $self->psgi_file,
        'Basic/script/server.pl'
    );
    $self->render_file(
        'Build.PL',
        'Minimum/Build.PL'
    );
    $self->render_file(
        'minil.toml',
        'Minimum/minil.toml'
    );
    $self->render_file(
        'builder/MyBuilder.pm',
        'Minimum/builder/MyBuilder.pm'
    );
    $self->create_cpanfile({
        'HTML::FillInForm::Lite'          => '1.11',
        'Time::Piece'                     => '1.20',
        'Plack::Middleware::ReverseProxy' => '0.09',
        'JSON'                            => '2.50',
        'Teng'                            => '0.18',
        'DBD::SQLite'                     => '1.33',
        'Test::WWW::Mechanize::PSGI'      => 0,
        'Router::Boom'                    => '0.06',
        'HTTP::Session2'                  => '1.03',
        'Crypt::CBC'                      => '0',
        'Crypt::Rijndael'                 => '0',
    });

    # static files
    $self->write_file("static/img/.gitignore", '');
    $self->write_file("static/robots.txt", '');
    $self->render_file(
        "static/js/jquery-1.11.3.min.js",
        "Akimacho/static/js/jquery-1.11.3.min.js"
    );
    $self->render_file(
        "static/js/script.js",
        "Akimacho/static/js/script.js"
    );
    $self->render_file(
        "static/css/style.css",
        "Akimacho/static/css/style.css"
    );
    $self->render_file(
        'db/.gitignore',
        'Basic/db/dot.gitignore'
    );

    # configuration files
    $self->render_file(
        'config/base.pl',
        "Akimacho/config/base.pl"
    );
    for my $env (qw(development production test)) {
        $self->render_file(
            "config/${env}.pl",
            "Akimacho/config/__ENV__.pl",
            { env => $env }
        );
    }
    $self->render_file(
        'sql/mysql.sql',
        'Basic/sql/mysql.sql'
    );
    $self->render_file(
        'sql/sqlite.sql',
        'Basic/sql/sqlite.sql'
    );
    $self->render_file(
        't/Util.pm',
        'Basic/t/Util.pm'
    );
    $self->render_file(
        't/00_compile.t',
        'Basic/t/00_compile.t'
    );
    $self->render_file(
        't/01_root.t',
        'Minimum/t/01_root.t',
        {psgi_file => $self->psgi_file,}
    );
    $self->render_file(
        't/02_mech.t',
        'Minimum/t/02_mech.t',
        {psgi_file => $self->psgi_file,}
    );
    $self->render_file(
        'xt/01_pod.t',
        'Minimum/xt/01_pod.t'
    );
    $self->render_file(
        'xt/02_perlcritic.t',
        'Basic/xt/02_perlcritic.t'
    );
    $self->render_file(
        '.gitignore',
        'Basic/dot.gitignore'
    );
    $self->render_file(
        '.proverc',
        'Basic/dot.proverc'
    );
    {
        my %status = (
            '503' => 'Service Unavailable',
            '502' => 'Bad Gateway',
            '500' => 'Internal Server Error',
            '504' => 'Gateway Timeout',
            '404' => 'Not Found'
        );
        while (my ($status, $status_message) = each %status) {
            $self->render_file(
                "static/$status.html",
                "Basic/static/__STATUS__.html",
                {
                    status => $status,
                    status_message => $status_message
                }
            );
        }
    }
}

sub psgi_file {
    my $self = shift;
    'script/' . lc($self->{dist}) . '-server';
}

sub show_banner {
    my $self = shift;

    printf <<'...', $self->psgi_file;
--------------------------------------------------------------

Setup script was done! You are ready to run the skelton.

You need to install the dependencies by:

    > carton install

And then, run your application server:

    > carton exec perl -Ilib %s

--------------------------------------------------------------
...
}

1;
