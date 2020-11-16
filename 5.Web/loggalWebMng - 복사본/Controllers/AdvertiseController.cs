﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ALT.VO.Common;
using ALT.VO.loggal;
using loggalServiceBiz;
using ALT.Framework;
using ALT.Framework.Data;
using ALT.Framework.Mvc.Helpers;
using ALT.BizService;
using ALT.Framework.Mvc.Vo;
using Newtonsoft.Json;
using loggalWebMng.CommonCS;
using System.Threading.Tasks;

namespace loggalWebMng.Controllers
{
    public class AdvertiseController : BaseController
    {
        // GET: Advertise
        [Compress]
        
        public ActionResult Index(AD_PAGE_COND Cond)
        {
            ViewBag.Cond = Cond;
            return View();
        }
        [Compress]
        public PartialViewResult PV_Ad_PageList(AD_PAGE_COND Cond)
        {
            if (SessionHelper.LoginInfo.STORE_CODE != 1 || !(SessionHelper.LoginInfo.STORE.STORE_TYPE == 1 || SessionHelper.LoginInfo.STORE.STORE_TYPE == 4))
            {
                Cond.COMPANY_CODE = SessionHelper.LoginInfo.COMPANY_CODE;
            }
            if (SessionHelper.LoginInfo.STORE_CODE != 1 && !(SessionHelper.LoginInfo.STORE.STORE_TYPE == 1 || SessionHelper.LoginInfo.STORE.STORE_TYPE == 4))
            {
                Cond.STORE_CODE = SessionHelper.LoginInfo.STORE_CODE;
            }

            if (SessionHelper.LoginInfo.EMPLOYEE.EMP_AUTH != null)
            {
                switch (SessionHelper.LoginInfo.EMPLOYEE.EMP_AUTH)
                {
                    case 2: /*상위부서권한*/
                        Cond.STORE_CODE = SessionHelper.LoginInfo.EMPLOYEE.STORE_CODE;
                        Cond.DEPT_SEARCH = SessionHelper.LoginInfo.EMPLOYEE.DEPT_SEARCH.ToString("");
                        break;
                    case 3:/*부서권한*/
                        Cond.STORE_CODE = SessionHelper.LoginInfo.EMPLOYEE.STORE_CODE;
                        Cond.DEPT_CODE = SessionHelper.LoginInfo.EMPLOYEE.DEPT_CODE;
                        break;
                    case 8:/*상급자권한*/
                        Cond.STORE_CODE = SessionHelper.LoginInfo.EMPLOYEE.STORE_CODE;
                        Cond.PARENT_MEMBER_CODE = SessionHelper.LoginInfo.EMPLOYEE.MEMBER_CODE;
                        break;
                    case 9:/*본인권한*/
                        Cond.STORE_CODE = SessionHelper.LoginInfo.EMPLOYEE.STORE_CODE;
                        Cond.MEMBER_CODE = SessionHelper.LoginInfo.MEMBER.MEMBER_CODE;
                        break;
                }
            }

            ViewBag.list = new AdvertisingService().GetT_Ad_PageList(Cond);
            return PartialView2();
        }
        [Compress]
        public ActionResult T_AD_ExcelReport(AD_PAGE_COND Cond)
        {
            if (SessionHelper.LoginInfo.STORE_CODE != 1 || !(SessionHelper.LoginInfo.STORE.STORE_TYPE == 1 || SessionHelper.LoginInfo.STORE.STORE_TYPE == 4))
            {
                Cond.COMPANY_CODE = SessionHelper.LoginInfo.COMPANY_CODE;
            }
            if (SessionHelper.LoginInfo.STORE_CODE != 1 && !(SessionHelper.LoginInfo.STORE.STORE_TYPE == 1 || SessionHelper.LoginInfo.STORE.STORE_TYPE == 4))
            {
                Cond.STORE_CODE = SessionHelper.LoginInfo.STORE_CODE;
            }

            if (SessionHelper.LoginInfo.EMPLOYEE.EMP_AUTH != null)
            {
                switch (SessionHelper.LoginInfo.EMPLOYEE.EMP_AUTH)
                {
                    case 2: /*상위부서권한*/
                        Cond.STORE_CODE = SessionHelper.LoginInfo.EMPLOYEE.STORE_CODE;
                        Cond.DEPT_SEARCH = SessionHelper.LoginInfo.EMPLOYEE.DEPT_SEARCH.ToString("");
                        break;
                    case 3:/*부서권한*/
                        Cond.STORE_CODE = SessionHelper.LoginInfo.EMPLOYEE.STORE_CODE;
                        Cond.DEPT_CODE = SessionHelper.LoginInfo.EMPLOYEE.DEPT_CODE;
                        break;
                    case 8:/*상급자권한*/
                        Cond.STORE_CODE = SessionHelper.LoginInfo.EMPLOYEE.STORE_CODE;
                        Cond.PARENT_MEMBER_CODE = SessionHelper.LoginInfo.EMPLOYEE.MEMBER_CODE;
                        break;
                    case 9:/*본인권한*/
                        Cond.STORE_CODE = SessionHelper.LoginInfo.EMPLOYEE.STORE_CODE;
                        Cond.MEMBER_CODE = SessionHelper.LoginInfo.MEMBER.MEMBER_CODE;
                        break;
                }
            }

            //if(!(SessionHelper.LoginInfo.EMPLOYEE.EMP_AUTH == 2 || SessionHelper.LoginInfo.EMPLOYEE.EMP_AUTH == 4)) /**/
            //{

            //}
            List<string> headers = new List<string>()
            { "코드", "로고|LINK", "대표카테고리", "제목", "부제목" ,"상태", "내용|LINK", "시작일자"
            , "종료일자", "시작시간", "종료시간", "클릭수", "요청회사","요청지점", "요청자"
            , "비고","숨김여부", "등록자", "등록시간", "수정자", "수정시간"  };

            Cond.PAGE = 1;
            Cond.PAGE_COUNT = 100000;

            return new AdvertisingService().GetT_Ad_PageList(Cond).Select(s => new {
                AD_CODE = s.AD_CODE
               , LOGO_URL = s.LOGO_URL
               , REP_CATEGORY_NAME = s.REP_CATEGORY_NAME
               , TITLE = s.TITLE
               , SUB_TITLE = s.SUB_TITLE
               , STATUS_NAME = s.STATUS_NAME
               , CONTENT = Global.ConfigInfo.MANAGEMENT_SITE + "/advertise/contentview/" + s.AD_CODE.ToString("")
               , FR_DATE = s.FR_DATE
               , TO_DATE = s.TO_DATE
               , FR_TIME = s.FR_TIME
               , TO_TIME = s.TO_TIME
               , CLICK_CNT = s.CLICK_CNT
               //,GRADE_POINT = s.GRADE_POINT
               , COMPANY_NAME = s.COMPANY_NAME
               , STORE_NAME = s.STORE_NAME
               , MEMBER_NAME = s.MEMBER_NAME
               , REMARK = s.REMARK
               , HIDE_NAME = s.HIDE_NAME
               , INSERT_NAME = s.INSERT_NAME
               , INSERT_DATE = s.INSERT_DATE
               , UPDATE_NAME = s.UPDATE_NAME
               , UPDATE_DATE = s.UPDATE_DATE
            }).ToList().ToExcel(SessionHelper.LoginInfo.CURRENT_MENU_NAME + DateTime.Now.ToString("_yyyyMMddHHmmss"), headers);
        }
        [Compress]
        public ActionResult adreg(long? id)
        {
            T_COMPANY_COND compCond = new T_COMPANY_COND { };
            if (SessionHelper.LoginInfo.STORE_CODE != 1)
            {
                compCond.COMPANY_CODE = SessionHelper.LoginInfo.COMPANY_CODE;
            }
            ViewBag.compCombo = new BasicService().GetCompanyList(compCond).Select(s => new SelectListItem { Value = s.COMPANY_CODE.ToString(), Text = s.COMPANY_NAME }).ToList();
            ViewBag.data = new AdvertisingService().GetT_AD_List((long)(id == null ? 0 : id)).FirstOrDefault();

            ViewBag.filelocalbox = new CommonService().GetFileList(new T_FILE { TABLE_NAME = "T_AD", TABLE_KEY = id.ToString(), FILE_SEQ = 1 }).FirstOrDefault();
            if (SessionHelper.LoginInfo.EMPLOYEE.COMPANY_CODE == 1  || id == null || SessionHelper.LoginInfo.EMPLOYEE.COMPANY_CODE == ViewBag.data.COMPANY_CODE)
                SessionHelper.LoginInfo.EDIT_MODE = enEditMode.WRITE;
            else
                SessionHelper.LoginInfo.EDIT_MODE = enEditMode.READ;

            ViewBag.KeywordList = new KeywordService().GetAdDeviceSearchKeyword(new CATEGORY_KEYWORD_COND { AD_CODE = Convert.ToInt64(id.ToString("-1")), KEYWORD_TYPE =2 });
            return View();
        }
        [Compress]
        public JsonResult GetAdData(long? id)
        {
            var data = new AdvertisingService().GetT_AD_List((long)(id == null ? 0 : id)).FirstOrDefault();
            data = data == null ? new T_AD() { STATUS = 9, HIDE = false } : data;

            var keyword = new KeywordService().GetAdDeviceSearchKeyword(new CATEGORY_KEYWORD_COND { AD_CODE = Convert.ToInt64(id.ToString("-1")), KEYWORD_TYPE = 2 });
            return new JsonResult { Data = new { AD_DATA = data, KEYWORD_DATA = keyword } };
        }
        [Compress]
        public JsonResult adSave(T_AD Param, T_DEVICE_MAIN device)
        {
            Param.INSERT_CODE = SessionHelper.LoginInfo.MEMBER.MEMBER_CODE;
            RTN_SAVE_DATA rtn = new AdvertisingService().T_AD_Save(Param, device);

            return new JsonResult { Data = rtn };
        }
        [Compress]
        public JsonResult adDelete(long AD_CODE)
        {
            RTN_SAVE_DATA rtn = new AdvertisingService().AdDelete(new long[] { AD_CODE });
            return new JsonResult { Data = rtn };
        }
        [Compress]
        public PartialViewResult PV_AdRegRegionList(PAGE_COND Cond)
        {

            ViewBag.list = new AdvertisingService().GetAdRegionList(Cond);

            return PartialView2();
        }
        [Compress]
        public JsonResult AdRegionSave(List<AD_REGION> list)
        {

            RTN_SAVE_DATA data = new AdvertisingService().AdRegionSave(list, SessionHelper.LoginInfo.MEMBER.MEMBER_CODE);

            return new JsonResult { Data = data };
        }


        #region >> 기기에 광고 넣기
        [Compress]
        public ActionResult AdOnDevice()
        {
            return View();
        }
        [Compress]
        public PartialViewResult pv_AdOnDevicelist(SEARCH_COND Cond)
        {
            #region >> 권한 제거 이유 : 기기에 등록하기 위한 광고 데이터 이기 때문
            //if (SessionHelper.LoginInfo.STORE_CODE != 1 || !(SessionHelper.LoginInfo.STORE.STORE_TYPE == 1 || SessionHelper.LoginInfo.STORE.STORE_TYPE == 4))
            //{
            //    Cond.SEARCH_DATA3 = SessionHelper.LoginInfo.COMPANY_CODE.ToString("");
            //}
            //if (SessionHelper.LoginInfo.STORE_CODE != 1 && !(SessionHelper.LoginInfo.STORE.STORE_TYPE == 1 || SessionHelper.LoginInfo.STORE.STORE_TYPE == 4))
            //{
            //    Cond.SEARCH_DATA4 = SessionHelper.LoginInfo.STORE_CODE.ToString("");
            //}

            //if (SessionHelper.LoginInfo.EMPLOYEE.EMP_AUTH != null)
            //{
            //    switch (SessionHelper.LoginInfo.EMPLOYEE.EMP_AUTH)
            //    {
            //        case 2: /*상위부서권한*/
            //            Cond.SEARCH_DATA4 = SessionHelper.LoginInfo.EMPLOYEE.STORE_CODE.ToString("");
            //            Cond.SEARCH_DATA5 = SessionHelper.LoginInfo.EMPLOYEE.DEPT_SEARCH.ToString("");
            //            break;
            //        case 3:/*부서권한*/
            //            Cond.SEARCH_DATA4 = SessionHelper.LoginInfo.EMPLOYEE.STORE_CODE.ToString("");
            //            Cond.SEARCH_DATA6 = SessionHelper.LoginInfo.EMPLOYEE.DEPT_CODE.ToString("");
            //            break;
            //        case 8:/*상급자권한*/
            //            Cond.SEARCH_DATA4 = SessionHelper.LoginInfo.EMPLOYEE.STORE_CODE.ToString("");
            //            Cond.SEARCH_DATA7 = SessionHelper.LoginInfo.EMPLOYEE.MEMBER_CODE.ToString();
            //            break;
            //        case 9:/*본인권한*/
            //            Cond.SEARCH_DATA4 = SessionHelper.LoginInfo.EMPLOYEE.STORE_CODE.ToString("");
            //            Cond.SEARCH_DATA8 = SessionHelper.LoginInfo.MEMBER.MEMBER_CODE.ToString();
            //            break;
            //    }
            //}
            #endregion
            ViewBag.list = new AdvertisingService().GetAdOnDeviceList(Cond);
            return PartialView2();
        }
        [Compress]
        public PartialViewResult pv_AdOnDevicelist2(SEARCH_COND Cond)
        {
            if (SessionHelper.LoginInfo.STORE_CODE != 1 || !(SessionHelper.LoginInfo.STORE.STORE_TYPE == 1 || SessionHelper.LoginInfo.STORE.STORE_TYPE == 4))
            {
                Cond.SEARCH_DATA3 = SessionHelper.LoginInfo.COMPANY_CODE.ToString("");
            }
            if (SessionHelper.LoginInfo.STORE_CODE != 1 && !(SessionHelper.LoginInfo.STORE.STORE_TYPE == 1 || SessionHelper.LoginInfo.STORE.STORE_TYPE == 4))
            {
                Cond.SEARCH_DATA4 = SessionHelper.LoginInfo.STORE_CODE.ToString("");
            }

            if (SessionHelper.LoginInfo.EMPLOYEE.EMP_AUTH != null)
            {
                switch (SessionHelper.LoginInfo.EMPLOYEE.EMP_AUTH)
                {
                    case 2: /*상위부서권한*/
                        Cond.SEARCH_DATA4 = SessionHelper.LoginInfo.EMPLOYEE.STORE_CODE.ToString("");
                        Cond.SEARCH_DATA5 = SessionHelper.LoginInfo.EMPLOYEE.DEPT_SEARCH.ToString("");
                        break;
                    case 3:/*부서권한*/
                        Cond.SEARCH_DATA4 = SessionHelper.LoginInfo.EMPLOYEE.STORE_CODE.ToString("");
                        Cond.SEARCH_DATA6 = SessionHelper.LoginInfo.EMPLOYEE.DEPT_CODE.ToString("");
                        break;
                    case 8:/*상급자권한*/
                        Cond.SEARCH_DATA4 = SessionHelper.LoginInfo.EMPLOYEE.STORE_CODE.ToString("");
                        Cond.SEARCH_DATA7 = SessionHelper.LoginInfo.EMPLOYEE.MEMBER_CODE.ToString();
                        break;
                    case 9:/*본인권한*/
                        Cond.SEARCH_DATA4 = SessionHelper.LoginInfo.EMPLOYEE.STORE_CODE.ToString("");
                        Cond.SEARCH_DATA8 = SessionHelper.LoginInfo.MEMBER.MEMBER_CODE.ToString();
                        break;
                }
            }
            ViewBag.list = new AdvertisingService().GetAdOnDeviceList2(Cond);
            return PartialView2();
        }
        [Compress]
        public JsonResult AdOnDeviceSave(AdDeviceSaveData saveData)
        {
            RTN_SAVE_DATA rtn = new AdvertisingService().T_AD_DEVICE_Save(saveData);
            return new JsonResult { Data = rtn };
        }
        #endregion
        /// <summary>
        /// 선택된 주소 지역구 검색어 자동 저장
        /// </summary>
        /// <param name="Cond"></param>
        /// <returns></returns>

        [Compress]
        public JsonResult AdRegionAutoSave(CODE_DATA Cond)
        {
            RTN_SAVE_DATA data = new AdvertisingService().AdRegionAutoSave(Cond, SessionHelper.LoginInfo.MEMBER.MEMBER_CODE);
            return new JsonResult { Data = data };
        }

        #region >> 광고 장소

        [Compress]
        public PartialViewResult PV_AdplaceList(T_AD_PLACE_COND Cond)
        {
            ViewBag.list = new AdvertisingService().GetAdplaceList(Cond);
            return PartialView2();
        }


        /// <summary>                                                                                      
        /// T_AD_PLACE 저장하기(광고장소 - T_AD_PLACE 저장 -  saveparam Query)										  
        /// </summary>																					  
        /// <param name="list"></param>																	  
        /// <returns></returns>									
        [Compress]
        public JsonResult AdplaceSave(List<T_AD_PLACE> list, int? AD_CODE=0)
        {
            RTN_SAVE_DATA data = new AdvertisingService().AdplaceSave(list, AD_CODE,  SessionHelper.LoginInfo.MEMBER.MEMBER_CODE);
            return new JsonResult { Data = data };
        }

        #endregion

        /// <summary>
        /// 서브배너 View 페이지
        /// </summary>
        /// <param name="Param"></param>
        /// <returns></returns>
        [Compress]
        public ActionResult AdSub(T_AD_SUB Param, long? id = null)
        {

            Param.AD_CODE = (long)(id == null ? Param.AD_CODE : id);  
            ViewBag.data = new AdvertisingService().GetAdSubList(Param);
            return View();
        }

        [Compress]
        public PartialViewResult PV_AdSubList(T_AD_SUB Cond)
        {
            ViewBag.data = Cond;
            ViewBag.list = new AdvertisingService().GetAdSubList(Cond);
            return PartialView2();
        }

        [Compress]
        public JsonResult AdSubSave(List<T_AD_SUB> list)
        {
            RTN_SAVE_DATA data = new AdvertisingService().AdSubSave(list);
            return new JsonResult { Data = data };
        }


        [Compress]
        public JsonResult GetAdplaceList(T_AD_PLACE_COND Param)
        {
            return new JsonResult { Data = new AdvertisingService().GetAdplaceList(Param).Select(s => new DAUM_MAPLIST { TITLE = "", LATITUDE = s.LATITUDE, LONGITUDE = s.LONGITUDE, LINK_URL = "" }).ToList() };
        }

        [Compress]
        public PartialViewResult pv_AdShareDevicelist(AD_SHARE_DEVICE_MAIN_COND Cond)
        {
            ViewBag.list = new DeviceService().GetAdShareDeviceList(Cond);
            return PartialView2();
        }

        [Compress]
        public PartialViewResult pv_AdShareSignagelist(AD_SHARE_SIGNAGE_COND Cond)
        {
            ViewBag.list = new DeviceService().GetAdShareSignageList(Cond);
            return PartialView2();
        }
        [Compress]
        public ActionResult AdSignInfo(long? id)
        {
            id = id ?? -1;
            ViewBag.list = new LoggalBoxService().GetadSigninfoSignageList(new T_AD_SIGNINFO_SIGNAGE_COND { SIGN_CODE = id, HIDE = false });
            ViewBag.SIGN_CODE = id == null?0 : id;
            return View();
        }
        [Compress]
        public JsonResult AdStatusApprovalSave(T_AD_STATUS Cond)
        {
            Cond.REG_CODE = (int)(SessionHelper.LoginInfo.MEMBER.MEMBER_CODE == null ? 0 : SessionHelper.LoginInfo.MEMBER.MEMBER_CODE);
            RTN_SAVE_DATA data = new AdvertisingService().AdStatusApprovalSave(Cond);
            return new JsonResult { Data = data };
        }



        /// <summary>
        /// 상세보기화면
        /// </summary>
        /// <param name="id"></param>
        /// <param name="deviceCode"></param>
        /// <param name="bannerKind"></param>
        /// <returns></returns>
        [Compress]
        public ActionResult ContentView(long id, long? deviceCode = null, int bannerKind = 2)
        {

            T_AD dataSel = new AdvertisingService().GetT_AD_List(id).FirstOrDefault();
          
            string deviceName = "";

            if (deviceCode != null)
            {
                var device = new LoggalBoxService().GetLoggalBoxList(new LOGGAL_BOX_COND { DEVICE_CODE = deviceCode }).FirstOrDefault();
                deviceName = device == null ? "" : device.DEVICE_NAME;
            }

            T_AD_PLAY_LOG_MONGO param = new T_AD_PLAY_LOG_MONGO()
            {
                DEVICE_CODE = deviceCode,
                DEVICE_NAME = deviceName,
                AD_CODE = id,
                TITLE = dataSel.TITLE,
                DEVICE_KIND = (deviceCode == null ? 1 : 2),
                DEVICE_KIND_NAME = (deviceCode == null ? "모바일" : "로컬박스"),
                FRAME_TYPE = 1,
                FRAME_TYPE_NAME = "1 Frame",
                BANNER_TYPE2 = 1,
                BANNER_TYPE2_NAME = "이미지",
                BANNER_KIND = bannerKind,
                BANNER_KIND_NAME = bannerKind == 1 ? "내배너" : "일반배너",
                PLAY_TYPE = 2,
                PLAY_TYPE_NAME = "클릭",
                PLAY_TIME = 30,
                REMARK = ""
            };

            Task.Run(async () =>
            {
                //new CommonService().GetCommon(new T_COMMON_COND() { ADD_COND = "AND MAIN_CODE IN ('A010','B008','H002','L003','P004')" }).Select(s => new { s.MAIN_CODE, s.SUB_CODE, s.NAME });
                new MongoDBService().AdPlayLogSave(param);
                await Task.FromResult(false);
            });
            ViewBag.data = dataSel;
            ViewBag.deviceCode = deviceCode;
            return View();
        }

        /// <summary>
        /// 상세보기시 클릭수 추가
        /// </summary>
        /// <param name="Param"></param>
        /// <returns></returns>
        [Compress]
        public JsonResult AdContentClickSave(LOGGAL_AD_COND Param)
        {

            RTN_SAVE_DATA data = new AdvertisingService().AdContentClickSave(Param);
            return new JsonResult { Data = data };
        }

    }
}