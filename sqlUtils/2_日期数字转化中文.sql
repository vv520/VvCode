CREATE OR REPLACE FUNCTION TO_UPPER_NUM  
(  
  P_NUM   IN NUMBER DEFAULT NULL,  
  P_ROUND NUMBER    DEFAULT 2,    --���Ҫ������С��λ��  
  P_MONTH NUMBER    DEFAULT 1     --�����Ϊ�·ݻ�����ʱ,���˲������벻Ϊ1ʱ,����ֵΪ��д(�Ǻ���)����  
)  
  RETURN  NVARCHAR2  
IS  
  /** 
   *����������ת��Ϊ��д���ֵĺ��� 
   *�������ת��ǰ������,Ҫ������С��λ��(4��5����Բ�����,Ĭ��ΪС�����2λ) 
   *�������Ϊת����Ĵ�д���� 
   *֧��С����͸���,�������������ֲ��ܳ���16λ 
   *֧��ת���·ݺ�����,�� SELECT TO_UPPER_NUM('31','3','2') FROM DUAL 
   *--��������(��ݵ�ת������һ������) 
   *  SELECT TO_UPPER_YEAR(TO_CHAR(SYSDATE,'YYYY')) || '��' || 
   *  TO_UPPER_NUM(TO_CHAR(SYSDATE,'MM'),'2','2') || '��' || 
   *  TO_UPPER_NUM(TO_CHAR(SYSDATE,'DD'),'2','2') || '��'  
   *  FROM DUAL ; 
   *--��������(��ȡС�������λ,��������) 
   *  SELECT TO_UPPER_NUM(1234.564) FROM dual ; 
   */  
   RESULT      NVARCHAR2(100) := ''; --���ش�д�����ַ���  
   NUM_ROUND   NVARCHAR2(100) := TO_CHAR(ABS(ROUND(P_NUM, P_ROUND))); --ת������ΪС�����p_roundλ���ַ�(����)  
   NUM_LEFT    NVARCHAR2(100);       --С������ߵ�����  
   NUM_RIGHT   NVARCHAR2(100);       --С�����ұߵ�����  
   STR1        NCHAR(10) := '��Ҽ��������½��ƾ�';             --���ִ�д  
   STR2        NCHAR(16) := '��ʰ��Ǫ��ʰ��Ǫ��ʰ��Ǫ��ʰ��Ǫ'; --����λ��(�ӵ�����)  
   STR3        NCHAR(10) := '��һ�����������߰˾�';             --�·����ִ�д  
   STR4        NCHAR(16) := '��ʮ��Ǫ��ʰ��Ǫ��ʰ��Ǫ��ʰ��Ǫ'; --����λ��(�ӵ�����)  
   NUM_PRE     NUMBER(1) := 1;       --ǰһλ�ϵ�����  
   NUM_CURRENT NUMBER(1);            --��ǰλ�ϵ�����  
   NUM_COUNT   NUMBER := 0;          --��ǰ����λ��  
BEGIN  
  --ת������ΪNULLʱ������NULL  
  IF P_NUM IS NULL THEN  
    RETURN NULL;  
  END IF;  
  --���Ҫת���·ݻ�����ʱ,���滻��ʱ����  
  IF P_MONTH <> 1 THEN  
    STR1 := STR3;  
    STR2 := STR4;  
  END IF;  
  --ȡ��С������ߵ�����  
  SELECT TO_CHAR(NVL(SUBSTR(TO_CHAR(NUM_ROUND),  
                            1,  
                            DECODE(INSTR(TO_CHAR(NUM_ROUND), '.'),  
                                   0,  
                                   LENGTH(NUM_ROUND),  
                                   INSTR(TO_CHAR(NUM_ROUND), '.') - 1)),  
                     0))  
    INTO NUM_LEFT  
    FROM DUAL;  
  --ȡ��С�����ұߵ�����  
  SELECT SUBSTR(TO_CHAR(NUM_ROUND),  
                DECODE(INSTR(TO_CHAR(NUM_ROUND), '.'),  
                       0,  
                       LENGTH(NUM_ROUND) + 1,  
                       INSTR(TO_CHAR(NUM_ROUND), '.') + 1),  
                P_ROUND)  
    INTO NUM_RIGHT  
    FROM DUAL;  
  --�����������ֳ���16λʱ.���ôӵ����ߵ��㷨���ȴ���С������ߵ�����  
  IF LENGTH(NUM_LEFT) > 16 THEN  
    RETURN '**********';  
  END IF;  
  FOR I IN REVERSE 1 .. LENGTH(NUM_LEFT) LOOP  
    --(�ӵ�����)  
    NUM_CURRENT := TO_NUMBER(SUBSTR(NUM_LEFT, I, 1)); --��ǰλ�ϵ�����  
    NUM_COUNT   := NUM_COUNT + 1;                     --��ǰ����λ��  
    --��ǰλ�����ֲ�Ϊ0����������  
    IF NUM_CURRENT > 0 THEN  
     --���ת���������λ��ʮλ,ת������Ҫǰ���Ҽ,���·�12ת����Ϊʰ��,��  
      IF NUM_CURRENT = 1 AND P_MONTH <> 1 AND NUM_COUNT = 2 THEN  
        RESULT :=  SUBSTR(STR2, NUM_COUNT, 1) || RESULT;  
        STR1 := STR3;  
      ELSE  
        RESULT := SUBSTR(STR1, NUM_CURRENT + 1, 1)  
                ||SUBSTR(STR2, NUM_COUNT, 1)  
                || RESULT;  
      END IF;  
    ELSE  
      --��ǰλ������Ϊ0ʱ  
      IF MOD(NUM_COUNT - 1, 4) = 0 THEN  
        --��ǰλ�ǵ㡢�����ʱ  
        RESULT  := SUBSTR(STR2, NUM_COUNT, 1) || RESULT;  
        NUM_PRE := 0; --�㡢��,��ǰ��׼����  
      END IF;  
      IF NUM_PRE > 0 OR LENGTH(NUM_LEFT) = 1 THEN  
        --��һλ���ֲ�Ϊ0��ֻ�и�λʱ  
        RESULT := SUBSTR(STR1, NUM_CURRENT + 1, 1) || RESULT;  
      END IF;  
    END IF;  
    NUM_PRE := NUM_CURRENT;  
  END LOOP;  
  --�ٴ���С�����ұߵ�����  
  IF LENGTH(NUM_RIGHT) > 0 THEN  
    FOR I IN 1 .. LENGTH(NUM_RIGHT) LOOP  
      --(�Ӹ�����)  
      NUM_CURRENT := TO_NUMBER(SUBSTR(NUM_RIGHT, I, 1)); --��ǰλ�ϵ�����  
      RESULT      := RESULT || SUBSTR(STR1, NUM_CURRENT + 1, 1);  
    END LOOP;  
  ELSE  
    RESULT := REPLACE(RESULT, '��', '');                 --��С��ʱȥ����  
  END IF;  
  --ת�������Ǹ���ʱ  
  IF P_NUM < 0 THEN  
    RESULT := '��' || RESULT;  
  END IF;  
  RETURN RESULT;  
EXCEPTION  
  WHEN OTHERS THEN  
    DBMS_OUTPUT.PUT_LINE(SQLERRM);  
    RETURN '';  
END;  
