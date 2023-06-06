# capacitacionIWS

# Building a REST service with integrated web services server for IBM i

1. Learn the basics

 https://developer.ibm.com/tutorials/i-rest-web-services-server1

2. Deploy a simple RESTful application

https://developer.ibm.com/tutorials/i-rest-web-services-server2/

3. Deploy a RESTful application using multiple HTTP methods

https://developer.ibm.com/tutorials/i-rest-web-services-server3/

4. Create REST APIs based on SQL statements

Learn how to enable IBM Db2 to act as a RESTful service provider

https://developer.ibm.com/tutorials/creating-rest-apis-based-on-sql-statements/

Directorio Base

/QIBM/ProdData/OS/WebServices/bin.

1. el directorio /www se debe poner en replica.

/QIBM/ProdData/OS/WebServices/bin/saveWebServices.sh
 -server server-name -saveFile save-file
 [ -serviceList *ALL|service-list ]
 [ -targetRelease *CURRENT|*PREVIOUS ]
 [ -printErrorDetails ] [ -help ]

/QIBM/ProdData/OS/WebServices/bin/saveWebServices.sh
server capacita -saveFile /qsys.lib/qgpl.lib/jcnl7207.file
  -serviceList pruebaConsumo01:ConvertTemp  -printErrorDetails

restoreWebServices.sh
 -server server-name -saveFile save-file
 -fromServerDirectory server-directory
 [ -serviceList *ALL|service-list ]
 [ -migrationOptions 'option-list' ]
 [ -printErrorDetails ] [ -help ]

/QIBM/ProdData/OS/WebServices/bin/restoreWebServices.sh

-server juann -saveFile /qsys.lib/qgpl.lib/jcnl7207.file
 -fromServerDirectory /www/capacita -serviceList pruebaConsumo01
    -printErrorDetails

/QIBM/ProdData/OS/WebServices/bin/stopWebServicesServer.sh
    -server juann  -printErrorDetails

/QIBM/ProdData/OS/WebServices/bin/deleteWebServicesServer.sh
    -server juann  -printErrorDetails

---

/QIBM/ProdData/OS/WebServices/bin/listWebServices.sh
    -server capacita  -printErrorDetails     > /tmp/salida.txt

- 
- Recuperar la variable de ambiente - :

  dcl-s QUERY_STRING     char(1024);

  dcl-pr getenv pointer extproc('getenv');
  *n pointer value options(*string:*trim)  ;
  end-pr;
- QUERY_STRING   = %str(getenv('QUERY_STRING'));
- contador del arreglo. - considerar variable ortncount int(10:0)
- 


Ejemplo de consumo de REST desde DB" - 400

previamente en linea de comando  "CHGJOB CCSID(284)"

SELECT * FROM
JSON_TABLE(SYSTOOLS.HTTPGETCLOB('https://api.weather.gov/gridpoints/
ARX/03,76/forecast',''),
'lax $.properties.periods[*]' COLUMNS(name VARCHAR(20) PATH 'lax
    $.name',
  temperature INT PATH 'lax $.temperature',
  temperatureUnit char(1) PATH 'lax $.temperatureUnit',
  Viento        varchar(25) PATH 'lax $.windSpeed',
  Direcc        varchar(2) PATH 'lax $.windDirection',
  Humedad       varchar(2) PATH 'lax $.relativeHumidity.value'

))
