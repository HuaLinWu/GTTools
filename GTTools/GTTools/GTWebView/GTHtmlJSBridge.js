function preprocessorJSCode(){
    if(window.webViewJavascriptBridge) {
        return;
    }
    if(!window.onerror) {
        window.onerror = function (message,url,line,column,error) {
            console.log("webViewJavascriptBridge: ERROR:" + msg + "@" + url + ":" + line);
        }
    }
    window.webViewJavascriptBridge = {
         registerHandler:registerHandler,
         callHandler : callHandler,
        _handleMessageFromNavtive:_handleMessageFromNavtive,
        _fetchMessageQueue :_fetchMessageQueue
    }
    var registerHandlerDict ={};
    var responseCallBackDict={};
    function registerHandler(handleName,handler) {
        if(handleName && handler) {
            registerHandlerDict[handleName] = handler;
        }
    }
    function callHandler(data,handleName,responseCallBack) {
        
    }
    function _handleMessageFromNavtive(messageJSon) {
        
    }
    function _fetchMessageQueue() {
        
    }
}
