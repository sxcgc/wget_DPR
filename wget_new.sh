#!/bin/bash
outputPath="/mnt/g/save/fyf/2019GPM"

user=cgc@mail.ustc.edu.cn
pass=cgc@mail.ustc.edu.cn

for gpmtype in "2A.GPM.DPR" #"2A.GPM.Ka" "2A.GPM.Ku"
do
	for year in "2019"
	do 
		for month in $(seq 3 4)
		do
			for day in $(seq 1 31)
			do
			wget -nc  --user=$user --password=$pass -P $outputPath ftp://arthurhou.pps.eosdis.nasa.gov/pub/gpmdata/$year/$(printf '%02d' $month)/$(printf '%02d' $day)/radar/$gpmtype".*.HDF5"	

		    done
		done
	done

done


