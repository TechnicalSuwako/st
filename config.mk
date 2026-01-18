# st version
VERSION = 0.9.2

# Customize below to fit your system

# paths
PREFIX = /usr/local
MANPREFIX = $(PREFIX)/share/man

# OS
UNAME != uname -s

.if "$(UNAME)" == "OpenBSD"
X11INC = /usr/X11R6/include
X11LIB = /usr/X11R6/lib
FREETYPE = $(X11INC)/freetype2
.elif "$(UNAME)" == "FreeBSD"
X11INC = /usr/local/include
X11LIB = /usr/local/lib
.endif

PKG_CONFIG = pkg-config

# includes and libs
.if "$(UNAME)" == "OpenBSD"
INCS = -I$(X11INC) -I$(FREETYPE) \
				-I/usr/include/freetype2 \
				-L/usr/local/include \
       `$(PKG_CONFIG) --cflags fontconfig` \
       `$(PKG_CONFIG) --cflags freetype2`
CPPFLAGS = -DVERSION=\"$(VERSION)\" -D_XOPEN_SOURCE=600 -D_BSD_SOURCE
LIBS = -L$(X11LIB) -L/usr/local/lib -static -lm -lX11 -lutil -lXft \
			 -lfontconfig -lfreetype -lc -lxcb -lpthread -lpng16 -lz -lexpat \
			 -lXrender -lXau -lXdmcp
MANPREFIX = ${PREFIX}/man
.elif "$(UNAME)" == "FreeBSD"
INCS = -I$(X11INC) \
				-I/usr/include/freetype2 \
       `$(PKG_CONFIG) --cflags fontconfig` \
       `$(PKG_CONFIG) --cflags freetype2`
LIBS = -L$(X11LIB) -static -lm -lrt -lX11 -lutil -lXft \
       -lfontconfig -lfreetype \
       -lc -lxcb -lthr -lXrender -lexpat -lintl -lbz2 \
       -lpng16 -lbrotlidec -lz -lsys -lXau -lXdmcp -lbrotlicommon
       # `$(PKG_CONFIG) --libs fontconfig` \
       # `$(PKG_CONFIG) --libs freetype2` 
.endif

# flags
STCPPFLAGS = -DVERSION=\"$(VERSION)\" -D_XOPEN_SOURCE=600
STCFLAGS = $(INCS) $(STCPPFLAGS) $(CPPFLAGS) $(CFLAGS)
STLDFLAGS = $(LIBS) $(LDFLAGS)

# compiler and linker
# CC = c99
