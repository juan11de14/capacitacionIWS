**Free
    ctl-opt option(*srcstmt) dftactGrp(*no) bnddir('HTTPAPI');
    /copy httpapi_h
    dcl-s   HTTPCODE    char(100);
    dcl-s   pos         int(5);
    dcl-s   url         varchar(2000);
    dcl-s   request     varchar(2000);
    dcl-s   response    varchar(15000);
    dcl-s   responsew   varchar(15000);
    dcl-s   httpstatus  int(10);
    dcl-s   AccessToken varchar(256);
    dcl-s   Error       Ind;

    dcl-pr Autenticarse extpgm('COBAUTHEN');
    end-pr;

    dcl-ds result qualified;
        dcl-ds  catalogs    dim(50);
            code            char(1);
            value           varchar(100);
        end-ds;
        totalResult         int(10);
        dcl-ds links;
            self             varchar(256);
            dcl-ds navs dim(1);
                href         varchar(256);
                dcl-subf rel varchar(20);
                type         varchar(10);
            end-ds;
        end-ds;
    end-ds;
    
    dcl-ds tk_dtaara dtaara('COBTRAB/TK_DTAARA');
        tk_inicio          TimeStamp;
        Authorization      Char(1974);
    end-ds;
    Autenticarse();
    in *lock tk_dtaara;
    http_xproc( HTTP_POINT_ADDL_HEADER: %paddr(add_accept_header));
    http_debug(*on: '/tmp/PRTAPIGET-log.txt');
    url =   'https://admxxxxxxxxxxva.com.co/generic/v1' +
            '/admin/catalogs?name=cl_oficina';
    monitor;
        response = http_string('GET': url);
        on-error;
            Error = *On;
            httpcode = http_error();
    endmon;
    iF Not Error;
        pos = %Scan(x'25':response);
        responsew = %SubSt(response:1:pos-1);
        DATA-INTO result
        %DATA(responsew: 'case=any allowmissing=yes countprefix=totalR')
                          %PARSER('YAJLINTO');

    Endif;
    *InLr = *On;
dcl-proc add_accept_header;
    dcl-pi *n;
        extraHeader varchar(10000);
    end-pi;
    dcl-c CRLF x'0d25';
    extraHeader += 'x-request-id: b6feb603-40e2-402a-9fa4-55e9d3aaa686'
                 + CRLF;
    extraHeader += 'x-end-user-login: aplcmvstg' + CRLF;
    extraHeader += 'x-end-user-terminal: consumer' + CRLF;
    extraHeader += 'x-end-user-last-logged-date-time: 2022-10-02T23:00:20Z'
     + CRLF;
    extraHeader += 'content-type: application/json' + CRLF;
    extraHeader += 'x-end-user-request-date-time: 2022-10-02T23:00:20Z' + CRLF;
    extraHeader += 'x-reverse: false' + CRLF;
    extraHeader += 'x-financial-id: 1'  + CRLF;
    extraHeader += 'Accept-Language: ES-EC'  + CRLF;
    extraHeader += 'Authorization: ' + %Trim(Authorization) + CRLF;
end-proc;
**end-free