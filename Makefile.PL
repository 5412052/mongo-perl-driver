use strict;
use warnings;

use lib '.';

BEGIN {
    if ( $^O eq "MSWin32" ) {
        my (undef, $major, undef, undef, $id ) = Win32::GetOSVersion();
        die "OS unsupported.  Windows Vista or later is required.\n"
            unless $id > 2 || $major > 5;
    }
}

use inc::Module::Install;

name 'MongoDB';
perl_version '5.10.1';
author 'Florian Ragwitz <rafl@debian.org>';
author 'Kristina Chodorow <kristina@mongodb.com>';
author 'Mike Friedman <mike.friedman@mongodb.com>';
author 'David.Golden <david.golden@mongodb.com>';
license 'Apache';
all_from 'lib/MongoDB.pm';

requires 'Authen::SCRAM::Client' => '0.009';
requires 'BSON::Decimal128' => '1';
requires 'Carp';
requires 'Class::XSAccessor';
requires 'DateTime' => '0.78';
requires 'Digest::MD5';
requires 'Encode';
requires 'Exporter' => '5.57';
requires 'ExtUtils::ParseXS' => 3.21;
requires 'IO::File';
requires 'IO::Socket' => ( $^O eq 'MSWin32' ? '1.31' : '0' );
requires 'List::Util';
requires 'MIME::Base64';
requires 'Moo' => '2';
requires 'Moo::Role';
requires 'Net::DNS';
requires 'Safe::Isa';
requires 'Scalar::Util';
requires 'Socket';
requires 'Tie::IxHash';
requires 'Time::HiRes';
requires 'Try::Tiny';
requires 'Type::Library';
requires 'Type::Tiny' => '1';
requires 'Type::Tiny::XS' if $] ge '5.010001';
requires 'Type::Utils';
requires 'Types::Standard';
requires 'UUID::URandom';
requires 'XSLoader';
requires 'boolean' => 0.25;
requires 'constant';
requires 'if';
requires 'namespace::clean';
requires 'overload';
requires 're';
requires 'strict';
requires 'version';
requires 'warnings';

test_requires 'Data::Dumper';
test_requires 'Devel::Peek';
test_requires 'ExtUtils::MakeMaker';
test_requires 'File::Spec';
test_requires 'File::Temp' => '0.17';
test_requires 'FileHandle';
test_requires 'JSON::MaybeXS' => '1.002005';
test_requires 'Math::BigInt';
test_requires 'Path::Tiny' => '0.054';
test_requires 'Test::Deep' => '0.111';
test_requires 'Test::Fatal';
test_requires 'Test::More' => '0.96';
test_requires 'bigint';
test_requires 'lib';
test_requires 'utf8';

mongo;

repository 'git://github.com/mongodb/mongo-perl-driver.git';

tests_recursive;

WriteAll;

package MY;

use Config;

# Because we keep our XS in an 'xs' subdirectory, this ensures the object files
# are built there, too, which is needed for linking to work.
# Originally added by Florian Ragwitz, based on Glib::MakeHelper. See
# https://metacpan.org/source/XAOC/Glib-1.304/lib/Glib/MakeHelper.pm#L553
sub const_cccmd {
    my $inherited = shift->SUPER::const_cccmd(@_);
    return '' unless $inherited;

    if ($Config{cc} =~ /^cl\b/) {
        $inherited .= ' /Fo$@';
    }
    else {
        $inherited .= ' -o $@';
    }
    return $inherited;
}
