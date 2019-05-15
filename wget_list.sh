#!/bin/bash
# 生成file.html配合Windows idm下载器下载
outputPath="abc"

user=cgc@mail.ustc.edu.cn
pass=cgc@mail.ustc.edu.cn

for gpmtype in "2A.GPM.DPR"
do
	for year in "2019"
	do 
		for month in $(seq 1 4)
		do
			for day in $(seq 1 31)
			do
			wget -nc  --user=$user --password=$pass -P $outputPath ftp://arthurhou.pps.eosdis.nasa.gov/pub/gpmdata/$year/$(printf '%02d' $month)/$(printf '%02d' $day)/radar/
                        echo $(cat ./$outputPath/index.html | grep $gpmtype)>>file.html

 


		        done
		done
	done

done


