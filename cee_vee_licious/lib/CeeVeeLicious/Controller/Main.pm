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

package CeeVeeLicious::Controller::Main;
use Mojo::Base 'Mojolicious::Controller';

=head1 webapp

This action renders the complete SPA-webapp, which consumes the Swagger2-api.

=cut

sub webapp {
  my $self = shift;

  # Render template "main/webapp.html.ep"
  $self->render();
}

1;
