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

package CeeVeeLicious::DB;
use Modern::Perl '2015';

=NAME

CeeVeeLicious::DB

=DESCRIPTION

This class defines the DB accessors-as-an-object.
Currently uses DBM::Deep as a backend for persistence.

=FILES

All objects are persisted to B</persistence/*.db>

=cut

use DBM::Deep;
use MooseX::Params::Validate;

use CeeVeeLicious::Config;

my %connections; #Cache connections here for reuse accross modules

=head2 connect

    my $stories = CeeVeeLicious::DB->connect('stories');

B<@param1 String>, the schema to use. Each object maps to a persistence schema.

=RETURNS

DBM::Deep matching the given schema.

=ERRORS

These exceptions could be thrown but that is outside the scope of this simple cv.

CeeVeeLicious::Exception::DB::MissingSchema

=cut

sub connect {
    my $class = shift;
    my ( $schemaName ) = validated_list( \@_,
        schema   => { isa => 'Str' },
    );

    return $connections{$schemaName} if ($connections{$schemaName});
    return $connections{$schemaName} = $class->_new($schemaName);
}

sub _new {
    my ($class, $schemaName) = @_;
    my $conf = CeeVeeLicious::Config->getConfig();
    #Access to configuration should be validated. Path parameters need to be untainted. This is outside the scope of this cv.
    return DBM::Deep->new({
        file => $conf->{db}->{dbm_deep_dir}."$schemaName.db",
        locking => 1,
        autoflush => 1,
        num_txns => $conf->{db}->{dbm_max_connections},
    });
}

1;
