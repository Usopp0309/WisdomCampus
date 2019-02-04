/**
Core script to handle the entire theme and core functions
**/
function Attendance() {

    // IE mode
    var onWorkNormalList ;
    var offWorkNormalList ;
    var latelList ;
    var leavelList ;
    var absenteeismList ;
    var abnormalInList ;
    var abnormalOutList ;
    
    // To get the correct viewport width based on  http://andylangton.co.uk/articles/javascript/get-viewport-size-javascript/
    this._getOnWorkNormalList = function () {
        return onWorkNormalList;
    }
    this._setOnWorkNormalList = function (onWorkNormalListParam) {
    	onWorkNormalList = onWorkNormalListParam;
    }
    this._getOffWorkNormalList = function () {
        return offWorkNormalList;
    }
    this._setOffWorkNormalList = function (offWorkNormalListParam) {
    	offWorkNormalList = offWorkNormalListParam;
    }
    this._getLatelList = function () {
        return latelList;
    }
    this._setLatelList = function (latelListParam) {
    	latelList = latelListParam;
    }
    this._getLeavelList = function () {
        return leavelList;
    }
    this._setLeavelList = function (leavelListParam) {
    	leavelList = leavelListParam;
    }
    this._getAbsenteeismList = function () {
        return absenteeismList;
    }
    this._setAbsenteeismList = function (absenteeismListParam) {
    	absenteeismList = absenteeismListParam;
    }
    this._getAbnormalInList = function () {
        return abnormalInList;
    }
    this._setAbnormalInList = function (abnormalInListParam) {
    	abnormalInList = abnormalInListParam;
    }
    this._getAbnormalOutList = function () {
        return abnormalOutList;
    }
    this._setAbnormalOutList = function (abnormalOutListParam) {
    	abnormalOutList = abnormalOutListParam;
    }
}