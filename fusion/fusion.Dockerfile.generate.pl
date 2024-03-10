#!/usr/bin/env perl

use strict;
use warnings;
use diagnostics;
use utf8;
use feature ':5.34';

####################################################################################################

our $DIR     = $ARGV[0];
our $VARIANT = $ARGV[1];
our @DEPS    = @ARGV[ 2 .. $#ARGV ];
our $REPO    = 'bdockerimg/';

our $FUSION_TAG = "";
our @DEPTAGS    = ();

####################################################################################################

sub find_deptag {
    my $dep      = shift;
    my $all_tags = qx/docker image ls --format='{{.Tag}}' ${REPO}${dep}/;
    foreach my $tag ( split( /\n/, $all_tags ) ) {
        if ( $tag =~ /(.+)--${VARIANT}/ ) {
            return { dep => $dep, tag => $1 };
        }
    }
    return { dep => $dep, tag => "" };
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
        my $tag = deptag_to_string($deptag);
        $FUSION_TAG .= ( $tag . "--" );
    }
    $FUSION_TAG .= $VARIANT;
}

####################################################################################################

sub generate_dockerfile {
    open( my $dockerfile, ">${DIR}Dockerfile.${FUSION_TAG}" );
    foreach my $deptag (@DEPTAGS) {
        my $dep = $deptag->{dep};
        my $tag = $deptag->{tag} ? "$deptag->{tag}--${VARIANT}" : $VARIANT;
        say $dockerfile "FROM ${REPO}${dep}:${tag}";
    }

    for my $stage ( 0 .. $#DEPTAGS - 1 ) {
        say $dockerfile "COPY --from=${stage} / /";
    }
    close($dockerfile);
}

####################################################################################################

sub deptag_to_string {
    my $deptag = shift;
    my $dep    = $deptag->{dep};
    my $tag    = $deptag->{tag} ? "${dep}-$deptag->{tag}" : $dep;
    return $tag;
}

####################################################################################################

find_deptags;
generate_fusion_tag;
generate_dockerfile;
say $FUSION_TAG;
