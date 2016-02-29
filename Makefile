CC=gcc
RM=rm -fr
MKDIR=mkdir -p
DIR_SRC=src
DIR_OBJ=obj
DIR_LIB=lib


.PHONY: all my mypre test run runpre


all: my mypre test clean


dir_lib:
	$(MKDIR) $(DIR_LIB)

dir_obj:
	$(MKDIR) $(DIR_OBJ)


my: libmy.so

libmy.so: my.o dir_lib
	$(CC) -shared -o $(DIR_LIB)/libmy.so $(DIR_OBJ)/my.o

my.o: dir_obj
	$(CC) -fPIC -c -Wall -I$(DIR_SRC) -o $(DIR_OBJ)/my.o $(DIR_SRC)/my.c



mypre: libmypre.so

libmypre.so: mypre.o dir_lib
	$(CC) -shared -o $(DIR_LIB)/libmypre.so $(DIR_OBJ)/mypre.o

mypre.o: dir_obj
	$(CC) -fPIC -c -Wall -I$(DIR_SRC) -o $(DIR_OBJ)/mypre.o $(DIR_SRC)/mypre.c


test:
	$(CC) -Wall -o test $(DIR_SRC)/test.c -lmy -L$(DIR_LIB) -I$(DIR_SRC)


run:
	LD_LIBRARY_PATH=$(DIR_LIB) ./test

runpre:
	LD_PRELOAD=$(DIR_LIB)/libmypre.so LD_LIBRARY_PATH=$(DIR_LIB) ./test


clean:
	$(RM) $(DIR_OBJ)

clear: clean
	$(RM) $(DIR_LIB) test
