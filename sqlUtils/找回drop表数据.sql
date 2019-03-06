
--只是delete表中某些数据
select * from ttrd_wmps_unit as of timestamp to_timestamp('2018/12/20 13:00:00', 'yyyy-mm-dd hh24:mi:ss');

--drop表找回
select object_name,original_name,partition_name,type,ts_name,createtime,droptime from recyclebin;
flashback table "BIN$fXDzoJMfEqvgVQAAAAAAAQ==$0" to before drop;
--或
flashback table TTRD_WMPS_UNIT to before drop;