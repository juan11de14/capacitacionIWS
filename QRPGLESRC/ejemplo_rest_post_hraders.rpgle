**Free
  ctl-opt option(*srcstmt) dftactGrp(*no) bnddir('HTTPAPI');
  /copy httpapi_h

  dcl-s   HTTPCODE    char(100);
  dcl-s   url         varchar(2000);
  dcl-s   request     varchar(2000);
  dcl-s   response    varchar(19);
  dcl-s   httpstatus  int(10);

  dcl-ds reqds qualified;
      dcl-ds authentication;
          login               varchar(10);
          password            varchar(10);
      end-ds;
      dcl-ds subsidiary;
          code                zoned(1:0);
      end-ds;
      dcl-ds branch;
          code                zoned(1:0);
      end-ds;
      dcl-ds role;
          code                zoned(1:0);
      end-ds;
  end-ds;

  dcl-ds tk_dtaara dtaara('COBTRAB/TK_DTAARA');
    tk_inicio          TimeStamp;
    Authorization      Char(1974);
  end-ds;
  in *lock tk_dtaara;
  
  
  If tk_Inicio  + %Hours(1) < %TimeStamp();
    http_xproc( HTTP_POINT_ADDL_HEADER: %paddr(add_accept_header));
    reqds.authentication.login      = 'xxxxxxxxx';
    reqds.authentication.password   = 'yyyyyyyyy';
    reqds.subsidiary.code           = 1;
    reqds.branch.code               = 1;
    reqds.role.code                 = 1;
    data-gen reqds %data(request) %gen('YAJLDTAGEN');
    http_debug(*on: '/tmp/COBAuthen-log.txt');
    url = 'https://authenticationxxxxxxxxxxancoomeva.com.co' +
          '/applications/v1/syxxxxh/authentication-role/';
    monitor;
        http_xproc( HTTP_POINT_ADDL_HEADER: %paddr(add_accept_header));
        response = http_string('POST': url: request: 'application/json');
        Authorization = http_header('x-login');
        tk_Inicio = %TimesTamp();
        Out tk_dtaara;
        on-error;
        httpcode = http_error();
    endmon;
  Endif;
  *InLr = *On;
  dcl-proc add_accept_header;
     dcl-pi *n;
         extraHeader varchar(1024);
     end-pi;
     dcl-c CRLF x'0d25';
     extraHeader += 'x-api-key: LrnxMVUqpxxxxxxxxxQtup46BaB7CO0yQxF'+ CRLF;
        //    Es fija dentro de cada ambiente
        //    si es fija es la misma de producción, no bederia ser.


     extraHeader += 'x-financial-id: bancoomeva' + CRLF;
        //      Es fija para todos los ambiente y api's

     extraHeader += 'x-end-user-terminal: desarrol_as400' + CRLF;
        //      Es fija para todos los ambiente y api's

     extraHeader += 'x-request-id: 40a3cbfc-81f3-421a-8962-cee9fc70e51c' + CRLF;
        //  Calcular un HASH  timestamp' + job 

     extraHeader += 'x-end-user-login: jcnl7207' + CRLF;
        // buscar usuario de la sds

     extraHeader += 'x-end-user-request-date-time: 2022-10-02T23:00:20Z' + CRLF;
         // TimeStamp formateado
     
     extraHeader += 'x-channel: 1' + CRLF;
        // Se debe buscar que canal puede ser y ponerlo en dtaara

     extraHeader += 'Content-Type: application/json' + CRLF;
     extraHeader += 'Accept: application/json' + CRLF;
     extraHeader += 'Keep-Alive: timeout=5, max=10' + CRLF;
  end-proc;
**end-free