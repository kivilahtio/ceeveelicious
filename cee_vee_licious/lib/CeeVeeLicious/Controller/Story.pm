# Copyright (C) 2016  Olli-Antti Kivilahti
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

package CeeVeeLicious::Controller::Story;
use Mojo::Base 'Mojolicious::Controller';

use Modern::Perl;
use Try::Tiny;
use Scalar::Util qw(blessed);

my $storiesHash = {
    main => {
        storycode => 'main',
        author => 'Olli-Antti Kivilahti',
        title => 'The dreadful lamentation',
        text => 'Woe to the wary.',
    },
    cv => {
        storycode => 'cv',
        author => 'Olli-Antti Kivilahti',
        title => 'What can I do?',
        text => "Koha\nLiferay\nGuard\nCook's aide\nConstruction worker\nCarpenter's aide",
    },
    skills => {
        storycode => 'story',
        author => 'Olli-Antti Kivilahti',
        title => 'What can I do?',
        text => 'Perl\nSwagger\nMojolicious\nMooselike\nDBIx',
    },
    bio => {
        storycode => 'bio',
        author => 'Olli-Antti Kivilahti',
        title => 'Another dark tale',
        text => 'I was born. Like most of us.',
    },
    tools => {
        storycode => 'tools',
        author => 'Olli-Antti Kivilahti',
        title => 'Another dark tale',
        text => 'I was born. Like most of us.',
    },
};

sub list {
  my ($c, $args, $cb) = @_;

  my @stories = map {$storiesHash->{$_}} sort keys %$storiesHash;
  if (@stories) {
    return $c->$cb(\@stories, 200);
  }
  return $c->$cb({error => "No stories available"}, 404);
}

sub get {
  my ($c, $args, $cb) = @_;

  my $storycode = $args->{storycode};
  if ($storiesHash->{$storycode}) {
    return $c->$cb($storiesHash->{$storycode}, 200);
  }
  return $c->$cb({error => "No story found with storycode '$storycode'"}, 404);
}

1;
