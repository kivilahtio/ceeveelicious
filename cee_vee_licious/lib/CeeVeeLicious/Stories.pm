# Copyright (C) 2016  Olli-Antti Kivilahti
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

package CeeVeeLicious::Stories;
use Modern::Perl '2015';

=NAME

CeeVeeLicious::Stories

=DESCRIPTION

This is a static manager class for Story-objects

=cut

use MooseX::Params::Validate;

use CeeVeeLicious::DB;
use CeeVeeLicious::Story;

sub get {
    my $class = shift;
    my ( $storycode ) = validated_list( \@_,
        storycode   => { isa => 'Str' },
    );

    my $stories = CeeVeeLicious::DB->connect(schema => 'stories');
    return CeeVeeLicious::Story->unpack( $stories->{ $storycode } );
}

sub list {
    my $class = shift;

    my $stories = CeeVeeLicious::DB->connect(schema => 'stories');
    my @stories;
    while (my ($k,$s) = each(%$stories)) {
        push(@stories, CeeVeeLicious::Story->unpack($s) );
    }

    return \@stories;
}

1;
