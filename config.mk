# st version
VERSION = 0.9.2

# Customize below to fit your system

# paths
PREFIX = /usr/local
MANPREFIX = $(PREFIX)/share/man

# OS
UNAME != uname -s

X11INC = /usr/local/include
X11LIB = /usr/local/lib

PKG_CONFIG = pkg-config

# includes and libs
INCS = -I$(X11INC) \
				-I/usr/include/freetype2 \
       `$(PKG_CONFIG) --cflags fontconfig` \
       `$(PKG_CONFIG) --cflags freetype2`
LIBS = -L$(X11LIB) -static -lm -lrt -lX11 -lutil -lXft \
       -lfontconfig -lfreetype \
       -lc -lxcb -lthr -lXrender -lexpat -lintl -lbz2 \
       -lpng16 -lbrotlidec -lz -lsys -lXau -lXdmcp -lbrotlicommon
       # `$(PKG_CONFIG) --libs fontconfig` \
       # `$(PKG_CONFIG) --libs freetype2` \

# flags
STCPPFLAGS = -DVERSION=\"$(VERSION)\" -D_XOPEN_SOURCE=600
STCFLAGS = $(INCS) $(STCPPFLAGS) $(CPPFLAGS) $(CFLAGS)
STLDFLAGS = $(LIBS) $(LDFLAGS)

# OpenBSD:
.if "${UNAME}" == "OpenBSD"
CPPFLAGS = -DVERSION=\"$(VERSION)\" -D_XOPEN_SOURCE=600 -D_BSD_SOURCE
LIBS = -L$(X11LIB) -lm -lX11 -lutil -lXft \
       `$(PKG_CONFIG) --libs fontconfig` \
       `$(PKG_CONFIG) --libs freetype2`
MANPREFIX = ${PREFIX}/man
.endif

# compiler and linker
# CC = c99
