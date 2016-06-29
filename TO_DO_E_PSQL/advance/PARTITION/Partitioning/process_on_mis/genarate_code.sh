################ run file
{

LOOPDATE=$(date -d " 2013-03-10 0 month" +%Y-%m-%d)
LOOPENDDATE=$(date -d "2014-12-03 0 month" +%Y-%m-%d)

echo "LOOPDATE: $LOOPDATE"
echo "LOOPENDDATE: $LOOPENDDATE"

until [ "$( date -d "${LOOPDATE} 0 month" +%Y-%m )" ==  "$( date -d "${LOOPENDDATE} 0 month" +%Y-%m )" ]
do
 	
  NAME_FILE="insert_$( echo  "$( date -d "${LOOPDATE} 0 month" '+%Y-%m')" | sed 's/-//g') "  
#  echo "NAME: $NAME_FILE"
  echo "bash ./file/$NAME_FILE >  ./file/log_${NAME_FILE}   &"
  LOOPDATE=$(date -d "${LOOPDATE} 1 month" +%Y-%m-%d)
  
done
} 
#####################


{

LOOPDATE=$(date -d " 2013-03-10 0 day" +%Y-%m-%d)
LOOPENDDATE=$(date -d "2014-11-04 1 day" +%Y-%m-%d)

until [ "${LOOPENDDATE}" == "${LOOPDATE}" ]
do
 {
  	 
  NAME_TAB="all_customer_activity_$( echo  ${LOOPDATE} | sed 's/-//g') "  
  echo "########################################  load: $NAME_TAB"
  echo "START_TIME=\$(date +%s)" 
  echo "psql -U mis_etl -c \" INSERT INTO all_customer_activity select * from customer_activity where processing_date='$LOOPDATE'  and  (last_call_date is not null or last_topup_date is not null)  ;\"  "  
  echo "END_TIME=\$(date +%s)"
  echo "echo \" $NAME_TAB   \${START_TIME} - \${END_TIME}    TIME IN SECONDS: \$(( \$END_TIME-\$START_TIME ))\""
  LOOPDATE=$(date -d "${LOOPDATE} 1 day" +%Y-%m-%d)
  
  }  >> insert_$( echo  "$( date -d "${LOOPDATE} 0 month" '+%Y%m')") 
done
} 

select  processing_date , msisdn_skid , last_call_date , last_topup_date , churn_30_date , churn_90_date 
	from  customer_activity where processing_date='2014-10-10' and (last_call_date is not null or last_topup_date is not null) 



