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
