CC=gcc
FLG_W=-Wall -Wextra -Wpedantic -Wstrict-overflow

all: clean variant_a.so variant_b.so
	$(CC) -g $(FLG_W) -c main.c -o main.o
	$(CC) main.o -Wl,'-rpath' -Wl,'$$ORIGIN' -L. -l:variant_a.so -l:variant_b.so $(FLG_W) -o main

variant_a.so:
	$(CC) -g $(FLG_W) -D "MAGIC=5" -fvisibility=hidden -c shared.c -o shared.o
	$(CC) -g $(FLG_W) -c -fPIC variant_a.c -o variant_a.o
	$(CC) shared.o variant_a.o -shared -o variant_a.so

variant_b.so:
	$(CC) -g $(FLG_W) -D "MAGIC=9" -fvisibility=hidden -c shared.c -o shared.o
	$(CC) -g $(FLG_W) -c -fPIC variant_b.c -o variant_b.o
	$(CC) shared.o variant_b.o -shared -o variant_b.so

clean: ## Clean compilation artifacts
	@echo 'Cleaning up...'
	rm -f *.o
	rm -f *.s
	rm -f *.so
	rm -f main
