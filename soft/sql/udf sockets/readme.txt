requirements for Raspberry Pi:  

gcc build environment ; 
mysql 5.0 + client dev libs. installed by shell command: 

apt-get install libmysqlclient-dev


how to make it:

make


how to install it:

mysql -u root -p < ./lib_mysqludf_socket.sql


how to test it:

at the first window you have to start server:

perl socketserver.pl

at the second window start mysql shell and enter following command: 

select socketOpen("/tmp/ase-commands", "test\n");


