# Plugin for Foswiki - The Free and Open Source Wiki, http://foswiki.org/
#
# Copyright (C) 2006-2009 Michael Daum http://michaeldaumconsulting.com
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version. For
# more details read LICENSE in the root of this distribution.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#

package Foswiki::Plugins::SetVariablePlugin;

use strict;
use vars qw( 
  $VERSION $RELEASE $SHORTDESCRIPTION 
  $NO_PREFS_IN_TOPIC
  $core
);

$VERSION = '$Rev$';
$RELEASE = '1.00';

$SHORTDESCRIPTION = 'Flexible handling of topic variables';
$NO_PREFS_IN_TOPIC = 1;


###############################################################################
sub initPlugin {
  my( $topic, $web, $user, $installWeb ) = @_;

  # check for Plugins.pm versions
  if( $Foswiki::Plugins::VERSION < 1.026 ) {
    Foswiki::Func::writeWarning( "Version mismatch between SetVariablePlugin and Plugins.pm" );
    return 0;
  }

  Foswiki::Func::registerTagHandler('SETVAR', \&handleSetVar);
  Foswiki::Func::registerTagHandler('GETVAR', \&handleGetVar);
  Foswiki::Func::registerTagHandler('DELVAR', \&handleUnsetVar);
  Foswiki::Func::registerTagHandler('UNSETVAR', \&handleUnsetVar);
  Foswiki::Func::registerTagHandler('DEBUGRULES', \&handleDebugRules);

  return 1;
}

###############################################################################
sub getCore {
  return $core if $core;

  require Foswiki::Plugins::SetVariablePlugin::Core;
  $core = new Foswiki::Plugins::SetVariablePlugin::Core;

  return $core;
}

###############################################################################
sub handleSetVar { getCore()->handleSetVar(@_); }
sub handleGetVar { getCore()->handleGetVar(@_); }
sub handleUnsetVar { getCore()->handleUnsetVar(@_); }
sub handleDebugRules { getCore()->handleDebugRules(@_); }
sub beforeSaveHandler { getCore()->handleBeforeSave(@_); }

###############################################################################

1;
