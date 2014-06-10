use ExtUtils::MakeMaker;

WriteMakefile(
    'NAME'         => 'PPIx::Perlcc',
    'VERSION_FROM' => 'lib/PPIx/Perlcc.pm',
    'AUTHOR'       => 'Erin Schoenhals <erin@cpanel.net>',
    'LICENSE'      => 'perl',
    'ABSTRACT'     => 'Find code that runs in compile-time blocks',

    'PREREQ_PM' => {
        'PPI'          => 0,
        'Perl::Critic' => 0
    }
);
