var home_player, $home_player, home_player_id = "home-youtube-video-bg", $home_player_wrap;
window.youtube_player_states = {"-1": "unstarted", "0": "ended", "1": "playing", "2": "paused", "3": "buffering", "5": "video_cued"}


function home_onYouTubeIframeAPIReady(){
    console.log("home_onYouTubeIframeAPIReady")
    $home_player = $("#" + home_player_id)
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


function home_onPlayerStateChange(event){
    var state = event.data
    console.log("onPlayerStateChange: state: ", state)
    var state_str = youtube_player_states[state]

    $home_player_wrap.attr("data-state", state_str)
}

function home_onError(){

}

function home_onPlayerReady(){

}
