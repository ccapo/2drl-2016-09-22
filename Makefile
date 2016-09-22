SRCDIR = src
INCDIR = include
LIBDIR = lib
CPP = g++

#CFLAGS = -O2 -s -w -std=c++11 -I$(INCDIR)/2drl -I$(INCDIR)/tcod
CFLAGS = -O0 -g -Wall -std=c++11 -I$(INCDIR)/2drl -I$(INCDIR)/tcod

# Determine if operating system is 32-bit or 64-bit
ifeq ($(shell uname -m),x86_64)

	# These are the definitions specific to 64-bit systems
	LFLAGS = -L$(LIBDIR)/x86_64 -ltcod -ltcodxx -lm -Wl,-rpath=$(LIBDIR)/x86_64
	ARCHIVE = 2drl-linux-x86_64.tar.gz

else

	# These are the definitions specific to 32-bit systems
	LFLAGS = -L$(LIBDIR)/i386 -ltcod -ltcodxx -lm -Wl,-rpath=$(LIBDIR)/i386
	ARCHIVE = 2drl-linux-i386.tar.gz

endif

.SUFFIXES: .o .hpp .cpp

$(SRCDIR)/%.o: $(SRCDIR)/%.cpp
	@$(CPP) $(CFLAGS) -c $< -o $@

SOURCES = $(wildcard $(SRCDIR)/*.cpp)

HEADERS = $(wildcard $(INCDIR)/2drl/*.hpp)

OBJECTS = $(SOURCES:.cpp=.o)

all: clean 2drl bundle

2drl: $(HEADERS) $(OBJECTS)
	@$(CPP) $(CFLAGS) $(OBJECTS) -o $@ $(LFLAGS)
	@rm -f $(OBJECTS)

clean:
	@rm -f $(OBJECTS)
	@rm -f 2drl

bundle:
	@tar -zcf $(ARCHIVE) data lib 2drl HOWTO.md
