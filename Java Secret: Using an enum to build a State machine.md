
<!DOCTYPE HTML>
<html class='v2' dir='ltr'>
<head>
<meta content='text/html; charset=UTF-8' http-equiv='Content-Type'/>
<script type="text/javascript">(function() { var b=window,f="chrome",g="tick",k="jstiming";(function(){function d(a){this.t={};this.tick=function(a,d,c){var e=void 0!=c?c:(new Date).getTime();this.t[a]=[e,d];if(void 0==c)try{b.console.timeStamp("CSI/"+a)}catch(h){}};this[g]("start",null,a)}var a;b.performance&&(a=b.performance.timing);var n=a?new d(a.responseStart):new d;b.jstiming={Timer:d,load:n};if(a){var c=a.navigationStart,h=a.responseStart;0<c&&h>=c&&(b[k].srt=h-c)}if(a){var e=b[k].load;0<c&&h>=c&&(e[g]("_wtsrt",void 0,c),e[g]("wtsrt_","_wtsrt",h),e[g]("tbsd_","wtsrt_"))}try{a=null,
b[f]&&b[f].csi&&(a=Math.floor(b[f].csi().pageT),e&&0<c&&(e[g]("_tbnd",void 0,b[f].csi().startE),e[g]("tbnd_","_tbnd",c))),null==a&&b.gtbExternal&&(a=b.gtbExternal.pageT()),null==a&&b.external&&(a=b.external.pageT,e&&0<c&&(e[g]("_tbnd",void 0,b.external.startE),e[g]("tbnd_","_tbnd",c))),a&&(b[k].pt=a)}catch(p){}})();b.tickAboveFold=function(d){var a=0;if(d.offsetParent){do a+=d.offsetTop;while(d=d.offsetParent)}d=a;750>=d&&b[k].load[g]("aft")};var l=!1;function m(){l||(l=!0,b[k].load[g]("firstScrollTime"))}b.addEventListener?b.addEventListener("scroll",m,!1):b.attachEvent("onscroll",m);
 })();</script>
<meta content='blogger' name='generator'/>
<link href='http://vanillajava.blogspot.com/favicon.ico' rel='icon' type='image/x-icon'/>
<link href='http://vanillajava.blogspot.com/2011/06/java-secret-using-enum-as-state-machine.html' rel='canonical'/>
<link rel="alternate" type="application/atom+xml" title="Vanilla #Java - Atom" href="http://vanillajava.blogspot.com/feeds/posts/default" />
<link rel="alternate" type="application/rss+xml" title="Vanilla #Java - RSS" href="http://vanillajava.blogspot.com/feeds/posts/default?alt=rss" />
<link rel="service.post" type="application/atom+xml" title="Vanilla #Java - Atom" href="http://www.blogger.com/feeds/1729822519392175009/posts/default" />

<link rel="alternate" type="application/atom+xml" title="Vanilla #Java - Atom" href="http://vanillajava.blogspot.com/feeds/3233131739935168850/comments/default" />
<!--[if IE]><script type="text/javascript" src="https://www.blogger.com/static/v1/jsbin/3147806688-ieretrofit.js"></script>
<![endif]-->
<link href='http://t2.gstatic.com/images?q=tbn:ANd9GcQuPJJYVwYKMdS-oKpV0eumb8e3B140f1flSOnxQeeD37nxuIDu' rel='image_src'/>
<link href='https://plus.google.com/101646886860537518487' rel='publisher'/>
<!--[if IE]> <script> (function() { var html5 = ("abbr,article,aside,audio,canvas,datalist,details," + "figure,footer,header,hgroup,mark,menu,meter,nav,output," + "progress,section,time,video").split(','); for (var i = 0; i < html5.length; i++) { document.createElement(html5[i]); } try { document.execCommand('BackgroundImageCache', false, true); } catch(e) {} })(); </script> <![endif]-->
<title>Vanilla #Java: Java Secret: Using an enum to build a State machine.</title>
<meta content='!' name='fragment'/>
<meta content='dynamic' name='blogger-template'/>
<meta content='IE=9,chrome=1' http-equiv='X-UA-Compatible'/>
<meta content='initial-scale=1.0, maximum-scale=1.0, user-scalable=no, width=device-width' name='viewport'/>
<link type='text/css' rel='stylesheet' href='https://www.blogger.com/static/v1/widgets/1535467126-widget_css_2_bundle.css' />
<link type='text/css' rel='stylesheet' href='https://www.blogger.com/dyn-css/authorization.css?targetBlogID=1729822519392175009&zx=cf679617-f7b1-4e74-8be9-54187334c4c2' />
<style id='page-skin-1' type='text/css'><!--
/*-----------------------------------------------
Blogger Template Style
Name: Dynamic Views
----------------------------------------------- */
/* Variable definitions
====================
<Variable name="keycolor" description="Main Color" type="color" default="#ffffff"
variants="#2b256f,#00b2b4,#4ba976,#696f00,#b38f00,#f07300,#d0422c,#f37a86,#7b5341"/>
<Group description="Page">
<Variable name="page.text.font" description="Font" type="font"
default="'Helvetica Neue Light', HelveticaNeue-Light, 'Helvetica Neue', Helvetica, Arial, sans-serif"/>
<Variable name="page.text.color" description="Text Color" type="color"
default="#333333" variants="#333333"/>
<Variable name="body.background.color" description="Background Color" type="color"
default="#EEEEEE"
variants="#dfdfea,#d9f4f4,#e4f2eb,#e9ead9,#f4eed9,#fdead9,#f8e3e0,#fdebed,#ebe5e3"/>
</Group>
<Variable name="body.background" description="Body Background" type="background"
color="#EEEEEE" default="$(color) none repeat scroll top left"/>
<Group description="Header">
<Variable name="header.background.color" description="Background Color" type="color"
default="#F3F3F3" variants="#F3F3F3"/>
</Group>
<Group description="Header Bar">
<Variable name="primary.color" description="Background Color" type="color"
default="#333333" variants="#2b256f,#00b2b4,#4ba976,#696f00,#b38f00,#f07300,#d0422c,#f37a86,#7b5341"/>
<Variable name="menu.font" description="Font" type="font"
default="'Helvetica Neue Light', HelveticaNeue-Light, 'Helvetica Neue', Helvetica, Arial, sans-serif"/>
<Variable name="menu.text.color" description="Text Color" type="color"
default="#FFFFFF" variants="#FFFFFF"/>
</Group>
<Group description="Links">
<Variable name="link.font" description="Link Text" type="font"
default="'Helvetica Neue Light', HelveticaNeue-Light, 'Helvetica Neue', Helvetica, Arial, sans-serif"/>
<Variable name="link.color" description="Link Color" type="color"
default="#009EB8"
variants="#2b256f,#00b2b4,#4ba976,#696f00,#b38f00,#f07300,#d0422c,#f37a86,#7b5341"/>
<Variable name="link.hover.color" description="Link Hover Color" type="color"
default="#009EB8"
variants="#2b256f,#00b2b4,#4ba976,#696f00,#b38f00,#f07300,#d0422c,#f37a86,#7b5341"/>
<Variable name="link.visited.color" description="Link Visited Color" type="color"
default="#009EB8"
variants="#2b256f,#00b2b4,#4ba976,#696f00,#b38f00,#f07300,#d0422c,#f37a86,#7b5341"/>
</Group>
<Group description="Blog Title">
<Variable name="blog.title.font" description="Font" type="font"
default="'Helvetica Neue Light', HelveticaNeue-Light, 'Helvetica Neue', Helvetica, Arial, sans-serif"/>
<Variable name="blog.title.color" description="Color" type="color"
default="#555555" variants="#555555"/>
</Group>
<Group description="Blog Description">
<Variable name="blog.description.font" description="Font" type="font"
default="'Helvetica Neue Light', HelveticaNeue-Light, 'Helvetica Neue', Helvetica, Arial, sans-serif"/>
<Variable name="blog.description.color" description="Color" type="color"
default="#555555" variants="#555555"/>
</Group>
<Group description="Post Title">
<Variable name="post.title.font" description="Font" type="font"
default="'Helvetica Neue Light', HelveticaNeue-Light, 'Helvetica Neue', Helvetica, Arial, sans-serif"/>
<Variable name="post.title.color" description="Color" type="color"
default="#333333" variants="#333333"/>
</Group>
<Group description="Date Ribbon">
<Variable name="ribbon.color" description="Color" type="color"
default="#666666" variants="#2b256f,#00b2b4,#4ba976,#696f00,#b38f00,#f07300,#d0422c,#f37a86,#7b5341"/>
<Variable name="ribbon.hover.color" description="Hover Color" type="color"
default="#AD3A2B" variants="#AD3A2B"/>
</Group>
<Variable name="blitzview" description="Initial view type"
type="automatic" default="sidebar"/>
*/
/* BEGIN CUT */
{
"font:Text": "'Helvetica Neue Light', HelveticaNeue-Light, 'Helvetica Neue', Helvetica, Arial, sans-serif",
"color:Text": "#333333",
"image:Background": "#EEEEEE none repeat scroll top left",
"color:Background": "#dfdfea",
"color:Header Background": "#f3f3f3",
"color:Primary": "#2b256f",
"color:Menu Text": "#ffffff",
"font:Menu": "'Helvetica Neue Light', HelveticaNeue-Light, 'Helvetica Neue', Helvetica, Arial, sans-serif",
"font:Link": "'Helvetica Neue Light', HelveticaNeue-Light, 'Helvetica Neue', Helvetica, Arial, sans-serif",
"color:Link": "#2b256f",
"color:Link Visited": "#2b256f",
"color:Link Hover": "#2b256f",
"font:Blog Title": "'Helvetica Neue Light', HelveticaNeue-Light, 'Helvetica Neue', Helvetica, Arial, sans-serif",
"color:Blog Title": "#555555",
"font:Blog Description": "'Helvetica Neue Light', HelveticaNeue-Light, 'Helvetica Neue', Helvetica, Arial, sans-serif",
"color:Blog Description": "#555555",
"font:Post Title": "'Helvetica Neue Light', HelveticaNeue-Light, 'Helvetica Neue', Helvetica, Arial, sans-serif",
"color:Post Title": "#333333",
"color:Ribbon": "#2b256f",
"color:Ribbon Hover": "#ad3a2b",
"view": "magazine"
}
/* END CUT */

--></style>
<style id='template-skin-1' type='text/css'><!--
body {
min-width: 960px;
}
.column-center-outer {
margin-top: 46px;
}
.content-outer, .content-fauxcolumn-outer, .region-inner {
min-width: 960px;
max-width: 960px;
_width: 960px;
}
.main-inner .columns {
padding-left: 0;
padding-right: 310px;
}
.main-inner .fauxcolumn-center-outer {
left: 0;
right: 310px;
/* IE6 does not respect left and right together */
_width: expression(this.parentNode.offsetWidth -
parseInt("0") -
parseInt("310px") + 'px');
}
.main-inner .fauxcolumn-left-outer {
width: 0;
}
.main-inner .fauxcolumn-right-outer {
width: 310px;
}
.main-inner .column-left-outer {
width: 0;
right: 100%;
margin-left: -0;
}
.main-inner .column-right-outer {
width: 310px;
margin-right: -310px;
}
#layout {
min-width: 0;
}
#layout .content-outer {
min-width: 0;
width: 800px;
}
#layout .region-inner {
min-width: 0;
width: auto;
}
--></style>
<script src='//www.blogblog.com/dynamicviews/76f25a6f2e06af76/js/thirdparty/jquery.js' type='text/javascript'></script>
<script src='//www.blogblog.com/dynamicviews/76f25a6f2e06af76/js/thirdparty/jquery-mousewheel.js' type='text/javascript'></script>
<script src='//www.blogblog.com/dynamicviews/76f25a6f2e06af76/js/common.js' type='text/javascript'></script>
<script src='//www.blogblog.com/dynamicviews/76f25a6f2e06af76/js/languages/lang__en_gb.js' type='text/javascript'></script>
<script src='//www.blogblog.com/dynamicviews/76f25a6f2e06af76/js/magazine.js' type='text/javascript'></script>
<script src='//www.blogblog.com/dynamicviews/76f25a6f2e06af76/js/gadgets.js' type='text/javascript'></script>
<script src='//www.blogblog.com/dynamicviews/4224c15c4e7c9321/js/comments.js'></script>
<script type="text/javascript">var a="indexOf",b="&m=1",e="(^|&)m=",f="?",g="?m=1";function h(){var c=window.location.href,d=c.split(f);switch(d.length){case 1:return c+g;case 2:return 0<=d[1].search(e)?null:c+b;default:return null}}var k=navigator.userAgent;if(-1!=k[a]("Mobile")&&-1!=k[a]("WebKit")&&-1==k[a]("iPad")||-1!=k[a]("Opera Mini")||-1!=k[a]("IEMobile")){var l=h();l&&window.location.replace(l)};
</script><script type="text/javascript">
if (window.jstiming) window.jstiming.load.tick('headEnd');
</script></head>
<body class='variant-magazine'>
<div class='content'>
<div class='content-outer'>
<div class='fauxborder-left content-fauxborder-left'>
<div class='content-inner'>
<div class='main-outer'>
<div class='fauxborder-left main-fauxborder-left'>
<div class='region-inner main-inner'>
<div class='columns fauxcolumns'>
<div class='column-center-outer'>
<div class='column-center-inner'>
<div class='main section' id='main'>
</div>
</div>
</div>
<div class='column-right-outer'>
<div class='column-right-inner'>
<aside>
<div class='sidebar section' id='sidebar-right-1'>
</div>
</aside>
</div>
</div>
<div style='clear: both'></div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
<script language='javascript' type='text/javascript'>
      setTimeout(function() {
        blogger.ui().configure().view();
      }, 0);
    </script>
<script type="text/javascript">
if (window.jstiming) window.jstiming.load.tick('widgetJsBefore');
</script><script type="text/javascript" src="https://www.blogger.com/static/v1/widgets/1093374584-widgets.js"></script>
<script type="text/javascript" src="https://apis.google.com/js/plusone.js"></script>
<script type='text/javascript'>
if (typeof(BLOG_attachCsiOnload) != 'undefined' && BLOG_attachCsiOnload != null) { window['blogger_templates_experiment_id'] = "templatesV2";window['blogger_blog_id'] = '1729822519392175009';BLOG_attachCsiOnload('item_'); }_WidgetManager._Init('//www.blogger.com/rearrange?blogID\x3d1729822519392175009','//vanillajava.blogspot.com/2011/06/java-secret-using-enum-as-state-machine.html','1729822519392175009');
_WidgetManager._SetDataContext([{'name': 'blog', 'data': {'blogId': '1729822519392175009', 'bloggerUrl': 'http://www.blogger.com', 'title': 'Vanilla #Java', 'pageType': 'item', 'postId': '3233131739935168850', 'url': 'http://vanillajava.blogspot.com/2011/06/java-secret-using-enum-as-state-machine.html', 'canonicalUrl': 'http://vanillajava.blogspot.com/2011/06/java-secret-using-enum-as-state-machine.html', 'canonicalHomepageUrl': 'http://vanillajava.blogspot.com/', 'homepageUrl': 'http://vanillajava.blogspot.com/', 'blogspotFaviconUrl': 'http://vanillajava.blogspot.com/favicon.ico', 'enabledCommentProfileImages': true, 'adultContent': false, 'disableAdSenseWidget': false, 'analyticsAccountNumber': '', 'searchLabel': '', 'searchQuery': '', 'pageName': 'Java Secret: Using an enum to build a State machine.', 'pageTitle': 'Vanilla #Java: Java Secret: Using an enum to build a State machine.', 'encoding': 'UTF-8', 'locale': 'en_GB', 'localeUnderscoreDelimited': 'en_gb', 'isPrivate': false, 'isMobile': false, 'isMobileRequest': false, 'mobileClass': '', 'isPrivateBlog': false, 'languageDirection': 'ltr', 'feedLinks': '\74link rel\75\42alternate\42 type\75\42application/atom+xml\42 title\75\42Vanilla #Java - Atom\42 href\75\42http://vanillajava.blogspot.com/feeds/posts/default\42 /\76\n\74link rel\75\42alternate\42 type\75\42application/rss+xml\42 title\75\42Vanilla #Java - RSS\42 href\75\42http://vanillajava.blogspot.com/feeds/posts/default?alt\75rss\42 /\76\n\74link rel\75\42service.post\42 type\75\42application/atom+xml\42 title\75\42Vanilla #Java - Atom\42 href\75\42http://www.blogger.com/feeds/1729822519392175009/posts/default\42 /\76\n\n\74link rel\75\42alternate\42 type\75\42application/atom+xml\42 title\75\42Vanilla #Java - Atom\42 href\75\42http://vanillajava.blogspot.com/feeds/3233131739935168850/comments/default\42 /\76\n', 'meTag': '', 'openIdOpTag': '', 'googleProfileUrl': 'https://plus.google.com/101646886860537518487', 'postImageUrl': 'http://t2.gstatic.com/images?q\75tbn:ANd9GcQuPJJYVwYKMdS-oKpV0eumb8e3B140f1flSOnxQeeD37nxuIDu', 'latencyHeadScript': '\74script type\75\42text/javascript\42\76(function() { var b\75window,f\75\42chrome\42,g\75\42tick\42,k\75\42jstiming\42;(function(){function d(a){this.t\75{};this.tick\75function(a,d,c){var e\75void 0!\75c?c:(new Date).getTime();this.t[a]\75[e,d];if(void 0\75\75c)try{b.console.timeStamp(\42CSI/\42+a)}catch(h){}};this[g](\42start\42,null,a)}var a;b.performance\46\46(a\75b.performance.timing);var n\75a?new d(a.responseStart):new d;b.jstiming\75{Timer:d,load:n};if(a){var c\75a.navigationStart,h\75a.responseStart;0\74c\46\46h\76\75c\46\46(b[k].srt\75h-c)}if(a){var e\75b[k].load;0\74c\46\46h\76\75c\46\46(e[g](\42_wtsrt\42,void 0,c),e[g](\42wtsrt_\42,\42_wtsrt\42,h),e[g](\42tbsd_\42,\42wtsrt_\42))}try{a\75null,\nb[f]\46\46b[f].csi\46\46(a\75Math.floor(b[f].csi().pageT),e\46\0460\74c\46\46(e[g](\42_tbnd\42,void 0,b[f].csi().startE),e[g](\42tbnd_\42,\42_tbnd\42,c))),null\75\75a\46\46b.gtbExternal\46\46(a\75b.gtbExternal.pageT()),null\75\75a\46\46b.external\46\46(a\75b.external.pageT,e\46\0460\74c\46\46(e[g](\42_tbnd\42,void 0,b.external.startE),e[g](\42tbnd_\42,\42_tbnd\42,c))),a\46\46(b[k].pt\75a)}catch(p){}})();b.tickAboveFold\75function(d){var a\0750;if(d.offsetParent){do a+\75d.offsetTop;while(d\75d.offsetParent)}d\75a;750\76\75d\46\46b[k].load[g](\42aft\42)};var l\75!1;function m(){l||(l\75!0,b[k].load[g](\42firstScrollTime\42))}b.addEventListener?b.addEventListener(\42scroll\42,m,!1):b.attachEvent(\42onscroll\42,m);\n })();\74/script\076', 'mobileHeadScript': '', 'adsenseClientId': 'pub-2617001371505250', 'ieCssRetrofitLinks': '\74!--[if IE]\76\74script type\75\42text/javascript\42 src\75\42https://www.blogger.com/static/v1/jsbin/3147806688-ieretrofit.js\42\76\74/script\76\n\74![endif]--\076', 'view': '', 'dynamicViewsCommentsSrc': '//www.blogblog.com/dynamicviews/4224c15c4e7c9321/js/comments.js', 'dynamicViewsScriptSrc': '//www.blogblog.com/dynamicviews/76f25a6f2e06af76', 'plusOneApiSrc': 'https://apis.google.com/js/plusone.js', 'sf': 'n', 'tf': ''}}, {'name': 'skin', 'data': {'vars': {'primary_color': '#2b256f', 'link_font': '\47Helvetica Neue Light\47, HelveticaNeue-Light, \47Helvetica Neue\47, Helvetica, Arial, sans-serif', 'blitzview': 'magazine', 'page_text_font': '\47Helvetica Neue Light\47, HelveticaNeue-Light, \47Helvetica Neue\47, Helvetica, Arial, sans-serif', 'body_background': '#EEEEEE none repeat scroll top left', 'menu_text_color': '#ffffff', 'keycolor': '#2b256f', 'ribbon_color': '#2b256f', 'link_color': '#2b256f', 'ribbon_hover_color': '#ad3a2b', 'blog_title_color': '#555555', 'page_text_color': '#333333', 'link_hover_color': '#2b256f', 'blog_description_font': '\47Helvetica Neue Light\47, HelveticaNeue-Light, \47Helvetica Neue\47, Helvetica, Arial, sans-serif', 'header_background_color': '#f3f3f3', 'blog_description_color': '#555555', 'link_visited_color': '#2b256f', 'post_title_font': '\47Helvetica Neue Light\47, HelveticaNeue-Light, \47Helvetica Neue\47, Helvetica, Arial, sans-serif', 'menu_font': '\47Helvetica Neue Light\47, HelveticaNeue-Light, \47Helvetica Neue\47, Helvetica, Arial, sans-serif', 'post_title_color': '#333333', 'body_background_color': '#dfdfea', 'blog_title_font': '\47Helvetica Neue Light\47, HelveticaNeue-Light, \47Helvetica Neue\47, Helvetica, Arial, sans-serif'}, 'override': ''}}, {'name': 'view', 'data': {'classic': {'name': 'classic', 'url': '?view\75classic'}, 'flipcard': {'name': 'flipcard', 'url': '?view\75flipcard'}, 'magazine': {'name': 'magazine', 'url': '?view\75magazine'}, 'mosaic': {'name': 'mosaic', 'url': '?view\75mosaic'}, 'sidebar': {'name': 'sidebar', 'url': '?view\75sidebar'}, 'snapshot': {'name': 'snapshot', 'url': '?view\75snapshot'}, 'timeslide': {'name': 'timeslide', 'url': '?view\75timeslide'}}}]);
_WidgetManager._RegisterWidget('_NavbarView', new _WidgetInfo('Navbar1', 'sidebar-right-1', null, document.getElementById('Navbar1'), {}, 'displayModeFull'));
_WidgetManager._RegisterWidget('_HeaderView', new _WidgetInfo('Header1', 'sidebar-right-1', null, document.getElementById('Header1'), {}, 'displayModeFull'));
_WidgetManager._RegisterWidget('_HTMLView', new _WidgetInfo('HTML2', 'sidebar-right-1', null, document.getElementById('HTML2'), {}, 'displayModeFull'));
_WidgetManager._RegisterWidget('_SubscribeView', new _WidgetInfo('Subscribe1', 'sidebar-right-1', null, document.getElementById('Subscribe1'), {}, 'displayModeFull'));
_WidgetManager._RegisterWidget('_StatsView', new _WidgetInfo('Stats1', 'sidebar-right-1', null, document.getElementById('Stats1'), {'title': 'Pageviews', 'showGraphicalCounter': false, 'showAnimatedCounter': false, 'showSparkline': true, 'statsUrl': '//vanillajava.blogspot.com/b/stats?style\75WHITE_TRANSPARENT\46timeRange\75ALL_TIME\46token\75DDwNvEcBAAA.i8W5_IqJz9RLn-HtJR7wcoCSWpTWSxitWyKZFGD7_dA.HiKY75Ol3F8nZroNxR4gCQ'}, 'displayModeFull'));
_WidgetManager._RegisterWidget('_ImageView', new _WidgetInfo('Image2', 'sidebar-right-1', null, document.getElementById('Image2'), {'resize': false}, 'displayModeFull'));
_WidgetManager._RegisterWidget('_BlogArchiveView', new _WidgetInfo('BlogArchive1', 'sidebar-right-1', null, document.getElementById('BlogArchive1'), {'languageDirection': 'ltr'}, 'displayModeFull'));
_WidgetManager._RegisterWidget('_FollowersView', new _WidgetInfo('Followers1', 'sidebar-right-1', null, document.getElementById('Followers1'), {}, 'displayModeFull'));
_WidgetManager._RegisterWidget('_HTMLView', new _WidgetInfo('HTML1', 'sidebar-right-1', null, document.getElementById('HTML1'), {}, 'displayModeFull'));
_WidgetManager._RegisterWidget('_ProfileView', new _WidgetInfo('Profile1', 'sidebar-right-1', null, document.getElementById('Profile1'), {}, 'displayModeFull'));
_WidgetManager._RegisterWidget('_ImageView', new _WidgetInfo('Image1', 'sidebar-right-1', null, document.getElementById('Image1'), {'resize': false}, 'displayModeFull'));
_WidgetManager._RegisterWidget('_AttributionView', new _WidgetInfo('Attribution1', 'sidebar-right-1', null, document.getElementById('Attribution1'), {'attribution': 'Peter Lawrey. Dynamic Views template. Powered by \74a href\75\47http://www.blogger.com\47 target\75\47_blank\47\76Blogger\74/a\76.'}, 'displayModeFull'));
_WidgetManager._RegisterWidget('_BlogView', new _WidgetInfo('Blog1', 'main', null, document.getElementById('Blog1'), {'cmtInteractionsEnabled': false, 'showBacklinks': true, 'postId': '3233131739935168850', 'lightboxEnabled': true, 'lightboxModuleUrl': 'https://www.blogger.com/static/v1/jsbin/1433668789-lbx__en_gb.js', 'lightboxCssUrl': 'https://www.blogger.com/static/v1/v-css/2392111094-lightbox_bundle.css'}, 'displayModeFull'));
</script>
</body>
</html>