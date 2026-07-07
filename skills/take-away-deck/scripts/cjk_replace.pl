#!/usr/bin/perl
# Reliable find/replace for files containing CJK (Chinese/Japanese/Korean) text.
#
# IMPORTANT: this runs in BYTE mode on purpose (no `use utf8`, no -CSD).
# The pattern and the file are both raw UTF-8 bytes, so they match 1:1.
# If you add `use utf8` or the `-CSD` flag, the Chinese literals get decoded
# to characters while the file is read as bytes, the encodings differ, and
# NOTHING matches (a silent no-op). This footgun cost real time — don't.
#
# Usage:
#   FIND='旧文本' REPLACE='新文本' perl cjk_replace.pl file1 [file2 ...]
use strict;
use warnings;

my $find = defined $ENV{FIND}    ? $ENV{FIND}    : die "set FIND env var\n";
my $repl = defined $ENV{REPLACE} ? $ENV{REPLACE} : die "set REPLACE env var\n";

local $/;    # slurp
for my $f (@ARGV) {
    open my $in, '<', $f or die "$f: $!";
    my $c = <$in>;
    close $in;
    my $n = ($c =~ s/\Q$find\E/$repl/g);   # \Q..\E => literal, metachar-safe
    open my $out, '>', $f or die "$f: $!";
    print $out $c;
    close $out;
    print "$f: $n replacement(s)\n";
}
