function onYouTubeIframeAPIReady(){
    //console.log("onYouTubeIframeAPIReady")
    if (!window.YT || !YT.Player){
        console.log("onYouTubeIframeAPIReady: return")
        return
    }
    var callback_this = this, callback_args = arguments
    $(".youtube-video").each(function(){
        init_youtube_player.call(this, callback_this, callback_args)
    })

    //var key = iframe_id == "about-video" ? "about" : iframe_id == "home-full-video" ? "home_full" : "home"
    //window[key + "_" + "onYouTubeIframeAPIReady"].apply(this, arguments)
}

function init_youtube_player(callback_this, callback_args){
    var $iframe = $(this)
    if ($iframe.hasClass("ready-api")){
        return
    }

    $iframe.addClass("ready-api")

    var iframe_id = $iframe.attr("id")
    var map = {
        "home-youtube-video-bg": "home",
        "home-full-video": "home_full",
        "about-video": "about"
    }
    var key;
    //key = iframe_id.replace("-", "_")
    key = map[iframe_id]

    window[key + "_" + "onYouTubeIframeAPIReady"].apply(callback_this, callback_args)
}


onYouTubeIframeAPIReady()
$document.on("ready page:load", onYouTubeIframeAPIReady)