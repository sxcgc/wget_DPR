#/bin/tcsh
#!/bin/tcsh
set pre = "1C-R"
set sup = "HDF5"
if ($#argv < 1) then
 echo "Usage: $0 yyyy mm [1C-R|1C.GPM|2A.GPM.DPR|2A.GPM.Ka|2A.GPM.Ku]"
 echo "       $0 -go  <-- tmp.tmp exists"
 exit
endif

set host = arthurhou.pps.eosdis.nasa.gov
set uid = cgc@mail.ustc.edu.cn
set pswd = $uid

if ("$1" == "-go") then
set i = 0
goto AA
endif

if ("$3" != "") then
 set pre = $3
endif

set pdir = `pwd`
set dir = "$1""$2"
test -e $dir || mkdir $dir
cd $dir

set dir2 = "radar"

set yy = `echo $pre | cut -c1-2`
if("$yy" == "1C") then
 set dir2 = "1C"
else if("$pre" == "2A.GPM.DPR") then
 set dir2 = "radar"
endif

echo -n > tmp.tmp
set maxd = 31
set i = 0
while ($i < $maxd)
@ i += 1
if ($i < 10) then
 set rdir = "0""$i"
else
 set rdir = "$i"
endif
set rdir = "gpmdata/$1/$2/$rdir/$dir2"
#echo $rdir; exit
unset noclobber
echo "open $host \
      user $uid $pswd \
      nlist $rdir/$pre.V*.$sup 1.tmp \
      nlist $rdir/$pre.V*.$sup \
quit" | ftp -n -i
set noclobber
cat 1.tmp >> tmp.tmp
\rm 1.tmp
end


set i = 0
AA:
@ i += 1
set file = `sed -n "${i}p" tmp.tmp`
if ("$file" != "") then
wget --ftp-user=$uid --ftp-password=$pswd -P /mnt/g/save/fyf/2019GPM/ftp://$host/$file
#gunzip -d `basename $file`
#bzip2 `basename $file | cut -d'.' -f1-5`
#bzip2 -f `basename $file`
goto AA
endif
FIN:
rm -f tmp.tmp
#gunzip -d *.gz; bzip2 -f *.HDF &
cd $pdir

