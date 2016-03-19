#!/usr/bin/env perl

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

use FindBin;
BEGIN { unshift @INC, "$FindBin::Bin/../lib" }

use CeeVeeLicious::Installer;
use Test::Mojo;

#Load the Mojolicious app, so we get config loaded
my $t = Test::Mojo->new('CeeVeeLicious');

CeeVeeLicious::Installer::install();