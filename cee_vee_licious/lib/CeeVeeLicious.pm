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


package CeeVeeLicious;
use Mojo::Base 'Mojolicious';

use CeeVeeLicious::Assets;

sub startup {
  my $self = shift;
  my $app = $self->app;
  $app->secrets(['No day like today!']);

  # Documentation browser under "/perldoc"
  $self->plugin('PODRenderer');
  $self->plugin('AssetPack');

  CeeVeeLicious::Assets->introduce($app);

  $self->_defineRoutes();
}

sub _defineRoutes {
  my ($self) = @_;
  my $r = $self->routes;

  # Normal route to controller
  $r->get('/')->to(controller => 'main', action => 'webapp');
  $r->get('/example')->to(controller => 'example', action => 'welcome');
}

1;
