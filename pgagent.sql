-- Show available job in pgagent
-- column jobid it is some thing like number family
-- column jsttid it is some thing like number of job
select 
  j.jobid
, j.jobname
, s.jstid
, s.jstname 
from pgagent.pga_job j
join pgagent.pga_jobstep s on (j.jobid=s.jstjobid)
order by j.jobid, jstid;

-- Show log of executing job
SLECT * FROM pgagent.pga_jobsteplog WHERE  jsljstid=<nr>

-------------- Show implementation of job
--------------
select jstid, jstcode from pgagent.pga_jobstep;

         
