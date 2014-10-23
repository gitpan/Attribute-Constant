#!perl -T
#
# $Id: 03-obj.t,v 0.2 2008/06/27 19:50:52 dankogai Exp dankogai $
#
use strict;
use warnings;
use Attribute::Constant;
#use Test::More 'no_plan';
use Test::More tests => 10;

{
    package Foo;
    sub new { my $pkg = shift; bless { @_ }, $pkg }
    sub get { $_[0]->{foo} }
    sub set { $_[0]->{foo} = $_[1] };
}
{
    my $o : Constant( Foo->new(foo=>1) );
    isa_ok $o, 'Foo';
    is $o->get, 1, '$o->get == 1';
    eval{ $o = Foo->new(foo=>2) };
    ok $@, $@;
    eval{ $o->set(2) };
    ok !$@, '$o->set(2)';
    is $o->get, 2, '$o->get == 2';
}
SKIP: {
    skip 'Perl 5.9.5 or better required', 5 unless $] >= 5.009005;
    my $o : Constant( 
		     Foo->new(foo=>1) 
		    );
    isa_ok $o, 'Foo';
    is $o->get, 1, '$o->get == 1';
    eval{ $o = Foo->new(foo=>2) };
    ok $@, $@;
    eval{ $o->set(2) };
    ok !$@, '$o->set(2)';
    is $o->get, 2, '$o->get == 2';
}

__END__
#SCALAR
ARRAY
HASH
#CODE
#REF
#GLOB
#LVALUE
#FORMAT
#IO
#VSTRING
#Regexp

