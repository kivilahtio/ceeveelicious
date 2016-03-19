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

package CeeVeeLicious::Config;
use Modern::Perl '2015';

=NAME

CeeVeeLicious::Config

=DESCRIPTION

This class provides access to the application config.

=FILES

Config file should be a plain perl hash in cee_vee_licious/cee_vee_licious.conf

=cut

my $conf; #Cache the config here

=head2 setConfig

    CeeVeeLicious::Config->setConfig($configHash);

B<@param1 HASHref>, the config file slurped as perl hash.

=ERRORS

Config file should be validated and objectized but
these are outside the scope of this simple cv.

=cut

sub setConfig {
    my ($class, $configHash) = @_;
    $conf = $configHash;
}

sub getConfig {
    return $conf;
}

1;
