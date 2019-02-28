#!/bin/bash

scripts_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
base_dir="$(dirname "$scripts_dir")"
raw_data_dir="$base_dir/raw_data"

for classname in $raw_data_dir/*
do
	echo "$classname"
	if test -d $classname
	then
		for sub in $classname/*
		do
			if test -f $sub
			then
				images_dir="$raw_data_dir/$(basename $classname)/IMAGES"
				mkdir -p "$images_dir"
				urls_file="$raw_data_dir/$(basename $classname)/urls_$(basename $classname).txt"
				ls $urls_file
				echo "Class: $cname. Total # of urls: $(cat $urls_file | wc -l)"
				echo "Downloading images..."
				xargs -n 8 -P 8 wget -nc -q --timeout=5 --tries=2 -P "$images_dir" < "$urls_file"
			fi
			if test -d $sub
			then 
				images_dir="$raw_data_dir/$(basename $classname)/$(basename $sub)/IMAGES"
				mkdir -p "$images_dir"
				urls_file="$raw_data_dir/$(basename $classname)/$(basename $sub)/urls.txt"
				ls $urls_file
				xargs -n 8 -P 8 wget -nc -q --timeout=5 --tries=2 -P "$images_dir" < "$urls_file"
			fi
		done
	fi
done


