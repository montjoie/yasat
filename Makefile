DESTDIR=
PREFIX=/usr/local/
SYSCONFDIR=${PREFIX}/etc
DATADIR=${PREFIX}/share
MANDIR=${PREFIX}/share/man/man8/
#http://www.freebsd.org/doc/en/books/porters-handbook/porting-prefix.html

nothing:
	@exit

test: test_todo test_display_without_advice real_test
	exit

test_todo:
	@echo "Number of TODO `grep -ri TODO * | grep -v '.svn' | wc -l`"

test_display_without_advice:
	@echo "Number of error display without advice `grep -r Display * | grep RED |grep -v advice |grep -v .svn | wc -l`"
	@echo "Number of warning display without advice `grep -r Display * | grep ORANGE |grep -v advice | grep -v .svn |wc -l`"

#dont work :'(
#test_space_end:
#	 @echo  "`grep -nri \"[[:space:]][[:space:]]*$\" .`"

real_test:
	chmod +x ./tests/test.test
	./tests/test.test

#test will check
#
# display without advice
# check functions
# plugins without advice files
# check lines more 80(120) characters
# numbers of todo
# that PLUGINS_REP must be within {}
# -e -d etc have "" after


install:
	chmod +x ./tests/*.test
	chmod +x ./plugins/*.test
	chmod +x ./yasat
	mkdir -p ${DESTDIR}/${PREFIX}/bin
	cp yasat ${DESTDIR}/${PREFIX}/bin/yasat
	mkdir -p ${DESTDIR}/${DATADIR}/yasat/
	cp -R plugins ${DESTDIR}/${DATADIR}/yasat/
	cp yasat.css ${DESTDIR}/${DATADIR}/yasat/
	cp common ${DESTDIR}/${DATADIR}/yasat/
	cp osdetection ${DESTDIR}/${DATADIR}/yasat/
	mkdir -p ${DESTDIR}/${SYSCONFDIR}/yasat/
	echo "YASAT_ROOT=/${DATADIR}/yasat/" > ${DESTDIR}/${SYSCONFDIR}/yasat/yasat.conf
	echo "PLUGINS_REP=/${DATADIR}/yasat/plugins/" >> ${DESTDIR}/${SYSCONFDIR}/yasat/yasat.conf

installman:
	mkdir -p ${DESTDIR}/${MANDIR}/
	cp man/yasat.8 ${DESTDIR}/${MANDIR}/
	bzip2 -f -9 ${DESTDIR}/${MANDIR}/yasat.8

deinstall:
	rm ${DESTDIR}/${PREFIX}/bin/yasat
	rm -rf ${DESTDIR}/${DATADIR}/yasat
	rm -rf ${DESTDIR}/${SYSCONFDIR}/etc/yasat

