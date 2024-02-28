CREATE OR REPLACE PROCEDURE enqueue_json (p_table varchar2, p_payload varchar2) as
	enqueue_options dbms_aq.enqueue_options_t;
	message_properties dbms_aq.message_properties_t;
	message_handle RAW(16);
	message aq_admin.orders_message_type;
	message_id NUMBER;
BEGIN
	message := AQ_ADMIN.orders_message_type(p_table, p_payload);
	-- default for enqueue options VISIBILITY is ON_COMMIT. message has no delay and no expiration
	-- message_properties.CORRELATION := message.order_id;
	DBMS_AQ.ENQUEUE (
		queue_name => 'aq_admin.orders_msg_queue',
		enqueue_options => enqueue_options,
		message_properties => message_properties,
		payload => message,
		msgid => message_handle);
	COMMIT;
END;
/

grant execute on enqueue_json to SRC_OCIGGLL;

CREATE OR REPLACE PROCEDURE dequeue_json as
	dequeue_options dbms_aq.dequeue_options_t;
	message_properties dbms_aq.message_properties_t;
	message_handle RAW(16);
	message aq_admin.orders_message_type;
BEGIN
	-- defaults for dequeue_options
	-- Dequeue for the Europe_Orders subscriber
	-- Transformation Dollar_to_Euro is
	-- automatically applied
	--dequeue_options.consumer_name := 'EUROPE_ORDERS';
	-- set immediate visibility
	dequeue_options.VISIBILITY :=DBMS_AQ.IMMEDIATE;
	DBMS_AQ.DEQUEUE (
			queue_name => 'aq_admin.orders_msg_queue',
			dequeue_options => dequeue_options,
			message_properties => message_properties,
			payload => message,
			msgid => message_handle);
	dbms_output.put_line('+---------------+');
	dbms_output.put_line('| MESSAGE PAYLOAD |');
	dbms_output.put_line('+---------------+');
	dbms_output.put_line('- Table := ' ||message.tablename);
	dbms_output.put_line('- Payload := ' ||message.payload);
	COMMIT;
END;
/


BEGIN
enqueue_json('teste1','teste2');
end;
/

set SERVEROUTPUT on
BEGIN
dequeue_json();
end;
/


exit