var home_full_player, $home_full_player, home_full_player_id = "home-full-video", $home_full_player_wrap;

function home_full_onYouTubeIframeAPIReady(){
    console.log("home_full_onYouTubeIframeAPIReady")
    $home_full_player = $("#" + home_full_player_id)
    $home_full_player_wrap = $home_full_player.parent()
    var w = window.innerWidth
    var h = window.innerHeight
    home_full_player = new YT.Player(

        home_full_player_id, {
            width: w,
            height: h,
            videoId: 'M7lc1UVf-VE',
            events: {
                onReady: home_full_onPlayerReady,
                onStateChange: home_full_onPlayerStateChange,
                onError: home_full_onError
            }
        }
    )
}

function home_full_play(){
    home_full_player.playVideo()
}

function home_full_stop(){
    home_full_player.stopVideo()
}

window.youtube_player_states = {"-1": "unstarted", "0": "ended", "1": "playing", "2": "paused", "3": "buffering", "5": "video_cued"}

function home_full_onPlayerStateChange(event){
    var state = event.data
    console.log("onPlayerStateChange: state: ", state)
    var state_str = youtube_player_states[state]

    $home_full_player_wrap.attr("data-state", state_str)
}

function home_full_onError(){

}

function home_full_onPlayerReady(){

}
