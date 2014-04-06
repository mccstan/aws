conf =
        w : 1000
        h : 600
        c_top : 350
        c_w   : 300
        c_h   : 200
        s_top : 20
        s_left: 380
        s_w   : 100
        s_h   : 300
        rou_w : 60
        d_top : 20
        d_left: 600
        d_w   : 400

routes =
        '/play'         :  20
        '/api/userlist' :  70
        '/api/challenge': 150
        '/api/accept'   : 210
        '/api/reject'   : 270

div = $ '#app-logic'

# Svg canvas, for arrows etc.
svg = (Snap conf.w, conf.h).appendTo div


# The two clients
c1 = div.append 'div#client1.client
        <table><tr><td><a href="javascript:">client2</a></td></tr>
        <tr><td><a>client3</a></td></tr><tr><td>...</td></tr></table>
        <p class="msg"></p>'
c2 = div.append 'div#client2.client
        <table><tr><td>client2</td></tr>
        <tr><td><a>client3</a></td></tr><tr><td>...</td></tr></table>
        <p>Client 1 vous a invité à jouer. Accepter ? 
        <button id="oui">Oui</button>
        <button class="non">Non</button></p>'

# The database
db = div.append 'div#db
        <table><tr><th>login</th><th>joue</th><tr>
        <tr><td>client1</td><td class="joue">NULL</td></tr>
        <tr><td>client2</td><td class="joue">NULL</td></tr>
        <tr><td>...</td><td>...</td></tr></table>
        <table><tr><th>id</th><th>état</th></tr>
        <tr><td>123</td><td class="etat"></td></tr></table>'

# The server
s = div.append 'div#server'
for route, pos of routes
        (s.append "p.route #{route}").css
                top      : pos + 'px'
                width    : conf.s_w + conf.rou_w + 'px'
                left     : '-30px'

# JSON
(div.append '''p.response
<div class="polling">{
  "users" : [
    { "login" : "client1",
      "parties" : 10, ... },
      ...
  ],
<div id="notification-ch">  "notification" : {
    "type"  : "challenge",
    "login" : "client1" }
</div>}</div>''').css
        top  : 140 + 'px'
        left : 600 + 'px'
(div.append '''p.response
<div class="polling">{
  "users" : [
    { "login" : "client1",
      "parties" : 10, ... },
      ...
  ],
<div id="notification-ac" style="display:none">  "notification" : {
    "type"  : "accept",
    "login" : "client2" }
</div><div id="notification-re">  "notification" : {
    "type"  : "reject",
    "login" : "client2" }
</div>}</div>''').css
        top  : 40 + 'px'
        left : 60 + 'px'

# Arrows
svg.rect(0,0,conf.w,conf.h).attr
        'fill': svg.path('M 0,0 L 0,100 100,100 100,0 z').attr('stroke' : '#ddd', 'fill':'none').pattern(0,0,100,100)

route_l = conf.s_left - conf.rou_w / 2
route_r = conf.s_left + conf.s_w  + conf.rou_w / 2
route_t = (r) -> routes[r] + conf.s_top + 10

arrow = svg.path 'M -4,-6 L 10,0 -4,6 0,0 Z'
        .marker -4,-6,14,12,10,0
        .attr 'orient' : 'auto'

req = svg.g().attr
        'stroke' : 'black'
        'fill'   : 'none'
        'marker-end' : arrow
req.path "M #{route_r},#{route_t('/api/userlist')}
        t 40,0 40,60 130,40
        T #{conf.w - conf.c_w / 2},#{conf.c_top}"
        .attr 'class' : 'polling'
req.path "M #{route_l},#{route_t('/api/userlist')}
        t -70,0 -130,100 
        T 70,#{conf.c_top}"
        .attr 'class' : 'polling'
req.path "M #{conf.c_w - 40},#{conf.c_top}
        t 20,-80
        T #{route_l},#{route_t('/api/challenge')}"
req.path "M #{conf.w - conf.c_w},#{conf.c_top + conf.c_h / 2}
        t -60,0 -60,-100
        T #{route_r},#{route_t('/api/accept')}"
req.path "M #{conf.w - conf.c_w},#{conf.c_top + conf.c_h / 2}
        t -60,0 -60,-80
        T #{route_r},#{route_t('/api/reject')}"

play = svg.g().attr
        'stroke' : 'black'
        'fill'   : 'none'
        'marker-end' : arrow

play.path "M #{conf.c_w / 2},#{conf.c_top}
        t 10,-100
        T #{route_l},#{route_t('/play')}"
play.path "M #{conf.w - conf.c_w / 2},#{conf.c_top}
        t -10,-60 -130,-60 -130,-90
        T #{route_r},#{route_t('/play')}"
        
svg.path "M #{conf.s_left + conf.s_w},#{conf.s_top - 10}
        L #{conf.d_left},#{conf.d_top - 10}"
        .attr
                'stroke' : 'black'
                'fill'   : 'none'
                'marker-start' : arrow.clone().attr 'orient' : '180'
                'marker-end'   : arrow


# Generic CSS
div.append 'style
@keyframes pulse {
        0%   { opacity: 1 }
        30%  { opacity: 0.3 }
        70%  { opacity: 0.3 }
        100% { opacity: 1 }
}
@-webkit-keyframes pulse {
        0%   { opacity: 1 }
        30%  { opacity: 0.3 }
        70%  { opacity: 0.3 }
        100% { opacity: 1 }
}
'

div.css
        margin   : 'auto'
        position : 'relative'
        width    : conf.w + 'px'
        height   : conf.h + 'px'

        '#server, .client, #db, svg, .route, .response' : 
                position : 'absolute'
        '#server, .client, #db' : 
                fontSize : '70%'
        '#server, .client, #db table' : 
                border : 'solid thin black'
                borderRadius : '5px'
        
        '#server' : 
                left   : conf.s_left + 'px'
                top    : conf.s_top + 'px'
                width  : conf.s_w + 'px'
                height : conf.s_h + 'px'
        '.route' : 
                fontFamily      : 'Monospace, mono'
                backgroundColor : 'white'
                textAlign       : 'center'
                margin          : 0

        '#db' : 
                width     : conf.d_w + 'px'
                top       : conf.d_top + 'px'
                left      : conf.d_left + 'px'
                textAlign : 'center'
        '#db table' :
                display       : 'inline-table'
                width         : '45%'
                verticalAlign : 'top'

        '.client' : 
                width    : conf.c_w - 20 + 'px'
                height   : conf.c_h - 20 + 'px'
                top      : conf.c_top + 'px'
                padding  : '10px'
        '#client1' :
                left  : '0px' 
        '#client2' :
                right : '0px' 

        '.response' :
                fontFamily : 'Monospace, mono'
                fontSize   : '50%'
                whiteSpace : 'pre'
                backgroundColor: 'white'
        '.polling' :
                animation : 'pulse 2s linear infinite'
                '-webkit-animation' : 'pulse 2s linear infinite'

        'table' : 
                border : 'solid thin black'
                margin : 'auto'
        'td, th' : 
                borderLeft : 'solid thin black'
                padding : '2px'
        '.client table' : 
                width : '80%'
        'a:not([href])' :  
                color : 'red'

# Add a legend
legend = (elt, legend, placement) ->
        l = elt.append "p #{legend}"
        css =
            position  : 'absolute'
            textAlign : 'center'
            fontSize  : '130%'
            width     : elt.style.width
        css[placement or 'bottom'] = '-2.3em'
        l.css css

legend s,  'Server', 'top'
legend c1, 'Client 1'
legend c2, 'Client 2'
legend db, 'Database', 'top'
