LIBDIR=/usr/lib

install:
	gcc -Wall -I/usr/include/mysql -I. -shared lib_mysqludf_socket.c -o $(LIBDIR)/mysql/plugin/lib_mysqludf_socket.so
