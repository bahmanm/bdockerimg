#!/usr/bin/env perl

use strict;
use warnings;
use diagnostics;
use utf8;
use feature ':5.34';

####################################################################################################

our $DIR        = $ARGV[0];
our $VARIANT    = $ARGV[1];
our @DEPS       = @ARGV[ 2 .. $#ARGV ];
our $REPO       = 'bdockerimg/';

our $FUSION_TAG = "";
our @DEPTAGS    = ();

####################################################################################################

sub find_deptag {
    my $dep      = shift;
    my $all_tags = qx/docker image ls --format='{{.Tag}}' ${REPO}${dep}/;
    foreach my $tag ( split( /\n/, $all_tags ) ) {
        if ( $tag =~ /(.+)--${VARIANT}/ ) {
            return { dep => $dep, tag => "$dep-$1" };
        }
    }
    return { dep => $dep, tag => $dep };
}

####################################################################################################

sub find_deptags {
    foreach my $dep (@DEPS) {
        my $deptag = find_deptag($dep);
        push( @DEPTAGS, $deptag );
    }
}

####################################################################################################

sub generate_fusion_tag {
    foreach my $deptag (@DEPTAGS) {
        $FUSION_TAG .= ( $deptag->{tag} . "--" );
    }
    $FUSION_TAG .= $VARIANT;
}

####################################################################################################

sub generate_dockerfile {
    open( my $dockerfile, ">${DIR}Dockerfile.${FUSION_TAG}" );
    foreach my $deptag (@DEPTAGS) {
        my $tag = $deptag->{tag};
        say $dockerfile "FROM ${REPO}${tag}";
    }

    for my $stage ( 0 .. $#DEPTAGS - 1 ) {
        say $dockerfile "COPY --from=${stage} / /";
    }
    close($dockerfile);
}

####################################################################################################

find_deptags;
generate_fusion_tag;
generate_dockerfile;
say $FUSION_TAG;
