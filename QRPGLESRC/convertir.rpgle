**Free
    Ctl-Opt nomain PGMINFO(*PCML:*MODULE);
    Dcl-PR ConvertTemp;
      tempIn         char(10)  const;
      tempOut        Char(10);
     End-PR;
    Dcl-Proc ConvertTemp export;
        Dcl-PI ConvertTemp;
            tempIn         char(10)  const;
            tempOut        Char(10); 
        End-PI;
        Dcl-S tempI        packed(8:2);
        Dcl-S tempO        packed(8:2);
        Dcl-S value        char(50);
        value = %STR(%ADDR(tempIn));
        tempI=%DEC(value:7:2);
        tempO = (5/9)*(tempI - 32);
        value = %CHAR(tempO);
        tempOut = value;
        %STR(%ADDR(tempOut):10)=tempOut;
    end-proc;
**end-free