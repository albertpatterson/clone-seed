#!/usr/bin/env bash

seed=$1

proceed=true
first_arg=true
for i in "$@"; do
	
	case $i in
		-w=*|--write=*)
			write="${i#*=}"
		;;		
		-o=*|--origin=*)
			origin="${i#*=}"
		;;	
		*)
			if [ "$first_arg" != true ]; then
				echo unknown option for \""$i"\"
				proceed=false
			else
				first_arg=false
			fi
		;;
	esac
done	

case $seed in
	java)
		remote=https://github.com/albertpatterson/seed-java.git
	;;
	node*)
		remote=https://github.com/albertpatterson/seed-nodejs.git
	;;
	python2)
		remote=https://github.com/albertpatterson/seed-python2.git
	;;
	python3)
		remote=https://github.com/albertpatterson/seed-python3.git
	;;
	scala)
		remote=https://github.com/albertpatterson/seed-scala.git
	;;
	*)
		echo unmatched seed for \""$seed"\". Options are:
		echo java
		echo nodejs
		echo python2
		echo python3
		echo scala
		proceed=false
	;;
esac

if $proceed; then
	
	if [ -z "$write" ]; then
		write=$(pwd)
	fi

	git clone "$remote" "$write"
	cd "$write"
	git remote rm origin

	if [ ! -z "$origin" ]; then
		echo set origin $origin
		git remote add origin "$origin"
	fi
fi

