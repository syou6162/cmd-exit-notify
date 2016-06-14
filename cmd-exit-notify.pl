#!/usr/bin/env perl
use strict;
use warnings;

my $lastcmd = join ' ', @ARGV;
my $current = $ENV{WINDOW};
my $windows = qx{ tmux list-windows };
my $active;

for my $win (split "\n", $windows) {
    if ($win =~ /^(\d+):.*\(active\)$/) {
        $active = $1;
        last;
    }
}

if ($current != $active) {
    `echo "yasuhisa: $lastcmd" | slackcat -p >/dev/null 2>&1`;
}
