
var wx_comm = {
	months:[{label:"1月",value:"01"},
	            {label:"2月",value:"02"},
	            {label:"3月",value:"03"},
	            {label:"4月",value:"04"},
	            {label:"5月",value:"05"},
	            {label:"6月",value:"06"},
	            {label:"7月",value:"07"},
	            {label:"8月",value:"08"},
	            {label:"9月",value:"09"},
	            {label:"10月",value:"10"},
	            {label:"11月",value:"11"},
	            {label:"12月",value:"12"}
	        ],
	        
	getMonthPickerData:function(){
		var years = [];
		var d = new Date();
		var currYear = d.getFullYear();
		var currMonth = d.getMonth() + 1;
		currMonth = currMonth < 10 ? "0" + currMonth:"" + currMonth;
		for(var i = 2017; i <= currYear; i++){
			years.push({label:i+"年",value:i})
		}
        return {years:years,months:this.months,currYear:currYear,currMonth:currMonth};
	}
}
