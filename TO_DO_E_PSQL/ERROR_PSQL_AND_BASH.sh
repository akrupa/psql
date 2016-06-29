
psql --set ON_ERROR_STOP=1
psql -e -t -A -v p_job_id=331 --set ON_ERROR_STOP=1 -c " select * from sdaf "
psql -e -t -A -v p_job_id=331 --set ON_ERROR_STOP=1 -f skrypt.sql

Je¿el skrypt zwróci b³¹d to otrzymamy nastêpuj¹cy komunikat 
echo "$?"

