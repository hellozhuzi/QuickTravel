//
//  NetInterface.h
//  travelFree
//
//  Created by zhufengzhu on 15/12/20.
//  Copyright © 2015年 zhufengzhu. All rights reserved.
//

#ifndef NetInterface_h
#define NetInterface_h
//1.首页
#define kHomeUrl1 (@"http://open.qyer.com/lastminute/home/major?client_id=qyer_discount_ios&client_secret=44c86dbde623340b5e0a&track_user_id=&app_installtime=1447243904&size=375x667&track_app_version=1.8.0&track_deviceid=001619D4-DD86-4EC5-BA00-366BD4D6BF61&track_device_info=ios%2520device&track_app_channel=App%2520Store&track_os=ios%25209.1")
//精选产品
#define kHomeUrl2  (@"http://open.qyer.com/lastminute/app_selected_product?client_id=qyer_discount_ios&client_secret=44c86dbde623340b5e0a&pageSize=10&track_user_id=&ra_referer=app_home&app_installtime=1447243904&size=375x667&track_app_version=1.8.0&track_deviceid=001619D4-DD86-4EC5-BA00-366BD4D6BF61&track_device_info=ios%%2520device&page=%ld&track_app_channel=App%%2520Store&track_os=ios%%25209.1")

//首页按钮 机+酒 机票 玩乐 签证
#define kSearchToTalUrl (@"http://open.qyer.com/lastminute/app_lastminute_list?client_id=qyer_discount_ios&client_secret=44c86dbde623340b5e0a&page_size=20&track_app_channel=App%%2520Store&product_type=%ld&ra_referer=app_lastminute_list&departure=%@&lon=121.4874146073645&track_os=ios%%25209.2&track_app_version=1.9.0&track_device_info=ios%%2520device&track_deviceid=5AF77BD8-6364-4AFC-BA4E-65522BDE5455&app_installtime=1450590813&continent_id=0&size=375x667&country_id=%ld&orderName=&times=%ld&track_user_id=&lat=31.38089938320232&page=%ld&sequence=&orderValue=")


//搜索页面
#define kSearchConditionDataUrl (@"http://open.qyer.com/lastminute/get_all_categorys?client_id=qyer_discount_ios&client_secret=44c86dbde623340b5e0a&track_device_info=ios%2520device&track_deviceid=001619D4-DD86-4EC5-BA00-366BD4D6BF61&track_user_id=&country_id=0&track_os=ios%25209.1&continent_id=0&track_app_version=1.8.0&size=375x667&type=0&track_app_channel=App%2520Store&times=&app_installtime=1447243904&ra_referer=app_lastminute_list")


//2.目的地搜索

#define kDestUrl (@"http://open.qyer.com/lastminute/conf/destination?app_installtime=1450590813&client_id=qyer_discount_ios&client_secret=44c86dbde623340b5e0a&count=20&lat=31.38099517492254&lon=121.487426872485&page=1&size=375x667&track_app_channel=App%2520Store&track_app_version=1.9.0&track_device_info=ios%2520device&track_deviceid=5AF77BD8-6364-4AFC-BA4E-65522BDE5455&track_os=ios%25209.2&track_user_id=")



//3.穷游精选
#define kChoiceUrl (@"http://open.qyer.com/lastminute/get_play_and_fun?client_id=qyer_discount_ios&client_secret=44c86dbde623340b5e0a&track_user_id=&app_installtime=1447243904&size=375x667&track_app_version=1.8.0&track_deviceid=001619D4-DD86-4EC5-BA00-366BD4D6BF61&track_device_info=ios%2520device&ra_referer=choiceness&track_app_channel=App%2520Store&track_os=ios%25209.1")


//精选详情页(拼接)(用不了,Xcode说%太多了,然后加%转义就可以用了)
#define kChoiceDetailUrl (@"http://open.qyer.com/lastminute/get_list_by_id_vtwo?client_id=qyer_discount_ios&client_secret=44c86dbde623340b5e0a&source=LastMinuteTopicViewController&track_user_id=&id=%@&app_installtime=1447243904&size=375x667&track_app_version=1.8.0&track_deviceid=001619D4-DD86-4EC5-BA00-366BD4D6BF61&track_device_info=ios%%2520device&ra_referer=app_start_image&track_app_channel=App%%2520Store&track_os=ios%%25209.1")

#endif /* NetInterface_h */
