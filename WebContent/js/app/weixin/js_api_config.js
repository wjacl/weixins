
var jsApiConfig = {
	allApiList :[
			        'checkJsApi',
			        'onMenuShareTimeline',
			        'onMenuShareAppMessage',
			        'onMenuShareQQ',
			        'onMenuShareWeibo',
			        'onMenuShareQZone',
			        'hideMenuItems',
			        'showMenuItems',
			        'hideAllNonBaseMenuItem',
			        'showAllNonBaseMenuItem',
			        'translateVoice',
			        'startRecord',
			        'stopRecord',
			        'onVoiceRecordEnd',
			        'playVoice',
			        'onVoicePlayEnd',
			        'pauseVoice',
			        'stopVoice',
			        'uploadVoice',
			        'downloadVoice',
			        'chooseImage',
			        'previewImage',
			        'uploadImage',
			        'downloadImage',
			        'getNetworkType',
			        'openLocation',
			        'getLocation',
			        'hideOptionMenu',
			        'showOptionMenu',
			        'closeWindow',
			        'scanQRCode',
			        'chooseWXPay',
			        'openProductSpecificView',
			        'addCard',
			        'chooseCard',
			        'openCard'
			      ],
	config : function (apiList){
		if(apiList == undefined){
			apiList = this.allApiList
		}
		var currUrl = location.href.split('#')[0];
		
		$.ajax({url:ctx + "/weixin/comm/getJsApiSignature",
			type:"POST",
			data:{url:currUrl},
			dataType:"json",
			async: false,
			success:function(data){
				 wx.config({
				      debug: true,
				      appId: data.appid,
				      timestamp: data.timeStamp,
				      nonceStr: data.nonceStr,
				      signature: data.signature,
				      jsApiList: apiList
				  });
			}
		});
	}
}