function initCufon() {
	Cufon.replace('#nav > li > a', { fontFamily: 'YUFuturaB', hover: true });
	Cufon.replace('.main-block .three-col .col h2', { fontFamily: 'YUFuturaB' });
	Cufon.replace('.main-block .buttons-box div h2', { fontFamily: 'YUFuturaB' });
	Cufon.replace('.main-block .buttons-box .sign-up', { fontFamily: 'YUFuturaB', hover: true });
	Cufon.replace('.main-block .buttons-box .more', { fontFamily: 'YUFuturaB', hover: true });
	Cufon.replace('#content h2', { fontFamily: 'YUFuturaB' });
	Cufon.replace('#content .title .view', { fontFamily: 'YUFuturaB', hover: true });
	Cufon.replace('#content .post .text h3', { fontFamily: 'YUFuturaB' });
	Cufon.replace('#content .post .skils .row h4', { fontFamily: 'YUFuturaB' });
	Cufon.replace('#content .post .buttons li a', { fontFamily: 'YUFuturaB', hover: true });
	Cufon.replace('#content .post .invite .plus-box', { fontFamily: 'YUFuturaB' });
	Cufon.replace('#sidebar .box h3', { fontFamily: 'YUFuturaB' });
	Cufon.replace('#sidebar .box .title .view', { fontFamily: 'YUFuturaB', hover: true });
	Cufon.replace('#sidebar .box .users li .info .name a', { fontFamily: 'YUFuturaB', hover: true });
	Cufon.replace('#sidebar .box .users li .info .points li', { fontFamily: 'YUFuturaB', hover: true });
	Cufon.replace('#sidebar .all a', { fontFamily: 'YUFuturaB', hover: true });
	Cufon.replace('#sidebar .search-form label', { fontFamily: 'YUFuturaB' });
	Cufon.replace('.sort-holder .results li .text-info .state', { fontFamily: 'YUFuturaB' });
	Cufon.replace('.sort-holder .results li .text-info .name', { fontFamily: 'YUFuturaB' });
	Cufon.replace('#content .events-list li .text-info .theme', { fontFamily: 'YUFuturaB' });
	Cufon.replace('.global-info h2', { fontFamily: 'YUFuturaB' });
	Cufon.replace('.badge #content .global-info .list li', { fontFamily: 'YUFuturaB' });
	Cufon.replace('.causes-skills li', { fontFamily: 'YUFuturaB' });
	Cufon.replace('.badge #content .text-info p', { fontFamily: 'YUFuturaB' });
	Cufon.replace('#content .promo-buttons .btn', { fontFamily: 'YUFuturaB, hover: true ' });
	Cufon.replace('.cart-info .cart-text h3', { fontFamily: 'YUFuturaB' });
	Cufon.replace('.cart-info .cart-text .dc', { fontFamily: 'YUFuturaB' });
	Cufon.replace('.cart-info .cart-text .even', { fontFamily: 'YUFuturaB' });
	Cufon.replace('.cart-info .cart-text .row .suggest-btn', { fontFamily: 'YUFuturaB, hover: true ' });
	Cufon.replace('.cart-info .effected li strong', { fontFamily: 'YUFuturaB' });
	Cufon.replace('.user-info h2', { fontFamily: 'YUFuturaB' });
	Cufon.replace('.steps-block .holder li strong', { fontFamily: 'YUFuturaB' });
	Cufon.replace('.steps-block .holder li span', { fontFamily: 'YUFuturaB' });
	Cufon.replace('.select-block h3', { fontFamily: 'YUFuturaB' });
	Cufon.replace('.select-block .list li a', { fontFamily: 'YUFuturaB' });
	Cufon.replace('.select-block .box .heading strong', { fontFamily: 'YUFuturaB' });
	Cufon.replace('.form-notice h3', { fontFamily: 'YUFuturaB' });
	Cufon.replace('.form-notice label', { fontFamily: 'YUFuturaB' });
	Cufon.replace('.quick-block .column a', { fontFamily: 'YUFuturaB', hover: true  })
	Cufon.replace('.quick-block .holder li .ttl', { fontFamily: 'YUFuturaB' });
	Cufon.replace('.quick-block .btn-holder li a', { fontFamily: 'YUFuturaB', hover: true  })
}

Event.observe(window, 'load', function() { 
	initCufon();
});

/*
$(document).ready(function(){
	initCufon();
});
*/