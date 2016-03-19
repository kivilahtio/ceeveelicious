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

package CeeVeeLicious::Installer;
use Modern::Perl '2015';

=NAME

Installer

=DESCRIPTION

Installs the default DB

=FILES

All default objects are stored to B</persistence/*.json>

=cut

use DBM::Deep;
use MooseX::Params::Validate;
use JSON;
use File::Slurp;

use CeeVeeLicious::Story;

sub install {
    installDefaultDB();
}

sub installDefaultDB {
    installStories();
}

sub installStories {
    my $conf = CeeVeeLicious::Config->getConfig();
    my $stories = File::Slurp::read_file(  $conf->{db}->{dbm_deep_dir}."stories.json", binmode => ':utf8'  );
    $stories = JSON::from_json($stories);
    while (my ($k, $story) = each(%$stories)) {
        $story = CeeVeeLicious::Story->new($story);
        $story->save();
    }
}

1;
