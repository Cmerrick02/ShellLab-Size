#!/bin/sh



bytes=$(wc -c * | awk '{total = $1} END {print total}')
kilo=$((bytes/1000))
echo "Total size of all files in this directory:" $bytes "bytes (~" $kilo "KB)."



read=0
write=0
execute=0
count=0

for file in *;
do
	if [[ -r "$file" && -w "$file" && -x "$file" ]]; then
	read=$((read+1))
	write=$((write+1))
	execute=$((execute+1))

	elif [[ -r "$file" && -w "$file" ]]; then
	read=$((read+1))
	write=$((write+1))


	elif [[ -r "$file" && -x "$file" ]]; then
	read=$((read+1))
	execute=$((execute+1))

	elif [[ -r "$file" ]]; then
	read=$((read+1))

	elif [[ -w "$file" ]]; then
	write=$((write+1))

	elif [[ -w "$file" && -x "$file" ]]; then
	write=$((write+1))
	execute=$((execute+1))

	else
	execute=$((execute+1))
	fi

done

count=$(head -10 * |  grep -l "#\!\/bin\/sh" * | wc -l)

echo $read "of the files have read permissions."
echo $write "of the files have write permissions."
echo $execute "of the files have execute permissions."
echo "Estimated number of shell script files in this directory: "
echo $count
 
