#!/usr/bin/env perl -w
# Apache mod_perl additional configuration file
#
#	If configured manually, it could be worth to use relative
#	file paths so that this file is location independent.
#	Relative file paths are here relative to LXR root directory.

@INC=	( @INC
		, "/usr/local/share/lxr/lxr-2.3.5"		# <- LXR root directory
		, "/usr/local/share/lxr/lxr-2.3.5/lib"	# <- LXR library directory
		);

1;
