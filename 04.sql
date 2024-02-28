create or replace trigger "SRC_OCIGGLL"."TRG_ORDERS" 
  after insert on "SRC_OCIGGLL"."SRC_ORDERS"
  REFERENCING NEW AS NEW OLD AS OLD

FOR EACH ROW
declare

v_payload varchar2(4000);

  begin
  
select json_object(*) into v_payload from (  
  select 
  :new.ORDER_ID , 
	:new.STATUS , 
	:new.CUST_ID , 
	:new.ORDER_DATE , 
	:new.CUSTOMER
from dual);

aq_admin.enqueue_json ('SRC_ORDERS',v_payload);

end;
/

exit