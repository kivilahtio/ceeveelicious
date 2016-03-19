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

package CeeVeeLicious::Story;
use Modern::Perl '2015';
use Moose;
use MooseX::Params::Validate;
use MooseX::Storage;

use CeeVeeLicious::DB;

=NAME

CeeVeeLicious::Story

=DESCRIPTION

This is a story object, telling a story about me.

=cut

with Storage();
has 'storycode' => (
    is  => 'ro',
    isa => 'Str',
);
has 'author' => (
    is  => 'rw',
    isa => 'Str',
);
has 'title' => (
    is  => 'rw',
    isa => 'Str',
);
has 'text' => (
    is  => 'rw',
    isa => 'Str',
);

sub save {
    my $self = shift;
    my $db = CeeVeeLicious::DB->connect(schema => 'stories');
    $db->{ $self->storycode } = $self->pack;
}

1;
