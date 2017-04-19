// https://gist.github.com/simonhearne/ef145e2732f2082771d3

(function(window){

    /* clears any divs we've created before */
    function cl() {
        // clear colours
        var s=document.getElementsByClassName('fpser-lay');
        var l = s.length-1;
        for (var i=l;i>=0;i--) {
            try {document.body.removeChild(s[i])} catch(e) {continue;}
        }
        // clear overlay
        var e = document.getElementById('fpser'); // remove overlay if it's already there
        if (e) e.parentNode.removeChild(e);
    }

    /* scrolls the page to the bottom */
    function s2b() {
        cl();
        window.scrollTo(0,0); // reset screen position
        count = 0;
        sh = Math.max(document.documentElement.clientHeight, window.innerHeight || 0);
        h = Math.max(document.body.offsetHeight,document.body.scrollHeight) - sh;
        chunk = 100; // scrollwheel distance?
        if (h - 100 < 0) {
            alert ('I need to scroll, please reduce your browser height or choose a longer page!');
            throw 'Too short';
        }
        fA=[];
        window.requestAnimationFrame(sl);
        ll=false;
    }

    /* scrolls the page by one scroll-wheel turn and gets framerate */
    function sl() {
        if (!ll) {
            ll = performance.now();
            window.requestAnimationFrame(sl);
            return;
        }
        window.scrollBy(0,chunk);
        tl = performance.now();
        fA.push(parseInt(1000/(tl-ll)));
        ll = tl;
        count += chunk;
        if (count >= h) {
            window.scrollTo(0,0);
            cF(fA);
        } else {
            window.requestAnimationFrame(sl);
        }
    }

    /* creates the google chart API URL */
    function spl(v) {
        d=enc(v,100);
        var w=350;
        var g=1;
        var cw=Math.max(parseInt((w/v.length)-g),2);
        var url = "https://chart.googleapis.com/chart?chbh="+cw+","+g+"&cht=bvs&chxt=y&chf=bg,s,00000000&chs=350x60&chm=D,FF0000,1,0,2,1&chd=" + d;
        console.log(url.length);
        return url.substr(0,url.length-1);
    }

    var EM='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-.';
    var EL=EM.length;
    function enc(arrVals, maxVal) {
        var cD = 'e:';
        for(i = 0, len = arrVals.length; i < len; i++) {
            // In case the array vals were translated to strings.
            var numericVal = new Number(arrVals[i]);
            // Scale the value to maxVal.
            var scaledVal = Math.floor(EL *
                EL * numericVal / maxVal);

            if(scaledVal > (EL * EL) - 1) {
                cD += "..";
            } else if (scaledVal < 0) {
                cD += '__';
            } else {
                // Calculate first and second digits and add them to the output.
                var quotient = Math.floor(scaledVal / EL);
                var remainder = scaledVal - EL * quotient;
                cD += EM.charAt(quotient) + EM.charAt(remainder);
            }
        }
        return cD;
    }

    /* creates overlays */
    function cF(v) {
        //v.shift();
        var k = v.slice(0); // take a copy before sorting

        // calculate median by sorting and select middle
        v.sort( function(a,b) {return a - b;} );
        var half = Math.floor(v.length/2);
        if(v.length % 2)
            var med = v[half];
        else
            var med = (v[half-1] + v[half]) / 2.0;

        // min and max from sorted array
        var mi = v[0];
        var ma = v[v.length-1];

        // mean by summing array and divide by total
        var to = 0;
        for (var i=0; i<v.length; i++) {
            to+=v[i];
        }
        var mn = parseInt(to/v.length);

        var c = spl(k);

        // create the summary box
        var d=document.createElement('div');
        d.id='fpser';
        d.style.cssText+=";font-family:sans-serif;font-weight:bold;width:400px;background:rgba(200,200,200,0.9);position:fixed;top:10px;right:10px;z-index:10002;padding:5px;box-shadow: 0px 0px 5px 2px rgba(0,0,0,0.75);text-align:center";
        var p=document.createElement('p');
        p.innerHTML='FPS: median = '+med + ', mean = '+mn + ', min = '+mi + ', max = '+ma;
        p2=document.createElement('p');

        if (med <= 50) {
            p2.style.color="red";
            p2.innerHTML="This page is JANKY (Framerate is below 50 FPS)";
        } else if (med >= 59) {
            p2.style.color="green";
            p2.innerHTML="This page is SMOOTH (Framerate around 60 FPS)";
        } else {
            p2.style.color="yellow";
            p2.innerHTML="This page is ALMOST JANKY (Framerate above 50 FPS)";
        }
        p3=document.createElement('p');
        p3.innerHTML="<a href='https://webperf.ninja/2015/jank-meter'>What is this?</a> | <a href='#' onclick='window.FPS.cl();'>Hide this</a>."

        // insert google chart image
        var i=document.createElement('img');
        i.src=c;
        d.appendChild(p);
        d.appendChild(i);
        d.appendChild(p2);
        d.appendChild(p3);
        document.body.appendChild(d);

        // create framerate indicator strip
        var j=0;

        for (var i = sh;i<=(h+sh);i+=100) {
            var c = document.createElement('div');
            c.className='fpser-lay';
            var co = "";
            if (parseInt(k[j])<50) {
                co="255,55,0";
            } else if (parseInt(k[j])<59) {
                co="255,255,0";
            } else if (parseInt(k[j])>0) {
                co="55,255,55";
            } else {
                co="55,55,55";
            }
            c.style.cssText+=";border-bottom:1px solid black;line-height:"+chunk+"px;text-align:center;font-weight:bold;z-index:10001;position:absolute;width:80px;height:"+chunk+"px;left:0;top:"+i+"px;background:rgba("+co+",0.5);";
            if (parseInt(k[j])>0) {
                var m = document.createElement('p');
                m.style.cssText+=";margin:0px";
                m.innerHTML = k[j]+" FPS";
                c.appendChild(m);
            }
            document.body.appendChild(c);
            j++;
        }
        var c = document.createElement('div');
        c.className='fpser-lay';
        c.style.cssText+=";z-index:10001;position:absolute;width:80px;height:"+sh+"px;left:0;top:0;background:rgba(55,55,55,0.5);";
        document.body.appendChild(c);
    }
    s2b();
    window.FPS={};
    window.FPS.cl=cl;
})(window);