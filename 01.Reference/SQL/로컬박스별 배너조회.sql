--DECLARE @DEVICE_CODE BIGINT = 10096
--       ,@NOW_DATE       VARCHAR(8)
--       ,@NOW_TIME  VARCHAR(5)
--	   ,@UTC_DATE DATETIME = GETUTCDATE()
--	   ,@MANAGEMENT_URL  NVARCHAR(100) = 'https://altsoft.ze.am'



	DECLARE @DEVICE_CODE     BIGINT = 10072
         ,@DEVICE_NUMBER   VARCHAR(100)  = ''
         ,@HOST_URL        NVARCHAR(100) = 'http://hosting.altsoft.ze.am'
         ,@MANAGEMENT_URL  NVARCHAR(100) = 'https://altsoft.ze.am'
         ,@NOW_DATE        VARCHAR(8)
	     ,@NOW_TIME        VARCHAR(5)
	     ,@DEVICE_NAME     NVARCHAR(200)
	     ,@UTC_DATE        DATETIME = GETUTCDATE()
         ,@JIBUN_ADDRESS   NVARCHAR(200)
      	 ,@PAGE INT       = 1
		 ,@PAGE_COUNT INT = 3000000
         ,@WORKING_TIME DATETIME = CASE WHEN '0' = '1' THEN GETDATE() ELSE NULL END

	
DECLARE @LATITUDE NUMERIC(20,16),@LONGITUDE NUMERIC(20,16), @RADIUS INT,@AD_FRAME_TYPE INT = 1

--select AD_CYCLE_TIME, * From t_device



--select * from V_ColumnInfo
--where table_name = 'T_DEVICE'

SELECT @LATITUDE      = LATITUDE,@LONGITUDE = LONGITUDE, @RADIUS=RADIUS, @AD_FRAME_TYPE = AD_FRAME_TYPE
      ,@NOW_DATE      = CONVERT(VARCHAR(8), DATEADD(MINUTE,  A.TIME_ZONE * 60, @UTC_DATE),112)
      ,@NOW_TIME      = CONVERT(VARCHAR(5), DATEADD(MINUTE,  A.TIME_ZONE * 60, @UTC_DATE),108)
	  ,@DEVICE_CODE   = DEVICE_CODE
	  ,@DEVICE_NUMBER = DEVICE_NUMBER
FROM T_DEVICE A
WHERE (DEVICE_CODE = @DEVICE_CODE OR DEVICE_NUMBER = @DEVICE_NUMBER);


WITH T_TABLE
AS
(
SELECT ROW_NUMBER()OVER(ORDER BY ISNULL(D.ORDER_SEQ,99999)) AS IDX
     , A.DEVICE_CODE, A.DEVICE_NAME
     , A.STORE_CODE
	 , A1.STORE_NAME
	 , B.BANNER_TYPE2 AS CONTENT_TYPE
	 , A.AD_CYCLE_TIME AS PLAY_TIME
	 , A.AD_CYCLE_TIME
	 , CASE WHEN A.STORE_CODE = B.STORE_CODE AND A.DEVICE_CODE = B.DEVICE_CODE AND B.REF_DATA2 LIKE '%1%' THEN '6336' ELSE B.REP_CATEGORY_CODE  END CATEGORY_CODE
	 , D.CATEGORY_NAME
	 , D.CATEGORY_TYPE
	 , B.BANNER_TYPE
	 , D.ORDER_SEQ
	 , B.AD_FRAME_TYPE
	 , B.AD_CODE, B.TITLE, B.SUB_TITLE
	 , B.CLICK_CNT
	 , B.LOGO_URL AS BANNER_URL
	 , CASE WHEN B.BANNER_TYPE2 IN (2,3) THEN ISNULL( B.FILE_URL,B.LOGO_URL) 
		      ELSE B.LOGO_URL END AS LOGO_URL
     , B.FR_DATE, B.TO_DATE
	 , B.FR_TIME, B.TO_TIME
	 , A.LATITUDE, A.LONGITUDE
	 , @MANAGEMENT_URL +'/advertise/adsub?AD_CODE=' + CONVERT(VARCHAR(10), B.AD_CODE) AS CONTENT_URL
	 , A.ADDRESS1 AS JIBUN_ADDRESS
	 , B.STORE_CODE AS DEVICE_STORE_CODE
	 , B.STORE_NAME AS DEVICE_STORE_NAME
	 ,AC.REF_DATA1
      /*, B.STORE_CODE, A.DEVICE_CODE, B.DEVICE_CODE
     , AC.REF_DATA1, B.REF_DATA2 , B.TITLE
	 , B.AD_CODE, A.DEVICE_CODE, A.DEVICE_TYPE, B.AD_TYPE, B.DEVICE_CODE,*/
  FROM T_DEVICE A
  LEFT JOIN T_DEVICE_PLACE AP
    ON A.DEVICE_CODE = AP.DEVICE_CODE
  INNER JOIN T_STORE A1
     ON A.STORE_CODE = A1.STORE_CODE
     
INNER JOIN (


  SELECT 
         A.*,A1.STORE_NAME, B.DEVICE_CODE,AC.REF_DATA2
       , ISNULL(PLACE_DISTANCE,0) AS PLACE_DISTANCE
	   , AF.FILE_URL  
    FROM T_AD A
	INNER JOIN T_STORE A1
     ON A.STORE_CODE = A1.STORE_CODE
   LEFT JOIN 
   (	SELECT AD_CODE, MIN(DBO.FN_TO_DISTANCE(@LATITUDE, @LONGITUDE, A.LATITUDE, A.LONGITUDE,'M') - A.RADIUS) AS PLACE_DISTANCE
          FROM T_AD_PLACE A
         GROUP BY AD_CODE
   ) AP
	  ON A.AD_CODE = AP.AD_CODE
   INNER JOIN T_COMMON AC
	  ON AC.MAIN_CODE = 'A006'
	 AND A.AD_TYPE = AC.SUB_CODE
	 
    LEFT JOIN T_AD_DEVICE B
      ON A.AD_CODE = B.AD_CODE
	 AND B.DEVICE_CODE = @DEVICE_CODE
	 AND B.STATUS IN(0, 9) 
	 AND B.HIDE = 0
  LEFT JOIN T_FILE AF
	    ON AF.TABLE_NAME = 'T_AD' AND AF.TABLE_KEY = CONVERT(VARCHAR(20), B.AD_CODE)
  WHERE  A.STATUS = 9 AND A.HIDE = 0
      AND (A.TO_DATE = '' OR A.TO_DATE >= @NOW_DATE)
       AND (A.FR_TIME = '' OR (@NOW_TIME >= A.FR_TIME 
                             AND @NOW_TIME < A.TO_TIME))
    
) B ON A.AD_FRAME_TYPE = B.AD_FRAME_TYPE 
 INNER JOIN T_COMMON AC
	  ON AC.MAIN_CODE = 'D003'
	 AND A.DEVICE_TYPE = AC.SUB_CODE
  LEFT JOIN T_CATEGORY D
    ON CASE WHEN A.STORE_CODE = B.STORE_CODE AND A.DEVICE_CODE = B.DEVICE_CODE AND B.REF_DATA2 LIKE '%1%' THEN '6336' ELSE B.REP_CATEGORY_CODE  END = D.CATEGORY_CODE      
WHERE A.DEVICE_CODE = @DEVICE_CODE
  AND A.AD_FRAME_TYPE = @AD_FRAME_TYPE
  
  AND ((A.DEVICE_CODE = B.DEVICE_CODE )
        OR (AC.REF_DATA1 LIKE '%2%' AND B.REF_DATA2 LIKE '%2%' AND b.PLACE_DISTANCE <= A.RADIUS)
      )
)
select * From T_TABLE


IF @WORKING_TIME IS NOT NULL
BEGIN
    UPDATE T_DEVICE
        SET WORKING_TIME = GETDATE()
    WHERE DEVICE_CODE = @DEVICE_CODE
END 


--select * From V_ColumnInfo
--where table_name = 'T_FILE'

--SELECT  *FROM T_DEVICE_MAIN A
--LEFT JOIN T_FILE B
--  ON B.TABLE_NAME = 'T_AD'
-- AND B.TABLE_KEY = CONVERT(VARCHAR(20),A.AD_CODE)
--WHERE ISNULL(A.REF_DATA1,'') <> ''
-- --AND B.TABLE_NAME IS NULL


