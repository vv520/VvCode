CREATE OR REPLACE FUNCTION TO_UPPER_YEAR(YEAR_IN  IN VARCHAR2)  
 RETURN VARCHAR2  
/**  
 *��ת��Ϊ��д���ֵĺ��� �罫2008ת��Ϊ��������  
 *�·ݺ�����ת���Ŀ��Ե��� TO_UPPER_NUM ����  
 *��SELECT TO_UPPER_NUM('21','2','2') FROM DUAL  
 *��ѯϵͳ��д����������:  
 *SELECT TO_UPPER_YEAR(TO_CHAR(SYSDATE,'YYYY')) || '��' ||  
 *       TO_UPPER_NUM(TO_CHAR(SYSDATE,'MM'),'2','2') || '��' ||  
 *       TO_UPPER_NUM(TO_CHAR(SYSDATE,'DD'),'2','2') || '��'  SJ  
 *FROM DUAL  
 */  
IS  
  TEMP     VARCHAR2(32767);  
  RESULT   VARCHAR2(32767);  
  STR      VARCHAR2(32767) := '��һ�����������߰˾�';  
BEGIN  
  IF YEAR_IN IS NULL THEN  
    RETURN NULL;  
  END IF;  
  FOR I IN 1 .. LENGTH(YEAR_IN)  
   LOOP  
     SELECT SUBSTR(STR, SUBSTR(YEAR_IN,I, 1) + 1, 1)  
       INTO TEMP  
       FROM DUAL;  
     RESULT := RESULT || TEMP;  
   END LOOP;  
  RETURN RESULT;  
EXCEPTION  
  WHEN OTHERS THEN  
    DBMS_OUTPUT.PUT_LINE(SQLERRM);  
    RETURN '';  
END;  
