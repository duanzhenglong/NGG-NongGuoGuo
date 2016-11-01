//
//  NGGConst.m
//  NGG-NongGuoGuo
//
//  Created by administrator on 16/10/10.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import <UIKit/UIKit.h>

//头像地址前缀
NSString * const HeaderPrefix = @"http://10.110.5.87:8888/NongGuoGuo/images/header/";
//物品图片地址前缀
NSString * const GoodsimagesPrefix = @"http://10.110.5.87:8888/NongGuoGuo/images/Goodsimages/";
//新闻图片地址前缀
NSString * const NewsPrefix = @"http://10.110.5.87:8888/NongGuoGuo/images/News/";

/*1.登陆接口URL*/
NSString * const LoginURL = @"http://10.110.5.87:8888/NongGuoGuo/index.php/home/user/login";
/*2.注册接口URL*/
NSString * const RegisterURL = @"http://10.110.5.87:8888/NongGuoGuo/index.php/home/user/register";
/*3.忘记密码接口URL*/
NSString * const ForgetPwdURL = @"http://10.110.5.87:8888/NongGuoGuo/index.php/home/user/Forgetpassword";
/*4.农业新闻接口URL*/
NSString * const NewsURL = @"http://10.110.5.87:8888/NongGuoGuo/index.php/home/News/inqurieNews";
/*5.采购大厅所有物品数据接口URL*/
NSString * const allNeedlistURL = @"http://10.110.5.87:8888/NongGuoGuo/index.php/home/needlist/allNeedlist";
/*6.采购大厅物品分类数据查询接口URL*/
NSString * const inquireNeedlistURL = @"http://10.110.5.87:8888/NongGuoGuo/index.php/home/needlist/inquireNeedlist";
/*7.用户信息查询接口URL*/
NSString * const inquireUserInfoURL = @"http://10.110.5.87:8888/NongGuoGuo/index.php/home/user/inquireUserInfo";
/***8.按需求表id查询***/
NSString * const inqureGoodsInfoByIdURL = @"http://10.110.5.87:8888/NongGuoGuo/index.php/home/needlist/inqureGoodsInfoById";
/***9.卖家查询买家已查看的报价信息***/
NSString * const inqureAlrQuotationURL = @"http://10.110.5.87:8888/NongGuoGuo/index.php/home/Quotationlist/inqureAlrQuotation";
/***10.卖家发布报价信息***/
NSString * const publishQuotationURL = @"http://10.110.5.87:8888/NongGuoGuo/index.php/home/Quotationlist/publishQuotation";
/***11.卖家发布供货信息***/
NSString * const publishSupplyURL = @"http://10.110.5.87:8888/NongGuoGuo/index.php/home/supplylist/publishSupply";
/***12.卖家发布供货照片信息***/
NSString * const uploadimageURL = @"http://10.110.5.87:8888/NongGuoGuo/index.php/home/supplylist/uploadimage";
/***13.卖家我的供应***/
NSString * const mysupplyURL = @"http://10.110.5.87:8888/NongGuoGuo/index.php/home/supplylist/mysupply";
/***14.卖家首页中的今日推荐中的信息***/
NSString * const RecommedURL = @"http://10.110.5.87:8888/NongGuoGuo/index.php/home/needlist/Recommed";
/***15.卖家首页中的搜索的信息***/
NSString * const GoodsIdNeedlistURL = @"http://10.110.5.87:8888/NongGuoGuo/index.php/home/needlist/GoodsIdNeedlist";
/***16.查询我的特权信息***/
NSString * const inqurePrivilegeURL = @"http://10.110.5.87:8888/NongGuoGuo/index.php/home/privilegelist/inqurePrivilege";
/***17.购买特权***/
NSString * const addPrivilegeURL = @"http://10.110.5.87:8888/NongGuoGuo/index.php/home/privilegelist/addPrivilege";
/***18.根据物品类别查询对应的物品***/
NSString * const lookGoodsURL = @"http://10.110.5.87:8888/NongGuoGuo/index.php/home/Goods/lookGoods";
/***19.查询地区的id和名称***/
NSString * const inqureAlladdressURL = @"http://10.110.5.87:8888/NongGuoGuo/index.php/home/Address/inqureAlladdress";
/***20.上传订单信息***/
NSString * const addorderURL = @"http://10.110.5.87:8888/NongGuoGuo/index.php/home/Order/addorder";
/***21.买家查看订单信息***/
NSString * const buyorderURL = @"http://10.110.5.87:8888/NongGuoGuo/index.php/home/Order/buyorder";
/***22.买家取消订单信息***/
NSString * const CancleorderURL = @"http://10.110.5.87:8888/NongGuoGuo/index.php/home/Order/Cancleorder";
/***23.卖家查看订单信息***/
NSString * const sellerorderURL = @"http://10.110.5.87:8888/NongGuoGuo/index.php/home/Order/sellerorder";
/***24.买家收藏***/
NSString * const collectgoodsURL = @"http://10.110.5.87:8888/NongGuoGuo/index.php/home/mycollect/collectgoods";
/***25.卖家收藏***/
NSString * const scollectgoodsURL = @"http://10.110.5.87:8888/NongGuoGuo/index.php/home/mycollect2/collectgoods";
/***26.用户认证***/
NSString * const certificationURL = @"http://10.110.5.87:8888/NongGuoGuo/index.php/home/user/certification";


//############################################################################

/*7.查看用户地址*/
NSString *const LookAddressURL = @"http://10.110.5.87:8888/NongGuoGuo/index.php/home/address/lookaddress";

/*8.修改用户地址*/
NSString *const UpdateAddressURL = @"http://10.110.5.87:8888/NongGuoGuo/index.php/home/address/updateaddress";

/*9.新增用户地址*/
NSString *const AddAddressURL = @"http://10.110.5.87:8888/NongGuoGuo/index.php/home/address/addaddress";

/*10.删除用户地址*/
NSString *const RemoveAddressURL = @"http://10.110.5.87:8888/NongGuoGuo/index.php/home/address/removeaddress";

/*11.选择默认地址*/
NSString *const ChooseAddrssURL = @"http://10.110.5.87:8888/NongGuoGuo/index.php/home/address/chooseaddrss";

/*12.更改头像*/
NSString *const UpdateHeaderimgURL = @"http://10.110.5.87:8888/NongGuoGuo/index.php/home/user/updateheaderimg";

/*13.下载头像*/
NSString *const DownLoadHeaderImgURL =@"http://10.110.5.87:8888/NongGuoGuo/images/header/";

/*14.修改密码*/
NSString *const UpdatePwdURL = @"http://10.110.5.87:8888/NongGuoGuo/index.php/home/user/updatepwd";




/*15.查看个人信息 或 更新用户信息*/
NSString *const CheckPersonalInfoURL = @"http://10.110.5.87:8888/NongGuoGuo/index.php/home/user/checkpersonalinfo";

/*16.更改用户昵称*/
NSString *const UpdateNickURL = @"http://10.110.5.87:8888/NongGuoGuo/index.php/home/user/updatenick";

/*17.更改用户手机号*/
NSString *const UpdatePhoneURL = @"http://10.110.5.87:8888/NongGuoGuo/index.php/home/user/updatephone";

/*18.职业展示*/
NSString *const ShowJobURL = @"http://10.110.5.87:8888/NongGuoGuo/index.php/home/job/showjob";


/*19.个人详细信息*/
NSString *const LookInfoURL = @"http://10.110.5.87:8888/NongGuoGuo/index.php/home/user/lookinfo";

/*20.职业数据上传*/
NSString *const ChooseJobURL = @"http://10.110.5.87:8888/NongGuoGuo/index.php/home/job/choosejob";


/*21.意见反馈*/
NSString *const AddAdviceURL = @"http://10.110.5.87:8888/NongGuoGuo/index.php/home/advice/addadvice";



//############################################################################



/*7.供应大厅所有物品数据接口URL*/
NSString *const QuerySupplyURL =
@"http://10.110.5.87:8888/NongGuoGuo/index.php/home/Select/QuerySupply";

/*8.我的采购信息物品数据接口URL*/
NSString *const QueryMyPurchaseURL =
@"http://10.110.5.87:8888/NongGuoGuo/index.php/home/Select/QueryMyPurchase";

/*9.查询采购信息接口URL*/
NSString *const PurchaseURL =
@"http://10.110.5.87:8888/NongGuoGuo/index.php/home/Select/Purchase";
/*10.水果信息接口URL*/
NSString *const FruitsURL =
@"http://10.110.5.87:8888/NongGuoGuo/index.php/home/Select/Fruits";
/*11.蔬菜信息接口URL*/
NSString *const VegetablesURL =
@"http://10.110.5.87:8888/NongGuoGuo/index.php/home/Select/Vegetables";

/*12.粮油信息接口URL*/
NSString *const OilsURL =
@"http://10.110.5.87:8888/NongGuoGuo/index.php/home/Select/Oils";

/*13.水产信息接口URL*/
NSString *const FisheriesURL =
@"http://10.110.5.87:8888/NongGuoGuo/index.php/home/Select/Fisheries";
/*14.禽畜信息接口URL*/
NSString *const LivestockURL =
@"http://10.110.5.87:8888/NongGuoGuo/index.php/home/Select/Livestock";
/*15.用户删除采购接口URL*/
NSString *const CancelPurchaseURL =
@"http://10.110.5.87:8888/NongGuoGuo/index.php/home/Select/CancelPurchase";
/*16.为你推荐接口URL*/
NSString *const SuggestForYouURL =
@"http://10.110.5.87:8888/NongGuoGuo/index.php/home/Select/SuggestForYou";
/*17.最新供应接口URL*/
NSString *const NewSupplyURL =
@"http://10.110.5.87:8888/NongGuoGuo/index.php/home/Select/NewSupply";
/*18.轮播器图片接口URL*/
NSString *const HeadimgURL =
@"http://10.110.5.87:8888/NongGuoGuo/index.php/home/Select/Headimg";

/*19.发布采购接口URL*/
NSString *const AddNeedURL =
@"http://10.110.5.87:8888/NongGuoGuo/index.php/home/Select/AddNeed";
/*20.发布采购接口URL*/
NSString *const PrivilegesURL =
@"http://10.110.5.87:8888/NongGuoGuo/index.php/home/Select/Privileges";
/*21.往我的采购表里写数据接口URL*/
NSString *const myPurchaseURL =
@"http://10.110.5.87:8888/NongGuoGuo/index.php/home/Select/myPurchase";
/*22.买家搜索数据接口URL*/
NSString *const GoodsIdSupplylistURL =
@"http://10.110.5.87:8888/NongGuoGuo/index.php/home/supplylist/GoodsIdSupplylist";

























