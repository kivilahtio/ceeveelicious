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

use Mojo::Base -strict;
use Test::More;
use Test::Mojo;

use CeeVeeLicious::DB;
use CeeVeeLicious::Story;
use CeeVeeLicious::Stories;


#Load the Mojolicious app, so we get config loaded
my $t = Test::Mojo->new('CeeVeeLicious');

subtest "GET Story", \&GETStory;
sub GETStory {
  my ($story, $persistedStory, $stories, $persistedStories);

  ##################
  ####  create  ####
  $story = CeeVeeLicious::Story->new(storycode => 'test-story', author => 'OAK', title => 'A test story', text => 'Lorem ipsum testing test');
  is($story->storycode,
    "test-story",
    "Story created");
  $story->save();

  ################
  ####  GET  ####
  $t->get_ok('/api/v1/story/'.$story->storycode)
    ->status_is(200)->json_is('/text', 'Lorem ipsum testing test')->json_is('/storycode', 'test-story');

  $t->get_ok('/api/v1/story')
    ->status_is(200)->json_is('/0/text', 'Lorem ipsum testing test')->json_is('/0/storycode', 'test-story');
}


done_testing();