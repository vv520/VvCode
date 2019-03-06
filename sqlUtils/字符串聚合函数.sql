create or replace type string_sum_obj as object ( 
--�ۺϺ�����ʵ�ʾ���һ������ 
     sum_string varchar2(4000), 
     static function ODCIAggregateInitialize(v_self in out string_sum_obj) return number, 
     --�����ʼ�� 
     member function ODCIAggregateIterate(self in out string_sum_obj, value in varchar2) return number, 
     --�ۺϺ����ĵ�������(��������Ҫ�ķ���) 
     member function ODCIAggregateMerge(self in out string_sum_obj, v_next in string_sum_obj) return number, 
     --����ѯ��䲢������ʱ,�Ż�ʹ�ø÷���,�ɽ�����������еĲ�ѯ����ۺ� 
      
     member function ODCIAggregateTerminate(self in string_sum_obj, return_value out varchar2 ,v_flags in number) return number 
     --��ֹ�ۼ������Ĵ���,���ؾۼ���������Ľ��. 
) 
/
create or replace type body string_sum_obj is
     static function ODCIAggregateInitialize(v_self in out string_sum_obj) return number is
     begin
         v_self := string_sum_obj(null);
         return ODCICONST.Success;
     end;
     member function ODCIAggregateIterate(self in out string_sum_obj, value in varchar2) return number is
     begin
          /* ���� */
          dbms_output.put_line('sum_string='||self.sum_string);
          if (   (  self.sum_string not like '%'||value||'%' or self.sum_string is  null )
                   and value is not null) then
             self.sum_string := self.sum_string || value||'��';
             
          end if;
          return ODCICONST.Success;
          /* ���ֵ */
          if self.sum_string<value then
              self.sum_string:=value;
          end if;
          /* ��Сֵ */
          if self.sum_string>value then
       self.sum_string:=value;
          end if;

          return ODCICONST.Success;
     end;
     member function ODCIAggregateMerge(self in out string_sum_obj, v_next in string_sum_obj) return number is
     begin
          /* ���� */
          self.sum_string := self.sum_string || v_next.sum_string;
          return ODCICONST.Success;
          /* ���ֵ */
          if self.sum_string<v_next.sum_string then
              self.sum_string:=v_next.sum_string;
          end if;

          /* ��Сֵ */
          if self.sum_string>v_next.sum_string then
              self.sum_string:=v_next.sum_string;
          end if;

          return ODCICONST.Success;
     end;
     member function ODCIAggregateTerminate(self in string_sum_obj, return_value out varchar2 ,v_flags in number) return number is
     begin
          return_value:= self.sum_string;
          return ODCICONST.Success;
     end;
end;
/
create or replace function ConnStrSum(value Varchar2) return Varchar2
     parallel_enable aggregate using string_sum_obj;
/
