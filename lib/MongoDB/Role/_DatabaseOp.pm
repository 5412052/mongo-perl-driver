#
#  Copyright 2014 MongoDB, Inc.
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#  http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
#

use strict;
use warnings;
package MongoDB::Role::_DatabaseOp;

# MongoDB role for operations within a database, that need a database name
# and a BSON codec.  This is likely a "base role" for all operations.

use version;
our $VERSION = 'v1.999.0';

use Moo::Role;

use MongoDB::_Types qw(
    BSONCodec
    ClientSession
);
use Types::Standard qw(
    CodeRef
    Str
    Maybe
);

use namespace::clean;

has bson_codec => (
    is       => 'ro',
    required => 1,
    isa      => BSONCodec,
);

has db_name => (
    is       => 'ro',
    required => 1,
    isa      => Str,
);

# required, but allowed to be undef so we're sure this gets wired up
# correctly through all database ops.
has monitoring_callback => (
    is       => 'ro',
    required => 1,
    isa      => Maybe[CodeRef],
);

has session => (
    is => 'ro',
    required => 0,
    isa => Maybe[ClientSession],
);

1;
