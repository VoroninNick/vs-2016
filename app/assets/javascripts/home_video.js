window.$home_player = null
var home_player, home_player_id = "home-youtube-video-bg", $home_player_wrap;
window.youtube_player_states = {"-1": "unstarted", "0": "ended", "1": "playing", "2": "paused", "3": "buffering", "5": "video_cued"}


function home_onYouTubeIframeAPIReady(){
    //console.log("home_onYouTubeIframeAPIReady")
    window.$home_player = $("#" + home_player_id)
    $home_player_wrap = $home_player.parent()
    var w = window.innerWidth
    var h = window.innerHeight
    home_player = new YT.Player(

        home_player_id, {
            width: w,
            height: h,
            videoId: 'M7lc1UVf-VE',
            events: {
                onReady: home_onPlayerReady,
                onStateChange: home_onPlayerStateChange,
                onError: home_onError
            }
        }
    )
}


window.set_frame_size = function(){
    var w = $home_player.width()
    var h = $home_player.height()
    var ratio = w / h
    var frame_view_port_w = $home_player.attr("width")
    var frame_view_port_h = $home_player.attr("height")
    var frame_view_port_ratio = frame_view_port_w / frame_view_port_h
    var scale = ratio / frame_view_port_ratio
    //if(scale)
    var scale_str = "scale(" + scale + ")"
    //alert("frame_view_port_ratio: " + frame_view_port_ratio + "ratio: " + ratio )

    var css_props = css_vendors({"transform": scale_str})
    $home_player.css(css_props)
}

function home_onPlayerStateChange(event){
    console.log("home_onPlayerStateChange")
    var state = event.data
    //console.log("home_onPlayerStateChange: state: ", state)
    var state_str = youtube_player_states[state]

    $home_player_wrap.attr("data-state", state_str)

}

function home_onError(){

}

function home_onPlayerReady(){
    console.log("home_onPlayerReady")
    //home_onPlayerStateChange({data: "1"})
    //set_frame_size()
}
