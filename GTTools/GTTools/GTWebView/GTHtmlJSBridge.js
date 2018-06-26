function preprocessorJSCode(){
    if(window.WebViewJavascriptBridge) {
        return;
    }
    if(!window.onerror) {
        window.onerror = function (message,url,line,column,error) {
            console.log("WebViewJavascriptBridge: ERROR:" + msg + "@" + url + ":" + line);
        }
    }
    window.WebViewJavascriptBridge = {
      registerHandler:registerHandler,
        callHandler : callHandler,
        _handleMessageFromObjC = _handleMessageFromObjC,
        
    }
    
    function registerHandler(handleName,handler) {
        
    }
    function callHandler(data,responseCallBack) {
        
    }
    function _handleMessageFromObjC(messageJSon) {
        
    }
    function _doSendMessage(data,handleName,responseCallBack) {
        
    }
}
