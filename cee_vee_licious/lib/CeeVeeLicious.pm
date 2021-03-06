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

package CeeVeeLicious;
use Mojo::Base 'Mojolicious';

use File::Basename;

use CeeVeeLicious::Assets;
use CeeVeeLicious::Stories;
use CeeVeeLicious::Config;
use CeeVeeLicious::Util::Swagger;

sub startup {
  my $self = shift;
  $self->app->secrets(['No day like today!']);

  $self->setPlugins();
  $self->defineRoutes();
}

sub setPlugins {
  my ($self) = @_;
  my $app = $self->app;
  my $swaggerMainFile = $app->home->rel_file("/public/swagger/swagger.json");

  CeeVeeLicious::Config->setConfig( $self->plugin('Config') );
  $self->plugin('PODRenderer');
  $self->plugin('AssetPack');
  $self->plugin(Swagger2 => {url => $swaggerMainFile});

  CeeVeeLicious::Util::Swagger->minifySwagger($swaggerMainFile);
  CeeVeeLicious::Assets->introduce($app);
}

sub defineRoutes {
  my ($self) = @_;
  my $r = $self->routes;

  # Normal route to controller
  $r->get('/')->to('main#webapp');
}

1;
