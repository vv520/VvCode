CREATE OR REPLACE FUNCTION TO_UPPER_NUM  
(  
  P_NUM   IN NUMBER DEFAULT NULL,  
  P_ROUND NUMBER    DEFAULT 2,    --输出要保留的小数位数  
  P_MONTH NUMBER    DEFAULT 1     --输出不为月份或者日时,当此参数输入不为1时,返回值为大写(非汉字)数字  
)  
  RETURN  NVARCHAR2  
IS  
  /** 
   *阿拉伯数字转化为大写汉字的函数 
   *输入参数转换前的数字,要保留的小数位数(4舍5入可以不输入,默认为小数点后2位) 
   *输出参数为转化后的大写数字 
   *支持小数点和负数,但数字整数部分不能超过16位 
   *支持转换月份和日期,如 SELECT TO_UPPER_NUM('31','3','2') FROM DUAL 
   *--日期例子(年份的转换见另一个函数) 
   *  SELECT TO_UPPER_YEAR(TO_CHAR(SYSDATE,'YYYY')) || '年' || 
   *  TO_UPPER_NUM(TO_CHAR(SYSDATE,'MM'),'2','2') || '月' || 
   *  TO_UPPER_NUM(TO_CHAR(SYSDATE,'DD'),'2','2') || '日'  
   *  FROM DUAL ; 
   *--货币例子(截取小数点后两位,四舍五入) 
   *  SELECT TO_UPPER_NUM(1234.564) FROM dual ; 
   */  
   RESULT      NVARCHAR2(100) := ''; --返回大写汉字字符串  
   NUM_ROUND   NVARCHAR2(100) := TO_CHAR(ABS(ROUND(P_NUM, P_ROUND))); --转换数字为小数点后p_round位的字符(正数)  
   NUM_LEFT    NVARCHAR2(100);       --小数点左边的数字  
   NUM_RIGHT   NVARCHAR2(100);       --小数点右边的数字  
   STR1        NCHAR(10) := '零壹贰叁肆伍陆柒捌玖';             --数字大写  
   STR2        NCHAR(16) := '点拾佰仟万拾佰仟亿拾佰仟万拾佰仟'; --数字位数(从低至高)  
   STR3        NCHAR(10) := '〇一二三四五六七八九';             --月份数字大写  
   STR4        NCHAR(16) := '点十佰仟万拾佰仟亿拾佰仟万拾佰仟'; --数字位数(从低至高)  
   NUM_PRE     NUMBER(1) := 1;       --前一位上的数字  
   NUM_CURRENT NUMBER(1);            --当前位上的数字  
   NUM_COUNT   NUMBER := 0;          --当前数字位数  
BEGIN  
  --转换数字为NULL时，返回NULL  
  IF P_NUM IS NULL THEN  
    RETURN NULL;  
  END IF;  
  --如果要转换月份或者日时,则替换临时变量  
  IF P_MONTH <> 1 THEN  
    STR1 := STR3;  
    STR2 := STR4;  
  END IF;  
  --取得小数点左边的数字  
  SELECT TO_CHAR(NVL(SUBSTR(TO_CHAR(NUM_ROUND),  
                            1,  
                            DECODE(INSTR(TO_CHAR(NUM_ROUND), '.'),  
                                   0,  
                                   LENGTH(NUM_ROUND),  
                                   INSTR(TO_CHAR(NUM_ROUND), '.') - 1)),  
                     0))  
    INTO NUM_LEFT  
    FROM DUAL;  
  --取得小数点右边的数字  
  SELECT SUBSTR(TO_CHAR(NUM_ROUND),  
                DECODE(INSTR(TO_CHAR(NUM_ROUND), '.'),  
                       0,  
                       LENGTH(NUM_ROUND) + 1,  
                       INSTR(TO_CHAR(NUM_ROUND), '.') + 1),  
                P_ROUND)  
    INTO NUM_RIGHT  
    FROM DUAL;  
  --数字整数部分超过16位时.采用从低至高的算法，先处理小数点左边的数字  
  IF LENGTH(NUM_LEFT) > 16 THEN  
    RETURN '**********';  
  END IF;  
  FOR I IN REVERSE 1 .. LENGTH(NUM_LEFT) LOOP  
    --(从低至高)  
    NUM_CURRENT := TO_NUMBER(SUBSTR(NUM_LEFT, I, 1)); --当前位上的数字  
    NUM_COUNT   := NUM_COUNT + 1;                     --当前数字位数  
    --当前位上数字不为0按正常处理  
    IF NUM_CURRENT > 0 THEN  
     --如果转换数字最高位是十位,转换后不需要前面的壹,如月份12转换后为拾贰,则  
      IF NUM_CURRENT = 1 AND P_MONTH <> 1 AND NUM_COUNT = 2 THEN  
        RESULT :=  SUBSTR(STR2, NUM_COUNT, 1) || RESULT;  
        STR1 := STR3;  
      ELSE  
        RESULT := SUBSTR(STR1, NUM_CURRENT + 1, 1)  
                ||SUBSTR(STR2, NUM_COUNT, 1)  
                || RESULT;  
      END IF;  
    ELSE  
      --当前位上数字为0时  
      IF MOD(NUM_COUNT - 1, 4) = 0 THEN  
        --当前位是点、万或亿时  
        RESULT  := SUBSTR(STR2, NUM_COUNT, 1) || RESULT;  
        NUM_PRE := 0; --点、万,亿前不准加零  
      END IF;  
      IF NUM_PRE > 0 OR LENGTH(NUM_LEFT) = 1 THEN  
        --上一位数字不为0或只有个位时  
        RESULT := SUBSTR(STR1, NUM_CURRENT + 1, 1) || RESULT;  
      END IF;  
    END IF;  
    NUM_PRE := NUM_CURRENT;  
  END LOOP;  
  --再处理小数点右边的数字  
  IF LENGTH(NUM_RIGHT) > 0 THEN  
    FOR I IN 1 .. LENGTH(NUM_RIGHT) LOOP  
      --(从高至低)  
      NUM_CURRENT := TO_NUMBER(SUBSTR(NUM_RIGHT, I, 1)); --当前位上的数字  
      RESULT      := RESULT || SUBSTR(STR1, NUM_CURRENT + 1, 1);  
    END LOOP;  
  ELSE  
    RESULT := REPLACE(RESULT, '点', '');                 --无小数时去掉点  
  END IF;  
  --转换数字是负数时  
  IF P_NUM < 0 THEN  
    RESULT := '负' || RESULT;  
  END IF;  
  RETURN RESULT;  
EXCEPTION  
  WHEN OTHERS THEN  
    DBMS_OUTPUT.PUT_LINE(SQLERRM);  
    RETURN '';  
END;  
