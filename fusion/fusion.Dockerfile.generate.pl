#!/usr/bin/env perl

use strict;
use warnings;
use diagnostics;
use utf8;
use feature ':5.34';

our $VARIANT = $ARGV[0];
our @DEPS    = @ARGV[ 1 .. $#ARGV ];
our $REPO    = 'bdockerimg/';

sub find_tag {
    my $dep      = shift;
    my $all_tags = qx/docker image ls --format='{{.Tag}}' ${REPO}${dep}/;

    foreach my $tag ( split( /\n/, $all_tags ) ) {
        return "$dep-$1" if ( $tag =~ /(.+)--${VARIANT}/ );
    }
    return $dep;
}

our @tags = ();
foreach my $dep (@DEPS) {
    my $tag = find_tag($dep);
    push( @tags, $tag );
}
say join( '--', @tags ) . '--' . $VARIANT;
