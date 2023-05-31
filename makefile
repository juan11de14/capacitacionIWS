


BIN_LIB=CMPSYS
DESTINO=CMO2023178
ANO=2023
CMO=0000178
LIBLIST=FINTRAB FINPLTDAT FINCOODAT FINCLIDAT FINCOOOBJ EOCOBJETO
SHELL=/QOpenSys/usr/bin/qsh

all: ejemplo1.rpgle comodin.cmo

%.sql:
	system -s "CAll FINCOOOBJ/CREALIB PARM('$(DESTINO)')"
	system -s "CHGATR OBJ('./QDDSSRC/$*.sql') ATR(*CCSID) VALUE(1252)"
	liblist -a $(LIBLIST);\
	system "RUNSQLSTM SRCSTMF('./QDDSSRC/$*.sql') COMMIT(*NONE) DFTRDBCOL($(DESTINO))"
	system "CPYFRMIMPF FROMSTMF('./QDDSSRC/$*.sql') TOFILE($(DESTINO)/FINDDS $*) MBROPT(*REPLACE) TOCCSID(284) RCDDLM(*CRLF) STRDLM(*NONE) RMVBLANK(*NONE) FLDDLM('°')"
	system "CHGPFM FILE($(DESTINO)/FINDDS) MBR($*) SRCTYPE(PF)"

%.rpgle:
	system -s "CAll FINCOOOBJ/CREALIB PARM('$(DESTINO)')"
	system -s "CHGATR OBJ('./QRPGLESRC/$*.rpgle') ATR(*CCSID) VALUE(1252)"
	liblist -a $(LIBLIST);\
	system "CRTBNDRPG PGM($(DESTINO)/$*) SRCSTMF('./QRPGLESRC/$*.rpgle') OPTION(*EVENTF) DBGVIEW(*LIST) TGTRLS(*CURRENT)"
	system "CPYFRMIMPF FROMSTMF('./QRPGLESRC/$*.rpgle') TOFILE($(DESTINO)/FINRPG $*) MBROPT(*REPLACE) TOCCSID(284) RCDDLM(*CRLF) STRDLM(*NONE) RMVBLANK(*NONE) FLDDLM('°')"
	system "CHGPFM FILE($(DESTINO)/FINRPG) MBR($*) SRCTYPE(RPGLE)"
	
	
%.sqlrpgle:
	system -s "CAll FINCOOOBJ/CREALIB PARM('$(DESTINO)')"
	system -s "CHGATR OBJ('./QRPGLESRC/$*.sqlrpgle') ATR(*CCSID) VALUE(1252)"
	liblist -a $(LIBLIST);\
	system "CRTSQLRPGI OBJ($(DESTINO)/$*) SRCSTMF('./QRPGLESRC/$*.sqlrpgle') CLOSQLCSR(*ENDMOD) OPTION(*EVENTF) DBGVIEW(*LIST) TGTRLS(*CURRENT)"
	system "CPYFRMIMPF FROMSTMF('./QRPGLESRC/$*.rpgle') TOFILE($(DESTINO)/FINRPG $*) MBROPT(*REPLACE) TOCCSID(284) RCDDLM(*CRLF) STRDLM(*NONE) RMVBLANK(*NONE) FLDDLM('°')"

%.clle:
	system -s "CAll FINCOOOBJ/CREALIB PARM('$(DESTINO)')"
	system -s "CHGATR OBJ('./QCLLESRC/$*.clle') ATR(*CCSID) VALUE(1252)"
	liblist -a $(LIBLIST);\
	system "CRTBNDCL PGM($(DESTINO)/$*) SRCSTMF('./QCLLESRC/$*.clle') DBGVIEW(*LIST)"
	system "CPYFRMIMPF FROMSTMF('./QCLLESRC/$*.clle') TOFILE($(DESTINO)/FINCLP $*) MBROPT(*REPLACE) TOCCSID(284) RCDDLM(*CRLF) STRDLM(*NONE) RMVBLANK(*NONE) FLDDLM('°')"
	system "CHGPFM FILE($(DESTINO)/FINCLP) MBR($*) SRCTYPE(CLLE)"

%.cmo:
	liblist -a $(LIBLIST);\
	system -s "CALL PGM(EOCOBJETO/HAPPL101B) PARM('$(DESTINO)' ' ' 'FIN' '$(ANO)' '$(CMO)' '141845')"


