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

package CeeVeeLicious::Assets;

use Modern::Perl;

=head1 SYNOPSIS

In this file all the assets that the app needs are introduced

=cut

sub introduce {
    my ($class, $app) = @_;
    $ENV{MOJO_ASSETPACK_NO_CACHE} = 1 unless ($ENV{MOJO_MODE} && $ENV{MOJO_MODE} eq 'production'); #Pack all assets on each request? Only for development.

    $app->asset("webapp.js" => (
        "http://code.jquery.com/jquery-2.2.1.min.js",
        "/js/webapp.js",
    ));
    $app->asset("webapp.css" => (
        "/css/base_theme_dark.less",
    ));

    # Add custom response headers for assets
    $app->asset->headers({"Cache-Control" => "max-age=31536000"});

    # Remove old assets
    $app->asset->purge;
}

1;
