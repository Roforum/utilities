while test 1
do
 timeval=`date '+Jun%d.%H.%M'`
./jcmd $PID VM.native_memory summary > NativeMemoryReport.$timeval.Summary.txt
./jcmd $PID VM.native_memory summary.diff > NativeMemoryReport.$timeval.Summary.diff.txt
./jcmd $PID VM.native_memory detail > NativeMemoryReport.$timeval.Detail.txt
./jcmd $PID VM.native_memory detail.diff > NativeMemoryReport.$timeval.DetailDiff.txt
./jstack $PID  > NativeMemoryReport.$timeval.Threads.txt
pmap -x $PID   > NativeMemoryReport.$timeval.pmap.txt
ps aux | grep $PID   > NativeMemoryReport.$timeval.ps.txt
cat /proc/$PID/maps   > NativeMemoryReport.$timeval.maps.txt
cat /proc/$PID/smaps   > NativeMemoryReport.$timeval.smaps.txt
free -m > NativeMemoryReport.$timeval.free.txt
grep -e AnonHugePages  /proc/$PID/smaps | awk  '{  if($2>4) print $0} '  > NativeMemoryReport.$timeval.AnonHugePages.txt
cat /proc/vmstat | grep thp_ > NativeMemoryReport.$timeval.vmstat_thp.txt
sleep 60
done
