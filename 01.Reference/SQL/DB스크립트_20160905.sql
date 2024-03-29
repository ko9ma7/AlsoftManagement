USE [master]
GO
/****** Object:  Database [ALTSOFT_ONLINESERVICE]    Script Date: 2016-09-05 오후 6:22:35 ******/
CREATE DATABASE [ALTSOFT_ONLINESERVICE]
GO
ALTER DATABASE [ALTSOFT_ONLINESERVICE] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ALTSOFT_ONLINESERVICE].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ALTSOFT_ONLINESERVICE] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ALTSOFT_ONLINESERVICE] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ALTSOFT_ONLINESERVICE] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ALTSOFT_ONLINESERVICE] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ALTSOFT_ONLINESERVICE] SET ARITHABORT OFF 
GO
ALTER DATABASE [ALTSOFT_ONLINESERVICE] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ALTSOFT_ONLINESERVICE] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ALTSOFT_ONLINESERVICE] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ALTSOFT_ONLINESERVICE] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ALTSOFT_ONLINESERVICE] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ALTSOFT_ONLINESERVICE] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ALTSOFT_ONLINESERVICE] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ALTSOFT_ONLINESERVICE] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ALTSOFT_ONLINESERVICE] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ALTSOFT_ONLINESERVICE] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ALTSOFT_ONLINESERVICE] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ALTSOFT_ONLINESERVICE] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ALTSOFT_ONLINESERVICE] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ALTSOFT_ONLINESERVICE] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ALTSOFT_ONLINESERVICE] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ALTSOFT_ONLINESERVICE] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ALTSOFT_ONLINESERVICE] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ALTSOFT_ONLINESERVICE] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [ALTSOFT_ONLINESERVICE] SET  MULTI_USER 
GO
ALTER DATABASE [ALTSOFT_ONLINESERVICE] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ALTSOFT_ONLINESERVICE] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ALTSOFT_ONLINESERVICE] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ALTSOFT_ONLINESERVICE] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [ALTSOFT_ONLINESERVICE] SET DELAYED_DURABILITY = DISABLED 
GO
USE [ALTSOFT_ONLINESERVICE]
GO
/****** Object:  Synonym [dbo].[T_SYN]    Script Date: 2016-09-05 오후 6:22:36 ******/
CREATE SYNONYM [dbo].[T_SYN] FOR [master].[dbo].[T_SYN]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetDateName]    Script Date: 2016-09-05 오후 6:22:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*****************************************************************************/
/*  날짜에 해당 하는 요일 가져오는 함수                                      */
/*  작성일 : 2015년 12월 31일(2015.12.31추가)                                */
/*  작성자 : 박동영                                                          */
/*  변  수 : @SGUBUN => 1 = 영어 Full , 2 = 영어 , 3 = 한글 FULL , 4 = 한글  */
/*****************************************************************************/
CREATE FUNCTION [dbo].[fn_GetDateName] (
      @SDATE   DATETIME
    , @SGUBUN  NVARCHAR(1)
)
RETURNS NVARCHAR(100) 
AS 
BEGIN
    
    --DECLARE @SDATE  DATETIME    = GETDATE()
    --      , @SGUBUN NVARCHAR(1) = '1'
    
    DECLARE @RETURN_NAME NVARCHAR(100)

    IF @SGUBUN = '3'
    BEGIN
        SET @RETURN_NAME = CASE (DATEPART(DW, @SDATE) + @@DATEFIRST) % 7 WHEN 1 THEN N'일요일'
                                                                         WHEN 2 THEN N'월요일'
                                                                         WHEN 3 THEN N'화요일'
                                                                         WHEN 4 THEN N'수요일'
                                                                         WHEN 5 THEN N'목요일'
                                                                         WHEN 6 THEN N'금요일'
                                                                         WHEN 0 THEN N'토요일' END
    END
    ELSE IF @SGUBUN = '4' 
    BEGIN
        SET @RETURN_NAME = CASE (DATEPART(DW, @SDATE) + @@DATEFIRST) % 7 WHEN 1 THEN N'일'
                                                                         WHEN 2 THEN N'월'
                                                                         WHEN 3 THEN N'화'
                                                                         WHEN 4 THEN N'수'
                                                                         WHEN 5 THEN N'목'
                                                                         WHEN 6 THEN N'금'
                                                                         WHEN 0 THEN N'토' END
    END
    ELSE IF @SGUBUN = '1' 
    BEGIN
        SET @RETURN_NAME = CASE (DATEPART(DW, @SDATE) + @@DATEFIRST) % 7 WHEN 1 THEN N'Sunday'
                                                                         WHEN 2 THEN N'Monday'
                                                                         WHEN 3 THEN N'Tuesday'
                                                                         WHEN 4 THEN N'Wednesday'
                                                                         WHEN 5 THEN N'Thursday'
                                                                         WHEN 6 THEN N'Friday'
                                                                         WHEN 0 THEN N'Saturday' END
    END
    ELSE 
    BEGIN
        SET @RETURN_NAME = CASE (DATEPART(DW, @SDATE) + @@DATEFIRST) % 7 WHEN 1 THEN N'Sun' 
                                                                         WHEN 2 THEN N'Mon' 
                                                                         WHEN 3 THEN N'Tue' 
                                                                         WHEN 4 THEN N'Wed' 
                                                                         WHEN 5 THEN N'Thu' 
                                                                         WHEN 6 THEN N'Fri' 
                                                                         WHEN 0 THEN N'Sat' END
    END

    RETURN @RETURN_NAME

   
END    


GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetTimeMeridiem]    Script Date: 2016-09-05 오후 6:22:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*****************************************************************************/
/*  시간 AM, PM 구분 가져오는 함수                                           */
/*  작성일 : 2016년 06월 03일(2015.12.31추가)                                */
/*  작성자 : 전상훈                                                          */
/*****************************************************************************/
CREATE FUNCTION [dbo].[fn_GetTimeMeridiem] (
      @STIME   NVARCHAR(20)
)
RETURNS NVARCHAR(100) 
AS 
BEGIN
    IF ISNULL(@STIME ,'') = '' RETURN ''
	SET @STIME = REPLACE(@STIME, ':', '')
    
	SET @STIME = CASE WHEN LEN(@STIME) = 3 THEN '0' + @STIME ELSE @STIME END
	
    RETURN CASE WHEN CONVERT(INT, LEFT(@STIME, 2)) > 12 THEN REPLICATE('0', 2 - LEN(CONVERT(NVARCHAR, CONVERT(INT, LEFT(@STIME ,2)) - 12))) + CONVERT(NVARCHAR, CONVERT(INT, LEFT(@STIME ,2)) - 12)  + ':' + RIGHT(@STIME, 2) + ' PM' 
                WHEN CONVERT(INT, LEFT(@STIME, 2)) = 12 THEN REPLICATE('0', 2 - LEN(CONVERT(NVARCHAR, CONVERT(INT, LEFT(@STIME ,2))))) + CONVERT(NVARCHAR, CONVERT(INT, LEFT(@STIME ,2)))       + ':' + RIGHT(@STIME, 2) + ' PM' 
                                                        ELSE REPLICATE('0', 2 - LEN(CONVERT(NVARCHAR, CONVERT(INT, LEFT(@STIME ,2))))) + CONVERT(NVARCHAR, CONVERT(INT, LEFT(@STIME ,2)))       + ':' + RIGHT(@STIME, 2) + ' AM' END
END    
GO
/****** Object:  UserDefinedFunction [dbo].[fn_KoreanUnit]    Script Date: 2016-09-05 오후 6:22:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--select *, LEN(FIRST_KEY),LEN(MIDDLE_KEY),LEN(LAST_KEY) from  [dbo].[KoreanUnit]('성수동')


CREATE Function [dbo].[fn_KoreanUnit](@Str nVarChar(100))
RETURNS @TABLE TABLE
( 
	FIRST_KEY NVARCHAR(300)
   ,MIDDLE_KEY NVARCHAR(300)
   ,LAST_KEY   NVARCHAR(300)
   ,SPLITE_KEYS NVARCHAR(300)
)
AS
BEGIN

 DECLARE  @BEGIN INT,
   @END INT,
   @FIRST INT,
   @MIDIUM INT,
   @LAST INT,
   @FStr INT,
   @MStr INT,
   @LStr INT,
   @i INT,
   @UniCode INT,
   @FIRST_KEY NVARCHAR(300) = ''
  ,@MIDDLE_KEY NVARCHAR(300) = ''
  ,@LAST_KEY   NVARCHAR(300) = ''
  ,@retStr nVarChar(200)
  ,@CHOSUNGLIST NVARCHAR(200) = N'ㄱㄲㄴㄷㄸㄹㅁㅂㅃㅅㅆㅇㅈㅉㅊㅋㅌㅍㅎ'
  ,@JUNGSUNGLIST NVARCHAR(200) = N'ㅏㅐㅑㅒㅓㅔㅕㅖㅗㅘㅙㅚㅛㅜㅝㅞㅟㅠㅡㅢㅣ'
  ,@JONGSUNGLIST NVARCHAR(200) =' ㄱㄲㄳㄴㄵㄶㄷㄹㄺㄻㄼㄽㄾㄿㅀㅁㅂㅄㅅㅆㅇㅈㅊㅋㅌㅍㅎ'
 SET @BEGIN = 44032 --한글 시작
 SET @END = 55203 --한글 끝(유니코드상에서...)
 SET @FIRST = 0
 SET @MIDIUM = 0
 SET @LAST = 0
 SET @FStr = 0
 SET @MStr = 0
 SET @LStr = 0
 SET @i = 1
 SET @retStr = ''
 While @i <= Len(@Str) --문자열끝까지 돈다
  BEGIN 
   SET @UniCode = UNICODE(SUBSTRING(@Str, @i, 1)) --한글자를뽑는다.
   IF(@UniCode >= @BEGIN AND @UniCode <= @END) --한글이냐?
    BEGIN
     SET @UniCode = @UniCode - @BEGIN
     SET @LAST = @UniCode % 28 --종성 분리
     SET @UniCode = CEILING(@UniCode / 28)
     SET @MIDIUM = @UniCode % 21 --중성 분리
     SET @FIRST = CEILING(@UniCode / 21) --초성분리
     SET @retStr = @retStr + NChar(4352 + @FIRST) --일단 초성 저장
	 SET @FIRST_KEY = @FIRST_KEY + CASE WHEN @CHOSUNGLIST LIKE '%' + NChar(4352 + @FIRST) + '%' THEN  NChar(4352 + @FIRST) ELSE '' END

     IF @MIDIUM = 9  --중성저장 아래 ElseIF문은 두개 자음 분리 방법을 몰라서 ㅡ.ㅡ;;
      SET @retStr = @retStr +'ㅗㅏ'
     ELSE IF @MIDIUM = 10 
      SET @retStr = @retStr +'ㅗㅐ'
     ELSE IF @MIDIUM =  11
      SET @retStr = @retStr +'ㅗㅣ'
     ELSE IF @MIDIUM =  14
      SET @retStr = @retStr +'ㅜㅓ'
     ELSE IF @MIDIUM =  15
      SET @retStr = @retStr +'ㅜㅔ'
     ELSE IF @MIDIUM =  16
      SET @retStr = @retStr +'ㅜㅣ'
     ELSE IF @MIDIUM =  19
      SET @retStr = @retStr +'ㅡㅣ'
     ELSE
      SET @retStr = @retStr + NChar(4449 + @MIDIUM)
	 SET @MIDDLE_KEY = @MIDDLE_KEY  + CASE WHEN @CHOSUNGLIST LIKE '%' + NChar(4352 + @FIRST) + '%' THEN  CASE WHEN @MIDIUM < 0 THEN ' ' ELSE  NChar(4449 + @MIDIUM) END ELSE  NChar(4352 + @FIRST)  END
     IF @LAST > 0 --종성이 있냐?..
      BEGIN
       --IF @LAST = 2
       -- SET @retStr = @retStr + 'ㄱㄱ'
       --ELSE IF @LAST = 3
       -- SET @retStr = @retStr + 'ㄱㅅ'
       --ELSE IF @LAST = 5
       -- SET @retStr = @retStr + 'ㄴㅈ'
       --ELSE IF @LAST = 6
       -- SET @retStr = @retStr + 'ㄴㅎ'
       --ELSE IF @LAST = 9
       -- SET @retStr = @retStr + 'ㄹㄱ'
       --ELSE IF @LAST = 10
       -- SET @retStr = @retStr + 'ㄹㅁ'
       --ELSE IF @LAST = 11
       -- SET @retStr = @retStr + 'ㄹㅂ'
       --ELSE IF @LAST = 12
       -- SET @retStr = @retStr + 'ㄹㅅ'
       --ELSE IF @LAST = 13
       -- SET @retStr = @retStr + 'ㄹㅌ'
       --ELSE IF @LAST = 14
       -- SET @retStr = @retStr + 'ㄹㅍ'
       --ELSE IF @LAST = 15
       -- SET @retStr = @retStr + 'ㄹㅎ'
       --ELSE IF @LAST = 18
       -- SET @retStr = @retStr + 'ㅂㅅ'
       --ELSE IF @LAST = 20
       -- SET @retStr = @retStr + 'ㅅㅅ'
       --ELSE
        SET @retStr = @retStr + NChar(4519 + @LAST)
		 SET @LAST_KEY = @LAST_KEY +  NChar(4519 + @LAST)
      END
	   SET @LAST_KEY = @LAST_KEY + ' '
    END
   ELSE
   BEGIN
    SET @retStr = @retStr + NChar(@UniCode)
	SET @FIRST_KEY = @FIRST_KEY +  CASE WHEN @JUNGSUNGLIST LIKE N'%' + NChar(@UniCode) + '%' THEN ' ' ELSE NChar(@UniCode) END
	SET @MIDDLE_KEY = @MIDDLE_KEY +    CASE WHEN @JUNGSUNGLIST LIKE N'%' + NChar(@UniCode) + '%' THEN  NChar(@UniCode) ELSE ' ' END
	SET @LAST_KEY = @LAST_KEY +  ' '
	END
   SET @i = @i + 1
  END
 INSERT INTO @TABLE
  SELECT @FIRST_KEY, @MIDDLE_KEY, @LAST_KEY, @retStr
 
 return
END





GO
/****** Object:  UserDefinedFunction [dbo].[FN_SPLIT]    Script Date: 2016-09-05 오후 6:22:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/**************************************/
/* 문자열을 행으로 Split 하는 함수    */
/**************************************/
CREATE FUNCTION [dbo].[FN_SPLIT]
(
	@Val VARCHAR(MAX)
	,@Gubun VARCHAR(10)
)
RETURNS @TB TABLE
( 
	IDX int IDENTITY PRIMARY KEY,
	VAL1 varchar(200)
)
AS
/*
- '' 값도 반환한다
- 마지막은 분리자로 끝낸다
SELECT * FROM  dbo.[FN_SPLIT]('^1^^333^2^222^3^333^4^444^5^555^6^666^7^777^8^888^9^999','^') A
SELECT * FROM  dbo.[FN_SPLIT]('1^^22^^^^^^444444','^^') A
*/
BEGIN
 DECLARE
	  @Start SMALLINT
	 ,@End SMALLINT
	 ,@Cnt SMALLINT
	 ,@Gubun2 SMALLINT
 SELECT @Gubun2 = LEN(@Gubun)
 
 IF RIGHT(@Val,@Gubun2)!=@Gubun
 BEGIN
	SET @Val=@Val+@Gubun
 END
 SET @Val=@Gubun+@Val
  
 SET @Start = 1
 SELECT @End = CHARINDEX (@Gubun,@Val ,@Start+@Gubun2)
 SET @Cnt = 0
 WHILE (1=1)
 BEGIN
	  SET @Start = CHARINDEX (@Gubun,@Val )
	  SELECT @End = CHARINDEX (@Gubun,@Val ,@Start+@Gubun2)
			IF @End <= 0 BREAK
	  INSERT INTO @TB(VAL1) VALUES (SUBSTRING(@Val,@Start+@Gubun2,@End-@Start-@Gubun2))
	  SELECT @Val = STUFF(@Val,@Start,@Gubun2,'')
	  SET @Cnt = @Cnt + 1
 END
 RETURN
END


GO
/****** Object:  UserDefinedFunction [dbo].[FN_TO_DISTANCE]    Script Date: 2016-09-05 오후 6:22:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/************************************/
/* 위도경도로 거리 구하는 함수     */
/***********************************/
CREATE FUNCTION [dbo].[FN_TO_DISTANCE]( 
    @LAT1 AS NUMERIC(30,15), /*시작위도*/
    @LONG1 AS NUMERIC(30,15), /*시작위도*/
    @LAT2 AS NUMERIC(30,15),  /*종료경도*/
    @LONG2 AS NUMERIC(30,15),  /*종료경도*/
	@GUBUN VARCHAR(20) /*MILE 또는 KM*/
	
) 
/*
 위도,경도를 이용한 두 위치사이의 거리 구하기
 SELECT dbo.FN_TO_DISTANCE(37.5301719,127.0030122, 37.5059799,126.9381546,'km') 
*/
RETURNS NUMERIC(30,15) AS

BEGIN
    DECLARE @V_RETURN NUMERIC(30,15)
	       ,@GUBUN_DATA NUMERIC(30,15)
		    
   SET @GUBUN_DATA = CASE WHEN UPPER(@GUBUN) = 'MILE' THEN 3963.000
	      WHEN UPPER(@GUBUN) = 'KM' THEN 6387.700
		  WHEN UPPER(@GUBUN) = 'M' THEN 6387700
		  ELSE 6387.700 END
    SELECT @V_RETURN = DISTANCE 
      FROM
           (SELECT 2 * ATN2(SQRT(P.A), SQRT(1-P.A)) * @GUBUN_DATA AS DISTANCE 
             FROM
                  (SELECT SIN(L.DLAT/2) * SIN(L.DLAT/2) + SIN(L.DLON/2) * SIN(L.DLON/2) * COS(L.LAT1) * COS(L.LAT2) AS A 
                    FROM
                         (SELECT RADIANS(K.LAT2 - K.LAT1) AS DLAT, 
                                RADIANS(K.LONG2 - K.LONG1) AS DLON, 
                                RADIANS(K.LAT1) AS LAT1, 
                                RADIANS(K.LAT2) AS LAT2 
                           FROM
                                (SELECT @LAT1 AS LAT1, 
                                       @LONG1 AS LONG1, 
                                       @LAT2 AS LAT2, 
                                       @LONG2 AS LONG2 
                                ) K 
                         ) L 
                  ) P 
           ) O
    RETURN @V_RETURN; 
END

GO
/****** Object:  UserDefinedFunction [dbo].[fnSplitColumn]    Script Date: 2016-09-05 오후 6:22:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*************************************************************/
/*  문자열을 구분자 순번으로 잘라서 가져오는 함수            */
/*  작성일 : 2012년 12월 07일(2015.05.18추가)                */
/*  작성자 : 전상훈                                          */
/*  사용법 : SELECT DBO.FNSPLITCOLUMN('ABC/DEF/GHI', '/',0)  */
/*************************************************************/
CREATE FUNCTION [dbo].[fnSplitColumn]
   ( @SDATA NVARCHAR(200)
    ,@SGUBUN VARCHAR(2)
    ,@INDEX INT
 
   )
RETURNS NVARCHAR(100)   
AS

BEGIN
     DECLARE @IDX INT
           ,@RTNDATA NVARCHAR(100)
		   ,@REVERSE_DATA NVARCHAR(100)
		   
     SET @IDX = 0
     SET @SDATA = @SDATA + @SGUBUN
     SET @RTNDATA = ''
     WHILE 1=1
     BEGIN
          SET @IDX = CHARINDEX(@SGUBUN, @SDATA) -1
  
	      IF @INDEX = 999
		  BEGIN
		       SET @REVERSE_DATA = reverse(@SDATA)
			   SET @REVERSE_DATA = SUBSTRING(@REVERSE_DATA, 2, LEN(@REVERSE_DATA))
		
		  
		     SET @IDX = len(@SDATA) - charindex(@SGUBUN, @REVERSE_DATA) -1
			 
			 set @RTNDATA = substring(@SDATA, @idx + 2, LEN(@SDATA) - @idx-2)
			 
			 goto  LOOPBREAK
		  END
          IF @IDX = 0 
          BEGIN
                SET @SDATA = SUBSTRING(@SDATA, 2  , LEN(@SDATA))
                SET @RTNDATA = SUBSTRING(@SDATA,1,@IDX)
				
          END
          ELSE IF @IDX = -1
          BEGIN
                SET @RTNDATA = @SDATA
                GOTO LOOPBREAK
          END
          ELSE
          BEGIN
               IF @INDEX = 0 SET @RTNDATA = SUBSTRING(@SDATA, 1, (CASE WHEN @IDX <=0 THEN LEN(@SDATA) ELSE @IDX END)  )
               SET @SDATA = SUBSTRING(@SDATA, @IDX + 2 , LEN(@SDATA))
               
          END
        
          IF @INDEX = 0 GOTO LOOPBREAK
          SET @INDEX = @INDEX - 1
          IF @IDX <= -1 GOTO LOOPBREAK
  
     END
     LOOPBREAK: 

	 
	RETURN @RTNDATA
	 
END




GO
/****** Object:  UserDefinedFunction [dbo].[SplitKorean]    Script Date: 2016-09-05 오후 6:22:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Function [dbo].[SplitKorean](@Str nVarChar(100))
RETURNS nVarChar(250)
AS
BEGIN
 DECLARE  @BEGIN INT,
   @END INT,
   @FIRST INT,
   @MIDIUM INT,
   @LAST INT,
   @FStr INT,
   @MStr INT,
   @LStr INT,
   @i INT,
   @UniCode INT,
   @retStr nVarChar(200)
 SET @BEGIN = 44032 --한글 시작
 SET @END = 55203 --한글 끝(유니코드상에서...)
 SET @FIRST = 0
 SET @MIDIUM = 0
 SET @LAST = 0
 SET @FStr = 0
 SET @MStr = 0
 SET @LStr = 0
 SET @i = 1
 SET @retStr = ''
 While @i <= Len(@Str) --문자열끝까지 돈다
  BEGIN 
   SET @UniCode = UNICODE(SUBSTRING(@Str, @i, 1)) --한글자를뽑는다.
   IF(@UniCode >= @BEGIN AND @UniCode <= @END) --한글이냐?
    BEGIN
     SET @UniCode = @UniCode - @BEGIN
     SET @LAST = @UniCode % 28 --종성 분리
     SET @UniCode = CEILING(@UniCode / 28)
     SET @MIDIUM = @UniCode % 21 --중성 분리
     SET @FIRST = CEILING(@UniCode / 21) --초성분리
     SET @retStr = @retStr + NChar(4352 + @FIRST) --일단 초성 저장
     IF @MIDIUM = 9  --중성저장 아래 ElseIF문은 두개 자음 분리 방법을 몰라서 ㅡ.ㅡ;;
      SET @retStr = @retStr +'ㅗㅏ'
     ELSE IF @MIDIUM = 10 
      SET @retStr = @retStr +'ㅗㅐ'
     ELSE IF @MIDIUM =  11
      SET @retStr = @retStr +'ㅗㅣ'
     ELSE IF @MIDIUM =  14
      SET @retStr = @retStr +'ㅜㅓ'
     ELSE IF @MIDIUM =  15
      SET @retStr = @retStr +'ㅜㅔ'
     ELSE IF @MIDIUM =  16
      SET @retStr = @retStr +'ㅜㅣ'
     ELSE IF @MIDIUM =  19
      SET @retStr = @retStr +'ㅡㅣ'
     ELSE
      SET @retStr = @retStr + NChar(4449 + @MIDIUM)
     IF @LAST > 0 --종성이 있냐?..
      BEGIN
       IF @LAST = 2
        SET @retStr = @retStr + 'ㄱㄱ'
       ELSE IF @LAST = 3
        SET @retStr = @retStr + 'ㄱㅅ'
       ELSE IF @LAST = 5
        SET @retStr = @retStr + 'ㄴㅈ'
       ELSE IF @LAST = 6
        SET @retStr = @retStr + 'ㄴㅎ'
       ELSE IF @LAST = 9
        SET @retStr = @retStr + 'ㄹㄱ'
       ELSE IF @LAST = 10
        SET @retStr = @retStr + 'ㄹㅁ'
       ELSE IF @LAST = 11
        SET @retStr = @retStr + 'ㄹㅂ'
       ELSE IF @LAST = 12
        SET @retStr = @retStr + 'ㄹㅅ'
       ELSE IF @LAST = 13
        SET @retStr = @retStr + 'ㄹㅌ'
       ELSE IF @LAST = 14
        SET @retStr = @retStr + 'ㄹㅍ'
       ELSE IF @LAST = 15
        SET @retStr = @retStr + 'ㄹㅎ'
       ELSE IF @LAST = 18
        SET @retStr = @retStr + 'ㅂㅅ'
       ELSE IF @LAST = 20
        SET @retStr = @retStr + 'ㅅㅅ'
       ELSE
        SET @retStr = @retStr + NChar(4519 + @LAST)
      END
    END
   ELSE
    SET @retStr = @retStr + NChar(@UniCode)
   SET @i = @i + 1
  END
 RETURN @retStr
 
END



GO
/****** Object:  Table [dbo].[T_AD]    Script Date: 2016-09-05 오후 6:22:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[T_AD](
	[AD_CODE] [bigint] IDENTITY(1,1) NOT NULL,
	[LOGO_URL] [nvarchar](200) NOT NULL,
	[TITLE] [nvarchar](200) NOT NULL,
	[SUB_TITLE] [nvarchar](200) NOT NULL,
	[CONTENT] [nvarchar](max) NOT NULL,
	[FR_DATE] [varchar](8) NOT NULL,
	[TO_DATE] [varchar](8) NOT NULL,
	[FR_TIME] [varchar](5) NOT NULL,
	[TO_TIME] [varchar](5) NOT NULL,
	[CLICK_CNT] [int] NOT NULL,
	[GRADE_POINT] [numeric](5, 2) NOT NULL,
	[REQUEST_COMPANY_CODE] [int] NULL,
	[REQUEST_STORE_CODE] [varchar](400) NULL,
	[REQUEST_USER_CODE] [int] NULL,
	[REMARK] [nvarchar](200) NULL,
	[STATUS] [int] NULL,
	[HIDE] [bit] NOT NULL,
	[INSERT_CODE] [int] NOT NULL,
	[INSERT_DATE] [datetime] NOT NULL,
	[UPDATE_CODE] [int] NOT NULL,
	[UPDATE_DATE] [datetime] NOT NULL,
 CONSTRAINT [pk_T_AD] PRIMARY KEY CLUSTERED 
(
	[AD_CODE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[T_AD_DEVICE]    Script Date: 2016-09-05 오후 6:22:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[T_AD_DEVICE](
	[AD_DEVICE_CODE] [bigint] IDENTITY(1,1) NOT NULL,
	[AD_CODE] [bigint] NULL,
	[DEVICE_CODE] [bigint] NULL,
	[FR_DATE] [varchar](8) NULL,
	[TO_DATE] [varchar](8) NULL,
	[FR_TIME] [varchar](5) NULL,
	[TO_TIME] [varchar](5) NULL,
	[FR_UTC_DATE] [varchar](8) NULL,
	[TO_UTC_DATE] [varchar](8) NULL,
	[FR_UTC_TIME] [varchar](5) NULL,
	[TO_UTC_TIME] [varchar](5) NULL,
	[CLICK_CNT] [int] NULL,
	[REMARK] [nvarchar](200) NULL,
	[INSERT_CODE] [int] NULL,
	[INSERT_DATE] [datetime] NULL,
	[UPDATE_CODE] [int] NULL,
	[UPDATE_DATE] [datetime] NULL,
 CONSTRAINT [pk_T_AD_DEVICE] PRIMARY KEY CLUSTERED 
(
	[AD_DEVICE_CODE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [uc_T_AD_DEVICE] UNIQUE NONCLUSTERED 
(
	[AD_CODE] ASC,
	[DEVICE_CODE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[T_CATEGORY]    Script Date: 2016-09-05 오후 6:22:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[T_CATEGORY](
	[CATEGORY_CODE] [int] NOT NULL,
	[CATEGORY_TYPE] [int] NOT NULL,
	[CATEGORY_TYPE2] [int] NOT NULL,
	[PARENT_CATEGORY_CODE] [int] NOT NULL,
	[LEVEL_DEPTH] [int] NOT NULL,
	[SEARCH_CATEGORY_CODE] [varchar](100) NOT NULL,
	[CATEGORY_NAME] [nvarchar](200) NOT NULL,
	[CATEGORY_DISPlAY_NAME] [nvarchar](200) NOT NULL,
	[ORDER_SEQ] [int] NOT NULL,
	[HIDE] [bit] NOT NULL,
	[REMARK] [nvarchar](200) NULL,
	[INSERT_CODE] [int] NOT NULL,
	[INSERT_DATE] [datetime] NOT NULL,
	[UPDATE_CODE] [int] NOT NULL,
	[UPDATE_DATE] [datetime] NOT NULL,
 CONSTRAINT [pk_T_CATEGORY] PRIMARY KEY CLUSTERED 
(
	[CATEGORY_CODE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[T_CATEGORY_KEYWORD]    Script Date: 2016-09-05 오후 6:22:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_CATEGORY_KEYWORD](
	[CK_CODE] [int] IDENTITY(1,1) NOT NULL,
	[CATEGORY_CODE] [int] NOT NULL,
	[KEYWORD_CODE] [int] NOT NULL,
	[KEYWORD_NAME] [nvarchar](200) NOT NULL,
	[LATITUDE] [numeric](20, 15) NULL,
	[LONGITUDE] [numeric](20, 15) NULL,
	[REMARK] [nvarchar](200) NULL,
	[HIDE] [bit] NOT NULL,
	[INSERT_CODE] [int] NOT NULL,
	[INSERT_DATE] [datetime] NOT NULL,
	[UPDATE_CODE] [int] NOT NULL,
	[UPDATE_DATE] [datetime] NOT NULL,
 CONSTRAINT [pk_T_CATEGORY_KEYWORD] PRIMARY KEY CLUSTERED 
(
	[CK_CODE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [uc_T_CATEGORY_KEYWORD] UNIQUE NONCLUSTERED 
(
	[CATEGORY_CODE] ASC,
	[KEYWORD_CODE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[T_COMMON]    Script Date: 2016-09-05 오후 6:22:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[T_COMMON](
	[IDX] [int] IDENTITY(1,1) NOT NULL,
	[MAIN_CODE] [varchar](4) NOT NULL,
	[SUB_CODE] [int] NOT NULL,
	[NAME] [nvarchar](200) NOT NULL,
	[LANGUAGE_CODE] [bigint] NULL,
	[ORDER_SEQ] [int] NOT NULL,
	[REF_DATA1] [nvarchar](200) NULL,
	[REF_DATA2] [nvarchar](200) NULL,
	[REF_DATA3] [nvarchar](200) NULL,
	[REF_DATA4] [nvarchar](200) NULL,
	[HIDE] [bit] NOT NULL,
	[INSERT_CODE] [int] NOT NULL,
	[INSERT_DATE] [datetime] NOT NULL,
	[UPDATE_CODE] [int] NOT NULL,
	[UPDATE_DATE] [datetime] NOT NULL,
 CONSTRAINT [pk_T_COMMON] PRIMARY KEY CLUSTERED 
(
	[IDX] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [uc_T_COMMON] UNIQUE NONCLUSTERED 
(
	[MAIN_CODE] ASC,
	[SUB_CODE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[T_COMPANY]    Script Date: 2016-09-05 오후 6:22:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[T_COMPANY](
	[COMPANY_CODE] [int] IDENTITY(1,1) NOT NULL,
	[COMPANY_ID] [varchar](30) NULL,
	[PASSWORD] [nvarchar](200) NULL,
	[COMPANY_NAME] [nvarchar](100) NULL,
	[PHONE] [varchar](30) NULL,
	[MOBILE] [varchar](30) NULL,
	[EMAIL] [nvarchar](50) NULL,
	[ADDRESS1] [nvarchar](200) NULL,
	[ADDRESS2] [nvarchar](200) NULL,
	[ZIP_CODE] [varchar](10) NULL,
	[OWNER_NAME] [nvarchar](50) NULL,
	[OWNER_PHONE] [varchar](30) NULL,
	[OWNER_MOBILE] [varchar](30) NULL,
	[OWNER_EMAIL] [varchar](50) NULL,
	[STATUS] [int] NULL,
	[CULTURE_NAME] [varchar](5) NULL,
	[THEME_NAME] [nvarchar](50) NULL,
	[REMARK] [nvarchar](200) NULL,
	[INSERT_CODE] [int] NULL,
	[INSERT_DATE] [datetime] NULL,
	[UPDATE_CODE] [int] NULL,
	[UPDATE_DATE] [datetime] NULL,
 CONSTRAINT [pk_T_COMPANY] PRIMARY KEY CLUSTERED 
(
	[COMPANY_CODE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [uc_T_COMPANY] UNIQUE NONCLUSTERED 
(
	[COMPANY_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[T_DEVICE]    Script Date: 2016-09-05 오후 6:22:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[T_DEVICE](
	[DEVICE_CODE] [bigint] IDENTITY(1,1) NOT NULL,
	[STORE_CODE] [int] NULL,
	[DEVICE_NUMBER] [varchar](100) NOT NULL,
	[DEVICE_NAME] [nvarchar](200) NOT NULL,
	[DEVICE_DESC] [nvarchar](400) NOT NULL,
	[BUSI_TYPE] [int] NOT NULL,
	[BUSI_TYPE2] [int] NOT NULL,
	[ADDRESS1] [nvarchar](200) NOT NULL,
	[ADDRESS2] [nvarchar](200) NOT NULL,
	[ZIP_CODE] [varchar](10) NOT NULL,
	[LATITUDE] [numeric](20, 16) NOT NULL,
	[LONGTITUDE] [numeric](20, 16) NOT NULL,
	[REMARK] [nvarchar](200) NULL,
	[TIME_ZONE] [int] NOT NULL CONSTRAINT [DF_T_DEVICE_TIME_ZONE]  DEFAULT ('9'),
	[INSERT_CODE] [int] NOT NULL,
	[INSERT_DATE] [datetime] NOT NULL,
	[UPDATE_CODE] [int] NOT NULL,
	[UPDATE_DATE] [datetime] NOT NULL,
 CONSTRAINT [PK_T_DEVICE] PRIMARY KEY CLUSTERED 
(
	[DEVICE_CODE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[T_ITEM]    Script Date: 2016-09-05 오후 6:22:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_ITEM](
	[ITEM_CODE] [bigint] IDENTITY(1,1) NOT NULL,
	[GROUP_CODE] [bigint] NULL,
	[ITEM_NAME] [nvarchar](100) NULL,
	[ITEM_NAME_DISPLAY] [nvarchar](100) NULL,
	[ITEM_TYPE] [int] NULL,
	[COST] [numeric](18, 12) NULL,
	[TAX] [numeric](18, 16) NULL,
	[TAX2] [numeric](18, 16) NULL,
	[TAX3] [numeric](18, 16) NULL,
	[PRICE] [numeric](18, 6) NULL,
	[ORDER_SEQ] [int] NULL,
	[IMAGE_URL] [nvarchar](200) NULL,
	[ITEM_DESC] [nvarchar](800) NULL,
	[REMARK] [nvarchar](200) NULL,
	[HIDE] [bit] NULL,
	[INSERT_CODE] [int] NULL,
	[INSERT_DATE] [datetime] NULL,
	[UPDATE_CODE] [int] NULL,
	[UPDATE_DATE] [datetime] NULL,
 CONSTRAINT [pk_T_ITEM] PRIMARY KEY CLUSTERED 
(
	[ITEM_CODE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[T_ITEM_GROUP]    Script Date: 2016-09-05 오후 6:22:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_ITEM_GROUP](
	[GROUP_CODE] [bigint] IDENTITY(1,1) NOT NULL,
	[GROUP_TYPE] [int] NULL,
	[PARENT_GROUP_CODE] [bigint] NULL,
	[LEVEL_DEPTH] [int] NULL,
	[STORE_CODE] [int] NULL,
	[GROUP_NAME] [nvarchar](100) NULL,
	[GROUP_NAME_DISPLAY] [nvarchar](100) NULL,
	[ORDER_SEQ] [int] NULL,
	[IMAGE_URL] [nvarchar](200) NULL,
	[GROUP_DESC] [nvarchar](200) NULL,
	[REMARK] [nvarchar](200) NULL,
	[HIDE] [bit] NULL,
	[INSERT_CODE] [int] NULL,
	[INSERT_DATE] [datetime] NULL,
	[UPDATE_CODE] [int] NULL,
	[UPDATE_DATE] [datetime] NULL,
 CONSTRAINT [pk_T_ITEM_GROUP] PRIMARY KEY CLUSTERED 
(
	[GROUP_CODE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[T_KEYWORD]    Script Date: 2016-09-05 오후 6:22:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_KEYWORD](
	[KEYWORD_CODE] [int] IDENTITY(1,1) NOT NULL,
	[KEYWORD_TYPE] [int] NULL,
	[BASE_CODE] [int] NOT NULL,
	[IS_SYNONYM] [bit] NOT NULL,
	[SEQ] [nchar](10) NOT NULL,
	[KEYWORD_NAME] [nvarchar](200) NOT NULL,
	[KEYWORD_DESC] [nvarchar](200) NULL,
	[LATITUDE] [numeric](20, 15) NULL,
	[LONGITUDE] [numeric](20, 15) NULL,
	[CHOSUNG] [nvarchar](150) NULL,
	[JUNGSUNG] [nvarchar](150) NULL,
	[JONGSUNG] [nvarchar](150) NULL,
	[KEYWORD_UNITS] [nvarchar](280) NULL,
	[REMARK] [nvarchar](200) NULL,
	[SEARCH_CNT] [int] NOT NULL,
	[HIDE] [bit] NOT NULL,
	[INSERT_CODE] [int] NOT NULL,
	[INSERT_DATE] [datetime] NOT NULL,
	[UPDATE_CODE] [int] NOT NULL,
	[UPDATE_DATE] [datetime] NOT NULL,
 CONSTRAINT [pk_T_KEYWORD] PRIMARY KEY CLUSTERED 
(
	[KEYWORD_CODE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [uc_T_KEYWORD_NAME] UNIQUE NONCLUSTERED 
(
	[KEYWORD_NAME] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[T_LANGUAGE]    Script Date: 2016-09-05 오후 6:22:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[T_LANGUAGE](
	[LANGUAGE_CODE] [bigint] NOT NULL,
	[LANGUAGE_TYPE] [varchar](2) NOT NULL,
	[PAGE_URL] [nvarchar](200) NULL,
	[NAME] [nvarchar](200) NULL,
	[NAME2] [nvarchar](200) NULL,
	[REMARK] [nvarchar](200) NULL,
	[HIDE] [bit] NULL,
	[INSERT_CODE] [int] NULL,
	[INSERT_DATE] [datetime] NULL,
	[UPDATE_CODE] [int] NULL,
	[UPDATE_DATE] [datetime] NULL,
 CONSTRAINT [pk_T_LANGUAGE] PRIMARY KEY CLUSTERED 
(
	[LANGUAGE_CODE] ASC,
	[LANGUAGE_TYPE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[T_LOG]    Script Date: 2016-09-05 오후 6:22:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[T_LOG](
	[LOG_DATE] [varchar](16) NULL,
	[LOG_TYPE] [int] NULL,
	[LOG_DESC] [nvarchar](max) NULL,
	[USE_IP] [nvarchar](30) NULL,
	[LOG_TABLE] [nvarchar](50) NULL,
	[INSERT_CODE] [int] NULL,
	[INSERT_DATE] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[T_MEMBER]    Script Date: 2016-09-05 오후 6:22:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[T_MEMBER](
	[MEMBER_CODE] [int] IDENTITY(0,1) NOT NULL,
	[USER_TYPE] [int] NULL,
	[USER_ID] [nvarchar](50) NULL,
	[PASSWORD] [nvarchar](200) NOT NULL,
	[USER_NAME] [nvarchar](100) NOT NULL,
	[EMAIL] [nvarchar](100) NULL,
	[PHONE] [varchar](30) NULL,
	[MOBILE] [varchar](30) NULL,
	[ADDRESS1] [nvarchar](200) NULL,
	[ADDRESS2] [nvarchar](200) NULL,
	[ZIP_CODE] [varchar](10) NULL,
	[BIRTH] [varchar](8) NULL,
	[GENDER] [int] NULL,
	[REMARK] [nvarchar](1000) NULL,
	[HIDE] [bit] NOT NULL,
	[INSERT_CODE] [int] NOT NULL,
	[INSERT_DATE] [datetime] NOT NULL,
	[UPDATE_CODE] [int] NOT NULL,
	[UPDATE_DATE] [datetime] NOT NULL,
 CONSTRAINT [pk_T_MEMBER] PRIMARY KEY CLUSTERED 
(
	[MEMBER_CODE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [uc_T_MEMBER] UNIQUE NONCLUSTERED 
(
	[USER_TYPE] ASC,
	[USER_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[T_SALE]    Script Date: 2016-09-05 오후 6:22:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[T_SALE](
	[SALE_CODE] [bigint] IDENTITY(1,1) NOT NULL,
	[SALE_DATE] [varchar](16) NOT NULL,
	[BILL_NO] [varchar](50) NOT NULL,
	[STORE_CODE] [int] NOT NULL,
	[MEMBER_CODE] [int] NULL,
	[TOT_TAX] [numeric](30, 16) NOT NULL,
	[TAX1] [numeric](30, 16) NOT NULL,
	[TAX2] [numeric](30, 16) NOT NULL,
	[TAX3] [numeric](30, 16) NOT NULL,
	[DELIVERY_FEE] [numeric](30, 6) NOT NULL,
	[TIP_AMT] [numeric](30, 6) NOT NULL,
	[ADD_AMT] [numeric](30, 6) NOT NULL,
	[ITEM_DISCOUNT_AMT] [numeric](30, 6) NOT NULL,
	[ORDER_DISCOUNT_TYPE] [int] NOT NULL,
	[ORDER_DISCOUNT_AMT] [numeric](30, 6) NOT NULL,
	[SALE_AMT] [numeric](30, 6) NOT NULL,
	[REMARK] [nvarchar](400) NULL,
	[INSERT_CODE] [int] NOT NULL,
	[INSERT_DATE] [datetime] NOT NULL,
	[UPDATE_CODE] [int] NOT NULL,
	[UPDATE_DATE] [datetime] NOT NULL,
 CONSTRAINT [pk_T_SALE] PRIMARY KEY CLUSTERED 
(
	[SALE_CODE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[T_SALE_COUPON]    Script Date: 2016-09-05 오후 6:22:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[T_SALE_COUPON](
	[COUPON_CODE] [bigint] IDENTITY(1,1) NOT NULL,
	[COUPON_NO] [varchar](200) NOT NULL,
	[COUPON_DESC] [nvarchar](1000) NOT NULL,
	[COUPON_TYPE] [int] NOT NULL,
	[USE_DATE] [varchar](8) NULL,
	[FR_DATE] [varchar](8) NOT NULL,
	[TO_DATE] [varchar](8) NOT NULL,
	[MEMBER_CODE] [int] NULL,
	[COMPANY_CODE] [int] NULL,
	[STORE_CODE] [int] NULL,
	[ITEM_GROUP_CODE] [bigint] NULL,
	[ITEM_CODE] [bigint] NULL,
	[DISCOUNT_RATE] [numeric](30, 6) NULL,
	[DISCOUNT_AMT] [numeric](30, 6) NOT NULL,
	[MIN_PAY_AMT] [numeric](30, 6) NOT NULL,
	[USE_DISCOUNT_AMT] [numeric](30, 6) NOT NULL,
	[USE_YN] [bit] NOT NULL,
	[SALE_CODE] [bigint] NULL,
	[SALE_ITEM_SEQ] [int] NULL,
	[REMARK] [nvarchar](200) NULL,
	[INSERT_CODE] [int] NOT NULL,
	[INSERT_DATE] [datetime] NOT NULL,
	[UPDATE_CODE] [int] NOT NULL,
	[UPDATE_DATE] [datetime] NOT NULL,
 CONSTRAINT [pk_T_COUPON] PRIMARY KEY CLUSTERED 
(
	[COUPON_CODE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [uc_T_COUPON] UNIQUE NONCLUSTERED 
(
	[COUPON_NO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[T_SALE_DISCOUNT]    Script Date: 2016-09-05 오후 6:22:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_SALE_DISCOUNT](
	[SALE_CODE] [bigint] NOT NULL,
	[SEQ] [int] NOT NULL,
	[ITEM_SEQ] [int] NULL,
	[DISCOUNT_TYPE] [int] NULL,
	[ITEM_DISCOUNT_TYPE] [int] NULL,
	[BASE_AMT] [numeric](30, 6) NOT NULL,
	[DISCOUNT_RATE] [numeric](30, 6) NOT NULL,
	[DISCOUNT_AMT] [numeric](30, 6) NOT NULL,
	[REMARK] [nvarchar](400) NULL,
	[INSERT_CODE] [int] NOT NULL,
	[INSERT_DATE] [datetime] NOT NULL,
	[UPDATE_CODE] [int] NOT NULL,
	[UPDATE_DATE] [datetime] NOT NULL,
 CONSTRAINT [pk_T_SALE_DISCOUNT] PRIMARY KEY CLUSTERED 
(
	[SALE_CODE] ASC,
	[SEQ] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[T_SALE_ITEM]    Script Date: 2016-09-05 오후 6:22:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_SALE_ITEM](
	[SALE_CODE] [bigint] NOT NULL,
	[ITEM_SEQ] [int] NOT NULL,
	[ITEM_CODE] [bigint] NOT NULL,
	[ITEM_NAME] [nvarchar](100) NOT NULL,
	[ITEM_TYPE] [int] NOT NULL,
	[COST] [numeric](30, 12) NOT NULL,
	[TOT_TAX] [numeric](30, 16) NOT NULL,
	[TAX1] [numeric](30, 16) NOT NULL,
	[TAX2] [numeric](30, 16) NOT NULL,
	[TAX3] [numeric](30, 16) NOT NULL,
	[CNT] [int] NOT NULL,
	[PRICE] [numeric](30, 6) NOT NULL,
	[DISCOUNT_TYPE] [int] NOT NULL,
	[DISCOUNT_AMT] [numeric](30, 6) NOT NULL,
	[TOPPING_CODE] [int] NULL,
	[REMARK] [nvarchar](400) NULL,
	[INSERT_CODE] [int] NOT NULL,
	[INSERT_DATE] [datetime] NOT NULL,
	[UPDATE_CODE] [int] NOT NULL,
	[UPDATE_DATE] [datetime] NOT NULL,
 CONSTRAINT [pk_T_SALE_ITEM] PRIMARY KEY CLUSTERED 
(
	[SALE_CODE] ASC,
	[ITEM_SEQ] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[T_SALE_ITEM_ADD]    Script Date: 2016-09-05 오후 6:22:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_SALE_ITEM_ADD](
	[SALE_CODE] [bigint] NOT NULL,
	[ITEM_SEQ] [int] NOT NULL,
	[SEQ] [int] NOT NULL,
	[ITEM_TYPE] [int] NOT NULL,
	[ITEM_CODE] [bigint] NOT NULL,
	[COST] [numeric](30, 6) NOT NULL,
	[CNT] [numeric](30, 0) NOT NULL,
	[TOT_TAX] [numeric](30, 6) NOT NULL,
	[TAX1] [numeric](30, 6) NOT NULL,
	[TAX2] [numeric](30, 6) NOT NULL,
	[TAX3] [numeric](30, 6) NOT NULL,
	[PRICE] [numeric](30, 6) NOT NULL,
	[REMARK] [nvarchar](200) NULL,
	[INSERT_CODE] [int] NOT NULL,
	[INSERT_DATE] [datetime] NOT NULL,
	[UPDATE_CODE] [int] NOT NULL,
	[UPDATE_DATE] [datetime] NOT NULL,
 CONSTRAINT [PK_T_SALE_ITEM_ADD] PRIMARY KEY CLUSTERED 
(
	[SALE_CODE] ASC,
	[ITEM_SEQ] ASC,
	[SEQ] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[T_SALE_TIP]    Script Date: 2016-09-05 오후 6:22:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_SALE_TIP](
	[SALE_CODE] [bigint] NOT NULL,
	[SEQ] [int] NOT NULL,
	[EMPLOYEE_MEMBER_CODE] [bigint] NOT NULL,
	[EMPLOYEE_NAME] [nvarchar](200) NOT NULL,
	[CUSTOMER_MEMBER_CODE] [int] NOT NULL,
	[CUSTOMER_MEMBER_NAME] [nvarchar](200) NOT NULL,
	[COST] [numeric](30, 6) NOT NULL,
	[TOT_TIP_TAX] [numeric](30, 6) NOT NULL,
	[TIP_TAX1] [numeric](30, 6) NOT NULL,
	[TIP_TAX2] [numeric](30, 6) NOT NULL,
	[TIP_TAX3] [numeric](30, 6) NOT NULL,
	[PRICE] [numeric](30, 6) NOT NULL,
	[REMARK] [nvarchar](200) NULL,
	[INSERT_CODE] [int] NOT NULL,
	[INSERT_DATE] [datetime] NOT NULL,
	[UPDATE_CODE] [int] NOT NULL,
	[UPDATE_DATE] [datetime] NOT NULL,
 CONSTRAINT [pk_T_SALE_TIP] PRIMARY KEY CLUSTERED 
(
	[SALE_CODE] ASC,
	[SEQ] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[T_SEARCH_KEYWORD]    Script Date: 2016-09-05 오후 6:22:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_SEARCH_KEYWORD](
	[AD_CODE] [bigint] NULL,
	[DEVICE_CODE] [bigint] NULL,
	[CK_CODE] [int] NOT NULL,
	[REMARK] [nvarchar](200) NULL,
	[INSERT_CODE] [int] NOT NULL,
	[INSERT_DATE] [datetime] NOT NULL,
	[UPDATE_CODE] [int] NOT NULL,
	[UPDATE_DATE] [datetime] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[T_STORE]    Script Date: 2016-09-05 오후 6:22:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[T_STORE](
	[STORE_CODE] [int] IDENTITY(1,1) NOT NULL,
	[COMPANY_CODE] [int] NOT NULL,
	[STORE_ID] [varchar](30) NULL,
	[PASSWORD] [nvarchar](200) NULL,
	[STORE_NAME] [nvarchar](100) NULL,
	[PHONE] [varchar](30) NULL,
	[MOBILE] [varchar](30) NULL,
	[EMAIL] [nvarchar](50) NULL,
	[ADDRESS1] [nvarchar](200) NULL,
	[ADDRESS2] [nvarchar](200) NULL,
	[ZIP_CODE] [varchar](10) NULL,
	[OWNER_NAME] [nvarchar](50) NULL,
	[OWNER_PHONE] [varchar](30) NULL,
	[OWNER_MOBILE] [varchar](30) NULL,
	[OWNER_EMAIL] [varchar](50) NULL,
	[STATUS] [int] NULL,
	[CULTURE_NAME] [varchar](5) NULL,
	[THEME_NAME] [nvarchar](50) NULL,
	[REMARK] [nvarchar](200) NULL,
	[INSERT_CODE] [int] NULL,
	[INSERT_DATE] [datetime] NULL,
	[UPDATE_CODE] [int] NULL,
	[UPDATE_DATE] [datetime] NULL,
 CONSTRAINT [pk_T_STORE] PRIMARY KEY CLUSTERED 
(
	[STORE_CODE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [uc_T_STORE] UNIQUE NONCLUSTERED 
(
	[COMPANY_CODE] ASC,
	[STORE_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[T_STORE_BUSINESSHOURS]    Script Date: 2016-09-05 오후 6:22:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[T_STORE_BUSINESSHOURS](
	[STORE_CODE] [int] NOT NULL,
	[SCHEDULE_TYPE] [int] NOT NULL,
	[SCHEDULE_TYPE_DTL] [varchar](8) NOT NULL,
	[FR_TIME] [varchar](5) NULL,
	[TO_TIME] [varchar](5) NULL,
	[REMARK] [nvarchar](200) NULL,
	[STATUS] [int] NULL,
	[INSERT_CODE] [int] NULL,
	[INSERT_DATE] [datetime] NULL,
	[UPDATE_CODE] [int] NULL,
	[UPDATE_DATE] [datetime] NULL,
 CONSTRAINT [pk_T_BUSINESSHOURS] PRIMARY KEY CLUSTERED 
(
	[STORE_CODE] ASC,
	[SCHEDULE_TYPE] ASC,
	[SCHEDULE_TYPE_DTL] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[T_STORE_CONTACT]    Script Date: 2016-09-05 오후 6:22:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[T_STORE_CONTACT](
	[IDX] [bigint] IDENTITY(1,1) NOT NULL,
	[STORE_CODE] [int] NULL,
	[REG_DATE] [varchar](16) NULL,
	[NAME] [nvarchar](100) NULL,
	[EMAIL] [nvarchar](100) NULL,
	[PHONE] [nvarchar](100) NULL,
	[TITLE] [nvarchar](200) NULL,
	[CONTENT] [nvarchar](max) NULL,
	[REMARK] [nvarchar](200) NULL,
	[STATUS] [int] NULL,
	[INSERT_CODE] [int] NULL,
	[INSERT_DATE] [datetime] NULL,
	[UPDATE_CODE] [int] NULL,
	[UPDATE_DATE] [datetime] NULL,
 CONSTRAINT [pk_T_STORE_CONTACT] PRIMARY KEY CLUSTERED 
(
	[IDX] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[T_STORE_IMAGE]    Script Date: 2016-09-05 오후 6:22:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_STORE_IMAGE](
	[STORE_CODE] [int] NULL,
	[SERVICE_TYPE] [int] NULL,
	[IMAGE_TYPE] [int] NULL,
	[SEQ] [int] NULL,
	[IMAGE_URL] [nvarchar](200) NULL,
	[DATA1] [nvarchar](200) NULL,
	[DATA2] [nvarchar](200) NULL,
	[DATA3] [nvarchar](max) NULL,
	[REMARK] [nvarchar](200) NULL,
	[HIDE] [bit] NULL,
	[INSERT_CODE] [int] NULL,
	[INSERT_DATE] [datetime] NULL,
	[UPDATE_CODE] [int] NULL,
	[UPDATE_DATE] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[T_STORE_RESERVATION]    Script Date: 2016-09-05 오후 6:22:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[T_STORE_RESERVATION](
	[IDX] [bigint] IDENTITY(1,1) NOT NULL,
	[STORE_CODE] [int] NULL,
	[REG_DATE] [varchar](16) NULL,
	[REQUEST_DATE] [varchar](16) NULL,
	[NAME] [nvarchar](100) NULL,
	[EMAIL] [nvarchar](100) NULL,
	[PHONE] [nvarchar](100) NULL,
	[PEOPLE_NUMBER] [int] NULL,
	[CONTENT] [nvarchar](max) NULL,
	[REMARK] [nvarchar](200) NULL,
	[STATUS] [int] NULL,
	[SALE_CODE] [bigint] NULL,
	[INSERT_CODE] [int] NULL,
	[INSERT_DATE] [datetime] NULL,
	[UPDATE_CODE] [int] NULL,
	[UPDATE_DATE] [datetime] NULL,
 CONSTRAINT [pk_T_STORE_RESERVATION] PRIMARY KEY CLUSTERED 
(
	[IDX] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[T_STORE_WEBMENU]    Script Date: 2016-09-05 오후 6:22:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[T_STORE_WEBMENU](
	[STORE_CODE] [int] NOT NULL,
	[CODE] [int] NOT NULL,
	[MENU_TYPE] [varchar](20) NULL,
	[PARENT_CODE] [int] NULL,
	[LEVEL] [int] NULL,
	[SEQ] [int] NULL,
	[NAME] [nvarchar](200) NULL,
	[FULL_NAME] [nvarchar](200) NULL,
	[MENU_URL] [nvarchar](200) NULL,
	[TEMPLEATE_PAGE] [nvarchar](100) NULL,
	[REMARK] [nvarchar](200) NULL,
	[HIDE] [bit] NULL,
	[INSERT_CODE] [int] NULL,
	[INSERT_DATE] [datetime] NULL,
	[UPDATE_CODE] [int] NULL,
	[UPDATE_DATE] [datetime] NULL,
 CONSTRAINT [pk_T_STORE_WEBMENU] PRIMARY KEY CLUSTERED 
(
	[STORE_CODE] ASC,
	[CODE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  View [dbo].[V_ColumnInfo]    Script Date: 2016-09-05 오후 6:22:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO










/***********************************/
/* 설명 : Decription 정보 가져오기 */
/***********************************/
CREATE VIEW [dbo].[V_ColumnInfo]
AS
SELECT 
    ST.NAME AS TABLE_NAME
   ,ISNULL(SC.COLUMN_ID,'0') AS COLUMN_ID

   ,ISNULL(SC.NAME,'') AS COLUMN_NAME
   ,CONVERT(NVARCHAR(500), SEP.VALUE) [DESCRIPTION]
   , IC.DATA_TYPE + CASE IC.DATA_TYPE  WHEN 'varchar'  THEN '(' + CASE WHEN CHARACTER_MAXIMUM_LENGTH = -1 THEN 'MAX' ELSE CONVERT(VARCHAR(10), CHARACTER_MAXIMUM_LENGTH) END + ')'
                                       WHEN 'nvarchar' THEN '(' + CASE WHEN CHARACTER_MAXIMUM_LENGTH = -1 THEN 'MAX' ELSE CONVERT(VARCHAR(10), CHARACTER_MAXIMUM_LENGTH) END + ')'
									   WHEN 'numeric'  THEN '(' + CONVERT(VARCHAR(10), NUMERIC_PRECISION) +',' + CONVERT(VARCHAR(10), NUMERIC_SCALE) + ')'
									   ELSE '' END AS DATA_TYPE
   ,CASE WHEN IC.IS_NULLABLE = 'YES' THEN 'Y' ELSE 'N' END AS IS_NULLABLE
   ,CASE WHEN TPK.COLUMN_NAME IS NULL THEN 'N' ELSE 'Y' END	IS_PRIMARY
   ,CASE WHEN COLUMNPROPERTY(object_id(ST.NAME),SC.NAME, 'IsIdentity') = 1 THEN 'Y' ELSE 'N' END IS_IDENTITY
FROM SYS.TABLES ST
LEFT JOIN SYS.EXTENDED_PROPERTIES SEP 
  ON ST.OBJECT_ID = SEP.MAJOR_ID
 AND SEP.NAME = 'MS_DESCRIPTION'
LEFT JOIN SYS.COLUMNS SC 
  ON ST.OBJECT_ID = SC.OBJECT_ID
 AND ISNULL(SC.COLUMN_ID, SEP.MINOR_ID)  = SEP.MINOR_ID
LEFT JOIN INFORMATION_SCHEMA.COLUMNS IC
  ON ST.NAME = IC.TABLE_NAME
 AND SC.NAME = IC.COLUMN_NAME

 LEFT JOIN (SELECT TABLE_NAME, COLUMN_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE OBJECTPROPERTY(OBJECT_ID(CONSTRAINT_SCHEMA + '.' + CONSTRAINT_NAME), 'IsPrimaryKey') = 1
) TPK
  ON ST.NAME = TPK.TABLE_NAME AND SC.NAME = TPK.COLUMN_NAME
 WHERE ST.NAME <> 'sysdiagrams'









GO
/****** Object:  View [dbo].[V_NETINFO]    Script Date: 2016-09-05 오후 6:22:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*********************************/
/* 설명 : 네트워크 정보 가져오기 */
/*********************************/
CREATE VIEW [dbo].[V_NETINFO]
AS
SELECT  
   CONVERT(NVARCHAR(2000), CONNECTIONPROPERTY('NET_TRANSPORT')) AS NET_TRANSPORT,
   CONVERT(NVARCHAR(2000), CONNECTIONPROPERTY('PROTOCOL_TYPE')) AS PROTOCOL_TYPE,
   CONVERT(NVARCHAR(2000), CONNECTIONPROPERTY('AUTH_SCHEME')) AS AUTH_SCHEME,
   CONVERT(NVARCHAR(2000), CONNECTIONPROPERTY('LOCAL_NET_ADDRESS')) AS IP_ADDRESS,
   CONVERT(NVARCHAR(2000), CONNECTIONPROPERTY('LOCAL_TCP_PORT')) AS TCP_PORT,
   CONVERT(NVARCHAR(2000), CONNECTIONPROPERTY('CLIENT_NET_ADDRESS')) AS CLIENT_NET_ADDRESS 
   ,DB_NAME() AS DB_NAME



GO
/****** Object:  Index [IDX_T_AD_REQUEST_USER_CODE]    Script Date: 2016-09-05 오후 6:22:36 ******/
CREATE NONCLUSTERED INDEX [IDX_T_AD_REQUEST_USER_CODE] ON [dbo].[T_AD]
(
	[REQUEST_USER_CODE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IDX_T_AD_DEVICE_UTCDATE]    Script Date: 2016-09-05 오후 6:22:36 ******/
CREATE NONCLUSTERED INDEX [IDX_T_AD_DEVICE_UTCDATE] ON [dbo].[T_AD_DEVICE]
(
	[FR_UTC_DATE] ASC,
	[FR_UTC_TIME] ASC,
	[TO_UTC_DATE] ASC,
	[TO_UTC_TIME] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_T_CATEGORY_ORDER_SEQ]    Script Date: 2016-09-05 오후 6:22:36 ******/
CREATE NONCLUSTERED INDEX [IX_T_CATEGORY_ORDER_SEQ] ON [dbo].[T_CATEGORY]
(
	[ORDER_SEQ] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_T_CATEGORY_PARENT_CATEGORY_CODE]    Script Date: 2016-09-05 오후 6:22:36 ******/
CREATE NONCLUSTERED INDEX [IX_T_CATEGORY_PARENT_CATEGORY_CODE] ON [dbo].[T_CATEGORY]
(
	[PARENT_CATEGORY_CODE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_T_CATEGORY_SEARCH]    Script Date: 2016-09-05 오후 6:22:36 ******/
CREATE NONCLUSTERED INDEX [IX_T_CATEGORY_SEARCH] ON [dbo].[T_CATEGORY]
(
	[SEARCH_CATEGORY_CODE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_T_CATEGORY_TYPE]    Script Date: 2016-09-05 오후 6:22:36 ******/
CREATE NONCLUSTERED INDEX [IX_T_CATEGORY_TYPE] ON [dbo].[T_CATEGORY]
(
	[CATEGORY_TYPE2] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IDX_T_COMMON]    Script Date: 2016-09-05 오후 6:22:36 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IDX_T_COMMON] ON [dbo].[T_COMMON]
(
	[MAIN_CODE] ASC,
	[SUB_CODE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IDX_T_ITEM_GROUP]    Script Date: 2016-09-05 오후 6:22:36 ******/
CREATE NONCLUSTERED INDEX [IDX_T_ITEM_GROUP] ON [dbo].[T_ITEM_GROUP]
(
	[STORE_CODE] ASC,
	[GROUP_CODE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [idx_uc_T_KEYWORD]    Script Date: 2016-09-05 오후 6:22:36 ******/
CREATE UNIQUE NONCLUSTERED INDEX [idx_uc_T_KEYWORD] ON [dbo].[T_KEYWORD]
(
	[BASE_CODE] ASC,
	[IS_SYNONYM] ASC,
	[SEQ] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_T_KEYWORD_UNITS_CHOSUNG]    Script Date: 2016-09-05 오후 6:22:36 ******/
CREATE NONCLUSTERED INDEX [IX_T_KEYWORD_UNITS_CHOSUNG] ON [dbo].[T_KEYWORD]
(
	[KEYWORD_UNITS] ASC,
	[CHOSUNG] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IDX_T_LOG_LOGDATE]    Script Date: 2016-09-05 오후 6:22:36 ******/
CREATE NONCLUSTERED INDEX [IDX_T_LOG_LOGDATE] ON [dbo].[T_LOG]
(
	[LOG_DATE] ASC,
	[LOG_TYPE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IDX_T_MEMBER_USER_ID]    Script Date: 2016-09-05 오후 6:22:36 ******/
CREATE NONCLUSTERED INDEX [IDX_T_MEMBER_USER_ID] ON [dbo].[T_MEMBER]
(
	[MEMBER_CODE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IDX_T_SALE_BILLNO]    Script Date: 2016-09-05 오후 6:22:36 ******/
CREATE NONCLUSTERED INDEX [IDX_T_SALE_BILLNO] ON [dbo].[T_SALE]
(
	[BILL_NO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IDX_T_SALE_DISCOUNT_ITEM_CODE]    Script Date: 2016-09-05 오후 6:22:36 ******/
CREATE NONCLUSTERED INDEX [IDX_T_SALE_DISCOUNT_ITEM_CODE] ON [dbo].[T_SALE_DISCOUNT]
(
	[SALE_CODE] ASC,
	[ITEM_SEQ] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IDX_T_SALE_ITEM_CODE]    Script Date: 2016-09-05 오후 6:22:36 ******/
CREATE NONCLUSTERED INDEX [IDX_T_SALE_ITEM_CODE] ON [dbo].[T_SALE_ITEM]
(
	[ITEM_CODE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IDX_T_SALE_ADD_ITEM_SEQ]    Script Date: 2016-09-05 오후 6:22:36 ******/
CREATE NONCLUSTERED INDEX [IDX_T_SALE_ADD_ITEM_SEQ] ON [dbo].[T_SALE_ITEM_ADD]
(
	[SALE_CODE] ASC,
	[ITEM_SEQ] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IDX_T_SALE_ITEM_ADD_ITEMCODE]    Script Date: 2016-09-05 오후 6:22:36 ******/
CREATE NONCLUSTERED INDEX [IDX_T_SALE_ITEM_ADD_ITEMCODE] ON [dbo].[T_SALE_ITEM_ADD]
(
	[ITEM_CODE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IDX_T_SALE_TIP_CUSTOMER_CODE]    Script Date: 2016-09-05 오후 6:22:36 ******/
CREATE NONCLUSTERED INDEX [IDX_T_SALE_TIP_CUSTOMER_CODE] ON [dbo].[T_SALE_TIP]
(
	[CUSTOMER_MEMBER_CODE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IDX_T_SALE_TIP_EMPCODE]    Script Date: 2016-09-05 오후 6:22:36 ******/
CREATE NONCLUSTERED INDEX [IDX_T_SALE_TIP_EMPCODE] ON [dbo].[T_SALE_TIP]
(
	[EMPLOYEE_MEMBER_CODE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IDX_T_SEARCH_KEYWORD_CK_CODE]    Script Date: 2016-09-05 오후 6:22:36 ******/
CREATE NONCLUSTERED INDEX [IDX_T_SEARCH_KEYWORD_CK_CODE] ON [dbo].[T_SEARCH_KEYWORD]
(
	[CK_CODE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IDX_UC_T_SEARCH_KEYWORD]    Script Date: 2016-09-05 오후 6:22:36 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IDX_UC_T_SEARCH_KEYWORD] ON [dbo].[T_SEARCH_KEYWORD]
(
	[AD_CODE] ASC,
	[DEVICE_CODE] ASC,
	[CK_CODE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IDX_T_STORE_CODE]    Script Date: 2016-09-05 오후 6:22:36 ******/
CREATE NONCLUSTERED INDEX [IDX_T_STORE_CODE] ON [dbo].[T_STORE]
(
	[COMPANY_CODE] ASC,
	[STORE_CODE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IDX_T_STORE_IMAGE_STORE_CODE]    Script Date: 2016-09-05 오후 6:22:36 ******/
CREATE NONCLUSTERED INDEX [IDX_T_STORE_IMAGE_STORE_CODE] ON [dbo].[T_STORE]
(
	[STORE_CODE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IDX_T_STORE_CONTACT_SOTRECODE]    Script Date: 2016-09-05 오후 6:22:36 ******/
CREATE NONCLUSTERED INDEX [IDX_T_STORE_CONTACT_SOTRECODE] ON [dbo].[T_STORE_CONTACT]
(
	[STORE_CODE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[T_SALE_COUPON] ADD  CONSTRAINT [DF_T_COUPON_INSERT_CODE]  DEFAULT ('0') FOR [INSERT_CODE]
GO
ALTER TABLE [dbo].[T_SALE_COUPON] ADD  CONSTRAINT [DF_T_COUPON_INSERT_DATE]  DEFAULT (getdate()) FOR [INSERT_DATE]
GO
ALTER TABLE [dbo].[T_SALE_COUPON] ADD  CONSTRAINT [DF_T_COUPON_UPDATE_CODE]  DEFAULT ('0') FOR [UPDATE_CODE]
GO
ALTER TABLE [dbo].[T_SALE_COUPON] ADD  CONSTRAINT [DF_T_COUPON_UPDATE_DATE]  DEFAULT (getdate()) FOR [UPDATE_DATE]
GO
ALTER TABLE [dbo].[T_AD]  WITH CHECK ADD  CONSTRAINT [FK_T_AD_INSERT_CODE] FOREIGN KEY([INSERT_CODE])
REFERENCES [dbo].[T_MEMBER] ([MEMBER_CODE])
GO
ALTER TABLE [dbo].[T_AD] CHECK CONSTRAINT [FK_T_AD_INSERT_CODE]
GO
ALTER TABLE [dbo].[T_AD]  WITH CHECK ADD  CONSTRAINT [FK_T_AD_UPDATE_CODE] FOREIGN KEY([UPDATE_CODE])
REFERENCES [dbo].[T_MEMBER] ([MEMBER_CODE])
GO
ALTER TABLE [dbo].[T_AD] CHECK CONSTRAINT [FK_T_AD_UPDATE_CODE]
GO
ALTER TABLE [dbo].[T_AD_DEVICE]  WITH CHECK ADD  CONSTRAINT [FK_T_AD_DEVICE_INSERT_CODE] FOREIGN KEY([INSERT_CODE])
REFERENCES [dbo].[T_MEMBER] ([MEMBER_CODE])
GO
ALTER TABLE [dbo].[T_AD_DEVICE] CHECK CONSTRAINT [FK_T_AD_DEVICE_INSERT_CODE]
GO
ALTER TABLE [dbo].[T_AD_DEVICE]  WITH CHECK ADD  CONSTRAINT [FK_T_AD_DEVICE_T_AD] FOREIGN KEY([AD_CODE])
REFERENCES [dbo].[T_AD] ([AD_CODE])
GO
ALTER TABLE [dbo].[T_AD_DEVICE] CHECK CONSTRAINT [FK_T_AD_DEVICE_T_AD]
GO
ALTER TABLE [dbo].[T_AD_DEVICE]  WITH CHECK ADD  CONSTRAINT [FK_T_AD_DEVICE_T_DEVICE] FOREIGN KEY([DEVICE_CODE])
REFERENCES [dbo].[T_DEVICE] ([DEVICE_CODE])
GO
ALTER TABLE [dbo].[T_AD_DEVICE] CHECK CONSTRAINT [FK_T_AD_DEVICE_T_DEVICE]
GO
ALTER TABLE [dbo].[T_CATEGORY]  WITH CHECK ADD  CONSTRAINT [FK_T_CATEGORY_INSERT_CODE] FOREIGN KEY([INSERT_CODE])
REFERENCES [dbo].[T_MEMBER] ([MEMBER_CODE])
GO
ALTER TABLE [dbo].[T_CATEGORY] CHECK CONSTRAINT [FK_T_CATEGORY_INSERT_CODE]
GO
ALTER TABLE [dbo].[T_CATEGORY]  WITH CHECK ADD  CONSTRAINT [FK_T_CATEGORY_UPDATE_CODE] FOREIGN KEY([UPDATE_CODE])
REFERENCES [dbo].[T_MEMBER] ([MEMBER_CODE])
GO
ALTER TABLE [dbo].[T_CATEGORY] CHECK CONSTRAINT [FK_T_CATEGORY_UPDATE_CODE]
GO
ALTER TABLE [dbo].[T_CATEGORY_KEYWORD]  WITH CHECK ADD  CONSTRAINT [FK_T_CATEGORY_KEYWORD_CC] FOREIGN KEY([CATEGORY_CODE])
REFERENCES [dbo].[T_CATEGORY] ([CATEGORY_CODE])
GO
ALTER TABLE [dbo].[T_CATEGORY_KEYWORD] CHECK CONSTRAINT [FK_T_CATEGORY_KEYWORD_CC]
GO
ALTER TABLE [dbo].[T_CATEGORY_KEYWORD]  WITH CHECK ADD  CONSTRAINT [FK_T_CATEGORY_KEYWORD_INSERT_CODE] FOREIGN KEY([INSERT_CODE])
REFERENCES [dbo].[T_MEMBER] ([MEMBER_CODE])
GO
ALTER TABLE [dbo].[T_CATEGORY_KEYWORD] CHECK CONSTRAINT [FK_T_CATEGORY_KEYWORD_INSERT_CODE]
GO
ALTER TABLE [dbo].[T_CATEGORY_KEYWORD]  WITH CHECK ADD  CONSTRAINT [FK_T_CATEGORY_KEYWORD_T_KEYWORD] FOREIGN KEY([KEYWORD_CODE])
REFERENCES [dbo].[T_KEYWORD] ([KEYWORD_CODE])
GO
ALTER TABLE [dbo].[T_CATEGORY_KEYWORD] CHECK CONSTRAINT [FK_T_CATEGORY_KEYWORD_T_KEYWORD]
GO
ALTER TABLE [dbo].[T_CATEGORY_KEYWORD]  WITH CHECK ADD  CONSTRAINT [FK_T_CATEGORY_KEYWORD_UPDATE_CODE] FOREIGN KEY([UPDATE_CODE])
REFERENCES [dbo].[T_MEMBER] ([MEMBER_CODE])
GO
ALTER TABLE [dbo].[T_CATEGORY_KEYWORD] CHECK CONSTRAINT [FK_T_CATEGORY_KEYWORD_UPDATE_CODE]
GO
ALTER TABLE [dbo].[T_COMMON]  WITH CHECK ADD  CONSTRAINT [FK_T_COMMON_INSERT_CODE] FOREIGN KEY([INSERT_CODE])
REFERENCES [dbo].[T_MEMBER] ([MEMBER_CODE])
GO
ALTER TABLE [dbo].[T_COMMON] CHECK CONSTRAINT [FK_T_COMMON_INSERT_CODE]
GO
ALTER TABLE [dbo].[T_COMPANY]  WITH CHECK ADD  CONSTRAINT [FK_T_COMPANY_INSERT_CODE] FOREIGN KEY([INSERT_CODE])
REFERENCES [dbo].[T_MEMBER] ([MEMBER_CODE])
GO
ALTER TABLE [dbo].[T_COMPANY] CHECK CONSTRAINT [FK_T_COMPANY_INSERT_CODE]
GO
ALTER TABLE [dbo].[T_COMPANY]  WITH CHECK ADD  CONSTRAINT [FK_T_COMPANY_UPDATE_CODE] FOREIGN KEY([UPDATE_CODE])
REFERENCES [dbo].[T_MEMBER] ([MEMBER_CODE])
GO
ALTER TABLE [dbo].[T_COMPANY] CHECK CONSTRAINT [FK_T_COMPANY_UPDATE_CODE]
GO
ALTER TABLE [dbo].[T_DEVICE]  WITH CHECK ADD  CONSTRAINT [FK_T_DEVICE_INSERT_CODE] FOREIGN KEY([STORE_CODE])
REFERENCES [dbo].[T_STORE] ([STORE_CODE])
GO
ALTER TABLE [dbo].[T_DEVICE] CHECK CONSTRAINT [FK_T_DEVICE_INSERT_CODE]
GO
ALTER TABLE [dbo].[T_DEVICE]  WITH CHECK ADD  CONSTRAINT [FK_T_DEVICE_UPDATE_CODE] FOREIGN KEY([UPDATE_CODE])
REFERENCES [dbo].[T_MEMBER] ([MEMBER_CODE])
GO
ALTER TABLE [dbo].[T_DEVICE] CHECK CONSTRAINT [FK_T_DEVICE_UPDATE_CODE]
GO
ALTER TABLE [dbo].[T_ITEM]  WITH CHECK ADD  CONSTRAINT [FK_T_ITEM_T_ITEM_GROUP] FOREIGN KEY([GROUP_CODE])
REFERENCES [dbo].[T_ITEM_GROUP] ([GROUP_CODE])
GO
ALTER TABLE [dbo].[T_ITEM] CHECK CONSTRAINT [FK_T_ITEM_T_ITEM_GROUP]
GO
ALTER TABLE [dbo].[T_ITEM_GROUP]  WITH CHECK ADD  CONSTRAINT [FK_T_ITEM_GROUP] FOREIGN KEY([STORE_CODE])
REFERENCES [dbo].[T_STORE] ([STORE_CODE])
GO
ALTER TABLE [dbo].[T_ITEM_GROUP] CHECK CONSTRAINT [FK_T_ITEM_GROUP]
GO
ALTER TABLE [dbo].[T_ITEM_GROUP]  WITH CHECK ADD  CONSTRAINT [FK_T_ITEM_GROUP_INSERT_CODE] FOREIGN KEY([INSERT_CODE])
REFERENCES [dbo].[T_MEMBER] ([MEMBER_CODE])
GO
ALTER TABLE [dbo].[T_ITEM_GROUP] CHECK CONSTRAINT [FK_T_ITEM_GROUP_INSERT_CODE]
GO
ALTER TABLE [dbo].[T_ITEM_GROUP]  WITH CHECK ADD  CONSTRAINT [FK_T_ITEM_GROUP_UPDATE_CODE] FOREIGN KEY([UPDATE_CODE])
REFERENCES [dbo].[T_MEMBER] ([MEMBER_CODE])
GO
ALTER TABLE [dbo].[T_ITEM_GROUP] CHECK CONSTRAINT [FK_T_ITEM_GROUP_UPDATE_CODE]
GO
ALTER TABLE [dbo].[T_KEYWORD]  WITH CHECK ADD  CONSTRAINT [FK_T_KEYWORD_INSERT_CODE] FOREIGN KEY([INSERT_CODE])
REFERENCES [dbo].[T_MEMBER] ([MEMBER_CODE])
GO
ALTER TABLE [dbo].[T_KEYWORD] CHECK CONSTRAINT [FK_T_KEYWORD_INSERT_CODE]
GO
ALTER TABLE [dbo].[T_KEYWORD]  WITH CHECK ADD  CONSTRAINT [FK_T_KEYWORD_UPDATE_CODE] FOREIGN KEY([UPDATE_CODE])
REFERENCES [dbo].[T_MEMBER] ([MEMBER_CODE])
GO
ALTER TABLE [dbo].[T_KEYWORD] CHECK CONSTRAINT [FK_T_KEYWORD_UPDATE_CODE]
GO
ALTER TABLE [dbo].[T_LANGUAGE]  WITH CHECK ADD  CONSTRAINT [FK_T_COMMON_UPDATE_CODE] FOREIGN KEY([UPDATE_CODE])
REFERENCES [dbo].[T_MEMBER] ([MEMBER_CODE])
GO
ALTER TABLE [dbo].[T_LANGUAGE] CHECK CONSTRAINT [FK_T_COMMON_UPDATE_CODE]
GO
ALTER TABLE [dbo].[T_LANGUAGE]  WITH CHECK ADD  CONSTRAINT [FK_T_LANGUAGE_INSERT_CODE] FOREIGN KEY([INSERT_CODE])
REFERENCES [dbo].[T_MEMBER] ([MEMBER_CODE])
GO
ALTER TABLE [dbo].[T_LANGUAGE] CHECK CONSTRAINT [FK_T_LANGUAGE_INSERT_CODE]
GO
ALTER TABLE [dbo].[T_LANGUAGE]  WITH CHECK ADD  CONSTRAINT [FK_T_LANGUAGE_UPDATE_CODE] FOREIGN KEY([UPDATE_CODE])
REFERENCES [dbo].[T_MEMBER] ([MEMBER_CODE])
GO
ALTER TABLE [dbo].[T_LANGUAGE] CHECK CONSTRAINT [FK_T_LANGUAGE_UPDATE_CODE]
GO
ALTER TABLE [dbo].[T_SALE]  WITH CHECK ADD  CONSTRAINT [FK_T_SALE_INSERT_CODE] FOREIGN KEY([INSERT_CODE])
REFERENCES [dbo].[T_MEMBER] ([MEMBER_CODE])
GO
ALTER TABLE [dbo].[T_SALE] CHECK CONSTRAINT [FK_T_SALE_INSERT_CODE]
GO
ALTER TABLE [dbo].[T_SALE]  WITH CHECK ADD  CONSTRAINT [FK_T_SALE_STORE] FOREIGN KEY([STORE_CODE])
REFERENCES [dbo].[T_STORE] ([STORE_CODE])
GO
ALTER TABLE [dbo].[T_SALE] CHECK CONSTRAINT [FK_T_SALE_STORE]
GO
ALTER TABLE [dbo].[T_SALE]  WITH CHECK ADD  CONSTRAINT [FK_T_SALE_UPDATE_CODE] FOREIGN KEY([UPDATE_CODE])
REFERENCES [dbo].[T_MEMBER] ([MEMBER_CODE])
GO
ALTER TABLE [dbo].[T_SALE] CHECK CONSTRAINT [FK_T_SALE_UPDATE_CODE]
GO
ALTER TABLE [dbo].[T_SALE_COUPON]  WITH CHECK ADD  CONSTRAINT [FK_T_COUPON_INSERT_CODE] FOREIGN KEY([INSERT_CODE])
REFERENCES [dbo].[T_MEMBER] ([MEMBER_CODE])
GO
ALTER TABLE [dbo].[T_SALE_COUPON] CHECK CONSTRAINT [FK_T_COUPON_INSERT_CODE]
GO
ALTER TABLE [dbo].[T_SALE_COUPON]  WITH CHECK ADD  CONSTRAINT [FK_T_COUPON_MEMBER_CODE] FOREIGN KEY([MEMBER_CODE])
REFERENCES [dbo].[T_MEMBER] ([MEMBER_CODE])
GO
ALTER TABLE [dbo].[T_SALE_COUPON] CHECK CONSTRAINT [FK_T_COUPON_MEMBER_CODE]
GO
ALTER TABLE [dbo].[T_SALE_COUPON]  WITH CHECK ADD  CONSTRAINT [FK_T_COUPON_T_STORE] FOREIGN KEY([STORE_CODE])
REFERENCES [dbo].[T_STORE] ([STORE_CODE])
GO
ALTER TABLE [dbo].[T_SALE_COUPON] CHECK CONSTRAINT [FK_T_COUPON_T_STORE]
GO
ALTER TABLE [dbo].[T_SALE_COUPON]  WITH CHECK ADD  CONSTRAINT [FK_T_COUPON_UPDATE_CODE] FOREIGN KEY([UPDATE_CODE])
REFERENCES [dbo].[T_MEMBER] ([MEMBER_CODE])
GO
ALTER TABLE [dbo].[T_SALE_COUPON] CHECK CONSTRAINT [FK_T_COUPON_UPDATE_CODE]
GO
ALTER TABLE [dbo].[T_SALE_DISCOUNT]  WITH CHECK ADD  CONSTRAINT [FK_T_SALE_DISCOUNT] FOREIGN KEY([SALE_CODE])
REFERENCES [dbo].[T_SALE] ([SALE_CODE])
GO
ALTER TABLE [dbo].[T_SALE_DISCOUNT] CHECK CONSTRAINT [FK_T_SALE_DISCOUNT]
GO
ALTER TABLE [dbo].[T_SALE_DISCOUNT]  WITH CHECK ADD  CONSTRAINT [FK_T_SALE_DISCOUNT_INSERT_CODE] FOREIGN KEY([INSERT_CODE])
REFERENCES [dbo].[T_MEMBER] ([MEMBER_CODE])
GO
ALTER TABLE [dbo].[T_SALE_DISCOUNT] CHECK CONSTRAINT [FK_T_SALE_DISCOUNT_INSERT_CODE]
GO
ALTER TABLE [dbo].[T_SALE_DISCOUNT]  WITH CHECK ADD  CONSTRAINT [FK_T_SALE_DISCOUNT_UPDATE_CODE] FOREIGN KEY([UPDATE_CODE])
REFERENCES [dbo].[T_MEMBER] ([MEMBER_CODE])
GO
ALTER TABLE [dbo].[T_SALE_DISCOUNT] CHECK CONSTRAINT [FK_T_SALE_DISCOUNT_UPDATE_CODE]
GO
ALTER TABLE [dbo].[T_SALE_ITEM]  WITH CHECK ADD  CONSTRAINT [FK_T_SALE_ITEM] FOREIGN KEY([SALE_CODE])
REFERENCES [dbo].[T_SALE] ([SALE_CODE])
GO
ALTER TABLE [dbo].[T_SALE_ITEM] CHECK CONSTRAINT [FK_T_SALE_ITEM]
GO
ALTER TABLE [dbo].[T_SALE_ITEM]  WITH CHECK ADD  CONSTRAINT [FK_T_SALE_ITEM_INSERT_CODE] FOREIGN KEY([INSERT_CODE])
REFERENCES [dbo].[T_MEMBER] ([MEMBER_CODE])
GO
ALTER TABLE [dbo].[T_SALE_ITEM] CHECK CONSTRAINT [FK_T_SALE_ITEM_INSERT_CODE]
GO
ALTER TABLE [dbo].[T_SALE_ITEM]  WITH CHECK ADD  CONSTRAINT [FK_T_SALE_ITEM_UPDATE_CODE] FOREIGN KEY([UPDATE_CODE])
REFERENCES [dbo].[T_MEMBER] ([MEMBER_CODE])
GO
ALTER TABLE [dbo].[T_SALE_ITEM] CHECK CONSTRAINT [FK_T_SALE_ITEM_UPDATE_CODE]
GO
ALTER TABLE [dbo].[T_SALE_ITEM_ADD]  WITH CHECK ADD  CONSTRAINT [FK_T_SALE_ITEM_ADD] FOREIGN KEY([SALE_CODE], [ITEM_SEQ])
REFERENCES [dbo].[T_SALE_ITEM] ([SALE_CODE], [ITEM_SEQ])
GO
ALTER TABLE [dbo].[T_SALE_ITEM_ADD] CHECK CONSTRAINT [FK_T_SALE_ITEM_ADD]
GO
ALTER TABLE [dbo].[T_SALE_ITEM_ADD]  WITH CHECK ADD  CONSTRAINT [FK_T_SALE_ITEM_ADD_INSERT_CODE] FOREIGN KEY([INSERT_CODE])
REFERENCES [dbo].[T_MEMBER] ([MEMBER_CODE])
GO
ALTER TABLE [dbo].[T_SALE_ITEM_ADD] CHECK CONSTRAINT [FK_T_SALE_ITEM_ADD_INSERT_CODE]
GO
ALTER TABLE [dbo].[T_SALE_ITEM_ADD]  WITH CHECK ADD  CONSTRAINT [FK_T_SALE_ITEM_ADD_UPDATE_CODE] FOREIGN KEY([UPDATE_CODE])
REFERENCES [dbo].[T_MEMBER] ([MEMBER_CODE])
GO
ALTER TABLE [dbo].[T_SALE_ITEM_ADD] CHECK CONSTRAINT [FK_T_SALE_ITEM_ADD_UPDATE_CODE]
GO
ALTER TABLE [dbo].[T_SALE_TIP]  WITH CHECK ADD  CONSTRAINT [FK_T_SALE_TIP_INSERT_CODE] FOREIGN KEY([INSERT_CODE])
REFERENCES [dbo].[T_MEMBER] ([MEMBER_CODE])
GO
ALTER TABLE [dbo].[T_SALE_TIP] CHECK CONSTRAINT [FK_T_SALE_TIP_INSERT_CODE]
GO
ALTER TABLE [dbo].[T_SALE_TIP]  WITH CHECK ADD  CONSTRAINT [FK_T_SALE_TIP_SALENO] FOREIGN KEY([SALE_CODE])
REFERENCES [dbo].[T_SALE] ([SALE_CODE])
GO
ALTER TABLE [dbo].[T_SALE_TIP] CHECK CONSTRAINT [FK_T_SALE_TIP_SALENO]
GO
ALTER TABLE [dbo].[T_SALE_TIP]  WITH CHECK ADD  CONSTRAINT [FK_T_SALE_TIP_UPDATE_CODE] FOREIGN KEY([UPDATE_CODE])
REFERENCES [dbo].[T_MEMBER] ([MEMBER_CODE])
GO
ALTER TABLE [dbo].[T_SALE_TIP] CHECK CONSTRAINT [FK_T_SALE_TIP_UPDATE_CODE]
GO
ALTER TABLE [dbo].[T_SEARCH_KEYWORD]  WITH CHECK ADD  CONSTRAINT [FK_T_SEARCH_KEYWORD_AD_CODE] FOREIGN KEY([AD_CODE])
REFERENCES [dbo].[T_AD] ([AD_CODE])
GO
ALTER TABLE [dbo].[T_SEARCH_KEYWORD] CHECK CONSTRAINT [FK_T_SEARCH_KEYWORD_AD_CODE]
GO
ALTER TABLE [dbo].[T_SEARCH_KEYWORD]  WITH CHECK ADD  CONSTRAINT [FK_T_SEARCH_KEYWORD_CK_CODE] FOREIGN KEY([CK_CODE])
REFERENCES [dbo].[T_CATEGORY_KEYWORD] ([CK_CODE])
GO
ALTER TABLE [dbo].[T_SEARCH_KEYWORD] CHECK CONSTRAINT [FK_T_SEARCH_KEYWORD_CK_CODE]
GO
ALTER TABLE [dbo].[T_SEARCH_KEYWORD]  WITH CHECK ADD  CONSTRAINT [FK_T_SEARCH_KEYWORD_DEVICE_CODE] FOREIGN KEY([DEVICE_CODE])
REFERENCES [dbo].[T_DEVICE] ([DEVICE_CODE])
GO
ALTER TABLE [dbo].[T_SEARCH_KEYWORD] CHECK CONSTRAINT [FK_T_SEARCH_KEYWORD_DEVICE_CODE]
GO
ALTER TABLE [dbo].[T_SEARCH_KEYWORD]  WITH CHECK ADD  CONSTRAINT [FK_T_SEARCH_KEYWORD_INSERT_CODE] FOREIGN KEY([INSERT_CODE])
REFERENCES [dbo].[T_MEMBER] ([MEMBER_CODE])
GO
ALTER TABLE [dbo].[T_SEARCH_KEYWORD] CHECK CONSTRAINT [FK_T_SEARCH_KEYWORD_INSERT_CODE]
GO
ALTER TABLE [dbo].[T_SEARCH_KEYWORD]  WITH CHECK ADD  CONSTRAINT [FK_T_SEARCH_KEYWORD_UPDATE_CODE] FOREIGN KEY([UPDATE_CODE])
REFERENCES [dbo].[T_MEMBER] ([MEMBER_CODE])
GO
ALTER TABLE [dbo].[T_SEARCH_KEYWORD] CHECK CONSTRAINT [FK_T_SEARCH_KEYWORD_UPDATE_CODE]
GO
ALTER TABLE [dbo].[T_STORE]  WITH CHECK ADD  CONSTRAINT [FK_T_STORE] FOREIGN KEY([COMPANY_CODE])
REFERENCES [dbo].[T_COMPANY] ([COMPANY_CODE])
GO
ALTER TABLE [dbo].[T_STORE] CHECK CONSTRAINT [FK_T_STORE]
GO
ALTER TABLE [dbo].[T_STORE]  WITH CHECK ADD  CONSTRAINT [FK_T_STORE_INSERT_CODE] FOREIGN KEY([INSERT_CODE])
REFERENCES [dbo].[T_MEMBER] ([MEMBER_CODE])
GO
ALTER TABLE [dbo].[T_STORE] CHECK CONSTRAINT [FK_T_STORE_INSERT_CODE]
GO
ALTER TABLE [dbo].[T_STORE]  WITH CHECK ADD  CONSTRAINT [FK_T_STORE_UPDATE_CODE] FOREIGN KEY([UPDATE_CODE])
REFERENCES [dbo].[T_MEMBER] ([MEMBER_CODE])
GO
ALTER TABLE [dbo].[T_STORE] CHECK CONSTRAINT [FK_T_STORE_UPDATE_CODE]
GO
ALTER TABLE [dbo].[T_STORE_BUSINESSHOURS]  WITH CHECK ADD  CONSTRAINT [FK_T_BUSINESSHOURS] FOREIGN KEY([STORE_CODE])
REFERENCES [dbo].[T_STORE] ([STORE_CODE])
GO
ALTER TABLE [dbo].[T_STORE_BUSINESSHOURS] CHECK CONSTRAINT [FK_T_BUSINESSHOURS]
GO
ALTER TABLE [dbo].[T_STORE_BUSINESSHOURS]  WITH CHECK ADD  CONSTRAINT [FK_T_BUSINESSHOURS_INSERT_CODE] FOREIGN KEY([INSERT_CODE])
REFERENCES [dbo].[T_MEMBER] ([MEMBER_CODE])
GO
ALTER TABLE [dbo].[T_STORE_BUSINESSHOURS] CHECK CONSTRAINT [FK_T_BUSINESSHOURS_INSERT_CODE]
GO
ALTER TABLE [dbo].[T_STORE_BUSINESSHOURS]  WITH CHECK ADD  CONSTRAINT [FK_T_BUSINESSHOURS_UPDATE_CODE] FOREIGN KEY([UPDATE_CODE])
REFERENCES [dbo].[T_MEMBER] ([MEMBER_CODE])
GO
ALTER TABLE [dbo].[T_STORE_BUSINESSHOURS] CHECK CONSTRAINT [FK_T_BUSINESSHOURS_UPDATE_CODE]
GO
ALTER TABLE [dbo].[T_STORE_CONTACT]  WITH CHECK ADD  CONSTRAINT [FK_T_STORE_CONTACT_INSERT_CODE] FOREIGN KEY([INSERT_CODE])
REFERENCES [dbo].[T_MEMBER] ([MEMBER_CODE])
GO
ALTER TABLE [dbo].[T_STORE_CONTACT] CHECK CONSTRAINT [FK_T_STORE_CONTACT_INSERT_CODE]
GO
ALTER TABLE [dbo].[T_STORE_CONTACT]  WITH CHECK ADD  CONSTRAINT [FK_T_STORE_CONTACT_STORECODE] FOREIGN KEY([STORE_CODE])
REFERENCES [dbo].[T_STORE] ([STORE_CODE])
GO
ALTER TABLE [dbo].[T_STORE_CONTACT] CHECK CONSTRAINT [FK_T_STORE_CONTACT_STORECODE]
GO
ALTER TABLE [dbo].[T_STORE_CONTACT]  WITH CHECK ADD  CONSTRAINT [FK_T_STORE_CONTACT_UPDATE_CODE] FOREIGN KEY([UPDATE_CODE])
REFERENCES [dbo].[T_MEMBER] ([MEMBER_CODE])
GO
ALTER TABLE [dbo].[T_STORE_CONTACT] CHECK CONSTRAINT [FK_T_STORE_CONTACT_UPDATE_CODE]
GO
ALTER TABLE [dbo].[T_STORE_IMAGE]  WITH CHECK ADD  CONSTRAINT [FK_FK_T_STORE_IMAGE_INSERT_CODE] FOREIGN KEY([INSERT_CODE])
REFERENCES [dbo].[T_MEMBER] ([MEMBER_CODE])
GO
ALTER TABLE [dbo].[T_STORE_IMAGE] CHECK CONSTRAINT [FK_FK_T_STORE_IMAGE_INSERT_CODE]
GO
ALTER TABLE [dbo].[T_STORE_IMAGE]  WITH CHECK ADD  CONSTRAINT [FK_FK_T_STORE_IMAGE_UPDATE_CODE] FOREIGN KEY([UPDATE_CODE])
REFERENCES [dbo].[T_MEMBER] ([MEMBER_CODE])
GO
ALTER TABLE [dbo].[T_STORE_IMAGE] CHECK CONSTRAINT [FK_FK_T_STORE_IMAGE_UPDATE_CODE]
GO
ALTER TABLE [dbo].[T_STORE_IMAGE]  WITH CHECK ADD  CONSTRAINT [FK_T_STORE_IMAGE] FOREIGN KEY([STORE_CODE])
REFERENCES [dbo].[T_STORE] ([STORE_CODE])
GO
ALTER TABLE [dbo].[T_STORE_IMAGE] CHECK CONSTRAINT [FK_T_STORE_IMAGE]
GO
ALTER TABLE [dbo].[T_STORE_RESERVATION]  WITH CHECK ADD  CONSTRAINT [FK_T_STORE_CONTACTSTORE_CODE] FOREIGN KEY([STORE_CODE])
REFERENCES [dbo].[T_STORE] ([STORE_CODE])
GO
ALTER TABLE [dbo].[T_STORE_RESERVATION] CHECK CONSTRAINT [FK_T_STORE_CONTACTSTORE_CODE]
GO
ALTER TABLE [dbo].[T_STORE_RESERVATION]  WITH CHECK ADD  CONSTRAINT [FK_T_STORE_RESERVATION_INSERT_CODE] FOREIGN KEY([INSERT_CODE])
REFERENCES [dbo].[T_MEMBER] ([MEMBER_CODE])
GO
ALTER TABLE [dbo].[T_STORE_RESERVATION] CHECK CONSTRAINT [FK_T_STORE_RESERVATION_INSERT_CODE]
GO
ALTER TABLE [dbo].[T_STORE_RESERVATION]  WITH CHECK ADD  CONSTRAINT [FK_T_STORE_RESERVATION_STORE_CODE] FOREIGN KEY([STORE_CODE])
REFERENCES [dbo].[T_STORE] ([STORE_CODE])
GO
ALTER TABLE [dbo].[T_STORE_RESERVATION] CHECK CONSTRAINT [FK_T_STORE_RESERVATION_STORE_CODE]
GO
ALTER TABLE [dbo].[T_STORE_RESERVATION]  WITH CHECK ADD  CONSTRAINT [FK_T_STORE_RESERVATION_T_SALE] FOREIGN KEY([SALE_CODE])
REFERENCES [dbo].[T_SALE] ([SALE_CODE])
GO
ALTER TABLE [dbo].[T_STORE_RESERVATION] CHECK CONSTRAINT [FK_T_STORE_RESERVATION_T_SALE]
GO
ALTER TABLE [dbo].[T_STORE_RESERVATION]  WITH CHECK ADD  CONSTRAINT [FK_T_STORE_RESERVATION_UPDATE_CODE] FOREIGN KEY([UPDATE_CODE])
REFERENCES [dbo].[T_MEMBER] ([MEMBER_CODE])
GO
ALTER TABLE [dbo].[T_STORE_RESERVATION] CHECK CONSTRAINT [FK_T_STORE_RESERVATION_UPDATE_CODE]
GO
ALTER TABLE [dbo].[T_STORE_WEBMENU]  WITH CHECK ADD  CONSTRAINT [FK_T_STORE_WEBMENU] FOREIGN KEY([STORE_CODE])
REFERENCES [dbo].[T_STORE] ([STORE_CODE])
GO
ALTER TABLE [dbo].[T_STORE_WEBMENU] CHECK CONSTRAINT [FK_T_STORE_WEBMENU]
GO
ALTER TABLE [dbo].[T_STORE_WEBMENU]  WITH CHECK ADD  CONSTRAINT [FK_T_STORE_WEBMENU_INSERT_CODE] FOREIGN KEY([INSERT_CODE])
REFERENCES [dbo].[T_MEMBER] ([MEMBER_CODE])
GO
ALTER TABLE [dbo].[T_STORE_WEBMENU] CHECK CONSTRAINT [FK_T_STORE_WEBMENU_INSERT_CODE]
GO
ALTER TABLE [dbo].[T_STORE_WEBMENU]  WITH CHECK ADD  CONSTRAINT [FK_T_STORE_WEBMENU_UPDATE_CODE] FOREIGN KEY([UPDATE_CODE])
REFERENCES [dbo].[T_MEMBER] ([MEMBER_CODE])
GO
ALTER TABLE [dbo].[T_STORE_WEBMENU] CHECK CONSTRAINT [FK_T_STORE_WEBMENU_UPDATE_CODE]
GO
/****** Object:  StoredProcedure [dbo].[SP_ADD_COMMENT]    Script Date: 2016-09-05 오후 6:22:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/***********************/
/* 설명 추가 프로시저  */
/* 작성자 : 전상훈     */
/* 작성일 : 2015.04.16 */
/***********************/
CREATE PROC [dbo].[SP_ADD_COMMENT]
(
    @TABLE_NAME   NVARCHAR(50)
    ,@COMMENT     NVARCHAR(500)
    ,@COLUMN_NAME NVARCHAR(100) = NULL/*Null 일경우 테이블, 값이 있을 경우 해당 칼럼에 설명 추가*/
)
AS 
BEGIN
    IF @COLUMN_NAME IS NULL /*테이블 설명 추가*/
    BEGIN
        IF NOT EXISTS (SELECT * FROM SYS.EXTENDED_PROPERTIES WHERE [MAJOR_ID] = OBJECT_ID(@TABLE_NAME) AND [NAME] = N'MS_DESCRIPTION' and minor_id = '0') 
        BEGIN
            EXEC   SP_ADDEXTENDEDPROPERTY 'MS_DESCRIPTION', @COMMENT, 'USER', DBO, 'TABLE', @TABLE_NAME
        END
        ELSE EXEC   SP_UPDATEEXTENDEDPROPERTY  'MS_DESCRIPTION', @COMMENT, 'USER', DBO, 'TABLE', @TABLE_NAME
    END
    ELSE /*칼럼 설명추가*/
    BEGIN
        IF NOT EXISTS (SELECT NULL FROM SYS.EXTENDED_PROPERTIES 
                        WHERE [MAJOR_ID] = OBJECT_ID(@TABLE_NAME) AND [NAME] = N'MS_DESCRIPTION' 
                          AND [MINOR_ID] = (SELECT [COLUMN_ID] 
                                             FROM SYS.COLUMNS WHERE [NAME] = @COLUMN_NAME AND [OBJECT_ID] = OBJECT_ID(@TABLE_NAME)))
        BEGIN
             EXEC   SP_ADDEXTENDEDPROPERTY 'MS_DESCRIPTION', @COMMENT, 'USER', DBO, 'TABLE', @TABLE_NAME, 'COLUMN', @COLUMN_NAME
        END
        ELSE
            EXEC   SP_UPDATEEXTENDEDPROPERTY 'MS_DESCRIPTION', @COMMENT, 'USER', DBO, 'TABLE', @TABLE_NAME, 'COLUMN', @COLUMN_NAME
        
    END
END


GO
/****** Object:  StoredProcedure [dbo].[SP_ADD_Default]    Script Date: 2016-09-05 오후 6:22:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/***************************/
/* 기본값 추가 프로시저    */
/* 작  성  자 : 전상훈     */
/* 작  성  일 : 2015.03.11 */
/* 최종수정일 : 2015.05.11 */
/***************************/
CREATE PROCEDURE [dbo].[SP_ADD_Default](
                                    @TABLE_NAME VARCHAR(50)    /*테이블명*/
                                  , @COLUMN_NAME NVARCHAR(50)  /*칼럼명*/
								  , @DEFAULT_VALUE NVARCHAR(50)/*Default 값*/
     
    
)
AS
BEGIN
	    DECLARE @PRE_DEVAULT_NAME NVARCHAR(400), @SQL_DESC NVARCHAR(MAX)
		SELECT
			@PRE_DEVAULT_NAME = default_constraints.name
		FROM sys.all_columns
       INNER JOIN sys.tables
		  ON all_columns.object_id = tables.object_id
       INNER JOIN sys.schemas
	      ON tables.schema_id = schemas.schema_id
       INNER JOIN sys.default_constraints
		  ON all_columns.default_object_id = default_constraints.object_id
       WHERE 1=1
			   -- schemas.name = 'dbo'
			AND tables.name =  @TABLE_NAME
			AND all_columns.name = @COLUMN_NAME

      IF ISNULL(@PRE_DEVAULT_NAME,'') <> ''
	  BEGIN
	       SET @SQL_DESC = 'ALTER TABLE ' + @TABLE_NAME + ' DROP CONSTRAINT ' + @PRE_DEVAULT_NAME
		   EXEC (@SQL_DESC)
	  END

	  IF UPPER(@DEFAULT_VALUE) LIKE '%DATE()'
	  BEGIN
		SET @SQL_DESC = 'ALTER TABLE ' + @TABLE_NAME + ' ADD CONSTRAINT DF_' + @TABLE_NAME +'_' + @COLUMN_NAME + ' default ' + @DEFAULT_VALUE + ' FOR '  + @COLUMN_NAME
	  END
	  ELSE
	  BEGIN
		SET @SQL_DESC = 'ALTER TABLE ' + @TABLE_NAME + ' ADD CONSTRAINT DF_' + @TABLE_NAME +'_' + @COLUMN_NAME + ' default ''' + @DEFAULT_VALUE + ''' FOR '  + @COLUMN_NAME
	  END
	  
	  EXEC (@SQL_DESC)
END




GO
/****** Object:  StoredProcedure [dbo].[SP_ADD_FK]    Script Date: 2016-09-05 오후 6:22:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*****************************/
/* Forean Key 추가 프로시저  */
/* 작성자 : 전상훈           */
/* 작성일 : 2016.07.06       */
/*****************************/
CREATE PROC [dbo].[SP_ADD_FK]
(
    @TABLE_NAME             NVARCHAR(50)
    ,@TARGET_TABLE_NAME     NVARCHAR(50)
    ,@COLUMN_NAME           NVARCHAR(100) 
	,@TARGET_COLUMN         NVARCHAR(100) = NULL
)
AS 
BEGIN
    IF @TARGET_COLUMN IS NULL SET @TARGET_COLUMN = @COLUMN_NAME

    DECLARE @SQL_DESC NVARCHAR(MAX)
	SET @SQL_DESC = 'IF OBJECT_ID(''FK_' + @TABLE_NAME + '_' + @COLUMN_NAME + ''') IS NULL
					BEGIN
						ALTER TABLE T_AD  
						ADD CONSTRAINT FK_' + @TABLE_NAME + '_' + @COLUMN_NAME + ''' FOREIGN KEY (' + @COLUMN_NAME + ')  
						REFERENCES ' + @TARGET_TABLE_NAME + '(' + @TARGET_COLUMN + ')
					END'
   EXEC @SQL_DESC
END
GO
/****** Object:  StoredProcedure [dbo].[SP_SET_TABLE_COMMENT]    Script Date: 2016-09-05 오후 6:22:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_SET_TABLE_COMMENT]
(
 @SET_TYPE CHAR(1), --// 추가(I)/수정(U) 구분
 @SET_TABLE VARCHAR(50), --// 테이블명
 @SET_COLUMN VARCHAR(50), --// 컬럼명(없을경우 테이블 COMMENT)
 @SET_COMMENT NVARCHAR(1000) --// 등록할 COMMENT
)
AS
BEGIN
IF @SET_TYPE = 'I' --// 신규추가용
 BEGIN
  IF @SET_COLUMN = '' --// 컬럼명이 없을경우(테이블 COMMENT)
   EXEC sp_addextendedproperty 'MS_Description', @SET_COMMENT, 'SCHEMA', 'penpalon', 'TABLE', @SET_TABLE
  ELSE
   EXEC sp_addextendedproperty 'MS_Description', @SET_COMMENT, 'SCHEMA', 'penpalon', 'TABLE', @SET_TABLE, 'COLUMN', @SET_COLUMN
 END
 
 IF @SET_TYPE = 'U' --// 업데이트용
 BEGIN
  IF @SET_COLUMN = ''
   EXEC sp_updateextendedproperty 'MS_Description', @SET_COMMENT, 'SCHEMA', 'penpalon', 'TABLE', @SET_TABLE
  ELSE
   EXEC sp_updateextendedproperty 'MS_Description', @SET_COMMENT, 'SCHEMA', 'penpalon', 'TABLE', @SET_TABLE, 'COLUMN', @SET_COLUMN
 END
END

GO
/****** Object:  StoredProcedure [dbo].[SP_TableDescHtml]    Script Date: 2016-09-05 오후 6:22:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/***************************/
/* 테이블 명세서 프로시저  */
/* 작  성  자 : 전상훈     */
/* 작  성  일 : 2014.10.11 */
/* 최종수정일 : 2014.10.11 */
/***************************/
CREATE PROC [dbo].[SP_TableDescHtml]
AS
BEGIN
--exec [dbo].[sp_TableDescHtml]
Declare @i Int, @maxi Int
Declare @j Int, @maxj Int
Declare @sr int
Declare @Output nvarchar(4000)
--Declare @tmpOutput nvarchar(max)
Declare @SqlVersion nvarchar(5)
Declare @last nvarchar(155), @current nvarchar(255), @typ nvarchar(255), @description nvarchar(4000)

create Table #Tables  (id int identity(1, 1), Object_id int, Name nvarchar(155), Type nvarchar(20), [description] nvarchar(4000))
create Table #Columns (id int identity(1,1), Name nvarchar(155), Type nvarchar(155), Nullable nvarchar(2), [description] nvarchar(4000))
create Table #Fk(id int identity(1,1), Name nvarchar(155), col nvarchar(155), refObj nvarchar(155), refCol nvarchar(155))
create Table #Constraint(id int identity(1,1), Name nvarchar(155), col nvarchar(155), definition nvarchar(1000))
create Table #Indexes(id int identity(1,1), Name nvarchar(155), Type nvarchar(25), cols nvarchar(1000))

 If (substring(@@VERSION, 1, 25 ) = 'Microsoft SQL Server 2008')
   set @SqlVersion = '2008'
else if (substring(@@VERSION, 1, 26 ) = 'Microsoft SQL Server  2000')
   set @SqlVersion = '2000'
else 
   set @SqlVersion = '2008'

Print '<html>'
Print '<head>'
Print '<title>::' + DB_name() + '::</title>'
Print '<style>'
Print '      H2 {page-break-before: always}'
Print '      P.breakhere {page-break-before: always} '
Print '      body {'
Print '      font-family:verdana;'
Print '      font-size:9pt;'
Print '      }'
      
Print '      td {'
Print '      font-family:verdana;'
Print '      font-size:9pt;'
Print '      }'
      
Print '      th {'
Print '      font-family:verdana;'
Print '      font-size:9pt;'
Print '      background:#d3d3d3;'
Print '      }'
Print '      table'
Print '      {'
Print '      width:750px;'
Print '      background:#d3d3d3;'
Print '      }'
Print '      tr'
Print '      {'
Print '      background:#ffffff;'
Print '      }'
Print '   </style>'
Print '</head>'
Print '<body>'

set nocount on
   if @SqlVersion = '2000' 
      begin
      insert into #Tables (Object_id, Name, Type, [description])
         --FOR 2000
         select  object_id(table_name),  '[' + table_schema + '].[' + table_name + ']',  
         case when table_type = 'BASE TABLE'  then 'Table'   else 'View' end,
         cast(p.value as nvarchar(4000))
         from information_schema.tables t
         left outer join sysproperties p on p.id = object_id(t.table_name) and smallid = 0 and p.name = 'MS_Description' 
        
		 order by table_type, table_schema, table_name
      end
   else if @SqlVersion = '2008' 
      begin
      insert into #Tables (Object_id, Name, Type, [description])
      --FOR 2008
      Select  o.object_id,  '[' + s.name + '].[' + o.name + ']', 
            case when type = 'V' then 'View' when type = 'U' then 'Table' end,  
            cast(p.value as nvarchar(4000))
            from sys.objects o 
               left outer join sys.schemas s on s.schema_id = o.schema_id 
               left outer join sys.extended_properties p on p.major_id = o.object_id and minor_id = 0 and p.name = 'MS_Description' 
            where type in ('U', 'V') and o.NAME NOT LIKE '%sysdiagrams%'
			  AND NOT (o.NAME  LIKE '%V_COLUMNINFO%' or o.NAME  LIKE '%V_NETINFO%')
            order by type, s.name, o.name
      end
Set @maxi = @@rowcount
set @i = 1



print N'<table border="0" cellspacing="0" cellpadding="0" width="550px" align="center"><tr><td colspan="3" style="height:50;font-size:14pt;text-align:center;"><a name="index"></a><b>테이블명세서</b></td></tr></table>'
print '<table border="0" cellspacing="1" cellpadding="0" width="550px" align="center"><tr><th>Sr</th><th>Object</th><th>Type</th></tr>' 
While(@i <= @maxi)
begin
   select @Output =  '<tr><td align="center">' + Cast((@i) as nvarchar) + '</td><td><a href="#' + Type + ':' + name + '">' + name + '</a></td><td>' + Type + '</td></tr>' 
         from #Tables where id = @i
   
   print @Output
   set @i = @i + 1
end
print '</table><br />'

set @i = 1
While(@i <= @maxi)
begin
   --table header
   print '<P CLASS="breakhere">'
   select @Output =  '<tr><th align="left"><a name="' + Type + ':' + name + '"></a><b>' + Type + ':' + name + '</b></th></tr>',  @description = [description]
         from #Tables where id = @i
   
   print '<br /><br /><br /><table border="0" cellspacing="0" cellpadding="0" width="750px" align="center"><tr><td align="right"><a href="#index">Index</a></td></tr>'
   print @Output
   print '</table><br />'
   print '<table border="0" cellspacing="0" cellpadding="0" width="750px" align="center"><tr><td><b>Description</b></td></tr><tr><td>' + isnull(@description, '') + '</td></tr></table><br />' 

   --table columns
   truncate table #Columns 
   if @SqlVersion = '2000' 
      begin
      insert into #Columns  (Name, Type, Nullable, [description])
      --FOR 2000
      Select c.name, 
               type_name(xtype) + (
               case when (type_name(xtype) = 'varchar' or type_name(xtype) = 'nvarchar' or type_name(xtype) ='char' or type_name(xtype) ='nchar')
                  then '(' + cast(length as nvarchar) + ')' 
                when type_name(xtype) = 'decimal' OR type_name(xtype) = 'numeric'   
                     then '(' + cast(prec as nvarchar) + ',' + cast(scale as nvarchar)   + ')' 
               else ''
               end            
               ), 
               case when isnullable = 1 then 'Y' else 'N'  end, 
               cast(p.value as nvarchar(8000))
            from syscolumns c
               inner join #Tables t on t.object_id = c.id
               left outer join sysproperties p on p.id = c.id and p.smallid = c.colid and p.name = 'MS_Description' 
            where t.id = @i
            order by c.colorder
      end
   else if @SqlVersion = '2008' 
      begin
      insert into #Columns  (Name, Type, Nullable, [description])
      --FOR 2008   
      Select c.name, 
               type_name(user_type_id) + (
               case when (type_name(user_type_id) = 'varchar'  or type_name(user_type_id) ='char' )
                    then '(' + cast(max_length as nvarchar) + ')' 
				    when ( type_name(user_type_id) = 'nvarchar' or  type_name(user_type_id) ='nchar')
                    then '(' + cast((max_length/2) as nvarchar) + ')' 
                when type_name(user_type_id) = 'decimal'   OR type_name(user_type_id) = 'numeric' 
                     then '(' + cast([precision] as nvarchar) + ',' + cast(scale as nvarchar)   + ')' 
               else ''
               end            
               ), 
               case when is_nullable = 1 then 'Y' else 'N'  end,
               cast(p.value as nvarchar(4000))
      from sys.columns c
            inner join #Tables t on t.object_id = c.object_id
            left outer join sys.extended_properties p on p.major_id = c.object_id and p.minor_id  = c.column_id and p.name = 'MS_Description' 
      where t.id = @i
      order by c.column_id
      end
   Set @maxj =   @@rowcount
   set @j = 1

   print '<table border="0" cellspacing="0" cellpadding="0" width="750px" align="center"><tr><td><b>Table Columns</b></td></tr></table>' 
   print '<table border="0" cellspacing="1" cellpadding="0" width="750px" align="center"><tr><th>Sr.</th><th>Name</th><th>Datatype</th><th>Nullable</th><th>Description</th></tr>' 
   
   While(@j <= @maxj)
   begin
      select @Output = '<tr><td width="20px" align="center">' + Cast((@j) as nvarchar) + '</td><td width="150px">' + isnull(name,'')  + '</td><td width="150px">' +  upper(isnull(Type,'')) + '</td><td width="50px" align="center">' + isnull(Nullable,'N') + '</td><td>' + isnull([description],'') + '</td></tr>' 
         from #Columns  where id = @j
      
      print    @Output    
      Set @j = @j + 1;
   end

   print '</table><br />'

   --reference key
   truncate table #FK
   if @SqlVersion = '2000' 
      begin
      insert into #FK  (Name, col, refObj, refCol)
   --      FOR 2000
      select object_name(constid), s.name,  object_name(rkeyid) ,  s1.name  
            from sysforeignkeys f
               inner join sysobjects o on o.id = f.constid
               inner join syscolumns s on s.id = f.fkeyid and s.colorder = f.fkey
               inner join syscolumns s1 on s1.id = f.rkeyid and s1.colorder = f.rkey
               inner join #Tables t on t.object_id = f.fkeyid
            where t.id = @i
            order by 1
      end   
   else if @SqlVersion = '2008' 
      begin
      insert into #FK  (Name, col, refObj, refCol)
--      FOR 2008
      select f.name, COL_NAME (fc.parent_object_id, fc.parent_column_id) , object_name(fc.referenced_object_id) , COL_NAME (fc.referenced_object_id, fc.referenced_column_id)     
      from sys.foreign_keys f
         inner  join  sys.foreign_key_columns  fc  on f.object_id = fc.constraint_object_id   
         inner join #Tables t on t.object_id = f.parent_object_id
      where t.id = @i
      order by f.name
      end
   
   Set @maxj =   @@rowcount
   set @j = 1
   if (@maxj >0)
   begin

      print '<table border="0" cellspacing="0" cellpadding="0" width="750px" align="center"><tr><td><b>Refrence Keys</b></td></tr></table>' 
      print '<table border="0" cellspacing="1" cellpadding="0" width="750px" align="center"><tr><th>Sr.</th><th>Name</th><th>Column</th><th>Reference To</th></tr>' 

      While(@j <= @maxj)
      begin

         select @Output = '<tr><td width="20px" align="center">' + Cast((@j) as nvarchar) + '</td><td width="150px">' + isnull(name,'')  + '</td><td width="150px">' +  isnull(col,'') + '</td><td>[' + isnull(refObj,'N') + '].[' +  isnull(refCol,'N') + ']</td></tr>' 
            from #FK  where id = @j

         print @Output
         Set @j = @j + 1;
      end

      print '</table><br />'
   end

   --Default Constraints 
   truncate table #Constraint
   if @SqlVersion = '2000' 
      begin
      insert into #Constraint  (Name, col, definition)
      select object_name(c.constid), col_name(c.id, c.colid), s.text
            from sysconstraints c
               inner join #Tables t on t.object_id = c.id
               left outer join syscomments s on s.id = c.constid
            where t.id = @i 
            and 
            convert(nvarchar,+ (c.status & 1)/1)
            + convert(nvarchar,(c.status & 2)/2)
            + convert(nvarchar,(c.status & 4)/4)
            + convert(nvarchar,(c.status & 8)/8)
            + convert(nvarchar,(c.status & 16)/16)
            + convert(nvarchar,(c.status & 32)/32)
            + convert(nvarchar,(c.status & 64)/64)
            + convert(nvarchar,(c.status & 128)/128) = '10101000'
      end
   else if @SqlVersion = '2008' 
      begin
      insert into #Constraint  (Name, col, definition)
      select c.name,  col_name(parent_object_id, parent_column_id), c.definition 
      from sys.default_constraints c
         inner join #Tables t on t.object_id = c.parent_object_id
      where t.id = @i
      order by c.name
      end
   Set @maxj =   @@rowcount
   set @j = 1
   if (@maxj >0)
   begin

      print '<table border="0" cellspacing="0" cellpadding="0" width="750px" align="center"><tr><td><b>Default Constraints</b></td></tr></table>' 
      print '<table border="0" cellspacing="1" cellpadding="0" width="750px" align="center"><tr><th>Sr.</th><th>Name</th><th>Column</th><th>Value</th></tr>' 

      While(@j <= @maxj)
      begin

         select @Output = '<tr><td width="20px" align="center">' + Cast((@j) as nvarchar) + '</td><td width="250px">' + isnull(name,'')  + '</td><td width="150px">' +  isnull(col,'') + '</td><td>' +  isnull(definition,'') + '</td></tr>' 
            from #Constraint  where id = @j

         print @Output
         Set @j = @j + 1;
      end

   print '</table><br />'
   end


   --Check  Constraints
   truncate table #Constraint
   if @SqlVersion = '2000' 
      begin
      insert into #Constraint  (Name, col, definition)
         select object_name(c.constid), col_name(c.id, c.colid), s.text
            from sysconstraints c
               inner join #Tables t on t.object_id = c.id
               left outer join syscomments s on s.id = c.constid
            where t.id = @i 
            and ( convert(nvarchar,+ (c.status & 1)/1)
               + convert(nvarchar,(c.status & 2)/2)
               + convert(nvarchar,(c.status & 4)/4)
               + convert(nvarchar,(c.status & 8)/8)
               + convert(nvarchar,(c.status & 16)/16)
               + convert(nvarchar,(c.status & 32)/32)
               + convert(nvarchar,(c.status & 64)/64)
               + convert(nvarchar,(c.status & 128)/128) = '00101000' 
            or convert(nvarchar,+ (c.status & 1)/1)
               + convert(nvarchar,(c.status & 2)/2)
               + convert(nvarchar,(c.status & 4)/4)
               + convert(nvarchar,(c.status & 8)/8)
               + convert(nvarchar,(c.status & 16)/16)
               + convert(nvarchar,(c.status & 32)/32)
               + convert(nvarchar,(c.status & 64)/64)
               + convert(nvarchar,(c.status & 128)/128) = '00100100')

      end
   else if @SqlVersion = '2008' 
      begin
      insert into #Constraint  (Name, col, definition)
         select c.name,  col_name(parent_object_id, parent_column_id), definition 
         from sys.check_constraints c
            inner join #Tables t on t.object_id = c.parent_object_id
         where t.id = @i
         order by c.name
      end
   Set @maxj =   @@rowcount
   
   set @j = 1
   if (@maxj >0)
   begin

      print '<table border="0" cellspacing="0" cellpadding="0" width="750px" align="center"><tr><td><b>Check  Constraints</b></td></tr></table>' 
      print '<table border="0" cellspacing="1" cellpadding="0" width="750px" align="center"><tr><th>Sr.</th><th>Name</th><th>Column</th><th>Definition</th></tr>' 

      While(@j <= @maxj)
      begin

         select @Output = '<tr><td width="20px" align="center">' + Cast((@j) as nvarchar) + '</td><td width="250px">' + isnull(name,'')  + '</td><td width="150px">' +  isnull(col,'') + '</td><td>' +  isnull(definition,'') + '</td></tr>' 
            from #Constraint  where id = @j
         print @Output 
         Set @j = @j + 1;
      end

      print '</table><br />'
   end


   --Triggers 
   truncate table #Constraint
   if @SqlVersion = '2000' 
      begin
      insert into #Constraint  (Name)
         select tr.name
         FROM sysobjects tr
            inner join #Tables t on t.object_id = tr.parent_obj
         where t.id = @i and tr.type = 'TR'
         order by tr.name
      end
   else if @SqlVersion = '2008' 
      begin
      insert into #Constraint  (Name)
         SELECT tr.name
         FROM sys.triggers tr
            inner join #Tables t on t.object_id = tr.parent_id
         where t.id = @i
         order by tr.name
      end
   Set @maxj =   @@rowcount
   
   set @j = 1
   if (@maxj >0)
   begin

      print '<table border="0" cellspacing="0" cellpadding="0" width="750px" align="center"><tr><td><b>Triggers</b></td></tr></table>' 
      print '<table border="0" cellspacing="1" cellpadding="0" width="750px" align="center"><tr><th>Sr.</th><th>Name</th><th>Description</th></tr>' 

      While(@j <= @maxj)
      begin
         select @Output = '<tr><td width="20px" align="center">' + Cast((@j) as nvarchar) + '</td><td width="150px">' + isnull(name,'')  + '</td><td></td></tr>' 
            from #Constraint  where id = @j
         print @Output 
         Set @j = @j + 1;
      end

      print '</table><br />'
   end

   --Indexes 
   truncate table #Indexes
   if @SqlVersion = '2000' 
      begin
      insert into #Indexes  (Name, type, cols)
         select i.name, case when i.indid = 0 then 'Heap' when i.indid = 1 then 'Clustered' else 'Nonclustered' end , c.name 
         from sysindexes i
            inner join sysindexkeys k  on k.indid = i.indid  and k.id = i.id
            inner join syscolumns c on c.id = k.id and c.colorder = k.colid
            inner join #Tables t on t.object_id = i.id
         where t.id = @i and i.name not like '_WA%'
         order by i.name, i.keycnt
      end
   else if @SqlVersion = '2008' 
      begin
      insert into #Indexes  (Name, type, cols)
         select i.name, case when i.type = 0 then 'Heap' when i.type = 1 then 'Clustered' else 'Nonclustered' end,  col_name(i.object_id, c.column_id)
            from sys.indexes i 
               inner join sys.index_columns c on i.index_id = c.index_id and c.object_id = i.object_id 
               inner join #Tables t on t.object_id = i.object_id
            where t.id = @i
            order by i.name, c.column_id
      end

   Set @maxj =   @@rowcount
   
   set @j = 1
   set @sr = 1
   if (@maxj >0)
   begin

      print '<table border="0" cellspacing="0" cellpadding="0" width="750px" align="center"><tr><td><b>Indexes</b></td></tr></table>' 
      print '<table border="0" cellspacing="1" cellpadding="0" width="750px" align="center"><tr><th>Sr.</th><th>Name</th><th>Type</th><th>Columns</th></tr>' 
      set @Output = ''
      set @last = ''
      set @current = ''
      While(@j <= @maxj)
      begin
         select @current = isnull(name,'') from #Indexes  where id = @j
                
         if @last <> @current  and @last <> ''
            begin   
            print '<tr><td width="20px" align="center">' + Cast((@sr) as nvarchar) + '</td><td width="150px">' + @last + '</td><td width="150px">' + @typ + '</td><td>' + @Output  + '</td></tr>' 
            set @Output  = ''
            set @sr = @sr + 1
            end
         
            
         select @Output = @Output + cols + '<br />' , @typ = type
               from #Indexes  where id = @j
         
         set @last = @current    
         Set @j = @j + 1;
      end
      if @Output <> ''
            begin   
            print '<tr><td width="20px" align="center">' + Cast((@sr) as nvarchar) + '</td><td width="150px">' + @last + '</td><td width="150px">' + @typ + '</td><td>' + @Output  + '</td></tr>' 
            end

      print '</table><br />'
   end

    Set @i = @i + 1;
   --Print @Output 
end


Print '</body>'
Print '</html>'

drop table #Tables
drop table #Columns
drop table #FK
drop table #Constraint
drop table #Indexes 
set nocount off

/*
1. 주석추가 (add)
//테이블
EXEC   sp_addextendedproperty 'MS_Description', '테이블설명', 'user', dbo, 'table',테이블명
//컬럼들
EXEC   sp_addextendedproperty 'MS_Description', '컬럼설명', 'user', dbo, 'table', 테이블명, 'column', 컬럼명
 
2. 주석수정 (update)
//테이블
EXEC   sp_updateextendedproperty 'MS_Description', '테이블설명', 'user', dbo, 'table',테이블명
//컬럼들
EXEC   sp_updateextendedproperty 'MS_Description', '컬럼설명', 'user', dbo, 'table', 테이블명, 'column', 컬럼명
*/
END
--exec dbo.sp_TableDescHtml





  --EXEC   sp_addextendedproperty 'MS_Description', N'어카운트테이블', 'user', dbo, 'table', 'ACCOUNT'
  --EXEC   sp_updateextendedproperty 'MS_Description', N'어카운트테이블', 'user', dbo, 'table', 'ACCOUNT'


GO
/****** Object:  StoredProcedure [dbo].[SP_TableToAutoQuery]    Script Date: 2016-09-05 오후 6:22:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/***********************************************************************/
/* 설명 : DB를 기준으로 자동쿼리를 만들어 줌                           */
/* 작성자 : 전상훈                                                     */
/* 작성일 : 2016.06.17                                                 */
/* 실행 방법: exec [SP_TableToAutoQuery] 'T_SALE','save','%'           */
/* SELECT : 조회쿼리, SAVE 저장쿼리, SaveParam : 저장하기위한 Biz 코딩 */
/***********************************************************************/
CREATE PROCEDURE [dbo].[SP_TableToAutoQuery](@TABLE_NAME NVARCHAR(100), @GUBUN VARCHAR(20) ='SELECT', @TYPE VARCHAR(1) = '' /*@TYPE가 %면 테이블명 LIKE 검색해서 처리*/
) 
AS
BEGIN
	DECLARE @SQL_DATA NVARCHAR(MAX) = ''
	       ,@SQL_DATA2 NVARCHAR(MAX) = ''
	       ,@MIN_SEQ INT =1, @MAX_SEQ INT
		   ,@COLUMN_NAME VARCHAR(50)
	       ,@DESCRIPTION NVARCHAR(500)
	       ,@DATA_TYPE   NVARCHAR(50)
		   ,@IS_NULLABLE VARCHAR(10)
		   ,@TABLE_MIN_IDX INT = 1
		   ,@TABLE_MAX_IDX INT = 1
		   ,@TABLE_DESCRIPTION NVARCHAR(500)
		   ,@IS_PRIMARY VARCHAR(2)
		   ,@IS_IDENTITY VARCHAR(2)
		   ,@PK_MIN_IDX INT = 1
		   ,@PK_MAX_IDX INT = 1
		   
	
    DECLARE @RTN_TABLE TABLE
	(
		CLASS_DATA NVARCHAR(MAX)
	)
    DECLARE @TABLE TABLE
	(
		SEQ INT
	   ,COLUMN_NAME VARCHAR(50)
	   ,DESCRIPTION NVARCHAR(500)
	   ,DATA_TYPE   NVARCHAR(50)
	   ,IS_NULLABLE VARCHAR(10)
	   ,IS_PRIMARY VARCHAR(2)
	   ,IS_IDENTITY VARCHAR(2)
	)

	DECLARE @SEARCH_TABLE TABLE
	(
		SEQ INT IDENTITY(1,1)
	   ,TABLE_NAME VARCHAR(100)

	)
	DECLARE @PRIMARYKEY_TABLE TABLE
	(
		SEQ INT 
	   ,IS_IDENTITY VARCHAR(2)
	   ,COLUMN_NAME VARCHAR(50)

	)

	IF @TYPE = '%'
	BEGIN
		INSERT INTO @SEARCH_TABLE
		(TABLE_NAME)
		SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME lIKE '%' + @TABLE_NAME + '%'
	    SET @TABLE_MAX_IDX = @@ROWCOUNT
	END
	ELSE
	BEGIN
		INSERT INTO @SEARCH_TABLE
		SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = @TABLE_NAME 
	
	END

	WHILE @TABLE_MIN_IDX <= @TABLE_MAX_IDX
	BEGIN
	    DELETE FROM @TABLE
		SET @MIN_SEQ = 1
	    SELECT @TABLE_NAME = TABLE_NAME FROM @SEARCH_TABLE
		WHERE SEQ = @TABLE_MIN_IDX

		
	
		INSERT INTO @TABLE	
		SELECT ROW_NUMBER() OVER(ORDER BY COLUMN_ID) - 1, COLUMN_NAME, ISNULL(DESCRIPTION,''), DATA_TYPE
		     , IS_NULLABLE, IS_PRIMARY, IS_IDENTITY 
		  FROM V_ColumnInfo
		WHERE TABLE_NAME = @TABLE_NAME 
		SET @MAX_SEQ = @@ROWCOUNT -1 



		select * from @TABLE
		SET @PK_MIN_IDX = 1
		
		INSERT INTO @PRIMARYKEY_TABLE
		SELECT ROW_NUMBER() OVER(ORDER BY SEQ) AS SEQ, IS_IDENTITY, COLUMN_NAME FROM @TABLE
		WHERE IS_PRIMARY = 'Y'
		SET @PK_MAX_IDX = @@ROWCOUNT
		
		SELECT @TABLE_DESCRIPTION = DESCRIPTION +' - '+ @TABLE_NAME +   ' ' + CASE WHEN @GUBUN = 'SELECT' THEN '조회' ELSE '저장' END + ' - ' + ' ' + LOWER(@GUBUN) + ' Query' FROM @TABLE WHERE SEQ = 0
		
		DECLARE @STAR_ADD NVARCHAR(100) = LEFT('**************************************************************', CONVERT(INT,LEN(@TABLE_DESCRIPTION) * 1.2))
		SET @SQL_DATA = CHAR(9) + 'SET NOCOUNT ON ' + char(10)
		SET @SQL_DATA = @SQL_DATA + CHAR(9) + '/***' + @STAR_ADD + '***/' + char(10)
		SET @SQL_DATA = @SQL_DATA + CHAR(9) + '/* ' + @TABLE_DESCRIPTION + ' */ ' + char(10)
		SET @SQL_DATA = @SQL_DATA + CHAR(9) + '/***' + @STAR_ADD + '***/' + char(10)
	
		IF @GUBUN = 'SELECT'
		BEGIN
		
			

			SET @SQL_DATA = @SQL_DATA + CHAR(9) + 'SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED ' +CHAR(10)
			SET @SQL_DATA = @SQL_DATA + CHAR(9) + 'SELECT ' + char(10)
		
			WHILE @MIN_SEQ <= @MAX_SEQ
			BEGIN
				SELECT  @COLUMN_NAME = COLUMN_NAME
					 , @DESCRIPTION = DESCRIPTION
					 , @DATA_TYPE = DATA_TYPE 
					 , @IS_NULLABLE = IS_NULLABLE
					 , @IS_PRIMARY = IS_PRIMARY
					 , @IS_IDENTITY = IS_IDENTITY
				  FROM @TABLE
				WHERE SEQ = @MIN_SEQ
		
				IF @MIN_SEQ > 1
					SET @SQL_DATA = @SQL_DATA + CHAR(10) +  CHAR(9) + CHAR(9) +', A.' 
				ELSE
					SET @SQL_DATA = @SQL_DATA +  CHAR(9) + CHAR(9)+ '  '
			
				SET @SQL_DATA = @SQL_DATA + @COLUMN_NAME
				SET @MIN_SEQ = @MIN_SEQ + 1
			END
			SET @SQL_DATA = @SQL_DATA + CHAR(10) + CHAR(9) + 'FROM ' + @TABLE_NAME + ' A '   +  char(10)
			SET @SQL_DATA = @SQL_DATA + CHAR(10) + CHAR(9) + 'WHERE 1=1 '   +  char(10)
			SET @SQL_DATA = @SQL_DATA + CHAR(9) + 'SET NOCOUNT OFF ' + char(10) + char(10)
			
	    END
		ELSE IF @GUBUN = 'SaveParam' /*Biz CS 저장 파라미터 셋팅*/
		BEGIN

		SET @SQL_DATA = CHAR(9) + '        /// <summary>                                                                                      '  + char(10)
		SET @SQL_DATA = @SQL_DATA + CHAR(9) + '        /// ' + @TABLE_NAME + ' 저장하기																	  '  + char(10)
		SET @SQL_DATA = @SQL_DATA + CHAR(9) + '        /// </summary>																					  '  + char(10)
		SET @SQL_DATA = @SQL_DATA + CHAR(9) + '        /// <param name="Param"></param>																	  '  + char(10)
		SET @SQL_DATA = @SQL_DATA + CHAR(9) + '        /// <returns></returns>																			  '  + char(10)
		SET @SQL_DATA = @SQL_DATA + CHAR(9) + '        public RTN_SAVE_DATA ' + @TABLE_NAME + '_Save(' + @TABLE_NAME + ' Param)							  '  + char(10)
		SET @SQL_DATA = @SQL_DATA + CHAR(9) + '        {																								  '  + char(10)
		SET @SQL_DATA = @SQL_DATA + CHAR(9) + '																											  '  + char(10)
		SET @SQL_DATA = @SQL_DATA + CHAR(9) + '            RTN_SAVE_DATA rtn = new RTN_SAVE_DATA();														  '  + char(10)
		SET @SQL_DATA = @SQL_DATA + CHAR(9) + '            try																							  '  + char(10)
		SET @SQL_DATA = @SQL_DATA + CHAR(9) + '            {																							  '  + char(10)
		SET @SQL_DATA = @SQL_DATA + CHAR(9) + '                using (TransactionScope tran = new TransactionScope()) {									  '  + char(10)
		SET @SQL_DATA = @SQL_DATA + CHAR(9) + '                    string sql = Global.DBAgent.LoadSQL(sqlBasePath + "경로\\파일명.xml", "' + @TABLE_NAME + '_Save' +'"	  '   + char(10)


			WHILE @MIN_SEQ <= @MAX_SEQ
			BEGIN
				SELECT  @COLUMN_NAME = COLUMN_NAME
					 , @DESCRIPTION = DESCRIPTION
					 , @DATA_TYPE = DATA_TYPE 
					 , @IS_NULLABLE = IS_NULLABLE
					 , @IS_PRIMARY = IS_PRIMARY
					 , @IS_IDENTITY = IS_IDENTITY
				  FROM @TABLE
				WHERE SEQ = @MIN_SEQ
				
				SET @SQL_DATA = @SQL_DATA + CHAR(9) + '                                                    , Param.' + @COLUMN_NAME + '.ToString('
				IF @IS_PRIMARY = 'Y' SET @SQL_DATA = @SQL_DATA + '"-1"'
				ELSE IF @IS_NULLABLE = 'Y' SET @SQL_DATA = @SQL_DATA + '""'
				SET @SQL_DATA = @SQL_DATA + ')	'	   + char(10)			  

			
			    IF @COLUMN_NAME = 'INSERT_CODE' GOTO EXIT_WIHLE
				
				SET @MIN_SEQ = @MIN_SEQ + 1
			END
        EXIT_WIHLE:
		
		SET @SQL_DATA = @SQL_DATA + CHAR(9) + '																											  '   + char(10)
		SET @SQL_DATA = @SQL_DATA + CHAR(9) + '                      );																					  '	  + char(10)
		SET @SQL_DATA = @SQL_DATA + CHAR(9) + '                    rtn.DATA = db.ExecuteQuery<int>(sql).First().ToString();								  '	  + char(10)
		SET @SQL_DATA = @SQL_DATA + CHAR(9) + '                    tran.Complete();																		  '	  + char(10)
		SET @SQL_DATA = @SQL_DATA + CHAR(9) + '                }																						  '	  + char(10)
		SET @SQL_DATA = @SQL_DATA + CHAR(9) + '            }																							  '	  + char(10)
		SET @SQL_DATA = @SQL_DATA + CHAR(9) + '            catch (Exception ex)																			  '	  + char(10)
		SET @SQL_DATA = @SQL_DATA + CHAR(9) + '            {																							  '	  + char(10)
		SET @SQL_DATA = @SQL_DATA + CHAR(9) + '                rtn.ERROR_MESSAGE = ex.Message;															  '	  + char(10)
		SET @SQL_DATA = @SQL_DATA + CHAR(9) + '            }																							  '	  + char(10)
		SET @SQL_DATA = @SQL_DATA + CHAR(9) + '            return rtn;																					  '	  + char(10)
		SET @SQL_DATA = @SQL_DATA + CHAR(9) + '        }																								  '	  + char(10)
		
	    END
		ELSE IF @GUBUN = 'SAVE'
		BEGIN
			SELECT @TABLE_DESCRIPTION= DESCRIPTION FROM @TABLE WHERE SEQ = 0
	
			SET @SQL_DATA2 = ''
			SET @MIN_SEQ = 1

			WHILE @MIN_SEQ <= @MAX_SEQ
			BEGIN
				SELECT @COLUMN_NAME = COLUMN_NAME
					 , @DESCRIPTION = DESCRIPTION
					 , @DATA_TYPE = DATA_TYPE 
					 , @IS_NULLABLE = IS_NULLABLE
					 , @IS_IDENTITY = IS_IDENTITY
					 , @IS_PRIMARY  = IS_PRIMARY
				  FROM @TABLE
				WHERE SEQ = @MIN_SEQ
			
				IF @SQL_DATA2 = ''
				BEGIN
					SET @SQL_DATA2 = CHAR(9) + 'DECLARE ' 
				END
				ELSE 
				BEGIN
					SET @SQL_DATA2 = @SQL_DATA2 + CHAR(10) + CHAR(9) + CHAR(9)  +  CHAR(9) + '  , '
				END
				SET @SQL_DATA2 = @SQL_DATA2  +  '@' + LEFT( @COLUMN_NAME + SPACE(30),30) + ' ' + LEFT(@DATA_TYPE + SPACE(20), 20)


			
				IF @IS_PRIMARY <> 'Y' AND ( @DATA_TYPE like 'INT%' OR @DATA_TYPE like 'BIGINT%' OR @DATA_TYPE like 'NUMERIC%' OR @DATA_TYPE like 'bit%')
				BEGIN
					IF @COLUMN_NAME IN ('INSERT_CODE', 'UPDATE_CODE')
					BEGIN
						SET @SQL_DATA2 = @SQL_DATA2 + ' = {' + (SELECT CONVERT(VARCHAR(20), SEQ -1) FROM @TABLE WHERE COLUMN_NAME = 'INSERT_CODE') + '}'
					END
					ELSE
					BEGIN
						SET @SQL_DATA2 = @SQL_DATA2 + ' = CONVERT(' + @DATA_TYPE + ', CASE WHEN ISNUMERIC(''{' + CONVERT(VARCHAR(10), @MIN_SEQ - 1) + '}'') = 1 THEN ''{' + CONVERT(VARCHAR(10), @MIN_SEQ -1) + '}'' ELSE ' + (CASE WHEN @IS_NULLABLE = 'Y' THEN 'NULL' ELSE '''0''' END) + ' END )'
					END
				END
			
				ELSE IF @DATA_TYPE like '%datetime%'
				BEGIN
					IF @COLUMN_NAME IN ('INSERT_DATE' ,'UPDATE_DATE')
					BEGIN
						SET @SQL_DATA2 = @SQL_DATA2 + ' = GETDATE() '
					END
					ELSE
					BEGIN
						IF @IS_PRIMARY <> 'Y' 
						BEGIN
							SET @SQL_DATA2 = @SQL_DATA2 + ' = CASE WHEN ISDATE(''{' + CONVERT(VARCHAR(10), @MIN_SEQ-1) + '}'') = 1 THEN ''{' + CONVERT(VARCHAR(10), @MIN_SEQ-1) + '}'' ELSE GETDATE() END'
					    END
						ELSE
						BEGIN 
							SET @SQL_DATA2 = @SQL_DATA2 + ' = N''{' + CONVERT(VARCHAR(10), @MIN_SEQ-1) + '}'''
						END
					END
				END
				ELSE
				BEGIN
					SET @SQL_DATA2 = @SQL_DATA2 + ' = N''{' + CONVERT(VARCHAR(10), @MIN_SEQ-1) + '}'''
				END
			

				

				SET @MIN_SEQ= @MIN_SEQ + 1
			END
			
			SET @SQL_DATA = @SQL_DATA + @SQL_DATA2 + CHAR(10) + CHAR(10)
			SET @SQL_DATA = @SQL_DATA + CHAR(9) +  'UPDATE A ' + char(10)
			SET @SQL_DATA = @SQL_DATA + CHAR(9) +  'SET  ' 

			SET @SQL_DATA2 = ''
		    SET @MIN_SEQ =1
			WHILE @MIN_SEQ <= @MAX_SEQ
			BEGIN
				SELECT @COLUMN_NAME = COLUMN_NAME
					 , @DESCRIPTION = DESCRIPTION
					 , @DATA_TYPE = DATA_TYPE 
					 , @IS_NULLABLE = IS_NULLABLE
					 , @IS_IDENTITY = IS_IDENTITY
					 , @IS_PRIMARY = IS_PRIMARY
				  FROM @TABLE
				WHERE SEQ = @MIN_SEQ

				IF @IS_PRIMARY <> 'Y' AND  @COLUMN_NAME NOT IN ('INSERT_CODE' ,'INSERT_DATE')
				BEGIN
					IF @SQL_DATA2 <> ''  SET @SQL_DATA2 = @SQL_DATA2 + CHAR(9) + CHAR(9) +' ,' 
					ELSE SET @SQL_DATA2 = @SQL_DATA2 + CHAR(9) 
						
					SET @SQL_DATA2 = @SQL_DATA2 +'  ' + LEFT(@COLUMN_NAME + SPACE(30),30) + ' = @' + LEFT(@COLUMN_NAME  + SPACE(30), 30)
			

					IF @MIN_SEQ % 2 = 0
					BEGIN
						SET @SQL_DATA2 = @SQL_DATA2 + CHAR(10) + CHAR(9)
					END
				END
				SET @MIN_SEQ= @MIN_SEQ + 1
			END

		
			SET @SQL_DATA = @SQL_DATA + @SQL_DATA2 + CHAR(10) + CHAR(9) + 'FROM ' + @TABLE_NAME + ' A '   +  char(10)

			WHILE @PK_MIN_IDX <=@PK_MAX_IDX
			BEGIN
				SELECT @IS_IDENTITY = IS_IDENTITY
				      ,@COLUMN_NAME = COLUMN_NAME 
				  FROM @PRIMARYKEY_TABLE
					WHERE SEQ = @PK_MIN_IDX

			    IF @PK_MIN_IDX = 1
				BEGIN
					SET @SQL_DATA = @SQL_DATA + CHAR(9) + 'WHERE ' 
				END
				ELSE
				BEGIN
					SET @SQL_DATA = @SQL_DATA + CHAR(9) + '  AND ' 
				END
				
				SET @SQL_DATA = @SQL_DATA + @COLUMN_NAME + '= @' + @COLUMN_NAME 
				
				
				SET @PK_MIN_IDX = @PK_MIN_IDX + 1
			END

			SET @SQL_DATA = @SQL_DATA + CHAR(10) + CHAR(9) + 'IF @@ROWCOUNT = 0'
			SET @SQL_DATA = @SQL_DATA + CHAR(10) + CHAR(9) + 'BEGIN'
			SET @SQL_DATA = @SQL_DATA + CHAR(10) + CHAR(9) + CHAR(9) + 'INSERT INTO ' + @TABLE_NAME
			SET @SQL_DATA = @SQL_DATA + CHAR(10) + CHAR(9) + CHAR(9) + '(' 
			
			SET @SQL_DATA2 = ''
			SET @MIN_SEQ = 1

			WHILE @MIN_SEQ <= @MAX_SEQ
			BEGIN
				SELECT @COLUMN_NAME = COLUMN_NAME
					 , @DESCRIPTION = DESCRIPTION
					 , @DATA_TYPE = DATA_TYPE 
					 , @IS_NULLABLE = IS_NULLABLE
					 , @IS_IDENTITY = IS_IDENTITY
				  FROM @TABLE
				WHERE SEQ = @MIN_SEQ
				IF @IS_IDENTITY <> 'Y'
				BEGIN
					IF @SQL_DATA2 <> '' 
					BEGIN
						SET @SQL_DATA2 = @SQL_DATA2 + ', '
					END
					ELSE
						SET @SQL_DATA2 = @SQL_DATA2 + CHAR(9) + CHAR(9) 
					SET @SQL_DATA2 = @SQL_DATA2 +  LEFT(@COLUMN_NAME + SPACE(30),30) + CHAR(9) + CHAR(9)
				END
				IF @MIN_SEQ % 4 = 0
				BEGIN
					SET @SQL_DATA2 = @SQL_DATA2 + CHAR(10) + CHAR(9) + CHAR(9) + CHAR(9)
				END
				SET @MIN_SEQ= @MIN_SEQ + 1
			END

			SET @SQL_DATA = @SQL_DATA + @SQL_DATA2  + CHAR(10) + CHAR(9) + CHAR(9) + ')'

			SET @SQL_DATA2 = ''
			SET @MIN_SEQ = 1

			WHILE @MIN_SEQ <= @MAX_SEQ
			BEGIN
				SELECT @COLUMN_NAME = COLUMN_NAME
					 , @DESCRIPTION = DESCRIPTION
					 , @DATA_TYPE = DATA_TYPE 
					 , @IS_NULLABLE = IS_NULLABLE
					 , @IS_IDENTITY = IS_IDENTITY
				  FROM @TABLE
				WHERE SEQ = @MIN_SEQ
					IF @IS_IDENTITY <> 'Y'
					BEGIN
						IF @SQL_DATA2 = ''
						BEGIN
							SET @SQL_DATA2 = @SQL_DATA2 + CHAR(9) + CHAR(9) +  'SELECT '
						END 
						ELSE
						BEGIN
							SET @SQL_DATA2 = @SQL_DATA2 + CHAR(9) + ', '
						END
						SET @SQL_DATA2 = @SQL_DATA2 + LEFT('@'  + @COLUMN_NAME + SPACE(30),30) + CHAR(9)

					IF @MIN_SEQ % 3 = 0
					BEGIN
						SET @SQL_DATA2 = @SQL_DATA2 + CHAR(10) + CHAR(9) + CHAR(9) + CHAR(9)
					END
				END
			    SET @MIN_SEQ= @MIN_SEQ + 1
			END
			SET @SQL_DATA = @SQL_DATA + CHAR(10) + @SQL_DATA2 
			


			SET @SQL_DATA = @SQL_DATA + CHAR(10)+ CHAR(9) + ' END'  + char(10)+ 'SET NOCOUNT OFF' + char(10)

		END
		INSERT INTO @RTN_TABLE
		SELECT @SQL_DATA AS CLASS_DATA
		SET @TABLE_MIN_IDX = @TABLE_MIN_IDX + 1

	END

	IF @GUBUN =  'SaveParam' SELECT CLASS_DATA FROM @RTN_TABLE
	ELSE SELECT UPPER(CLASS_DATA) FROM @RTN_TABLE
END

--SELECT COLUMN_NAME
--FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
--WHERE OBJECTPROPERTY(OBJECT_ID(CONSTRAINT_SCHEMA + '.' + CONSTRAINT_NAME), 'IsPrimaryKey') = 1
--AND TABLE_NAME = 'T_SALE'


GO
/****** Object:  StoredProcedure [dbo].[SP_TableToClass]    Script Date: 2016-09-05 오후 6:22:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*********************************************/
/* 설명 : DB를 기준으로 CLASS 를 만들어 줌   */
/* 작성자 : 전상훈                           */
/* 작성일 : 2016.06.17                       */
/* 실행 방법: exec [SP_TableToClass]'T_SALE','%' */
/*********************************************/
CREATE PROCEDURE [dbo].[SP_TableToClass](@TABLE_NAME NVARCHAR(100), @TYPE VARCHAR(1) = '' /*@TYPE가 %면 테이블명 LIKE 검색해서 처리*/
) 
AS
BEGIN
	DECLARE @CLASS_DATA NVARCHAR(MAX)
	       ,@MIN_SEQ INT =1, @MAX_SEQ INT
		   ,@COLUMN_NAME VARCHAR(50)
	       ,@DESCRIPTION NVARCHAR(500)
	       ,@DATA_TYPE   NVARCHAR(50)
		   ,@IS_NULLABLE VARCHAR(10)
		   ,@TABLE_MIN_IDX INT = 1
		   ,@TABLE_MAX_IDX INT = 1
		   ,@TABLE_DESCRIPTION NVARCHAR(500)
		   ,@IS_PRIMARY VARCHAR(2)
    DECLARE @RTN_TABLE TABLE
	(
		CLASS_DATA NVARCHAR(MAX)
	)
    DECLARE @TABLE TABLE
	(
		SEQ INT
	   ,COLUMN_NAME VARCHAR(50)
	   ,DESCRIPTION NVARCHAR(500)
	   ,DATA_TYPE   NVARCHAR(50)
	   ,IS_NULLABLE VARCHAR(10)
	   ,IS_PRIMARY  VARCHAR(2)
	)

	DECLARE @SEARCH_TABLE TABLE
	(
		SEQ INT IDENTITY(1,1)
	   ,TABLE_NAME VARCHAR(100)

	)

	IF @TYPE = '%'
	BEGIN
		INSERT INTO @SEARCH_TABLE
		(TABLE_NAME)
		SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME lIKE '%' + @TABLE_NAME + '%'
		ORDER BY TABLE_NAME
	    SET @TABLE_MAX_IDX = @@ROWCOUNT
	END
	ELSE
	BEGIN
		INSERT INTO @SEARCH_TABLE
		SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = @TABLE_NAME 
	
	END

	WHILE @TABLE_MIN_IDX <= @TABLE_MAX_IDX
	BEGIN
	    DELETE FROM @TABLE
		SET @MIN_SEQ = 1
	    SELECT @TABLE_NAME = TABLE_NAME FROM @SEARCH_TABLE
		WHERE SEQ = @TABLE_MIN_IDX
		INSERT INTO @TABLE	
		SELECT ROW_NUMBER() OVER(ORDER BY COLUMN_ID) -1, COLUMN_NAME, ISNULL(DESCRIPTION,''), DATA_TYPE, IS_NULLABLE, IS_PRIMARY FROM V_ColumnInfo
		WHERE TABLE_NAME = @TABLE_NAME 
		SET @MAX_SEQ = @@ROWCOUNT -1 
		SELECT @TABLE_DESCRIPTION= DESCRIPTION  + '(' + @TABLE_NAME + ')' FROM @TABLE WHERE SEQ = 0
		SET @CLASS_DATA = '#region >> ' + @TABLE_DESCRIPTION + char(10)
		SET @CLASS_DATA = @CLASS_DATA + '/// <summary>       ' + char(10)
		SET @CLASS_DATA = @CLASS_DATA + '/// ' + @TABLE_DESCRIPTION + char(10)
		SET @CLASS_DATA = @CLASS_DATA + '/// </summary>	   ' + char(10)
		SET @CLASS_DATA = @CLASS_DATA + 'public class ' + @TABLE_NAME + char(10)
		SET @CLASS_DATA = @CLASS_DATA + '{ ' +  char(10)
		WHILE @MIN_SEQ <= @MAX_SEQ
		BEGIN
			SELECT  @COLUMN_NAME = COLUMN_NAME
				 , @DESCRIPTION = DESCRIPTION
				 , @DATA_TYPE = DATA_TYPE 
				 , @IS_NULLABLE = IS_NULLABLE
			  FROM @TABLE
			WHERE SEQ = @MIN_SEQ
		
			SET @CLASS_DATA = @CLASS_DATA + CHAR(9) + '/// <summary>       ' + char(10)
			SET @CLASS_DATA = @CLASS_DATA + CHAR(9) +'/// ' + @DESCRIPTION + char(10)
			SET @CLASS_DATA = @CLASS_DATA + CHAR(9) +'/// </summary>	   ' + char(10)
			IF @DATA_TYPE like 'INT%'
			BEGIN
				SET @CLASS_DATA = @CLASS_DATA + CHAR(9) +'public int' + CASE WHEN @IS_NULLABLE = 'Y' THEN '? ' ELSE ' ' END+ @COLUMN_NAME + ' { get; set; }' + char(10)
			END
			ELSE IF @DATA_TYPE like 'BIGINT%'
			BEGIN
				SET @CLASS_DATA = @CLASS_DATA + CHAR(9) +'public Int64'+ CASE WHEN @IS_NULLABLE = 'Y' THEN '? ' ELSE ' ' END + @COLUMN_NAME + ' { get; set; }' + char(10)
			END
			ELSE IF @DATA_TYPE like 'NUMERIC%'
			BEGIN
				SET @CLASS_DATA = @CLASS_DATA + CHAR(9) +'public decimal'+ CASE WHEN @IS_NULLABLE = 'Y' THEN '? ' ELSE ' ' END + @COLUMN_NAME + ' { get; set; }' + char(10)
			END
			ELSE IF @DATA_TYPE like 'bit%'
			BEGIN
				SET @CLASS_DATA = @CLASS_DATA + CHAR(9) +'public bool' + CASE WHEN @IS_NULLABLE = 'Y' THEN '? ' ELSE ' ' END + @COLUMN_NAME + ' { get; set; }' + char(10)
			END
			ELSE IF @DATA_TYPE like 'datetime%'
			BEGIN
				SET @CLASS_DATA = @CLASS_DATA + CHAR(9) +'public DateTime' + CASE WHEN @IS_NULLABLE = 'Y' THEN '? ' ELSE ' ' END + @COLUMN_NAME + ' { get; set; }' + char(10)
			END
			ELSE IF @DATA_TYPE like '%varchar%'
			BEGIN
				SET @CLASS_DATA = @CLASS_DATA + CHAR(9) +'public string ' + @COLUMN_NAME + ' { get; set; }' + char(10)
			END
			ELSE IF @DATA_TYPE like 'CHAR%'
			BEGIN
				SET @CLASS_DATA = @CLASS_DATA + CHAR(9) +'public string ' + @COLUMN_NAME + ' { get; set; }' + char(10)
			END
			SET @MIN_SEQ = @MIN_SEQ + 1
	
		END
		SET @CLASS_DATA = @CLASS_DATA + '}' +  char(10)
		SET @CLASS_DATA = @CLASS_DATA + '#endregion >> ' + @TABLE_DESCRIPTION + ' END ' + char(10)
		INSERT INTO @RTN_TABLE
		SELECT @CLASS_DATA AS CLASS_DATA
		SET @TABLE_MIN_IDX = @TABLE_MIN_IDX + 1

	END

	SELECT * FROM @RTN_TABLE
END



GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'일련번호(기본키)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_AD', @level2type=N'COLUMN',@level2name=N'AD_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'로고 URL' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_AD', @level2type=N'COLUMN',@level2name=N'LOGO_URL'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'제목' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_AD', @level2type=N'COLUMN',@level2name=N'TITLE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'부제목' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_AD', @level2type=N'COLUMN',@level2name=N'SUB_TITLE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'내용' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_AD', @level2type=N'COLUMN',@level2name=N'CONTENT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'광고시작일(yyyyMMdd)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_AD', @level2type=N'COLUMN',@level2name=N'FR_DATE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'광고종료일(yyyyMMdd)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_AD', @level2type=N'COLUMN',@level2name=N'TO_DATE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'광고시작시간(HH:mm)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_AD', @level2type=N'COLUMN',@level2name=N'FR_TIME'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'광고시작시간(HH:mm)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_AD', @level2type=N'COLUMN',@level2name=N'TO_TIME'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'광고클릭수' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_AD', @level2type=N'COLUMN',@level2name=N'CLICK_CNT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'별포인트 5점 만점 평점으로 계산' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_AD', @level2type=N'COLUMN',@level2name=N'GRADE_POINT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'T_COMPANY 테이블의 COMPANY_CODE' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_AD', @level2type=N'COLUMN',@level2name=N'REQUEST_COMPANY_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'요청한매장코드들 T_SOTRE 테이블의 STORE_CODE , 구분자 => | 값이 없으면 업체 전체 광고' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_AD', @level2type=N'COLUMN',@level2name=N'REQUEST_STORE_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'요청한사용자코드 T_MEMBER 테이블의 MEMBER_CODE' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_AD', @level2type=N'COLUMN',@level2name=N'REQUEST_USER_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'비고' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_AD', @level2type=N'COLUMN',@level2name=N'REMARK'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'광고요청상태(T_COMMON테이블의 A001 코드)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_AD', @level2type=N'COLUMN',@level2name=N'STATUS'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'숨김여부(1:숨김)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_AD', @level2type=N'COLUMN',@level2name=N'HIDE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'등록자' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_AD', @level2type=N'COLUMN',@level2name=N'INSERT_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'등록일' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_AD', @level2type=N'COLUMN',@level2name=N'INSERT_DATE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'수정자' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_AD', @level2type=N'COLUMN',@level2name=N'UPDATE_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'수정일시' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_AD', @level2type=N'COLUMN',@level2name=N'UPDATE_DATE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'광고테이블' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_AD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'일련번호(기본키)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_AD_DEVICE', @level2type=N'COLUMN',@level2name=N'AD_DEVICE_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'광고코드' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_AD_DEVICE', @level2type=N'COLUMN',@level2name=N'AD_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'광고테이블' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_AD_DEVICE', @level2type=N'COLUMN',@level2name=N'DEVICE_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'광고시작일(yyyyMMdd)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_AD_DEVICE', @level2type=N'COLUMN',@level2name=N'FR_DATE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'광고종료일(yyyyMMdd)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_AD_DEVICE', @level2type=N'COLUMN',@level2name=N'TO_DATE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'광고시작시간(HH:mm)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_AD_DEVICE', @level2type=N'COLUMN',@level2name=N'FR_TIME'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'광고시작시간(HH:mm)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_AD_DEVICE', @level2type=N'COLUMN',@level2name=N'TO_TIME'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'UTC 시작일(yyyyMMdd)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_AD_DEVICE', @level2type=N'COLUMN',@level2name=N'FR_UTC_DATE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'UTC 종료일(yyyyMMdd)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_AD_DEVICE', @level2type=N'COLUMN',@level2name=N'TO_UTC_DATE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'UTC 시작일(HH:mm)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_AD_DEVICE', @level2type=N'COLUMN',@level2name=N'FR_UTC_TIME'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'UTC 종료일(HH:mm)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_AD_DEVICE', @level2type=N'COLUMN',@level2name=N'TO_UTC_TIME'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'광고종료시간' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_AD_DEVICE', @level2type=N'COLUMN',@level2name=N'CLICK_CNT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'비고' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_AD_DEVICE', @level2type=N'COLUMN',@level2name=N'REMARK'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'등록자' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_AD_DEVICE', @level2type=N'COLUMN',@level2name=N'INSERT_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'등록일' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_AD_DEVICE', @level2type=N'COLUMN',@level2name=N'INSERT_DATE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'수정자' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_AD_DEVICE', @level2type=N'COLUMN',@level2name=N'UPDATE_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'수정일' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_AD_DEVICE', @level2type=N'COLUMN',@level2name=N'UPDATE_DATE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'광고&단말기테이블' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_AD_DEVICE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'분류코드번호  MAX + 1로생성함, 기본키' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_CATEGORY', @level2type=N'COLUMN',@level2name=N'CATEGORY_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'카테고리유형 T_COMMON 테이블의 B004 코드 사용, 1:광고 2:지역' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_CATEGORY', @level2type=N'COLUMN',@level2name=N'CATEGORY_TYPE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'카테고리유형2 (T_COMMON 테이블의 MAIN_CODE : B005) 1:광고>일반 2:지역>일반 3:지역>핫플레이스' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_CATEGORY', @level2type=N'COLUMN',@level2name=N'CATEGORY_TYPE2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'상위카테고리코드' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_CATEGORY', @level2type=N'COLUMN',@level2name=N'PARENT_CATEGORY_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'레벨깊이, 기본키' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_CATEGORY', @level2type=N'COLUMN',@level2name=N'LEVEL_DEPTH'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'검색을 위한 키조함  최상위코드부터 하위 코드 순으로 |로구분 예) 1|12|100' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_CATEGORY', @level2type=N'COLUMN',@level2name=N'SEARCH_CATEGORY_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'카테고리명' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_CATEGORY', @level2type=N'COLUMN',@level2name=N'CATEGORY_NAME'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'카테고리 표시명' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_CATEGORY', @level2type=N'COLUMN',@level2name=N'CATEGORY_DISPlAY_NAME'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'정렬순서' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_CATEGORY', @level2type=N'COLUMN',@level2name=N'ORDER_SEQ'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'숨김(0:보이기, 1:숨김) T_COMMON : MAIN_CODE=>B003' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_CATEGORY', @level2type=N'COLUMN',@level2name=N'HIDE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'비고' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_CATEGORY', @level2type=N'COLUMN',@level2name=N'REMARK'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'등록자' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_CATEGORY', @level2type=N'COLUMN',@level2name=N'INSERT_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'등록일' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_CATEGORY', @level2type=N'COLUMN',@level2name=N'INSERT_DATE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'수정자' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_CATEGORY', @level2type=N'COLUMN',@level2name=N'UPDATE_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'수정일' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_CATEGORY', @level2type=N'COLUMN',@level2name=N'UPDATE_DATE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'광고분류테이블' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_CATEGORY'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'일련번호(기본키)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_CATEGORY_KEYWORD', @level2type=N'COLUMN',@level2name=N'CK_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'카테고리코드 T_CATEGORY 테이블과 Relation' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_CATEGORY_KEYWORD', @level2type=N'COLUMN',@level2name=N'CATEGORY_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'키워드코드 T_KEYWORD 테이블과 Relation' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_CATEGORY_KEYWORD', @level2type=N'COLUMN',@level2name=N'KEYWORD_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'키워드명' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_CATEGORY_KEYWORD', @level2type=N'COLUMN',@level2name=N'KEYWORD_NAME'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'위도' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_CATEGORY_KEYWORD', @level2type=N'COLUMN',@level2name=N'LATITUDE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'경도' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_CATEGORY_KEYWORD', @level2type=N'COLUMN',@level2name=N'LONGITUDE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'비고' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_CATEGORY_KEYWORD', @level2type=N'COLUMN',@level2name=N'REMARK'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'숨김여부(0:보이기, 1:숨김) T_COMMON : MAIN_CODE=>B003' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_CATEGORY_KEYWORD', @level2type=N'COLUMN',@level2name=N'HIDE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'등록자' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_CATEGORY_KEYWORD', @level2type=N'COLUMN',@level2name=N'INSERT_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'등록일' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_CATEGORY_KEYWORD', @level2type=N'COLUMN',@level2name=N'INSERT_DATE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'수정자' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_CATEGORY_KEYWORD', @level2type=N'COLUMN',@level2name=N'UPDATE_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'수정일' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_CATEGORY_KEYWORD', @level2type=N'COLUMN',@level2name=N'UPDATE_DATE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'카테고리와 키워드 연결 테이블' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_CATEGORY_KEYWORD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'일련번호(자동순번)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_COMMON', @level2type=N'COLUMN',@level2name=N'IDX'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'메인코드' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_COMMON', @level2type=N'COLUMN',@level2name=N'MAIN_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'서브코드' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_COMMON', @level2type=N'COLUMN',@level2name=N'SUB_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'이름' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_COMMON', @level2type=N'COLUMN',@level2name=N'NAME'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'언어코드 T_LANGUAGE테이블의 LANGUAGE_CODE' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_COMMON', @level2type=N'COLUMN',@level2name=N'LANGUAGE_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'정렬순번' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_COMMON', @level2type=N'COLUMN',@level2name=N'ORDER_SEQ'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'참조코드1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_COMMON', @level2type=N'COLUMN',@level2name=N'REF_DATA1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'참조코드2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_COMMON', @level2type=N'COLUMN',@level2name=N'REF_DATA2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'참조코드3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_COMMON', @level2type=N'COLUMN',@level2name=N'REF_DATA3'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'참조코드4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_COMMON', @level2type=N'COLUMN',@level2name=N'REF_DATA4'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'숨김여부' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_COMMON', @level2type=N'COLUMN',@level2name=N'HIDE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'등록자(T_MEMBER의 MEMBER_COE)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_COMMON', @level2type=N'COLUMN',@level2name=N'INSERT_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'등록일' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_COMMON', @level2type=N'COLUMN',@level2name=N'INSERT_DATE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'수정자(T_MEMBER의 MEMBER_CODE)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_COMMON', @level2type=N'COLUMN',@level2name=N'UPDATE_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'수정일' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_COMMON', @level2type=N'COLUMN',@level2name=N'UPDATE_DATE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'공통코드 테이블(항상 첫번째 데이터는 SUB_CODE가 *이고 필드 설명이 들어감)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_COMMON'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'자동순번(기본키)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_COMPANY', @level2type=N'COLUMN',@level2name=N'COMPANY_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'회사아이디(Unique)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_COMPANY', @level2type=N'COLUMN',@level2name=N'COMPANY_ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'암호(SHA1암호화)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_COMPANY', @level2type=N'COLUMN',@level2name=N'PASSWORD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'회사명' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_COMPANY', @level2type=N'COLUMN',@level2name=N'COMPANY_NAME'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'전화번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_COMPANY', @level2type=N'COLUMN',@level2name=N'PHONE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'핸드폰번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_COMPANY', @level2type=N'COLUMN',@level2name=N'MOBILE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'이메일' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_COMPANY', @level2type=N'COLUMN',@level2name=N'EMAIL'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'기본주소' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_COMPANY', @level2type=N'COLUMN',@level2name=N'ADDRESS1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'상세주소' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_COMPANY', @level2type=N'COLUMN',@level2name=N'ADDRESS2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'우편번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_COMPANY', @level2type=N'COLUMN',@level2name=N'ZIP_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'대표자명' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_COMPANY', @level2type=N'COLUMN',@level2name=N'OWNER_NAME'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'대표자전화' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_COMPANY', @level2type=N'COLUMN',@level2name=N'OWNER_PHONE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'대표자핸드폰' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_COMPANY', @level2type=N'COLUMN',@level2name=N'OWNER_MOBILE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'대표자이메일' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_COMPANY', @level2type=N'COLUMN',@level2name=N'OWNER_EMAIL'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'상태(T_COMMON테이블의 MAIN_CODE : S001' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_COMPANY', @level2type=N'COLUMN',@level2name=N'STATUS'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'문화권(언어-국가, ko-KR)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_COMPANY', @level2type=N'COLUMN',@level2name=N'CULTURE_NAME'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'테마명' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_COMPANY', @level2type=N'COLUMN',@level2name=N'THEME_NAME'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'비고' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_COMPANY', @level2type=N'COLUMN',@level2name=N'REMARK'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'등록자(T_MEMBER의 MEMBER_CODE)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_COMPANY', @level2type=N'COLUMN',@level2name=N'INSERT_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'등록일' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_COMPANY', @level2type=N'COLUMN',@level2name=N'INSERT_DATE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'수정자(T_MEMBER의 MEMBER_CODE)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_COMPANY', @level2type=N'COLUMN',@level2name=N'UPDATE_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'수정일' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_COMPANY', @level2type=N'COLUMN',@level2name=N'UPDATE_DATE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'회사정보' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_COMPANY'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'단말기번호(일련번호), 기본키' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_DEVICE', @level2type=N'COLUMN',@level2name=N'DEVICE_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'매장코드 T_STORE 테이블 참조, NULL일경우 매장에 종속 된것이 아님' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_DEVICE', @level2type=N'COLUMN',@level2name=N'STORE_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'장비번호(MAC_ADDRESS)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_DEVICE', @level2type=N'COLUMN',@level2name=N'DEVICE_NUMBER'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'장비명' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_DEVICE', @level2type=N'COLUMN',@level2name=N'DEVICE_NAME'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'장비설명' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_DEVICE', @level2type=N'COLUMN',@level2name=N'DEVICE_DESC'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'영리여부(0:영리, 1:비영리) T_COMMON의 MAIN_CODE : B001' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_DEVICE', @level2type=N'COLUMN',@level2name=N'BUSI_TYPE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'사업자여부(0:일반, 1:사업자) T_COMMON의 MAIN_CODE : B002' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_DEVICE', @level2type=N'COLUMN',@level2name=N'BUSI_TYPE2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'주소' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_DEVICE', @level2type=N'COLUMN',@level2name=N'ADDRESS1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'상세주소' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_DEVICE', @level2type=N'COLUMN',@level2name=N'ADDRESS2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'우편번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_DEVICE', @level2type=N'COLUMN',@level2name=N'ZIP_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'위도' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_DEVICE', @level2type=N'COLUMN',@level2name=N'LATITUDE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'경도' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_DEVICE', @level2type=N'COLUMN',@level2name=N'LONGTITUDE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'비고' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_DEVICE', @level2type=N'COLUMN',@level2name=N'REMARK'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'UTC 기준 시간' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_DEVICE', @level2type=N'COLUMN',@level2name=N'TIME_ZONE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'등록자' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_DEVICE', @level2type=N'COLUMN',@level2name=N'INSERT_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'등록일' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_DEVICE', @level2type=N'COLUMN',@level2name=N'INSERT_DATE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'수정자' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_DEVICE', @level2type=N'COLUMN',@level2name=N'UPDATE_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'수정일' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_DEVICE', @level2type=N'COLUMN',@level2name=N'UPDATE_DATE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'로컬단말기기정보' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_DEVICE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'품목코드' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_ITEM', @level2type=N'COLUMN',@level2name=N'ITEM_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'그룹코드(T_ITEM_GROUP의 GROUP_CODE)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_ITEM', @level2type=N'COLUMN',@level2name=N'GROUP_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'품목명' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_ITEM', @level2type=N'COLUMN',@level2name=N'ITEM_NAME'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'품목명표시(온라인 사이트 등 다르게 표시 할때 사용)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_ITEM', @level2type=N'COLUMN',@level2name=N'ITEM_NAME_DISPLAY'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'T_COMMON : I002, 품목유형 1:일반, 2:세트, 3:토핑' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_ITEM', @level2type=N'COLUMN',@level2name=N'ITEM_TYPE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'단가' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_ITEM', @level2type=N'COLUMN',@level2name=N'COST'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'세금' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_ITEM', @level2type=N'COLUMN',@level2name=N'TAX'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'세금2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_ITEM', @level2type=N'COLUMN',@level2name=N'TAX2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'세금3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_ITEM', @level2type=N'COLUMN',@level2name=N'TAX3'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'금액' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_ITEM', @level2type=N'COLUMN',@level2name=N'PRICE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'정렬순번' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_ITEM', @level2type=N'COLUMN',@level2name=N'ORDER_SEQ'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'이미지경로' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_ITEM', @level2type=N'COLUMN',@level2name=N'IMAGE_URL'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'품목설명' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_ITEM', @level2type=N'COLUMN',@level2name=N'ITEM_DESC'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'비고' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_ITEM', @level2type=N'COLUMN',@level2name=N'REMARK'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'숨김여부(1:숨김)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_ITEM', @level2type=N'COLUMN',@level2name=N'HIDE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'등록자' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_ITEM', @level2type=N'COLUMN',@level2name=N'INSERT_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'등록시간' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_ITEM', @level2type=N'COLUMN',@level2name=N'INSERT_DATE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'수정자' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_ITEM', @level2type=N'COLUMN',@level2name=N'UPDATE_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'수정시간' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_ITEM', @level2type=N'COLUMN',@level2name=N'UPDATE_DATE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'품목' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_ITEM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'그룹코드(일련번호)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_ITEM_GROUP', @level2type=N'COLUMN',@level2name=N'GROUP_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'그룹유형(T_COMMON 테이블의 GROUP_CODE : I001)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_ITEM_GROUP', @level2type=N'COLUMN',@level2name=N'GROUP_TYPE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'상위그룹코드' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_ITEM_GROUP', @level2type=N'COLUMN',@level2name=N'PARENT_GROUP_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'레벨' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_ITEM_GROUP', @level2type=N'COLUMN',@level2name=N'LEVEL_DEPTH'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'매장코드 T_STORE테이블의 STORE_CODE' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_ITEM_GROUP', @level2type=N'COLUMN',@level2name=N'STORE_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'그룹명' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_ITEM_GROUP', @level2type=N'COLUMN',@level2name=N'GROUP_NAME'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'그룹명표시(온라인 사이트 등 다르게 표시 할때 사용)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_ITEM_GROUP', @level2type=N'COLUMN',@level2name=N'GROUP_NAME_DISPLAY'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'정렬순번' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_ITEM_GROUP', @level2type=N'COLUMN',@level2name=N'ORDER_SEQ'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'이미지경로' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_ITEM_GROUP', @level2type=N'COLUMN',@level2name=N'IMAGE_URL'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'그룹설명' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_ITEM_GROUP', @level2type=N'COLUMN',@level2name=N'GROUP_DESC'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'비고' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_ITEM_GROUP', @level2type=N'COLUMN',@level2name=N'REMARK'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'숨김여부' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_ITEM_GROUP', @level2type=N'COLUMN',@level2name=N'HIDE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'등록자(T_MEMBER의 MEMBER_CODE)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_ITEM_GROUP', @level2type=N'COLUMN',@level2name=N'INSERT_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'등록일' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_ITEM_GROUP', @level2type=N'COLUMN',@level2name=N'INSERT_DATE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'수정자(T_MEMBER의 MEMBER_CODE)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_ITEM_GROUP', @level2type=N'COLUMN',@level2name=N'UPDATE_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'수정일' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_ITEM_GROUP', @level2type=N'COLUMN',@level2name=N'UPDATE_DATE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'아이템그룹테이블' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_ITEM_GROUP'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'키워드코드' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_KEYWORD', @level2type=N'COLUMN',@level2name=N'KEYWORD_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'키워드유형(T_COMMON테이블 MAIN_CODE : B006 => 1:카테고리, 2:하위단어 ) T_COMMON : MAIN_CODE=>B003' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_KEYWORD', @level2type=N'COLUMN',@level2name=N'KEYWORD_TYPE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'기준되는코드, 값이 같은 경우 같은 키워드로 판단함, 키워드 검색시 해당코드가 같은 것중에 IS_SYNONYM이 0인 것으로 서버에서 조회 한다.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_KEYWORD', @level2type=N'COLUMN',@level2name=N'BASE_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'동의어 여부(0:기본어, 1:동의어) T_COMMON : B003' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_KEYWORD', @level2type=N'COLUMN',@level2name=N'IS_SYNONYM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'BASE_CODE, IS_SYNONYM 별 순번' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_KEYWORD', @level2type=N'COLUMN',@level2name=N'SEQ'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'키워드명' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_KEYWORD', @level2type=N'COLUMN',@level2name=N'KEYWORD_NAME'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'키워드설명' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_KEYWORD', @level2type=N'COLUMN',@level2name=N'KEYWORD_DESC'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'위도' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_KEYWORD', @level2type=N'COLUMN',@level2name=N'LATITUDE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'경도' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_KEYWORD', @level2type=N'COLUMN',@level2name=N'LONGITUDE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'초성' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_KEYWORD', @level2type=N'COLUMN',@level2name=N'CHOSUNG'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'중성' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_KEYWORD', @level2type=N'COLUMN',@level2name=N'JUNGSUNG'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'종성' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_KEYWORD', @level2type=N'COLUMN',@level2name=N'JONGSUNG'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'초성,중성,종성이분리' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_KEYWORD', @level2type=N'COLUMN',@level2name=N'KEYWORD_UNITS'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'비고' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_KEYWORD', @level2type=N'COLUMN',@level2name=N'REMARK'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'조회횟수' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_KEYWORD', @level2type=N'COLUMN',@level2name=N'SEARCH_CNT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'숨김여부(0:보이기, 1:숨김) T_COMMON : MAIN_CODE=>B003' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_KEYWORD', @level2type=N'COLUMN',@level2name=N'HIDE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'등록자' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_KEYWORD', @level2type=N'COLUMN',@level2name=N'INSERT_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'등록일' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_KEYWORD', @level2type=N'COLUMN',@level2name=N'INSERT_DATE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'수정자' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_KEYWORD', @level2type=N'COLUMN',@level2name=N'UPDATE_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'수정일' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_KEYWORD', @level2type=N'COLUMN',@level2name=N'UPDATE_DATE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'키워드 테이블' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_KEYWORD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'언어코드' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_LANGUAGE', @level2type=N'COLUMN',@level2name=N'LANGUAGE_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'언어유형(ISO 639 언어코드)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_LANGUAGE', @level2type=N'COLUMN',@level2name=N'LANGUAGE_TYPE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'적용된 페이지' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_LANGUAGE', @level2type=N'COLUMN',@level2name=N'PAGE_URL'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'이름' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_LANGUAGE', @level2type=N'COLUMN',@level2name=N'NAME'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'이름' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_LANGUAGE', @level2type=N'COLUMN',@level2name=N'NAME2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'비고' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_LANGUAGE', @level2type=N'COLUMN',@level2name=N'REMARK'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'숨김여부(1:숨김)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_LANGUAGE', @level2type=N'COLUMN',@level2name=N'HIDE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'등록자' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_LANGUAGE', @level2type=N'COLUMN',@level2name=N'INSERT_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'등록시간' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_LANGUAGE', @level2type=N'COLUMN',@level2name=N'INSERT_DATE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'수정자' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_LANGUAGE', @level2type=N'COLUMN',@level2name=N'UPDATE_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'수정시간' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_LANGUAGE', @level2type=N'COLUMN',@level2name=N'UPDATE_DATE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'언어테이블' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_LANGUAGE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'로그일시(yyyyMMddHHmmss 24시간으로 표시)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_LOG', @level2type=N'COLUMN',@level2name=N'LOG_DATE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'로그유형(T_COMMON 테이블의 MAIN_CODE:L002' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_LOG', @level2type=N'COLUMN',@level2name=N'LOG_TYPE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'로그상세정보' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_LOG', @level2type=N'COLUMN',@level2name=N'LOG_DESC'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'사용 IP ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_LOG', @level2type=N'COLUMN',@level2name=N'USE_IP'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'로그 관련 테이블' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_LOG', @level2type=N'COLUMN',@level2name=N'LOG_TABLE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'등록자 T_MEMER의 MEMBER_CODE' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_LOG', @level2type=N'COLUMN',@level2name=N'INSERT_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'등록일시' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_LOG', @level2type=N'COLUMN',@level2name=N'INSERT_DATE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'로그테이블' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_LOG'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'순번(일련번호)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_MEMBER', @level2type=N'COLUMN',@level2name=N'MEMBER_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'T_COMMON 테이블의 MAIN_CODE:U001 사용' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_MEMBER', @level2type=N'COLUMN',@level2name=N'USER_TYPE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'사용자아이디(E-Mail)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_MEMBER', @level2type=N'COLUMN',@level2name=N'USER_ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'암호(SHA1으로 암호화)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_MEMBER', @level2type=N'COLUMN',@level2name=N'PASSWORD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'사용자명' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_MEMBER', @level2type=N'COLUMN',@level2name=N'USER_NAME'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'이메일' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_MEMBER', @level2type=N'COLUMN',@level2name=N'EMAIL'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'일반전화' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_MEMBER', @level2type=N'COLUMN',@level2name=N'PHONE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'모바일번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_MEMBER', @level2type=N'COLUMN',@level2name=N'MOBILE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'기본주소' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_MEMBER', @level2type=N'COLUMN',@level2name=N'ADDRESS1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'상세주소' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_MEMBER', @level2type=N'COLUMN',@level2name=N'ADDRESS2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'우편번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_MEMBER', @level2type=N'COLUMN',@level2name=N'ZIP_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'생년월일(yyyyMMdd 8자리로 등록) ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_MEMBER', @level2type=N'COLUMN',@level2name=N'BIRTH'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'T_COMMON 테이블의 MAIN_CODE : H001(1:남, 2:여) 사용 ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_MEMBER', @level2type=N'COLUMN',@level2name=N'GENDER'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'비고' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_MEMBER', @level2type=N'COLUMN',@level2name=N'REMARK'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'숨김여부(1:숨김 0:보임)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_MEMBER', @level2type=N'COLUMN',@level2name=N'HIDE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'등록자(T_MEMBER의 MEMBER_CODE)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_MEMBER', @level2type=N'COLUMN',@level2name=N'INSERT_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'등록일' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_MEMBER', @level2type=N'COLUMN',@level2name=N'INSERT_DATE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'수정자(T_MEMBER의 MEMBER_CODE)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_MEMBER', @level2type=N'COLUMN',@level2name=N'UPDATE_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'수정일' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_MEMBER', @level2type=N'COLUMN',@level2name=N'UPDATE_DATE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'사용자정보' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_MEMBER'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'매출번호(자동순번)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE', @level2type=N'COLUMN',@level2name=N'SALE_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'매출일(yyyyMMddHHmmss)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE', @level2type=N'COLUMN',@level2name=N'SALE_DATE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'계산서번호(기본:SALE_NO와같음)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE', @level2type=N'COLUMN',@level2name=N'BILL_NO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'매출매장코드(T_STORE의 STORE_CODE)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE', @level2type=N'COLUMN',@level2name=N'STORE_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'회원코드(T_MEMBER의 MEMBER_CODE)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE', @level2type=N'COLUMN',@level2name=N'MEMBER_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'총세금' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE', @level2type=N'COLUMN',@level2name=N'TOT_TAX'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'세금1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE', @level2type=N'COLUMN',@level2name=N'TAX1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'세금2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE', @level2type=N'COLUMN',@level2name=N'TAX2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'세금3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE', @level2type=N'COLUMN',@level2name=N'TAX3'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'배달비' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE', @level2type=N'COLUMN',@level2name=N'DELIVERY_FEE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'팁' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE', @level2type=N'COLUMN',@level2name=N'TIP_AMT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'기타추가금액' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE', @level2type=N'COLUMN',@level2name=N'ADD_AMT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'품목할인금액' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE', @level2type=N'COLUMN',@level2name=N'ITEM_DISCOUNT_AMT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'주문할인유형(T_COMMON:I002)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE', @level2type=N'COLUMN',@level2name=N'ORDER_DISCOUNT_TYPE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'주문할인금액' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE', @level2type=N'COLUMN',@level2name=N'ORDER_DISCOUNT_AMT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'매출금액' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE', @level2type=N'COLUMN',@level2name=N'SALE_AMT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'비고' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE', @level2type=N'COLUMN',@level2name=N'REMARK'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'등록자' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE', @level2type=N'COLUMN',@level2name=N'INSERT_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'등록일시' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE', @level2type=N'COLUMN',@level2name=N'INSERT_DATE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'수정자' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE', @level2type=N'COLUMN',@level2name=N'UPDATE_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'수정일시' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE', @level2type=N'COLUMN',@level2name=N'UPDATE_DATE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'매출테이블' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'쿠폰코드(자동순번)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_COUPON', @level2type=N'COLUMN',@level2name=N'COUPON_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'쿠폰번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_COUPON', @level2type=N'COLUMN',@level2name=N'COUPON_NO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'쿠폰설명' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_COUPON', @level2type=N'COLUMN',@level2name=N'COUPON_DESC'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'쿠폰유형 (T_COMMON : C001)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_COUPON', @level2type=N'COLUMN',@level2name=N'COUPON_TYPE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'쿠폰사용일자(yyyyMMdd)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_COUPON', @level2type=N'COLUMN',@level2name=N'USE_DATE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'사용가능시작일' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_COUPON', @level2type=N'COLUMN',@level2name=N'FR_DATE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'사용가능종료일' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_COUPON', @level2type=N'COLUMN',@level2name=N'TO_DATE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'쿠폰사용회원, 값이 null 일경우 회원 상관없이 모두 할인' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_COUPON', @level2type=N'COLUMN',@level2name=N'MEMBER_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'할인대상 업체, 값이 없을 경우 업체 구분없이 할인' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_COUPON', @level2type=N'COLUMN',@level2name=N'COMPANY_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'쿠폰사용매장' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_COUPON', @level2type=N'COLUMN',@level2name=N'STORE_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'T_ITEM_GROUP테이블의 GROUP_CODE이며 값이 있을 경우 해당 그룹만 할인 대상이 됨' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_COUPON', @level2type=N'COLUMN',@level2name=N'ITEM_GROUP_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'아이템할인일경우 등록됨' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_COUPON', @level2type=N'COLUMN',@level2name=N'ITEM_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'할인율' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_COUPON', @level2type=N'COLUMN',@level2name=N'DISCOUNT_RATE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'할인가능금액' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_COUPON', @level2type=N'COLUMN',@level2name=N'DISCOUNT_AMT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'사용가능최소결재금액' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_COUPON', @level2type=N'COLUMN',@level2name=N'MIN_PAY_AMT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'최종할인금액' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_COUPON', @level2type=N'COLUMN',@level2name=N'USE_DISCOUNT_AMT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'사용유무(1:사용 0:미사용)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_COUPON', @level2type=N'COLUMN',@level2name=N'USE_YN'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'T_SALE테이블 참조' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_COUPON', @level2type=N'COLUMN',@level2name=N'SALE_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'T_SALE_ITEM테이블 참조, 값이 없을 경우 주문할인 있을 경우 해당 아이템 할인' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_COUPON', @level2type=N'COLUMN',@level2name=N'SALE_ITEM_SEQ'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'비고' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_COUPON', @level2type=N'COLUMN',@level2name=N'REMARK'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'등록자' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_COUPON', @level2type=N'COLUMN',@level2name=N'INSERT_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'등록일' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_COUPON', @level2type=N'COLUMN',@level2name=N'INSERT_DATE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'쿠폰테이블' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_COUPON', @level2type=N'COLUMN',@level2name=N'UPDATE_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'수정일' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_COUPON', @level2type=N'COLUMN',@level2name=N'UPDATE_DATE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'쿠폰테이블' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_COUPON'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'매출번호(T_SALE 테이블의 SALE_NO)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_DISCOUNT', @level2type=N'COLUMN',@level2name=N'SALE_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'매출번호별 순번' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_DISCOUNT', @level2type=N'COLUMN',@level2name=N'SEQ'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'T_SALE_ITEM 테이블의 ITEM_SEQ, 주문할인일경우에는 NULL' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_DISCOUNT', @level2type=N'COLUMN',@level2name=N'ITEM_SEQ'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'매출할인유형(T_SALE테이블 DISCOUNT_AMT 할인정보, T_COMMON : C002)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_DISCOUNT', @level2type=N'COLUMN',@level2name=N'DISCOUNT_TYPE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'매출아이템할인유형(T_SALE_ITEM 테이블 DISCOUNT_AMT 할인정보,T_T_COMMON : C002)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_DISCOUNT', @level2type=N'COLUMN',@level2name=N'ITEM_DISCOUNT_TYPE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'할인대상금액' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_DISCOUNT', @level2type=N'COLUMN',@level2name=N'BASE_AMT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'할인율' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_DISCOUNT', @level2type=N'COLUMN',@level2name=N'DISCOUNT_RATE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'실제할인금액' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_DISCOUNT', @level2type=N'COLUMN',@level2name=N'DISCOUNT_AMT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'비고' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_DISCOUNT', @level2type=N'COLUMN',@level2name=N'REMARK'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'등록자' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_DISCOUNT', @level2type=N'COLUMN',@level2name=N'INSERT_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'등록일시' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_DISCOUNT', @level2type=N'COLUMN',@level2name=N'INSERT_DATE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'수정자' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_DISCOUNT', @level2type=N'COLUMN',@level2name=N'UPDATE_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'수정일시' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_DISCOUNT', @level2type=N'COLUMN',@level2name=N'UPDATE_DATE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'매출할인테이블' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_DISCOUNT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'매출번호(T_SALE 테이블의 SALE_NO)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_ITEM', @level2type=N'COLUMN',@level2name=N'SALE_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'매출번호별순번' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_ITEM', @level2type=N'COLUMN',@level2name=N'ITEM_SEQ'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'아이템코드(T_ITEM 테이블의 ITEM_CODE)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_ITEM', @level2type=N'COLUMN',@level2name=N'ITEM_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'아이템명' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_ITEM', @level2type=N'COLUMN',@level2name=N'ITEM_NAME'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'아이템유형T_ITEM 테이블의 ITEM_TYPE그대로저장' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_ITEM', @level2type=N'COLUMN',@level2name=N'ITEM_TYPE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'원가(T_ITEM COST * CNT)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_ITEM', @level2type=N'COLUMN',@level2name=N'COST'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'총세금(T_ITEM TOT_TAX * CNT)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_ITEM', @level2type=N'COLUMN',@level2name=N'TOT_TAX'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'세금1(T_ITEM TAX1 * CNT)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_ITEM', @level2type=N'COLUMN',@level2name=N'TAX1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'세금2(T_ITEM TAX2 * CNT)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_ITEM', @level2type=N'COLUMN',@level2name=N'TAX2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'세금3(T_ITEM TAX3 * CNT)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_ITEM', @level2type=N'COLUMN',@level2name=N'TAX3'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'판매갯수' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_ITEM', @level2type=N'COLUMN',@level2name=N'CNT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'가격(T_ITEM PRICE * CNT)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_ITEM', @level2type=N'COLUMN',@level2name=N'PRICE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'할인유형' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_ITEM', @level2type=N'COLUMN',@level2name=N'DISCOUNT_TYPE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'할인가격' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_ITEM', @level2type=N'COLUMN',@level2name=N'DISCOUNT_AMT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'토핑템플릿코드(토핑테이브은아직만들어지지않음)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_ITEM', @level2type=N'COLUMN',@level2name=N'TOPPING_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'비고' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_ITEM', @level2type=N'COLUMN',@level2name=N'REMARK'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'등록자' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_ITEM', @level2type=N'COLUMN',@level2name=N'INSERT_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'등록일시' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_ITEM', @level2type=N'COLUMN',@level2name=N'INSERT_DATE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'수정자' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_ITEM', @level2type=N'COLUMN',@level2name=N'UPDATE_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'수정일시' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_ITEM', @level2type=N'COLUMN',@level2name=N'UPDATE_DATE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'매출아이템테이블' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_ITEM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'매출번호(T_SALE 테이블의 SALE_NO)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_ITEM_ADD', @level2type=N'COLUMN',@level2name=N'SALE_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'품목추가정보(세트,토핑등)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_ITEM_ADD', @level2type=N'COLUMN',@level2name=N'ITEM_SEQ'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'매출번호별 순번' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_ITEM_ADD', @level2type=N'COLUMN',@level2name=N'SEQ'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'T_SALE_ITEM테이블의 ITEM_TYPE와 같음' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_ITEM_ADD', @level2type=N'COLUMN',@level2name=N'ITEM_TYPE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'대상품목 T_ITEM의 ITEM_CODE' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_ITEM_ADD', @level2type=N'COLUMN',@level2name=N'ITEM_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'원가(T_ITEM COST * CNT)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_ITEM_ADD', @level2type=N'COLUMN',@level2name=N'COST'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'판매갯수' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_ITEM_ADD', @level2type=N'COLUMN',@level2name=N'CNT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'총세금(T_ITEM TOT_TAX * CNT)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_ITEM_ADD', @level2type=N'COLUMN',@level2name=N'TOT_TAX'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'세금1(T_ITEM TAX1 * CNT)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_ITEM_ADD', @level2type=N'COLUMN',@level2name=N'TAX1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'세금2(T_ITEM TAX2 * CNT)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_ITEM_ADD', @level2type=N'COLUMN',@level2name=N'TAX2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'세금3(T_ITEM TAX3 * CNT)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_ITEM_ADD', @level2type=N'COLUMN',@level2name=N'TAX3'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'추가가격' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_ITEM_ADD', @level2type=N'COLUMN',@level2name=N'PRICE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'비고' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_ITEM_ADD', @level2type=N'COLUMN',@level2name=N'REMARK'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'등록자' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_ITEM_ADD', @level2type=N'COLUMN',@level2name=N'INSERT_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'등록일시' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_ITEM_ADD', @level2type=N'COLUMN',@level2name=N'INSERT_DATE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'수정자' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_ITEM_ADD', @level2type=N'COLUMN',@level2name=N'UPDATE_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'수정일시' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_ITEM_ADD', @level2type=N'COLUMN',@level2name=N'UPDATE_DATE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'품목추가정보(세트,토핑등)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_ITEM_ADD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'매출번호(T_SALE 테이블의 SALE_NO)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_TIP', @level2type=N'COLUMN',@level2name=N'SALE_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'매출번호별 순번' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_TIP', @level2type=N'COLUMN',@level2name=N'SEQ'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'직원코드(T_MEMBER의 MEMBER_CODE)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_TIP', @level2type=N'COLUMN',@level2name=N'EMPLOYEE_MEMBER_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'직원이름' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_TIP', @level2type=N'COLUMN',@level2name=N'EMPLOYEE_NAME'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'고객코드(T_MEMBER의 MEMBER_CODE)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_TIP', @level2type=N'COLUMN',@level2name=N'CUSTOMER_MEMBER_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'고객이름' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_TIP', @level2type=N'COLUMN',@level2name=N'CUSTOMER_MEMBER_NAME'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'고객이실제준 금액' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_TIP', @level2type=N'COLUMN',@level2name=N'COST'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'팁의 총세금' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_TIP', @level2type=N'COLUMN',@level2name=N'TOT_TIP_TAX'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'팁세금1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_TIP', @level2type=N'COLUMN',@level2name=N'TIP_TAX1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'팁세금2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_TIP', @level2type=N'COLUMN',@level2name=N'TIP_TAX2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'팁세금3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_TIP', @level2type=N'COLUMN',@level2name=N'TIP_TAX3'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'세금이포함된가격(ORI_PRICE + TOT_TIP_TAX)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_TIP', @level2type=N'COLUMN',@level2name=N'PRICE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'비고' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_TIP', @level2type=N'COLUMN',@level2name=N'REMARK'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'등록자' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_TIP', @level2type=N'COLUMN',@level2name=N'INSERT_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'등록일시' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_TIP', @level2type=N'COLUMN',@level2name=N'INSERT_DATE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'수정자' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_TIP', @level2type=N'COLUMN',@level2name=N'UPDATE_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'수정일시' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_TIP', @level2type=N'COLUMN',@level2name=N'UPDATE_DATE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'매출팁정보' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SALE_TIP'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'T_AD 테이블의 AD_CODE' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SEARCH_KEYWORD', @level2type=N'COLUMN',@level2name=N'AD_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'T_DEVICE 테이블의 DEVICE_CODE' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SEARCH_KEYWORD', @level2type=N'COLUMN',@level2name=N'DEVICE_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'T_CATEGORY_KEYWORD테이블의 CK_CODE' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SEARCH_KEYWORD', @level2type=N'COLUMN',@level2name=N'CK_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'비고' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SEARCH_KEYWORD', @level2type=N'COLUMN',@level2name=N'REMARK'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'등록자 T_MEMBER테이블의 MEMBER_CODE' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SEARCH_KEYWORD', @level2type=N'COLUMN',@level2name=N'INSERT_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'등록일자' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SEARCH_KEYWORD', @level2type=N'COLUMN',@level2name=N'INSERT_DATE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'수정자 T_MEMBER테이블의 MEMBER_CODE' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SEARCH_KEYWORD', @level2type=N'COLUMN',@level2name=N'UPDATE_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'수정일자' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SEARCH_KEYWORD', @level2type=N'COLUMN',@level2name=N'UPDATE_DATE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'자료검색키워드 테이블' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SEARCH_KEYWORD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'매장코드(일련번호)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE', @level2type=N'COLUMN',@level2name=N'STORE_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'T_COMPANY의 COMPANY_CODE(회사코드)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE', @level2type=N'COLUMN',@level2name=N'COMPANY_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'매장아이디(Unique)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE', @level2type=N'COLUMN',@level2name=N'STORE_ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'암호(SHA1암호화)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE', @level2type=N'COLUMN',@level2name=N'PASSWORD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'회사명' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE', @level2type=N'COLUMN',@level2name=N'STORE_NAME'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'전화번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE', @level2type=N'COLUMN',@level2name=N'PHONE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'핸드폰번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE', @level2type=N'COLUMN',@level2name=N'MOBILE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'이메일' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE', @level2type=N'COLUMN',@level2name=N'EMAIL'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'기본주소' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE', @level2type=N'COLUMN',@level2name=N'ADDRESS1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'상세주소' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE', @level2type=N'COLUMN',@level2name=N'ADDRESS2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'우편번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE', @level2type=N'COLUMN',@level2name=N'ZIP_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'대표자명' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE', @level2type=N'COLUMN',@level2name=N'OWNER_NAME'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'대표자전화' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE', @level2type=N'COLUMN',@level2name=N'OWNER_PHONE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'대표자핸드폰' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE', @level2type=N'COLUMN',@level2name=N'OWNER_MOBILE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'대표자이메일' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE', @level2type=N'COLUMN',@level2name=N'OWNER_EMAIL'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'상태(T_COMMON테이블의 MAIN_CODE : S001' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE', @level2type=N'COLUMN',@level2name=N'STATUS'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'문화권(언어-국가, ko-KR)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE', @level2type=N'COLUMN',@level2name=N'CULTURE_NAME'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'테마명' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE', @level2type=N'COLUMN',@level2name=N'THEME_NAME'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'비고' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE', @level2type=N'COLUMN',@level2name=N'REMARK'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'등록자(T_MEMBER의 MEMBER_CODE)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE', @level2type=N'COLUMN',@level2name=N'INSERT_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'등록일' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE', @level2type=N'COLUMN',@level2name=N'INSERT_DATE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'수정자(T_MEMBER의 MEMBER_CODE)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE', @level2type=N'COLUMN',@level2name=N'UPDATE_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'수정일' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE', @level2type=N'COLUMN',@level2name=N'UPDATE_DATE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'회사별매장정보' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'T_STORE 테이블의 STORE_CODE' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE_BUSINESSHOURS', @level2type=N'COLUMN',@level2name=N'STORE_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'T_COMMON테이블의 GROUP_CODE : S002참고' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE_BUSINESSHOURS', @level2type=N'COLUMN',@level2name=N'SCHEDULE_TYPE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'요일(DATEPART-int형) 또는 날짜(yyyyMMdd)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE_BUSINESSHOURS', @level2type=N'COLUMN',@level2name=N'SCHEDULE_TYPE_DTL'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'영업시작시간(24시간으로 표시 - 09:00-HH:mm)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE_BUSINESSHOURS', @level2type=N'COLUMN',@level2name=N'FR_TIME'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'영업종료시간(24시간으로 표시 - 21:00-HH:mm)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE_BUSINESSHOURS', @level2type=N'COLUMN',@level2name=N'TO_TIME'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'비고' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE_BUSINESSHOURS', @level2type=N'COLUMN',@level2name=N'REMARK'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'T_COMMON 테이블의 MAIN_CODE:S003' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE_BUSINESSHOURS', @level2type=N'COLUMN',@level2name=N'STATUS'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'등록자' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE_BUSINESSHOURS', @level2type=N'COLUMN',@level2name=N'INSERT_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'등록시간' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE_BUSINESSHOURS', @level2type=N'COLUMN',@level2name=N'INSERT_DATE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'수정자' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE_BUSINESSHOURS', @level2type=N'COLUMN',@level2name=N'UPDATE_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'수정시간' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE_BUSINESSHOURS', @level2type=N'COLUMN',@level2name=N'UPDATE_DATE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'매장별 영업시간 설정' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE_BUSINESSHOURS'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'순번(일련번호) 기본키' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE_CONTACT', @level2type=N'COLUMN',@level2name=N'IDX'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'매장코드' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE_CONTACT', @level2type=N'COLUMN',@level2name=N'STORE_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'등록일시(yyyyMMddHHmmss)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE_CONTACT', @level2type=N'COLUMN',@level2name=N'REG_DATE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'이름' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE_CONTACT', @level2type=N'COLUMN',@level2name=N'NAME'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'이메일' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE_CONTACT', @level2type=N'COLUMN',@level2name=N'EMAIL'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'전화번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE_CONTACT', @level2type=N'COLUMN',@level2name=N'PHONE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'제목' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE_CONTACT', @level2type=N'COLUMN',@level2name=N'TITLE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'내용' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE_CONTACT', @level2type=N'COLUMN',@level2name=N'CONTENT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'비고' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE_CONTACT', @level2type=N'COLUMN',@level2name=N'REMARK'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'상태' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE_CONTACT', @level2type=N'COLUMN',@level2name=N'STATUS'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'등록자(T_MEMBER의 MEMBER_CODE)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE_CONTACT', @level2type=N'COLUMN',@level2name=N'INSERT_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'등록일' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE_CONTACT', @level2type=N'COLUMN',@level2name=N'INSERT_DATE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'수정자(T_MEMBER의 MEMBER_CODE)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE_CONTACT', @level2type=N'COLUMN',@level2name=N'UPDATE_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'수정일' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE_CONTACT', @level2type=N'COLUMN',@level2name=N'UPDATE_DATE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'매장문의사항' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE_CONTACT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'매장코드' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE_IMAGE', @level2type=N'COLUMN',@level2name=N'STORE_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'서비스코드(T_COMMON 테이블의 MAIN_CODE : S004)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE_IMAGE', @level2type=N'COLUMN',@level2name=N'SERVICE_TYPE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'이미지유형(T_COMMON 테이블의 MAIN_CODE : S005)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE_IMAGE', @level2type=N'COLUMN',@level2name=N'IMAGE_TYPE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'순번' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE_IMAGE', @level2type=N'COLUMN',@level2name=N'SEQ'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'이미지URL' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE_IMAGE', @level2type=N'COLUMN',@level2name=N'IMAGE_URL'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'데이터1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE_IMAGE', @level2type=N'COLUMN',@level2name=N'DATA1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'데이터2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE_IMAGE', @level2type=N'COLUMN',@level2name=N'DATA2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'데이터3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE_IMAGE', @level2type=N'COLUMN',@level2name=N'DATA3'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'비고' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE_IMAGE', @level2type=N'COLUMN',@level2name=N'REMARK'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'숨김여부(1:숨김)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE_IMAGE', @level2type=N'COLUMN',@level2name=N'HIDE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'등록자(T_MEMBER의 MEMBER_CODE)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE_IMAGE', @level2type=N'COLUMN',@level2name=N'INSERT_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'등록일' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE_IMAGE', @level2type=N'COLUMN',@level2name=N'INSERT_DATE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'수정자(T_MEMBER의 MEMBER_CODE)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE_IMAGE', @level2type=N'COLUMN',@level2name=N'UPDATE_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'수정일' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE_IMAGE', @level2type=N'COLUMN',@level2name=N'UPDATE_DATE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'매장관련이미지' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE_IMAGE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'순번(일련번호) 기본키' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE_RESERVATION', @level2type=N'COLUMN',@level2name=N'IDX'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'매장코드' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE_RESERVATION', @level2type=N'COLUMN',@level2name=N'STORE_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'등록일시(yyyyMMddHHmmss)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE_RESERVATION', @level2type=N'COLUMN',@level2name=N'REG_DATE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'요청일' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE_RESERVATION', @level2type=N'COLUMN',@level2name=N'REQUEST_DATE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'이름' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE_RESERVATION', @level2type=N'COLUMN',@level2name=N'NAME'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'이메일' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE_RESERVATION', @level2type=N'COLUMN',@level2name=N'EMAIL'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'전화번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE_RESERVATION', @level2type=N'COLUMN',@level2name=N'PHONE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'사람수' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE_RESERVATION', @level2type=N'COLUMN',@level2name=N'PEOPLE_NUMBER'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'내용' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE_RESERVATION', @level2type=N'COLUMN',@level2name=N'CONTENT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'비고' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE_RESERVATION', @level2type=N'COLUMN',@level2name=N'REMARK'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'상태' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE_RESERVATION', @level2type=N'COLUMN',@level2name=N'STATUS'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'T_SALE테이블의 참조' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE_RESERVATION', @level2type=N'COLUMN',@level2name=N'SALE_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'등록자(T_MEMBER의 MEMBER_CODE)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE_RESERVATION', @level2type=N'COLUMN',@level2name=N'INSERT_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'등록일' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE_RESERVATION', @level2type=N'COLUMN',@level2name=N'INSERT_DATE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'수정자(T_MEMBER의 MEMBER_CODE)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE_RESERVATION', @level2type=N'COLUMN',@level2name=N'UPDATE_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'수정일' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE_RESERVATION', @level2type=N'COLUMN',@level2name=N'UPDATE_DATE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'매장예약' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE_RESERVATION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'매장코드' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE_WEBMENU', @level2type=N'COLUMN',@level2name=N'STORE_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'웹메뉴코드' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE_WEBMENU', @level2type=N'COLUMN',@level2name=N'CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'메뉴유형 T_COMMON : M001' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE_WEBMENU', @level2type=N'COLUMN',@level2name=N'MENU_TYPE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'웹메뉴상위코드' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE_WEBMENU', @level2type=N'COLUMN',@level2name=N'PARENT_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'메뉴의깊이' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE_WEBMENU', @level2type=N'COLUMN',@level2name=N'LEVEL'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'LEVEL별 웹메뉴의 순번' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE_WEBMENU', @level2type=N'COLUMN',@level2name=N'SEQ'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'메뉴명(줄임말)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE_WEBMENU', @level2type=N'COLUMN',@level2name=N'NAME'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'메뉴명(전체본명)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE_WEBMENU', @level2type=N'COLUMN',@level2name=N'FULL_NAME'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'메뉴주소' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE_WEBMENU', @level2type=N'COLUMN',@level2name=N'MENU_URL'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'템플릿페이지명' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE_WEBMENU', @level2type=N'COLUMN',@level2name=N'TEMPLEATE_PAGE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'비고' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE_WEBMENU', @level2type=N'COLUMN',@level2name=N'REMARK'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'숨김여부(1:숨김)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE_WEBMENU', @level2type=N'COLUMN',@level2name=N'HIDE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'등록자(T_MEMBER의 MEMBER_CODE)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE_WEBMENU', @level2type=N'COLUMN',@level2name=N'INSERT_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'등록일' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE_WEBMENU', @level2type=N'COLUMN',@level2name=N'INSERT_DATE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'수정자(T_MEMBER의 MEMBER_CODE)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE_WEBMENU', @level2type=N'COLUMN',@level2name=N'UPDATE_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'수정일' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE_WEBMENU', @level2type=N'COLUMN',@level2name=N'UPDATE_DATE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'매장별웹메뉴' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_STORE_WEBMENU'
GO
USE [master]
GO
ALTER DATABASE [ALTSOFT_ONLINESERVICE] SET  READ_WRITE 
GO
