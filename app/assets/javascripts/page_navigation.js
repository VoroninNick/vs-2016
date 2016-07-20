function page_navigation(container_selector){
    $container = $(container_selector)
    /**
     * This part does the "fixed navigation after scroll" functionality
     * We use the jQuery function scroll() to recalculate our variables as the
     * page is scrolled/
     */
    // $(window).scroll(function(){
    //     var window_top = $(window).scrollTop() + 12; // the "12" should equal the margin-top value for nav.stick
    //     var div_top = $('#nav-anchor').offset().top;
    //     if (window_top > div_top) {
    //         $('nav').addClass('stick');
    //     } else {
    //         $('nav').removeClass('stick');
    //     }
    // });

    /**
     * This part causes smooth scrolling using scrollto.js
     * We target all a tags inside the nav, and apply the scrollto.js to it.
     */
    $container.on("click", "a:not(.active)", function(e){
        e.preventDefault()
        var $target = $(this.hash)
        var scroll_top = $target.offset().top
        $container.find("a.active").removeClass("active")
        $(this).addClass("active")
        $("html, body").scrollTop(scroll_top)
    })
    // $("nav a").click(function(evn){
    //     evn.preventDefault();
    //     $('html,body').scrollTo(this.hash, this.hash);
    // });

    /**
     * This part handles the highlighting functionality.
     * We use the scroll functionality again, some array creation and
     * manipulation, class adding and class removing, and conditional testing
     */
    var aChildren = $container.find("a"); // find the a children of the list items
    var aArray = []; // create the empty aArray
    for (var i=0; i < aChildren.length; i++) {
        var aChild = aChildren[i];
        var ahref = $(aChild).attr('href');
        aArray.push(ahref);
    } // this for loop fills the aArray with attribute href values

    $(window).scroll(function(){
        var windowPos = $(window).scrollTop(); // get the offset of the window from the top of page
        var windowHeight = $(window).height(); // get the height of the window
        var docHeight = $(document).height();

        for (var i=0; i < aArray.length; i++) {
            var theID = aArray[i];
            var divPos = $(theID).offset().top; // get the offset of the div from the top of page
            var divHeight = $(theID).height(); // get the height of the div in question
            if (windowPos >= divPos && windowPos < (divPos + divHeight)) {
                $("a[href='" + theID + "']").addClass("active");
            } else {
                $("a[href='" + theID + "']").removeClass("active");
            }
        }

        if(windowPos + windowHeight == docHeight) {
            if (!$container.find("a:last-child").hasClass("active")) {
                var navActiveCurrent = $container.find("a.active").attr("href");
                $("a[href='" + navActiveCurrent + "']").removeClass("active");
                $container.find("a:last-child").addClass("active");
            }
        }
    });

    $window.on("scroll", function(){
        var $appeared_elements = $("[data-navigation-color]").filter(":appeared")
        var container_offset = $container.offset()
        if(!container_offset){
            return
        }
        var container_top = container_offset.top
        var container_bottom = container_top + $container.height()
        var $appeared_element = $appeared_elements.first()

        if($appeared_element.length == 0){
            $container.removeClass("dark")
            return true
        }

        var appeared_element_top = $appeared_element.offset().top
        var appeared_element_bottom = appeared_element_top + $appeared_element.height()
        var over_element = (appeared_element_top <= container_top && appeared_element_bottom >= container_top ) || (appeared_element_bottom >= container_bottom && appeared_element_top <= container_top)
        if(over_element){
            $container.addClass("dark")
        }
        else{
            $container.removeClass("dark")
        }
    })
}

page_navigation(".project-navigation")