console.history = [];
var oldConsole = {};
for (var i in console) {
    if (typeof console[i] == 'function') {
        oldConsole[i] = console[i];
        var strr = '(function(){\
            console.history.push({func:\'' + i + '\',args : Array.prototype.slice.call(arguments)});\
            oldConsole[\'' + i + '\'].apply(console, arguments);\
        })';
        console[i] = eval(strr);
    }
}
//
// window.onerror = function (e) {
//     //console.log("onerror", arguments)
//     alert("window.onerror")
//     //return true;
// }

// window.addEventListener("onerror", function(){
//     alert("window.addEventListener - onerror")
// })

window.addEventListener("error", function(){
    //alert("window.addEventListener - error")
    //console.log("error", this, arguments)
})