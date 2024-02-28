create or replace trigger "SRC_OCIGGLL"."TRG_ORDERS" 
  after insert or update on "SRC_OCIGGLL"."SRC_ORDERS"
  REFERENCING NEW AS NEW OLD AS OLD

FOR EACH ROW
declare

v_payload varchar2(4000);
v_op char(1);

  begin

if inserting then
v_op:='I';
select json_arrayagg(json_object(*)) into v_payload from (  
  select v_op operacao,
  :new.ORDER_ID ORDER_ID , 
	:new.STATUS STATUS , 
	:new.CUST_ID CUST_ID , 
	:new.ORDER_DATE ORDER_DATE , 
	:new.CUSTOMER CUSTOMER
from dual);
elsif updating then
v_op:='U';
select json_arrayagg(json_object(*)) into v_payload from (  
  select v_op operacao,'after' line_version,
  :new.ORDER_ID ORDER_ID , 
	:new.STATUS STATUS , 
	:new.CUST_ID CUST_ID , 
	:new.ORDER_DATE ORDER_DATE , 
	:new.CUSTOMER CUSTOMER
from dual
union all
 select v_op operacao,'before' line_version,
  :old.ORDER_ID ORDER_ID , 
	:old.STATUS STATUS , 
	:old.CUST_ID CUST_ID , 
	:old.ORDER_DATE ORDER_DATE , 
	:old.CUSTOMER CUSTOMER
from dual
);
end if;

  

aq_admin.enqueue_json ('SRC_ORDERS',v_payload);

end;
/


exit