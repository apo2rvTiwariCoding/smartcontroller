DROP FUNCTION IF EXISTS socketOpen;
CREATE FUNCTION socketOpen RETURNS string SONAME 'lib_mysqludf_socket.so';
