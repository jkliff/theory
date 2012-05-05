#!/bin/sh
SELF=$(cd $(dirname $0); pwd -P)/
CWD=$(pwd)

cd $SELF

start() {
	if [ ! -e "$SELF/env/bin/paster" ]
	then
		echo "please install the prerequisites by using the included install.sh script"
		exit
	fi
	echo "starting theory"
	"$SELF/env/bin/paster" serve --daemon --log-file "$SELF/theory.log" "$SELF/server.ini" && echo "theory started, http://localhost:9099/ if you're using the default port"
}

restart() {
	if [ ! -e "$SELF/env/bin/paster" ]
	then
		echo "please install the prerequisites by using the included install.sh script"
		exit
	fi
	echo "restarting theory"
	"$SELF/env/bin/paster" serve --reload --log-file "$SELF/theory.log" "$SELF/server.ini" && echo "theory started, http://localhost:9099/ if you're using the default port"
}


stop() {
	echo "stopping theory"
	"$SELF/env/bin/paster" serve "$SELF/server.ini" stop
}

case $1 in
'start')
	start;
	;;
'stop')
	stop;
	;;
'reload')
    reload;
    ;;
*)
	echo "usage: run-theory (start|stop|reload)"
	;;
esac

cd $CWD
