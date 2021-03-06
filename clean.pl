#!/usr/bin/perl
use 5.12.0;
use warnings FATAL => 'all';

my @files = `find . -type f`;

for my $file (@files) {
    $file =~ /^(\.\/)?.git/ && next;
    $file =~ /node_modules/ && next;
    $file =~ /deps/ && next;
    $file =~ /_build/ && next;

    chomp $file;
    my $type = `file "$file"`;
    chomp $type;

    if (($type =~ /ELF/ || $type =~ /BEAM/) && $type !~ /ASCII/) {
        say "Cleaning: $file";
        system(qq{rm "$file"});
    }
}

