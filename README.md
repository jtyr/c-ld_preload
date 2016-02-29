LD_PRELOAD example
==================

This repo contains an example of how to use `LD_PRELOAD`.


Usage
-----

```
$ make
mkdir -p obj
gcc -fPIC -c -Wall -Isrc -o obj/my.o src/my.c
mkdir -p lib
gcc -shared -o lib/libmy.so obj/my.o
gcc -fPIC -c -Wall -Isrc -o obj/mypre.o src/mypre.c
gcc -shared -o lib/libmypre.so obj/mypre.o
gcc -Wall -o test src/test.c -lmy -Llib -Isrc
rm -fr obj

$ make run
LD_LIBRARY_PATH=lib ./test
Hello World!

$ make runpre
LD_PRELOAD=lib/libmypre.so LD_LIBRARY_PATH=lib ./test
Hello PRELOAD World!
```


License
-------

MIT


Author
------

Jiri Tyr
