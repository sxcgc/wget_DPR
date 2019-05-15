#!/bin/bash
outputPath="/mnt/i/MODIS13"

user=cgc@mail.ustc.edu.cn
pass=Cgc108199

for gpmtype in "2A.GPM.DPR"
do
	for year in "2003" "2004" "2005" "2006"
	do 
		for month in $(seq 6 8)
		do

    			wget  -nc --user=$user --password=$pass -P $outputPath -r -np -nH -R index.html  https://e4ftl01.cr.usgs.gov/MOLA/MYD13C2.006/$year"."$(printf '%02d' $month)".01"/
                        
		done
	done

done


