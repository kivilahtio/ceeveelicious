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
use Modern::Perl '2015';

use CeeVeeLicious::Stories;

sub list {
  my ($c, $args, $cb) = @_;

  my $stories = CeeVeeLicious::Stories->list();
  my @stories = map {$_->pack} @$stories;
  if (@stories) {
    return $c->$cb(\@stories, 200);
  }
  return $c->$cb({error => "No stories available"}, 404);
}

sub get {
  my ($c, $args, $cb) = @_;

  my $storycode = $args->{storycode};
  my $story = CeeVeeLicious::Stories->get(storycode => $storycode);
  if ($story) {
    return $c->$cb($story->pack, 200);
  }
  return $c->$cb({error => "No story found with storycode '$storycode'"}, 404);
}

1;
