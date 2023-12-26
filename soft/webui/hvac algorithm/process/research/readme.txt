notes about simulation
----------------------

main display outdoor temperature used only when no HVAC outdoor sensor configured
possible to run in web and console mode. examples of running from console: 
perl engine.pl action=resetsim zoneid=4
perl engine.pl action=sim zoneid=4
perl engine.pl action=dbinit


notes about process
-------------------

virtual zone (profile target temperature is zero) are not processed for comfort targets
processing should be running from command console: 
perl process.pl
