-- #Query all tasks(SR) in G OR None G
SELECT TS.no_task, T.no_ticket, T.create_datetime, T.case_type , T.contract_no,
	CASE SUBSTR(T.contract_no , 5, 1)
    	WHEN '6' THEN 'Non G'
        WHEN '5' THEN 'Non G'
        WHEN '0' THEN 'Non G'
        WHEN 'P' THEN 'Non G'
        WHEN '3' THEN 'G'
     END  type
 FROM `ticket` T LEFT JOIN tasks TS ON TS.ticket_sid = T.sid
 WHERE T.create_datetime BETWEEN '2016-08-01 00:00:00.000000' AND '2016-09-01 00:00:00.000000' AND TS.no_task<> 'NULL'
 AND (T.case_type LIKE 'Preventive Maintenance' OR T.case_type = 'Incident' OR T.case_type = 'Implement' OR T.case_type = 'Install' OR T.case_type = 'Request' OR T.case_type = 'Question' )



  -- Query all case in month

  SELECT TS.no_task, T.no_ticket, T.create_datetime, T.case_type , T.contract_no
  FROM `ticket` T LEFT JOIN tasks TS ON TS.ticket_sid = T.sid
  WHERE T.create_datetime BETWEEN '2016-08-01 00:00:00.000000' AND '2016-09-01 00:00:00.000000' AND TS.no_task<> NULL  AND T.refer_remedy_hd <> '' AND T.status = '5'
  AND (T.case_type LIKE 'Preventive Maintenance' OR T.case_type = 'Incident' OR T.case_type = 'Implement' OR T.case_type = 'Install' OR T.case_type = 'Request' OR T.case_type = 'Question' )




-- Query Spare part in month
SELECT ts.create_by, t.no_ticket, ts.oracle_sr_type, ts.oracle_sr, ts.oracle_create_date, ts.model, tst.oracle_task,  tsp.part_description, tsp.spare_part_return_type, tsp.request_spare_part_date, tsp.delivery_due_date, tsp.receive_spare_part_date, DATEDIFF( receive_spare_part_date, delivery_due_date ) waiting,
(	SELECT end_user
	FROM ticket
	WHERE sid = ts.ticket_sid
	ORDER BY  no_ticket ASC
	LIMIT 0 , 1) end_user
FROM ticket_spare ts
LEFT JOIN ticket_spare_task tst ON tst.ticket_spare_sid = ts.sid
LEFT JOIN ticket_spare_part tsp ON tsp.ticket_spare_task_sid = tst.sid
LEFT JOIN ticket t ON t.sid = ts.ticket_sid
WHERE tsp.request_spare_part_date
BETWEEN  '2017-02-01 00:00:00'
AND  '2017-03-01 00:00:00'
ORDER BY tsp.request_spare_part_date ASC
