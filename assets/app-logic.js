(function() {
    var conf = {
	w : 1000,
	h : 600,
	c_top : 350,
	c_w   : 300,
	c_h   : 200,
	s_top : 250,
	s_w   : 100,
	s_h   : 300,
	d_top : 50,
	d_w   : 300,
    }

    var div = $('#app-logic');
    (function(s) {
	s.margin = 'auto';
	s.position = 'relative';
	s.width = conf.w + 'px';
	s.height = conf.h + 'px';
    })(div.style);

    var svg = Snap(conf.w, conf.h).appendTo(div).attr({
    });

    // The two clients
    var c1 = div.append('div');
    c1.id = 'client1';
    c1.innerHTML = '<table><tr><td><a href="javascript:">client2</a></td></tr>'
	+ '<tr><td><a>client3</a></td></tr><tr><td>...</td></tr></table>'
	+ '<p class="msg"></p>';
    var c2 = div.append('div');
    c2.id = 'client2';
    c2.innerHTML = '<table><tr><td>client2</td></tr>'
	+ '<tr><td><a>client3</a></td></tr><tr><td>...</td></tr></table>'
	+ '<form><p>Client 1 vous a invité à jouer. Accepter ? '
	+ '<button id="oui">Oui</button>'
	+ '<button class="non">Non</button></p></form>';

    [c1, c2].forEach(function(c) { c.className = 'client'; });

    // The database
    var db = div.append('div');
    db.id = 'db';
    db.innerHTML = '<table><tr><th>login</th><th>joue</th><tr>'
	+ '<tr><td>client1</td><td class="joue">NULL</td></tr>'
	+ '<tr><td>client2</td><td class="joue">NULL</td></tr>'
	+ '<tr><td>...</td><td>...</td></tr></table>';

    // The server
    var s = div.append('div');
    s.id = 'server';


    // Generic CSS
    var css = {
	'#server, .client, #db, svg' : {
	    position : 'absolute',
	    fontSize : '70%',
	},
	'#server, .client, #db table' : {
	    border : 'solid thin black',
	    borderRadius : '5px',
	},

	'#server' : {
	    left   : (conf.w - conf.s_w) / 2 + 'px',
	    top    : conf.s_top + 'px',
	    width  : conf.s_w + 'px',
	    height : conf.s_h + 'px',
	},
	'#db' : {
	    width      :conf.d_w + 'px',
	    top       : conf.d_top + 'px',
	    left      : (conf.w - conf.d_w) / 2 + 'px',
	    textAlign : 'center',
	},
	'#db table' : {
	    width      :conf.d_w + 'px',
	},
	'.client' : {
	    width    : conf.c_w - 20 + 'px',
	    height   : conf.c_h - 20 + 'px',
	    top      : conf.c_top + 'px',
	    padding  : '10px',
	},
	'#client1' : { left  : '0px' },
	'#client2' : { right : '0px' },
	'table' : {
	    border : 'solid thin black',
	    margin : 'auto',
	},
	'td, th' : {
	    borderLeft : 'solid thin black',
	    padding : '2px',
	},
	'.client table' : {
	    width : '80%',
	},
	'a:not([href])' : { 
	    color : 'red',
	},
    };
    for (var selector in css) {
	div.$$(selector).forEach(function(e) {
	    for (var prop in css[selector]) {
		e.style[prop] = css[selector][prop];
	    }
	});
    }


    // Add a legend
    function legend(elt, legend, placement) {
	var l = elt.append('p');
	l.innerHTML = legend;
	l.style.position = 'absolute';
	placement = (placement == 'top') ? 'top' : 'bottom';
	l.style[placement] = '-2.3em';
	l.style.textAlign = 'center';
	l.style.fontSize = '130%';
	l.style.width = elt.style.width;
    }
    legend(s, 'Server');
    legend(c1, 'Client 1');
    legend(c2, 'Client 2');
    legend(db, 'Database', 'top');
})();
