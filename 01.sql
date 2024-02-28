--DBA User
GRANT EXECUTE ON aq_admin.orders_message_type TO aq_user;

begin
	DBMS_AQADM.GRANT_QUEUE_PRIVILEGE(privilege => 'ALL',
									queue_name => 'aq_admin.orders_msg_queue',
									grantee => 'aq_user',
									grant_option => FALSE
	);
end;
/

exit