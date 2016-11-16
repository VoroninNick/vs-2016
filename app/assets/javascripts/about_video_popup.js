var about_player, $about_player, about_player_id = "about-video", $about_player_wrap;

function about_onYouTubeIframeAPIReady(){
    console.log("about_onYouTubeIframeAPIReady")
    $about_player = $("#" + about_player_id)
    $about_player_wrap = $about_player.parent()
    var w = window.innerWidth
    var h = window.innerHeight
    about_player = new YT.Player(

        about_player_id, {
            width: w,
            height: h,
            videoId: 'M7lc1UVf-VE',
            events: {
                onReady: about_onPlayerReady,
                onStateChange: about_onPlayerStateChange,
                onError: about_onError
            }
        }
    )
}

function about_play(){
    about_player.playVideo()
}

function about_stop(){
    about_player.stopVideo()
}

window.youtube_player_states = {"-1": "unstarted", "0": "ended", "1": "playing", "2": "paused", "3": "buffering", "5": "video_cued"}

function about_onPlayerStateChange(event){
    var state = event.data
    console.log("onPlayerStateChange: state: ", state)
    var state_str = youtube_player_states[state]

    $about_player_wrap.attr("data-state", state_str)
}

function about_onError(){

}

function about_onPlayerReady(){

}
