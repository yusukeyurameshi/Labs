CREATE TYPE orders_message_type AS OBJECT (tablename varchar2(30), payload VARCHAR2(4000))
/

begin
    DBMS_AQADM.CREATE_QUEUE_TABLE(queue_table => 'aq_admin.orders_qt',
                                queue_payload_type =>'aq_admin.orders_message_type'
    );
end;
/

begin
    DBMS_AQADM.CREATE_QUEUE(queue_name => 'orders_msg_queue',
                            queue_table => 'aq_admin.orders_qt',
                            queue_type => DBMS_AQADM.NORMAL_QUEUE,max_retries => 0,
                            retry_delay => 0,
                            retention_time => 1209600,
                            dependency_tracking => FALSE,
                            comment => 'Test Object Type Queue',
                            auto_commit => FALSE
    );
end;
/


begin
    DBMS_AQADM.START_QUEUE('orders_msg_queue');
end;
/

exit