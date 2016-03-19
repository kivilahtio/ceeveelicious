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

package CeeVeeLicious::Util::Swagger;
use Modern::Perl '2015';

=NAME

CeeVeeLicious::Util::Swagger

=DESCRIPTION

This class provides helper functions to deal with the Swagger2.0 spec

=cut

use File::Basename;

=head2 minifySwagger

    CeeVeeLicious::Util::Swagger->minifySwagger($swaggerMainFile);

B<@param1 String>, the full path to the swagger-file.

=cut

sub minifySwagger {
  my ($class, $swagger2SpecFilePath) = @_;
  my $dir = File::Basename::dirname($swagger2SpecFilePath);
  my $swaggerMinifiedFile = $dir.'/swagger.min.json';

  require Swagger2; #When you import the Swagger2-libraries, the environment variables are checked and cannot be altered anymore. So set verbosity first, then load libs.
  my $swagger = Swagger2->new($swagger2SpecFilePath);
  $swagger = $swagger->expand; #Fetch all JSON-Schema references

  my @errors = $swagger->validate;
  print join("\n", "Swagger2: Invalid spec:", @errors)."\n" if @errors;
  exit 1 if @errors;

  _removeNonSwagger2Values($swagger);

  open(SWOUT, ">:encoding(UTF-8)", $swaggerMinifiedFile) or die "$0: Couldn't open the minified Swagger2 output file '$swaggerMinifiedFile':\n  $!";
  print SWOUT $swagger->to_string();
  close(SWOUT);
}

sub _removeNonSwagger2Values {
  my ($swagger) = @_;

  my $data = $swagger->api_spec->data;
  delete($data->{id});
}

1;
