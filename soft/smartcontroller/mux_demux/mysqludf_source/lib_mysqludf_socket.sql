DROP FUNCTION IF EXISTS notifyMuxDemux;
DROP FUNCTION IF EXISTS closeClient;
DROP FUNCTION IF EXISTS initClient;
DROP FUNCTION IF EXISTS shutClient;

CREATE FUNCTION notifyMuxDemux RETURNS string SONAME 'mysqludf_source.so';
#CREATE FUNCTION closeClient RETURNS string SONAME 'mysqludf_source.so';
#CREATE FUNCTION initClient RETURNS string SONAME 'mysqludf_source.so';
#CREATE FUNCTION shutClient RETURNS string SONAME 'mysqludf_source.so';
