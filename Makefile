SRC := src/lua-getdate.c
BIN := getdate.so

all: $(BIN)

$(BIN): $(SRC)
	gcc -O2 -fPIC -shared -I/usr/include/lua5.1 -Isrc/ -o $@ $^

install: all
	install -m 755 $(BIN) $(DESTDIR)/usr/local/lib/lua/5.1/getdate.so

test: install
	lua test/date.lua

clean:
	rm src/lua-getdate.o $(BIN)

.PHONY: all install clean test
.SILENT:
