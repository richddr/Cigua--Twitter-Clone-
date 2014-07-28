<%-- 
    Document   : searchHashtag
    Created on : Jul 8, 2014, 12:34:53 AM
    Author     : Richard
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.List"%>
<%@page import="edu.pucmm.pw.parcial2.entidades.Tweet"%>
<%@page import="edu.pucmm.pw.parcial2.entidades.Usuario"%>
<%@page import="edu.pucmm.pw.parcial2.servicios.TweetServicio"%>
<%@page import="edu.pucmm.pw.parcial2.servicios.HashtagServicio"%>
<%@page import="edu.pucmm.pw.parcial2.servicios.UsuarioServicio"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%

    //Esta busqueda es general, se pueden buscar tanto usuarios como hashtags.
    //Una busqueda de Hashtag comienza con "#"
    UsuarioServicio us = new UsuarioServicio();
    HashtagServicio hs = new HashtagServicio();
    TweetServicio ts = new TweetServicio();
    
    boolean userNotLoggedIn = false;
    boolean noQuerySpecified = false;
    boolean allGood= false;
    boolean qForHt = false;
    boolean qForUsers = false;
    boolean tieneImagen = false;
    Usuario lu = (Usuario)request.getSession().getAttribute("usuarioLogueado");
    String q = request.getParameter("q");
    
    List<Tweet> tweetsByHT = null;
    List<Usuario> userByMatchingQuery = null;
    if(lu != null){
        if(q != null){
            //se debe determinar si el query es una busqueda de hashtag o usuario
            //Puede ser que pongan mas de una palabra pero solo nos interesa la primera
            String[] queries = q.split(" ");
            if(queries[0].charAt(0) == '#'){//empieza con pound es un hashtag.
                qForHt = true;
                tweetsByHT = ts.getTweetsByHashtag(queries[0]);
            }
            else{
                //no empienza con pound, no es un hashtag, es una busqueda de usuario by username.
                qForUsers = true;
                userByMatchingQuery = us.getUsersByMatchingUsername(queries[0]);
            }
            
        }
        else{
            noQuerySpecified = true;
        }
    }
    else{
        userNotLoggedIn = true;
    }
%>
<c:choose>
    <c:when test="<%=!userNotLoggedIn%>">
        <!DOCTYPE html>
        <html lang="en" data-scribe-reduced-action-queue="true"><!--<![endif]--><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

                <meta charset="utf-8">


                <link rel="stylesheet" href="https://abs.twimg.com/a/1404619576/css/t1/highline_rosetta_gotham_core.bundle.css">



                <title>Cigua</title>




                <meta name="msapplication-TileImage" content="//abs.twimg.com/favicons/win8-tile-144.png">
                <meta name="msapplication-TileColor" content="#00aced">



                <link rel="stylesheet" href="https://abs.twimg.com/font/gotham-narrow-v3.css">
                
                <style id="user-style-DvDHoz">

                    .btn_following:hover{
                       color: red
                    }
                    
                    .btn_notfollowing:hover{
                        color: royalblue
                    }

                    a,
                    a:hover,
                    a:focus,
                    a:active {
                        color: #0084B4;
                    }

                    .u-textUserColor,
                    .u-textUserColorHover:hover,
                    .u-textUserColorHover:focus {
                        color: #0084B4 !important;
                    }

                    .u-borderUserColor,
                    .u-borderUserColorHover:hover,
                    .u-borderUserColorHover:focus {
                        border-color: #0084B4 !important;
                    }

                    .u-bgUserColor,
                    .u-bgUserColorHover:hover,
                    .u-bgUserColorHover:focus {
                        background-color: #0084B4 !important;
                    }

                    .u-boxShadowInsetUserColorHover:hover,
                    .u-boxShadowInsetUserColorHover:focus {
                        box-shadow: inset 0 0 0 5px #0084B4 !important;
                    }



                    .u-textUserColorLight {
                        color: #99CDE1 !important;
                    }

                    .u-borderUserColorLight,
                    .u-borderUserColorLightFocus:focus,
                    .u-borderUserColorLightHover:hover,
                    .u-borderUserColorLightHover:focus {
                        border-color: #99CDE1 !important;
                    }

                    .u-bgUserColorLight {
                        background-color: #99CDE1 !important;
                    }


                    .u-boxShadowUserColorLighterFocus:focus {
                        box-shadow: 0 0 8px rgba(0, 0, 0, 0.05), inset 0 1px 2px rgba(0,132,180,0.25) !important;
                    }


                    .u-textUserColorLightest {
                        color: #E5F2F7 !important;
                    }

                    .u-borderUserColorLightest {
                        border-color: #E5F2F7 !important;
                    }

                    .u-bgUserColorLightest {
                        background-color: #E5F2F7 !important;
                    }


                    .u-textUserColorLighter {
                        color: #BFE0EC !important;
                    }

                    .u-borderUserColorLighter {
                        border-color: #BFE0EC !important;
                    }

                    .u-bgUserColorLighter {
                        background-color: #BFE0EC !important;
                    }


                    .u-bgUserColorDarkHover:hover {
                        background-color: #006990 !important;
                    }

                    .u-borderUserColorDark {
                        border-color: #006990 !important;
                    }


                    .u-bgUserColorDarkerActive:active {
                        background-color: #004F6C !important;
                    }















                    a,
                    .btn-link,
                    .btn-link:focus,
                    .icon-btn,



                    .pretty-link b,
                    .pretty-link:hover s,
                    .pretty-link:hover b,
                    .pretty-link:focus s,
                    .pretty-link:focus b,
                    /* Account Group */
                    .metadata a:hover,
                    .metadata a:focus,

                    .account-group:hover .fullname,
                    .account-group:focus .fullname,
                    .account-summary:focus .fullname,

                    .message .message-text a,
                    .stats a strong,
                    .plain-btn:hover,
                    .plain-btn:focus,
                    .dropdown.open .user-dropdown.plain-btn,
                    .open > .plain-btn,
                    #global-actions .new:before,
                    .module .list-link:hover,
                    .module .list-link:focus,

                    .UserCompletion-step:hover,

                    .stats a:hover,
                    .stats a:hover strong,
                    .stats a:focus,
                    .stats a:focus strong,

                    .profile-modal-header .fullname a:hover,
                    .profile-modal-header .username a:hover,
                    .profile-modal-header .fullname a:focus,
                    .profile-modal-header .username a:focus,

                    .story-article:hover .metadata,
                    .story-article .metadata a:focus,

                    .find-friends-sources li:hover .source,





                    .stream-item a:hover .fullname,
                    .stream-item a:focus .fullname,

                    .stream-item .view-all-supplements:hover,
                    .stream-item .view-all-supplements:focus,

                    .tweet .time a:hover,
                    .tweet .time a:focus,
                    .tweet-actions a,
                    .tweet .details.with-icn b,
                    .tweet .details.with-icn .Icon,
                    .tweet .tweet-geo-text a:hover,

                    .stream-item:hover .original-tweet .expand-action-wrapper,
                    .stream-item .original-tweet.focus .expand-action-wrapper,
                    .opened-tweet.original-tweet  .expand-action-wrapper,

                    .stream-item:hover .original-tweet .details b,
                    .stream-item .original-tweet.focus .details b,
                    .stream-item.open .original-tweet .details b,

                    .simple-tweet:hover .details b,
                    .simple-tweet.focus .details b,
                    .simple-tweet.open .details b,
                    .simple-tweet:hover .details .expand-action-wrapper,
                    .simple-tweet.focus .details .expand-action-wrapper,
                    .simple-tweet.open .details .collapse-action-wrapper,
                    .simple-tweet:hover .details .simple-details-link,
                    .simple-tweet.focus .details .simple-details-link,

                    .client-and-actions a:hover,
                    .client-and-actions a:focus,

                    .dismiss-promoted:hover b,

                    .tweet .context .pretty-link:hover s,
                    .tweet .context .pretty-link:hover b,
                    .tweet .context .pretty-link:focus s,
                    .tweet .context .pretty-link:focus b,

                    .list .username a:hover,
                    .list .username a:focus,
                    .list-membership-container .create-a-list,
                    .list-membership-container .create-a-list:hover,



                    .story-header:hover .view-tweets,
                    .card .list-details a:hover,
                    .card .list-details a:focus,
                    .card .card-body:hover .attribution,
                    .card .card-body .attribution:focus,
                    .events-card .card-body:hover .attribution,
                    .events-card .card-body .attribution:focus,
                    .new-tweets-bar,
                    .onebox .soccer ul.ticker a:hover,
                    .onebox .soccer ul.ticker a:focus,



                    .discover-item-actions a,



                    .disco-stream-item.disco_exp_actions_on_btm .more-tweet-actions .btn-link,
                    .disco-stream-item.disco_exp_actions_on_btm_without_stats .more-tweet-actions .btn-link,



                    .remove-background-btn,



                    .stream-item-activity-me .latest-tweet .tweet-row a:hover,
                    .stream-item-activity-me .latest-tweet .tweet-row a:focus,
                    .stream-item-activity-me .latest-tweet .tweet-row a:hover b,
                    .stream-item-activity-me .latest-tweet .tweet-row a:focus b,


                    .tweet-actions-sidebar a:hover .tweet-action-count,
                    .tweet-actions-sidebar a:focus .tweet-action-count {
                        color: #0084B4;
                    }



                    #global-actions > li > a {
                        border-bottom-color: #0084B4;
                    }

                    #global-actions > li:hover > a,
                    #global-actions > li > a:focus,
                    .nav.right-actions > li > a:hover,
                    .nav.right-actions > li > button:hover,
                    .nav.right-actions > li > a:focus,
                    .nav.right-actions > li > button:focus {
                        color: #0084B4;
                    }

                    /* Surpress the new connect glow if in experiment. */
                    #global-actions .people.new:before {
                        content: none;
                    }

                    /* hover state for photo select button*/
                    .photo-selector:not(.disabled):hover .btn,
                    .icon-btn:hover,
                    .icon-btn:active,
                    .icon-btn.active,
                    .icon-btn.enabled {
                        border-color: #0084B4;
                        border-color: rgba(0,132,180,.5);
                        color: #0084B4;
                    }

                    /* hover state for photo select button*/
                    .photo-selector:not(.disabled):hover .btn,
                    .icon-btn:hover {
                        background-image: linear-gradient(rgba(255,255,255,0), rgba(0,132,180,.1));
                        filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#00FFFFFF', endColorstr='#190084B4'); /* IE8-9 */
                    }

                    .icon-btn.disabled,
                    .icon-btn.disabled:hover,
                    .icon-btn[disabled],
                    .icon-btn[aria-disabled=true] {
                        color: #0084B4;
                    }

                    /* tweet-btn can have primary-btn class as well so the following rules ensure that the correct background color is applied */
                    .tweet-btn,
                    .tweet-btn:focus {
                        background-color: #0084B4;
                        background: rgba(0,132,180,.8);
                    }

                    .tweet-btn:hover,
                    .tweet-btn:active,
                    .tweet-btn.active {
                        background-color: #0084B4;
                    }

                    .tweet-btn.btn.disabled,
                    .tweet-btn.btn.disabled:hover,
                    .tweet-btn.btn[disabled],
                    .tweet-btn.btn[aria-disabled=true] {
                        background: #0084B4;
                    }

                    .btn:focus,
                    .btn.focus,
                    .Button:focus {
                        box-shadow:
                            0 0 0 1px #fff,
                            0 0 0 3px rgba(0, 132, 180, 0.5);
                    }

                    .selected-stream-item:focus {
                        box-shadow: 0 0 0 3px rgba(0, 132, 180, 0.5);
                    }

                    /**
                     * 1. Bring actionable tweet to top when active to ensure border
                     *    highlighting wraps entire tweet. Value must be at least at if not
                     *    higher than the z-index value of ProfileHeading to ensure first
                     *    tweet in timeline receives border on all four sides.
                     */

                    .ProfileTweet.is-actionable,
                    .js-stream-item.is-selected:focus .ProfileTweet,
                    .js-stream-item.is-selected:focus .ProfileCard {
                        border-color: rgba(0, 132, 180, 0.5);
                        z-index: 1; /* 1 */
                    }

                    .global-dm-nav.new.with-count .dm-new {
                        background: #0084B4;
                    }

                    .global-nav .people .count .count-inner {
                        background: #0084B4;
                    }

                    .dropdown-menu li > a:hover,
                    .dropdown-menu li > a:focus,
                    .dropdown-menu .dropdown-link:hover,
                    .dropdown-menu .dropdown-link:focus,
                    .dropdown-menu li:hover .dropdown-link,
                    .dropdown-menu li:focus .dropdown-link,
                    .dropdown-menu .typeahead-recent-search-item.selected,
                    .dropdown-menu .typeahead-saved-search-item.selected,
                    .dropdown-menu .selected a,
                    .dropdown-menu .dropdown-link.selected {
                        background-color: #0084B4;
                    }

                    /* give tweet boxes 10% of the users link color as background */
                    .home-tweet-box,
                    .dm-tweetbox,
                    .WebToast-box--altColor,
                    .content-main .conversations-enabled .expansion-container .inline-reply-tweetbox {
                        background-color: #E5F2F7;
                    }

                    .conversations-enabled .inline-reply-caret .caret-inner {
                        border-bottom-color: #E5F2F7;
                    }

                    /* give tweet boxes an outline using the users link color */
                    .tweet-box[contenteditable="true"] {
                        border-color: rgba(0,132,180,0.25);
                    }

                    input:focus,
                    textarea:focus,
                    div[contenteditable="true"]:focus,
                    div[contenteditable="true"].fake-focus {
                        border-color: #66B5D2;
                        box-shadow: inset 0 0 0 1px rgba(0, 132, 180, 0.7);
                    }

                    .currently-dragging.modal-enabled .modal .tweet-box,
                    .currently-dragging:not(.modal-enabled) .tweet-content .tweet-box,
                    body.supports-drag-and-drop .tweet-form.upload-photo-hover.drag-and-drop .tweet-box,
                    .tweet-box[contenteditable="true"]:focus {
                        border-color: #99CDE1;
                        box-shadow: none;
                    }




                    s,
                    .pretty-link:hover s,
                    .pretty-link:focus s,
                    .stream-item-activity-me .latest-tweet .tweet-row a:hover s,
                    .stream-item-activity-me .latest-tweet .tweet-row a:focus s {
                        color: #66B5D2;
                    }



                    .vellip,
                    .vellip:before,
                    .vellip:after,
                    .conversation-module > li:after,
                    .conversation-module > li:before {
                        background-color: #66B5D2;
                    }




                    .tweet .sm-reply,
                    .tweet .sm-rt,
                    .tweet .sm-fav,
                    .tweet .sm-image,
                    .tweet .sm-video,
                    .tweet .sm-audio,
                    .tweet .sm-geo,
                    .tweet .sm-in,
                    .tweet .sm-trash,
                    .tweet .sm-more,
                    .tweet .sm-page,
                    .tweet .sm-embed,
                    .tweet .sm-summary,
                    .tweet .sm-chat,

                    .timelines-navigation .active .profile-nav-icon,
                    .timelines-navigation .profile-nav-icon:hover,
                    .timelines-navigation .profile-nav-link:focus .profile-nav-icon,

                    .sm-top-tweet,

                    .metadata a.tweet-geo-text:hover .sm-geo,


                    .discover-item .js-action-card-search:hover .sm-search,
                    .discover-item .js-action-card-search:focus .sm-search {
                        background-color: #0084B4;
                    }



                    .tweet-action-icons .tweet .tweet-actions .sm-reply, .tweet-action-icons .tweet.opened-tweet .tweet-actions .sm-reply,
                    .tweet-action-icons .tweet .tweet-actions .sm-rt, .tweet-action-icons .tweet.opened-tweet .tweet-actions .sm-rt,
                    .tweet-action-icons .tweet .tweet-actions .sm-fav, .tweet-action-icons .tweet.opened-tweet .tweet-actions .sm-fav,
                    .tweet-action-icons .tweet .tweet-actions .sm-trash, .tweet-action-icons .tweet.opened-tweet .tweet-actions .sm-trash,
                    .tweet-action-icons .tweet .tweet-actions .sm-more, .tweet-action-icons .tweet.opened-tweet .tweet-actions .sm-more {
                        background-color: #66B5D2;
                    }

                    .persistent-tweet-actions.tweet-action-icons .tweet:hover .tweet-actions .sm-reply,
                    .persistent-tweet-actions.tweet-action-icons .tweet:hover .tweet-actions .sm-rt,
                    .persistent-tweet-actions.tweet-action-icons .tweet:hover .tweet-actions .sm-fav,
                    .persistent-tweet-actions.tweet-action-icons .tweet:hover .tweet-actions .sm-trash,
                    .persistent-tweet-actions.tweet-action-icons .tweet:hover .tweet-actions .sm-more {
                        background-color: #66B5D2;
                    }

                    .tweet-action-icons .stream .tweet .tweet-actions .sm-reply:hover, .tweet-action-icons .stream .tweet .tweet-actions a:focus .sm-reply,
                    .tweet-action-icons .stream .tweet .tweet-actions .sm-rt:hover, .tweet-action-icons .stream .tweet .tweet-actions a:focus .sm-rt,
                    .tweet-action-icons .stream .tweet .tweet-actions .sm-fav:hover, .tweet-action-icons .stream .tweet .tweet-actions a:focus .sm-fav,
                    .tweet-action-icons .stream .tweet .tweet-actions .sm-trash:hover, .tweet-action-icons .stream .tweet .tweet-actions a:focus .sm-trash,
                    .tweet-action-icons .stream .tweet .tweet-actions .sm-more:hover, .tweet-action-icons .stream .tweet .tweet-actions a:focus .sm-more {
                        background-color: #0084B4;
                    }


                    .enhanced-mini-profile .mini-profile .profile-summary {
                        background-image: url(https://pbs.twimg.com/profile_banners/48671649/1348543703/mobile);
                    }

                    .wrapper-profile .profile-card.profile-header .profile-header-inner {
                        background-image: url(https://pbs.twimg.com/profile_banners/48671649/1348543703/web);
                    }

                    #global-tweet-dialog .modal-header {
                        border-bottom: solid 1px rgba(0, 132, 180, .25);
                    }

                    #global-tweet-dialog .modal-tweet-form-container {
                        background-color: #0084B4;
                        background: rgba(0, 132, 180, .1);
                    }

                    .inline-reply-tweetbox {
                        background-color: #E5F2F7;
                    }

                </style>


                <style id="user-style-DvDHoz-bg-img" class="js-user-style-bg-img">
                    body.user-style-DvDHoz {

                        background-position: left 40px;
                        background-attachment: fixed;
                        background-repeat: repeat;
                        background-repeat: no-repeat;

                        background-color: #022330;
                    }

                    body.user-style-DvDHoz .enhanced-mini-profile .mini-profile .profile-summary {
                        background-image: url(https://pbs.twimg.com/profile_banners/48671649/1348543703/web);
                    }

                    body.user-style-DvDHoz .wrapper-profile .profile-card.profile-header .profile-header-inner {
                        background-image: url(https://pbs.twimg.com/profile_banners/48671649/1348543703/web);
                    }

                    .DashboardProfileCard-bg {
                        background-image: url(https://pbs.twimg.com/profile_banners/48671649/1348543703/600x200);
                    }

                    body.user-style-DvDHoz .profile-canopy .bg-img {
                        background-image: url(https://pbs.twimg.com/profile_banners/48671649/1348543703/web_retina);
                    }

                </style>



                <link rel="stylesheet" href="https://abs.twimg.com/a/1404619576/css/t1/rosetta_gotham_more.bundle.css" charset="utf-8"><link rel="stylesheet" href="https://abs.twimg.com/a/1404619576/css/t1/highline_more.bundle.css" charset="utf-8"><style id="scrollbar-width">        .compensate-for-scrollbar,        .modal-enabled,        .modal-enabled .global-nav-inner,        .profile-editing,        .profile-editing .global-nav-inner,        .overlay-enabled,        .overlay-enabled .global-nav-inner,        .grid-enabled,        .grid-enabled .global-nav-inner,        .gallery-enabled,        .gallery-enabled .global-nav-inner {          margin-right: 19px      }      </style></head>
            <body class="highline three-col logged-in user-style-DvDHoz ms-windows enhanced-mini-profile supports-drag-and-drop" data-fouc-class-names="swift-loading" dir="ltr"><div id="kb-shortcuts-msg" class="visuallyhidden">
                    <h2>Keyboard Shortcuts</h2>

                </div>

                <div id="doc" class="route-home">
                    <div class="topbar js-topbar">
                        <div id="banners" class="js-banners">
                        </div>

                        <div class="ProfilePage-editingOverlay"></div>

                        <div class="global-nav" data-section-term="top_nav">
                            <div class="global-nav-inner">
                                <div class="container">


                                    <h1 class="Icon Icon--bird bird-topbar-etched" style="display: inline-block; width: 24px; height: 21px;">
                                        <span class="visuallyhidden">Cigua</span>
                                    </h1>
                                    <div class="pushstate-spinner"></div>


                                    <div role="navigation" style="display: inline-block;">
                                        <ul class="nav js-global-actions" id="global-actions">
                                            <li id="global-nav-home" class="home active" data-global-action="home"> 
                                                <a class="js-nav" href="./index.jsp" data-component-term="home_nav" data-nav="home" title="Home"> 
                                                    <span class="Icon Icon--home Icon--large"></span> 
                                                    <span class="text">Home</span> 
                                                </a> 
                                            </li>
                                            <li class="topics" data-global-action="discover">
                                                
                                            </li>  
                                            <li class="profile" data-global-action="profile"> 
                                                <c:choose>
                                                    <c:when test="<%=lu != null%>">
                                                        <a class="js-nav" href="./verPerfil.jsp?username=<%=lu.getUsername()%>" data-component-term="profile_nav" data-nav="profile" title="Me"> 
                                                            <span class="Icon Icon--me Icon--large"></span> 
                                                            <span class="text">Mi Perfil</span> 
                                                        </a> 
                                                    </c:when>
                                                </c:choose>
                                            </li> 
                                        </ul>
                                    </div>

                                    <div class="pull-right" style="display: inline-block;"> 
                                        <div role="search" class="">
                                            <form class="t1-form form-search js-search-form" action="./search.jsp" id="global-nav-search">
                                                <label class="visuallyhidden" for="search-query">Search query</label>
                                                <input class="search-input" type="text" id="search-query" placeholder="Search Cigua: #ht o username" name="q" autocomplete="off" spellcheck="false" aria-autocomplete="list" aria-expanded="false" aria-owns="typeahead-dropdown-1" data-emoji_font="true" style="font-family: 'Gotham Narrow SSm', sans-serif, 'Segoe UI Emoji', 'Segoe UI Symbol', Symbola, EmojiSymbols !important;">
                                                <span class="search-icon js-search-action">
                                                    <button type="submit" class="Icon Icon--search nav-search" tabindex="-1">
                                                        <span class="visuallyhidden">

                                                            Search Cigua: #ht o username
                                                        </span>
                                                    </button>
                                                </span>
                                                <input aria-hidden="true" disabled="disabled" class="search-input search-hinting-input" type="text" id="search-query-hint" autocomplete="off" spellcheck="false">
                                                <div role="listbox" class="dropdown-menu typeahead" id="typeahead-dropdown-1">
                                                    <div aria-hidden="true" class="dropdown-caret">
                                                        <div class="caret-outer"></div>
                                                        <div class="caret-inner"></div>
                                                    </div>
                                                    <div role="presentation" class="dropdown-inner js-typeahead-results"><ul role="presentation" class="typeahead-items typeahead-context-list block0" style="display: none;"></ul><div role="presentation" class="typeahead-recent-searches block1">
                                                            <h3 id="recent-searches-heading" class="typeahead-category-title recent-searches-title" style="display: none;">Recent searches</h3><button type="button" tabindex="-1" class="btn-link clear-recent-searches" style="display: none;">Clear All</button>
                                                            <ul role="presentation" class="typeahead-items recent-searches-list"></ul>
                                                        </div><div role="presentation" class="typeahead-saved-searches block2">
                                                            <h3 id="saved-searches-heading" class="typeahead-category-title saved-searches-title" style="display: none;">Saved searches</h3>
                                                            <ul role="presentation" class="typeahead-items saved-searches-list"></ul>
                                                        </div><div role="presentation" class="typeahead-concierge block3" style="display: none;">
                                                            <h3 id="concierge-heading" class="typeahead-category-title concierge-title">Try these searches</h3>
                                                            <ul role="presentation" class="typeahead-items typeahead-concierge-list"></ul>
                                                        </div><ul role="presentation" class="typeahead-items typeahead-topics block4" style="display: none;"></ul><ul role="presentation" class="typeahead-items typeahead-accounts social-context js-typeahead-accounts block5" style="display: none;">


                                                            <li role="presentation" class="js-selectable typeahead-accounts-shortcut js-shortcut"><a role="option" class="js-nav" href="" data-search-query="" data-query-source="typeahead_click" data-shortcut="true" data-ds="account_search" id="typeahead-item-0"></a></li>
                                                        </ul></div>
                                                </div>

                                            </form>
                                        </div>
                                        <ul class="nav right-actions"> 
                                             
                                                <li class="me dropdown session js-session" data-global-action="t1me" id="user-dropdown"> 
                                                    <!--
                                                    <a href="/settings/account" class="js-tooltip settings dropdown-toggle js-dropdown-toggle" id="user-dropdown-toggle" title="Settings and help" data-placement="bottom" role="button" aria-haspopup="true"> 
                                                        <span class="Icon Icon--cog Icon--large"></span> 
                                                        <span class="visuallyhidden">Settings and help</span> 
                                                    </a> 
                                                    -->
                                                    <a href="./logout.jsp" class="js-tooltip settings dropdown-toggle js-dropdown-toggle" id="user-dropdown-toggle" title="Logout" data-placement="bottom" role="button" aria-haspopup="true"> 
                                                        <span class="Icon Icon--cog Icon--large"></span> 
                                                        <span class="visuallyhidden">Logout</span> 
                                                    </a>
                                                    <div class="dropdown-menu">
                                                    <div class="dropdown-caret">
                                                        <span class="caret-outer"></span>
                                                        <span class="caret-inner"></span>
                                                    </div>
                                                    <ul>

                                                        <li class="current-user" data-name="profile">


                                                            <a href="/settings/profile" class="account-summary account-summary-small" data-nav="edit_profile">
                                                                <div class="content">
                                                                    <div class="account-group js-mini-current-user" data-user-id="50219946" data-screen-name="richddr">
                                                                        <img class="avatar size32" src="../build/<%=lu.getFotoUsuario()%>" alt="" data-user-id="50219946">
                                                                        <b class="fullname"><%=lu.getNombre() + " " + lu.getApellido()%></b>
                                                                        <span class="screen-name hidden" dir="ltr">@<%=lu.getUsername()%></span>
                                                                        <small class="metadata">
                                                                            Edit profile

                                                                        </small>
                                                                    </div>
                                                                </div>
                                                            </a>

                                                        </li>

                                                        <li class="dropdown-divider"></li>

                                                        <li data-name="lists"><a href="/richddr/lists" data-nav="all_lists">Lists</a></li>
                                                        <li class="dropdown-divider"></li>




                                                        <li><a href="//support.twitter.com" data-nav="help_center">Help</a></li>


                                                        <li class="js-keyboard-shortcut-trigger" data-nav="shortcuts">
                                                            <button type="button" class="dropdown-link">Keyboard shortcuts</button>
                                                        </li>








                                                        <li class="dropdown-divider"></li>


                                                        <li>
                                                            <!--<a href="/settings/account" data-nav="settings" class="js-nav">Settings</a>-->
                                                            <a href="./logout.jsp" data-nav="settings" class="js-nav">Logout</a>
                                                        </li>


                                                        <li class="js-signout-button" id="signout-button" data-nav="logout">
                                                            <button type="button" class="dropdown-link">Sign out</button>
                                                            <form class="t1-form dropdown-link-form signout-form" id="signout-form" action="./logout.jsp" method="POST">
                                                                <input type="hidden" value="ca48ba697de6fd1e3a5166adffeca39c4542a119" name="authenticity_token" class="authenticity_token">
                                                                <input type="hidden" name="reliability_event" class="js-reliability-event">
                                                                <input type="hidden" name="scribe_log">
                                                            </form>
                                                        </li>

                                                    </ul>
                                                </div>
                                            </li>  
                                             </ul> </div>




                                </div>
                            </div>
                        </div>

                    </div>

                    <div id="page-outer">
                        <div id="page-container" class="AppContent wrapper wrapper-home white">







                            <div class="dashboard dashboard-left ">

                                <div class="DashboardProfileCard  module">

                                    <a class="DashboardProfileCard-bg u-bgUserColor u-block" href="" tabindex="-1" aria-hidden="true">
                                    </a>

                                    <div class="DashboardProfileCard-content">
                                        <a class="DashboardProfileCard-avatarLink u-inlineBlock" href="./verPerfil.jsp?username=<%=lu.getUsername()%>" title="<%=lu.getUsername()%>" tabindex="-1" aria-hidden="true">
                                               <%
                                             
                                                        String imagenProfile = "./media/images/null.gif";
                                                        if(lu.getFotoUsuario() != null)
                                                        {
                                                           
                                                            imagenProfile = "./"+lu.getFotoUsuario();
                                                        }
                                            %>
                                            
                                            <img class="DashboardProfileCard-avatarImage js-action-profile-avatar" src="<%= imagenProfile%>" alt="">
                                        </a>

                                        <div class="DashboardProfileCard-userFields">
                                            <div class="DashboardProfileCard-name u-textTruncate">
                                                <a class="u-textInheritColor" href="./verPerfil.jsp?username=<%=lu.getUsername()%>"><%=lu.getNombre()%></a>
                                            </div>
                                            <span class="DashboardProfileCard-screenname u-inlineBlock u-dir" dir="ltr">
                                                <a class="DashboardProfileCard-screennameLink u-linkComplex u-linkClean" href="./verPerfil.jsp?username=<%=lu.getUsername()%>">
                                                    @<span class="u-linkComplex-target"><%=lu.getUsername()%>

                                                    </span>
                                                </a>
                                            </span>
                                        </div>

                                        <div class="DashboardProfileCard-stats">
                                            <ul class="DashboardProfileCard-statList Arrange Arrange--bottom Arrange--equal">
                                                <li class="DashboardProfileCard-stat Arrange-sizeFit">
                                                    <a class="DashboardProfileCard-statLink u-textUserColor u-linkClean u-block" title="8,869 Tweets" href="./verPerfil.jsp?username=<%=lu.getUsername()%>" data-element-term="tweet_stats">
                                                        <span class="DashboardProfileCard-statLabel u-block">Tweets</span>
                                                        <span class="DashboardProfileCard-statValue" data-is-compact="false"><%=ts.getCantTweetsUsuario(lu)%></span>
                                                    </a>
                                                </li><li class="DashboardProfileCard-stat Arrange-sizeFit">
                                                    <a class="DashboardProfileCard-statLink u-textUserColor u-linkClean u-block" title="183 Following" href="https://twitter.com/following" data-element-term="follower_stats">
                                                        <span class="DashboardProfileCard-statLabel u-block">Following</span>
                                                        <span class="DashboardProfileCard-statValue" data-is-compact="false"><%=ts.getFollowingCount(lu)%></span>
                                                    </a>
                                                </li><li class="DashboardProfileCard-stat Arrange-sizeFit">
                                                    <a class="DashboardProfileCard-statLink u-textUserColor u-linkClean u-block" title="340 Followers" href="https://twitter.com/followers" data-element-term="following_stats">
                                                        <span class="DashboardProfileCard-statLabel u-block">Followers</span>
                                                        <span class="DashboardProfileCard-statValue" data-is-compact="false"><%=ts.getFollowersCount(lu)%></span>
                                                    </a>
                                                </li>
                                            </ul>
                                        </div>




                                        <div class="home-tweet-box tweet-box component tweet-user
                                             DashboardProfileCard-tweetbox u-bgUserColorLightest u-borderUserColorLighter">
                                            <form name="formCrearTweet" action="./ct" method="POST" enctype="multipart/form-data" class="t1-form tweet-form condensed">
                                                <br>Contenido:<br><textarea rows="5" cols="70" name="contenido" maxlength="200">@</textarea><br><br>
                                                Imagen(Opcional): <input type="file" value="" name="imagenTweet"/><br><br><br>
                                                Tweet Publico:<input type="checkbox" value="yes" name="isPublic" checked/>




                                                <div class="tweet-content">




                                                    <br>





                                                    <button class="btn primary-btn tweet-action tweet-btn js-tweet-btn" type="submit">
                                                        <span class="button-text tweeting-text">
                                                            <span class="Icon Icon--tweet"></span>
                                                            Enviar Cigua
                                                        </span>
                                                    </button>

                                                </div>
                                            </form>

                                        </div>

                                    </div>
                                </div>
                            </div>


                            <div role="main" aria-labelledby="content-main-heading" class="content-main " id="timeline">


                                <div class="content-header">
                                    <div class="header-inner">
                                        <h2 id="content-main-heading" class="js-timeline-title">
                                            <c:choose>
                                                <c:when test="<%=tweetsByHT != null && userByMatchingQuery == null%>">
                                                    Ciguas
                                                </c:when>
                                                <c:when test="<%=userByMatchingQuery != null && tweetsByHT == null%>">
                                                    Usuarios
                                                </c:when>
                                            </c:choose>
                                        </h2>
                                    </div>
                                </div>
                                <div class="stream-container conversations-enabled persistent-inline-actions light-inline-actions" data-max-position="486178457261711361" data-min-position="486172655801106432">

                                    <div class="stream-item js-new-items-bar-container">
                                    </div>

                                    <div class="stream home-stream">
                                        <ol class="stream-items js-navigable-stream" id="stream-items-id">  
                                            
                                            <c:choose>
                                                <c:when test="<%=qForHt%>">
                                                    <c:choose>
                                                        <c:when test="<%= tweetsByHT != null%>">
                                                            <li class="js-stream-item stream-item stream-item expanding-stream-item" data-item-id="484430288244572162" id="stream-item-tweet-484430288244572162" data-item-type="tweet">

                                                                <%
                                                                    tieneImagen = false;
                                                                    for (int i = 0; i < tweetsByHT.size(); i++) {
                                                                        Tweet t = tweetsByHT.get(i);
                                                                        if(t.getImagen() != null){
                                                                            tieneImagen = true;
                                                                        }

                                                                %>
                                                                <div class="tweet original-tweet js-stream-tweet js-actionable-tweet js-profile-popup-actionable js-original-tweet">

                                                                    <div class="context"> </div>
                                                                    <div class="content">


                                                                        <div class="stream-item-header">

                                                                            <a class="account-group js-account-group js-action-profile js-user-profile-link js-nav" href="./verPerfil.jsp?username=<%=t.getIdUsuario().getUsername()%>" data-user-id="43534995">
                                                                               
                                                                                <%
                                                                                                                                               boolean tieneImagenUser = false;
                                                        String imagenUsuario = "./media/images/null.gif";
                                                        
                                                        

                                                        if(t.getIdUsuario().getFotoUsuario() != null)
                                                        {
                                                            tieneImagenUser = true;
                                                            imagenUsuario = "./"+t.getIdUsuario().getFotoUsuario();
                                                        }
                                                                                %>
                                                                                <img class="avatar js-action-profile-avatar" src="<%=imagenUsuario%>" alt="">
                                                                                <strong class="fullname js-action-profile-name show-popup-with-id"><%=t.getIdUsuario().getNombre()%></strong>
                                                                                <span>
                                                                                    </span><span class="username js-action-profile-name"><s>@</s><b><%=t.getIdUsuario().getUsername()%></b></span>


                                                                            </a>

                                                                            
                                                                        </div>

                                                                        <p class="js-tweet-text tweet-text"><%=t.getContenido()%></p>
                                                                        <c:choose>
                                                                                <c:when test="<%=tieneImagen%>">
                                                                                    <img src="./<%=t.getImagen()%>" width="40px" height="40px">
                                                                                </c:when>
                                                                        </c:choose>

                                                                        <div class="expanded-content js-tweet-details-dropdown"> </div>
                                                                        <div class="stream-item-footer">  
                                                                            </ul>
                                                                        </div>            
                                                                    </div>
                                                                </div>
                                                                <%}%>        
                                                            </li>
                                                        </c:when>
                                                        <c:when test="<%=tweetsByHT == null%>">
                                                            <br>No se encontraron Tweets conteniendo ese hashtag.<br>
                                                        </c:when>
                                                    </c:choose>
                                                    
                                                </c:when>
                                                <c:when test="<%=qForUsers%>">
                                                    <c:choose>
                                                        <c:when test="<%=userByMatchingQuery != null%>">
                                                            <li class="js-stream-item stream-item stream-item expanding-stream-item" data-item-id="484430288244572162" id="stream-item-tweet-484430288244572162" data-item-type="tweet">

                                                                <%
                                                                    //boolean tieneImagen = false;
                                                                    for (int i = 0; i < userByMatchingQuery.size(); i++) {
                                                                        Usuario u = userByMatchingQuery.get(i);
                                                                        
                                                                                                                                                                 boolean tieneImagenUser = false;
                                                        String imagenUsuario = "./media/images/null.gif";
                                                        
                                                        

                                                        if( u.getFotoUsuario() != null)
                                                        {
                                                            tieneImagenUser = true;
                                                            imagenUsuario = "./"+ u.getFotoUsuario();
                                                        }
                                                                 
                                                                %>
                                                                <div class="tweet original-tweet js-stream-tweet js-actionable-tweet js-profile-popup-actionable js-original-tweet">

                                                                    <div class="context"> </div>
                                                                    <div class="content">


                                                                        <div class="stream-item-header">

                                                                            <a class="account-group js-account-group js-action-profile js-user-profile-link js-nav" href="./verPerfil.jsp?username=<%=u.getUsername()%>" data-user-id="43534995">
                                                                                <img class="avatar js-action-profile-avatar" src="<%=imagenUsuario%>" alt="">
                                                                                <strong class="fullname js-action-profile-name show-popup-with-id"><%=u.getNombre()%></strong>
                                                                                <span>
                                                                                    </span><span class="username js-action-profile-name"><s>@</s><b><%=u.getUsername()%></b></span>


                                                                            </a>

                                                                            <small class="time">
                                                                                <a href="https://twitter.com/PeriodicoHoy/status/486178457261711361" class="tweet-timestamp js-permalink js-nav js-tooltip" title="11:32 AM - 7 Jul 2014"><span class="_timestamp js-short-timestamp js-relative-timestamp" data-time="1404748951" data-time-ms="1404748951000" data-long-form="true">-</span></a>
                                                                            </small>
                                                                        </div>

                                                                        <p class="js-tweet-text tweet-text">
                                                                            <!-- Aqui iba el tweet content, replaced with...? -->

                                                                        </p>

                                                                        <div class="expanded-content js-tweet-details-dropdown"> </div>
                                                                        <div class="stream-item-footer">  
                                                                            </ul>
                                                                        </div>            
                                                                    </div>
                                                                </div>

                                                                <%}%>        


                                                            </li>
                                                        </c:when>
                                                        <c:when test="<%=userByMatchingQuery == null%>">
                                                            <br>No se encotraron usuarios por ese username.<br>
                                                        </c:when>
                                                    </c:choose>
                                                </c:when>
                                            </c:choose>





                                        </ol>
                                        <div class="stream-footer ">
                                            <div class="timeline-end has-items has-more-items">
                                                <div class="stream-end">
                                                    <div class="stream-end-inner ">
                                                        <span class="Icon Icon--large Icon--logo"></span>

                                                        <p class="empty-text">
                                                            Your timeline is currently empty. Follow people and topics you find interesting to see their Tweets in your timeline.
                                                        </p>


                                                        <p><button type="button" class="btn-link back-to-top hidden" style="display: inline-block;">Back to top ↑</button></p>

                                                    </div>
                                                </div>



                                            </div>
                                        </div>
                                        <div class="stream-fail-container">
                                            <div class="js-stream-whale-end stream-whale-end stream-placeholder centered-placeholder">
                                                <div class="stream-end-inner">
                                                    <h2 class="title">Loading seems to be taking a while.</h2>
                                                    <p>
                                                        Twitter may be over capacity or experiencing a momentary hiccup. <a role="button" href="https://twitter.com/#" class="try-again-after-whale">Try again</a> or visit <a target="_blank" href="http://status.twitter.com/">Twitter Status</a> for more information.
                                                    </p>
                                                </div>
                                            </div>
                                        </div>

                                        <ol class="hidden-replies-container"></ol>
                                    </div>
                                </div>
                                <div id="sensitive_flag_dialog" class="modal-container">
                                    <div class="close-modal-background-target"></div>
                                    <div class="modal modal-small draggable">
                                        <div class="modal-content">
                                            <button type="button" class="modal-btn modal-close js-close">
                                                <span class="Icon Icon--close Icon--medium">
                                                    <span class="visuallyhidden">Close</span>
                                                </span>
                                            </button>

                                            <div class="modal-header">
                                                <h3 class="modal-title">Flag this media</h3>
                                            </div>
                                            <div class="modal-body">
                                                <p class="sensitive-title">This has already been marked as containing sensitive content.</p>
                                                <label class="t1-label checkbox" for="sensitive-illegal-checkbox">
                                                    <input type="checkbox" id="sensitive-illegal-checkbox" value="illegal">
                                                    Flag this as containing potentially illegal content.
                                                </label>
                                            </div>
                                            <div class="modal-footer">
                                                <button id="submit_flag_confirmation" type="button" class="btn">Submit</button>
                                                <button id="cancel_flag_confirmation" type="button" class="btn primary-btn js-close">Cancel</button>

                                                <div class="sensitive-confirmation">
                                                    <a class="sensitive-learn-more" target="_blank" href="https://support.twitter.com/articles/20069937">Learn more about flagging media</a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="modal-overlay"></div>
                                </div>



                            </div>

                            <div class="dashboard dashboard-right"><div id="dashboard-matches" class="roaming-module"></div><div class="Footer module roaming-module ">
                                    <div class="flex-module">
                                        <div class="flex-module-inner js-items-container">
                                            <ul class="u-cf">
                                                <li class="Footer-item Footer-copyright copyright">© 2014 Cigua</li>

                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>


                        </div>
                    </div>


                </div>
            </body>
        </html>
        
    </c:when>
    <c:when test="<%=userNotLoggedIn%>">
        <!DOCTYPE html>
        <html lang="en" data-scribe-reduced-action-queue="true"><!--<![endif]--><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

                <meta charset="utf-8">


                <link rel="stylesheet" href="https://abs.twimg.com/a/1404619576/css/t1/highline_rosetta_gotham_core.bundle.css">



                <title>Cigua</title>




                <meta name="msapplication-TileImage" content="//abs.twimg.com/favicons/win8-tile-144.png">
                <meta name="msapplication-TileColor" content="#00aced">



                <link rel="stylesheet" href="https://abs.twimg.com/font/gotham-narrow-v3.css">
                
                <style id="user-style-DvDHoz">

                    .btn_following:hover{
                       color: red
                    }
                    
                    .btn_notfollowing:hover{
                        color: royalblue
                    }

                    a,
                    a:hover,
                    a:focus,
                    a:active {
                        color: #0084B4;
                    }

                    .u-textUserColor,
                    .u-textUserColorHover:hover,
                    .u-textUserColorHover:focus {
                        color: #0084B4 !important;
                    }

                    .u-borderUserColor,
                    .u-borderUserColorHover:hover,
                    .u-borderUserColorHover:focus {
                        border-color: #0084B4 !important;
                    }

                    .u-bgUserColor,
                    .u-bgUserColorHover:hover,
                    .u-bgUserColorHover:focus {
                        background-color: #0084B4 !important;
                    }

                    .u-boxShadowInsetUserColorHover:hover,
                    .u-boxShadowInsetUserColorHover:focus {
                        box-shadow: inset 0 0 0 5px #0084B4 !important;
                    }



                    .u-textUserColorLight {
                        color: #99CDE1 !important;
                    }

                    .u-borderUserColorLight,
                    .u-borderUserColorLightFocus:focus,
                    .u-borderUserColorLightHover:hover,
                    .u-borderUserColorLightHover:focus {
                        border-color: #99CDE1 !important;
                    }

                    .u-bgUserColorLight {
                        background-color: #99CDE1 !important;
                    }


                    .u-boxShadowUserColorLighterFocus:focus {
                        box-shadow: 0 0 8px rgba(0, 0, 0, 0.05), inset 0 1px 2px rgba(0,132,180,0.25) !important;
                    }


                    .u-textUserColorLightest {
                        color: #E5F2F7 !important;
                    }

                    .u-borderUserColorLightest {
                        border-color: #E5F2F7 !important;
                    }

                    .u-bgUserColorLightest {
                        background-color: #E5F2F7 !important;
                    }


                    .u-textUserColorLighter {
                        color: #BFE0EC !important;
                    }

                    .u-borderUserColorLighter {
                        border-color: #BFE0EC !important;
                    }

                    .u-bgUserColorLighter {
                        background-color: #BFE0EC !important;
                    }


                    .u-bgUserColorDarkHover:hover {
                        background-color: #006990 !important;
                    }

                    .u-borderUserColorDark {
                        border-color: #006990 !important;
                    }


                    .u-bgUserColorDarkerActive:active {
                        background-color: #004F6C !important;
                    }















                    a,
                    .btn-link,
                    .btn-link:focus,
                    .icon-btn,



                    .pretty-link b,
                    .pretty-link:hover s,
                    .pretty-link:hover b,
                    .pretty-link:focus s,
                    .pretty-link:focus b,
                    /* Account Group */
                    .metadata a:hover,
                    .metadata a:focus,

                    .account-group:hover .fullname,
                    .account-group:focus .fullname,
                    .account-summary:focus .fullname,

                    .message .message-text a,
                    .stats a strong,
                    .plain-btn:hover,
                    .plain-btn:focus,
                    .dropdown.open .user-dropdown.plain-btn,
                    .open > .plain-btn,
                    #global-actions .new:before,
                    .module .list-link:hover,
                    .module .list-link:focus,

                    .UserCompletion-step:hover,

                    .stats a:hover,
                    .stats a:hover strong,
                    .stats a:focus,
                    .stats a:focus strong,

                    .profile-modal-header .fullname a:hover,
                    .profile-modal-header .username a:hover,
                    .profile-modal-header .fullname a:focus,
                    .profile-modal-header .username a:focus,

                    .story-article:hover .metadata,
                    .story-article .metadata a:focus,

                    .find-friends-sources li:hover .source,





                    .stream-item a:hover .fullname,
                    .stream-item a:focus .fullname,

                    .stream-item .view-all-supplements:hover,
                    .stream-item .view-all-supplements:focus,

                    .tweet .time a:hover,
                    .tweet .time a:focus,
                    .tweet-actions a,
                    .tweet .details.with-icn b,
                    .tweet .details.with-icn .Icon,
                    .tweet .tweet-geo-text a:hover,

                    .stream-item:hover .original-tweet .expand-action-wrapper,
                    .stream-item .original-tweet.focus .expand-action-wrapper,
                    .opened-tweet.original-tweet  .expand-action-wrapper,

                    .stream-item:hover .original-tweet .details b,
                    .stream-item .original-tweet.focus .details b,
                    .stream-item.open .original-tweet .details b,

                    .simple-tweet:hover .details b,
                    .simple-tweet.focus .details b,
                    .simple-tweet.open .details b,
                    .simple-tweet:hover .details .expand-action-wrapper,
                    .simple-tweet.focus .details .expand-action-wrapper,
                    .simple-tweet.open .details .collapse-action-wrapper,
                    .simple-tweet:hover .details .simple-details-link,
                    .simple-tweet.focus .details .simple-details-link,

                    .client-and-actions a:hover,
                    .client-and-actions a:focus,

                    .dismiss-promoted:hover b,

                    .tweet .context .pretty-link:hover s,
                    .tweet .context .pretty-link:hover b,
                    .tweet .context .pretty-link:focus s,
                    .tweet .context .pretty-link:focus b,

                    .list .username a:hover,
                    .list .username a:focus,
                    .list-membership-container .create-a-list,
                    .list-membership-container .create-a-list:hover,



                    .story-header:hover .view-tweets,
                    .card .list-details a:hover,
                    .card .list-details a:focus,
                    .card .card-body:hover .attribution,
                    .card .card-body .attribution:focus,
                    .events-card .card-body:hover .attribution,
                    .events-card .card-body .attribution:focus,
                    .new-tweets-bar,
                    .onebox .soccer ul.ticker a:hover,
                    .onebox .soccer ul.ticker a:focus,



                    .discover-item-actions a,



                    .disco-stream-item.disco_exp_actions_on_btm .more-tweet-actions .btn-link,
                    .disco-stream-item.disco_exp_actions_on_btm_without_stats .more-tweet-actions .btn-link,



                    .remove-background-btn,



                    .stream-item-activity-me .latest-tweet .tweet-row a:hover,
                    .stream-item-activity-me .latest-tweet .tweet-row a:focus,
                    .stream-item-activity-me .latest-tweet .tweet-row a:hover b,
                    .stream-item-activity-me .latest-tweet .tweet-row a:focus b,


                    .tweet-actions-sidebar a:hover .tweet-action-count,
                    .tweet-actions-sidebar a:focus .tweet-action-count {
                        color: #0084B4;
                    }



                    #global-actions > li > a {
                        border-bottom-color: #0084B4;
                    }

                    #global-actions > li:hover > a,
                    #global-actions > li > a:focus,
                    .nav.right-actions > li > a:hover,
                    .nav.right-actions > li > button:hover,
                    .nav.right-actions > li > a:focus,
                    .nav.right-actions > li > button:focus {
                        color: #0084B4;
                    }

                    /* Surpress the new connect glow if in experiment. */
                    #global-actions .people.new:before {
                        content: none;
                    }

                    /* hover state for photo select button*/
                    .photo-selector:not(.disabled):hover .btn,
                    .icon-btn:hover,
                    .icon-btn:active,
                    .icon-btn.active,
                    .icon-btn.enabled {
                        border-color: #0084B4;
                        border-color: rgba(0,132,180,.5);
                        color: #0084B4;
                    }

                    /* hover state for photo select button*/
                    .photo-selector:not(.disabled):hover .btn,
                    .icon-btn:hover {
                        background-image: linear-gradient(rgba(255,255,255,0), rgba(0,132,180,.1));
                        filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#00FFFFFF', endColorstr='#190084B4'); /* IE8-9 */
                    }

                    .icon-btn.disabled,
                    .icon-btn.disabled:hover,
                    .icon-btn[disabled],
                    .icon-btn[aria-disabled=true] {
                        color: #0084B4;
                    }

                    /* tweet-btn can have primary-btn class as well so the following rules ensure that the correct background color is applied */
                    .tweet-btn,
                    .tweet-btn:focus {
                        background-color: #0084B4;
                        background: rgba(0,132,180,.8);
                    }

                    .tweet-btn:hover,
                    .tweet-btn:active,
                    .tweet-btn.active {
                        background-color: #0084B4;
                    }

                    .tweet-btn.btn.disabled,
                    .tweet-btn.btn.disabled:hover,
                    .tweet-btn.btn[disabled],
                    .tweet-btn.btn[aria-disabled=true] {
                        background: #0084B4;
                    }

                    .btn:focus,
                    .btn.focus,
                    .Button:focus {
                        box-shadow:
                            0 0 0 1px #fff,
                            0 0 0 3px rgba(0, 132, 180, 0.5);
                    }

                    .selected-stream-item:focus {
                        box-shadow: 0 0 0 3px rgba(0, 132, 180, 0.5);
                    }

                    /**
                     * 1. Bring actionable tweet to top when active to ensure border
                     *    highlighting wraps entire tweet. Value must be at least at if not
                     *    higher than the z-index value of ProfileHeading to ensure first
                     *    tweet in timeline receives border on all four sides.
                     */

                    .ProfileTweet.is-actionable,
                    .js-stream-item.is-selected:focus .ProfileTweet,
                    .js-stream-item.is-selected:focus .ProfileCard {
                        border-color: rgba(0, 132, 180, 0.5);
                        z-index: 1; /* 1 */
                    }

                    .global-dm-nav.new.with-count .dm-new {
                        background: #0084B4;
                    }

                    .global-nav .people .count .count-inner {
                        background: #0084B4;
                    }

                    .dropdown-menu li > a:hover,
                    .dropdown-menu li > a:focus,
                    .dropdown-menu .dropdown-link:hover,
                    .dropdown-menu .dropdown-link:focus,
                    .dropdown-menu li:hover .dropdown-link,
                    .dropdown-menu li:focus .dropdown-link,
                    .dropdown-menu .typeahead-recent-search-item.selected,
                    .dropdown-menu .typeahead-saved-search-item.selected,
                    .dropdown-menu .selected a,
                    .dropdown-menu .dropdown-link.selected {
                        background-color: #0084B4;
                    }

                    /* give tweet boxes 10% of the users link color as background */
                    .home-tweet-box,
                    .dm-tweetbox,
                    .WebToast-box--altColor,
                    .content-main .conversations-enabled .expansion-container .inline-reply-tweetbox {
                        background-color: #E5F2F7;
                    }

                    .conversations-enabled .inline-reply-caret .caret-inner {
                        border-bottom-color: #E5F2F7;
                    }

                    /* give tweet boxes an outline using the users link color */
                    .tweet-box[contenteditable="true"] {
                        border-color: rgba(0,132,180,0.25);
                    }

                    input:focus,
                    textarea:focus,
                    div[contenteditable="true"]:focus,
                    div[contenteditable="true"].fake-focus {
                        border-color: #66B5D2;
                        box-shadow: inset 0 0 0 1px rgba(0, 132, 180, 0.7);
                    }

                    .currently-dragging.modal-enabled .modal .tweet-box,
                    .currently-dragging:not(.modal-enabled) .tweet-content .tweet-box,
                    body.supports-drag-and-drop .tweet-form.upload-photo-hover.drag-and-drop .tweet-box,
                    .tweet-box[contenteditable="true"]:focus {
                        border-color: #99CDE1;
                        box-shadow: none;
                    }




                    s,
                    .pretty-link:hover s,
                    .pretty-link:focus s,
                    .stream-item-activity-me .latest-tweet .tweet-row a:hover s,
                    .stream-item-activity-me .latest-tweet .tweet-row a:focus s {
                        color: #66B5D2;
                    }



                    .vellip,
                    .vellip:before,
                    .vellip:after,
                    .conversation-module > li:after,
                    .conversation-module > li:before {
                        background-color: #66B5D2;
                    }




                    .tweet .sm-reply,
                    .tweet .sm-rt,
                    .tweet .sm-fav,
                    .tweet .sm-image,
                    .tweet .sm-video,
                    .tweet .sm-audio,
                    .tweet .sm-geo,
                    .tweet .sm-in,
                    .tweet .sm-trash,
                    .tweet .sm-more,
                    .tweet .sm-page,
                    .tweet .sm-embed,
                    .tweet .sm-summary,
                    .tweet .sm-chat,

                    .timelines-navigation .active .profile-nav-icon,
                    .timelines-navigation .profile-nav-icon:hover,
                    .timelines-navigation .profile-nav-link:focus .profile-nav-icon,

                    .sm-top-tweet,

                    .metadata a.tweet-geo-text:hover .sm-geo,


                    .discover-item .js-action-card-search:hover .sm-search,
                    .discover-item .js-action-card-search:focus .sm-search {
                        background-color: #0084B4;
                    }



                    .tweet-action-icons .tweet .tweet-actions .sm-reply, .tweet-action-icons .tweet.opened-tweet .tweet-actions .sm-reply,
                    .tweet-action-icons .tweet .tweet-actions .sm-rt, .tweet-action-icons .tweet.opened-tweet .tweet-actions .sm-rt,
                    .tweet-action-icons .tweet .tweet-actions .sm-fav, .tweet-action-icons .tweet.opened-tweet .tweet-actions .sm-fav,
                    .tweet-action-icons .tweet .tweet-actions .sm-trash, .tweet-action-icons .tweet.opened-tweet .tweet-actions .sm-trash,
                    .tweet-action-icons .tweet .tweet-actions .sm-more, .tweet-action-icons .tweet.opened-tweet .tweet-actions .sm-more {
                        background-color: #66B5D2;
                    }

                    .persistent-tweet-actions.tweet-action-icons .tweet:hover .tweet-actions .sm-reply,
                    .persistent-tweet-actions.tweet-action-icons .tweet:hover .tweet-actions .sm-rt,
                    .persistent-tweet-actions.tweet-action-icons .tweet:hover .tweet-actions .sm-fav,
                    .persistent-tweet-actions.tweet-action-icons .tweet:hover .tweet-actions .sm-trash,
                    .persistent-tweet-actions.tweet-action-icons .tweet:hover .tweet-actions .sm-more {
                        background-color: #66B5D2;
                    }

                    .tweet-action-icons .stream .tweet .tweet-actions .sm-reply:hover, .tweet-action-icons .stream .tweet .tweet-actions a:focus .sm-reply,
                    .tweet-action-icons .stream .tweet .tweet-actions .sm-rt:hover, .tweet-action-icons .stream .tweet .tweet-actions a:focus .sm-rt,
                    .tweet-action-icons .stream .tweet .tweet-actions .sm-fav:hover, .tweet-action-icons .stream .tweet .tweet-actions a:focus .sm-fav,
                    .tweet-action-icons .stream .tweet .tweet-actions .sm-trash:hover, .tweet-action-icons .stream .tweet .tweet-actions a:focus .sm-trash,
                    .tweet-action-icons .stream .tweet .tweet-actions .sm-more:hover, .tweet-action-icons .stream .tweet .tweet-actions a:focus .sm-more {
                        background-color: #0084B4;
                    }


                    .enhanced-mini-profile .mini-profile .profile-summary {
                        background-image: url(https://pbs.twimg.com/profile_banners/48671649/1348543703/mobile);
                    }

                    .wrapper-profile .profile-card.profile-header .profile-header-inner {
                        background-image: url(https://pbs.twimg.com/profile_banners/48671649/1348543703/web);
                    }

                    #global-tweet-dialog .modal-header {
                        border-bottom: solid 1px rgba(0, 132, 180, .25);
                    }

                    #global-tweet-dialog .modal-tweet-form-container {
                        background-color: #0084B4;
                        background: rgba(0, 132, 180, .1);
                    }

                    .inline-reply-tweetbox {
                        background-color: #E5F2F7;
                    }

                </style>


                <style id="user-style-DvDHoz-bg-img" class="js-user-style-bg-img">
                    body.user-style-DvDHoz {

                        background-position: left 40px;
                        background-attachment: fixed;
                        background-repeat: repeat;
                        background-repeat: no-repeat;

                        background-color: #022330;
                    }

                    body.user-style-DvDHoz .enhanced-mini-profile .mini-profile .profile-summary {
                        background-image: url(https://pbs.twimg.com/profile_banners/48671649/1348543703/web);
                    }

                    body.user-style-DvDHoz .wrapper-profile .profile-card.profile-header .profile-header-inner {
                        background-image: url(https://pbs.twimg.com/profile_banners/48671649/1348543703/web);
                    }

                    .DashboardProfileCard-bg {
                        background-image: url(https://pbs.twimg.com/profile_banners/48671649/1348543703/600x200);
                    }

                    body.user-style-DvDHoz .profile-canopy .bg-img {
                        background-image: url(https://pbs.twimg.com/profile_banners/48671649/1348543703/web_retina);
                    }

                </style>



                <link rel="stylesheet" href="https://abs.twimg.com/a/1404619576/css/t1/rosetta_gotham_more.bundle.css" charset="utf-8"><link rel="stylesheet" href="https://abs.twimg.com/a/1404619576/css/t1/highline_more.bundle.css" charset="utf-8"><style id="scrollbar-width">        .compensate-for-scrollbar,        .modal-enabled,        .modal-enabled .global-nav-inner,        .profile-editing,        .profile-editing .global-nav-inner,        .overlay-enabled,        .overlay-enabled .global-nav-inner,        .grid-enabled,        .grid-enabled .global-nav-inner,        .gallery-enabled,        .gallery-enabled .global-nav-inner {          margin-right: 19px      }      </style></head>
            <body class="highline three-col logged-in user-style-DvDHoz ms-windows enhanced-mini-profile supports-drag-and-drop" data-fouc-class-names="swift-loading" dir="ltr"><div id="kb-shortcuts-msg" class="visuallyhidden">
                    <h2>Keyboard Shortcuts</h2>

                </div>

                <div id="doc" class="route-home">
                    <div class="topbar js-topbar">
                        <div id="banners" class="js-banners">
                        </div>

                        <div class="ProfilePage-editingOverlay"></div>

                        <div class="global-nav" data-section-term="top_nav">
                            <div class="global-nav-inner">
                                <div class="container">


                                    <h1 class="Icon Icon--bird bird-topbar-etched" style="display: inline-block; width: 24px; height: 21px;">
                                        <span class="visuallyhidden">Cigua</span>
                                    </h1>
                                    <div class="pushstate-spinner"></div>


                                    <div role="navigation" style="display: inline-block;">
                                        <ul class="nav js-global-actions" id="global-actions">
                                            <li id="global-nav-home" class="home active" data-global-action="home"> 
                                                <a class="js-nav" href="./index.jsp" data-component-term="home_nav" data-nav="home" title="Home"> 
                                                    <span class="Icon Icon--home Icon--large"></span> 
                                                    <span class="text">Portada</span> 
                                                </a> 
                                            </li>
                                            <li class="topics" data-global-action="discover">
                                                
                                            </li>  
                                            <li class="profile" data-global-action="profile"> 
                                                <c:choose>
                                                    <c:when test="<%=lu != null%>">
                                                        <a class="js-nav" href="./verPerfil.jsp?username=<%=lu.getUsername()%>" data-component-term="profile_nav" data-nav="profile" title="Me"> 
                                                            <span class="Icon Icon--me Icon--large"></span> 
                                                            <span class="text">Mi Perfil</span> 
                                                        </a> 
                                                    </c:when>
                                                </c:choose>
                                            </li> 
                                        </ul>
                                    </div>

                                    <div class="pull-right" style="display: inline-block;"> 
                                        <div role="search" class="">
                                            <form class="t1-form form-search js-search-form" action="./search.jsp" id="global-nav-search">
                                                <label class="visuallyhidden" for="search-query">Search query</label>
                                                <input class="search-input" type="text" id="search-query" placeholder="Search Cigua: #ht o username" name="q" autocomplete="off" spellcheck="false" aria-autocomplete="list" aria-expanded="false" aria-owns="typeahead-dropdown-1" data-emoji_font="true" style="font-family: 'Gotham Narrow SSm', sans-serif, 'Segoe UI Emoji', 'Segoe UI Symbol', Symbola, EmojiSymbols !important;">
                                                <span class="search-icon js-search-action">
                                                    <button type="submit" class="Icon Icon--search nav-search" tabindex="-1">
                                                        <span class="visuallyhidden">

                                                            Search Cigua: #ht o username
                                                        </span>
                                                    </button>
                                                </span>
                                                <input aria-hidden="true" disabled="disabled" class="search-input search-hinting-input" type="text" id="search-query-hint" autocomplete="off" spellcheck="false">
                                                <div role="listbox" class="dropdown-menu typeahead" id="typeahead-dropdown-1">
                                                    <div aria-hidden="true" class="dropdown-caret">
                                                        <div class="caret-outer"></div>
                                                        <div class="caret-inner"></div>
                                                    </div>
                                                    <div role="presentation" class="dropdown-inner js-typeahead-results"><ul role="presentation" class="typeahead-items typeahead-context-list block0" style="display: none;"></ul><div role="presentation" class="typeahead-recent-searches block1">
                                                            <h3 id="recent-searches-heading" class="typeahead-category-title recent-searches-title" style="display: none;">Recent searches</h3><button type="button" tabindex="-1" class="btn-link clear-recent-searches" style="display: none;">Clear All</button>
                                                            <ul role="presentation" class="typeahead-items recent-searches-list"></ul>
                                                        </div><div role="presentation" class="typeahead-saved-searches block2">
                                                            <h3 id="saved-searches-heading" class="typeahead-category-title saved-searches-title" style="display: none;">Saved searches</h3>
                                                            <ul role="presentation" class="typeahead-items saved-searches-list"></ul>
                                                        </div><div role="presentation" class="typeahead-concierge block3" style="display: none;">
                                                            <h3 id="concierge-heading" class="typeahead-category-title concierge-title">Try these searches</h3>
                                                            <ul role="presentation" class="typeahead-items typeahead-concierge-list"></ul>
                                                        </div><ul role="presentation" class="typeahead-items typeahead-topics block4" style="display: none;"></ul><ul role="presentation" class="typeahead-items typeahead-accounts social-context js-typeahead-accounts block5" style="display: none;">


                                                            <li role="presentation" class="js-selectable typeahead-accounts-shortcut js-shortcut"><a role="option" class="js-nav" href="" data-search-query="" data-query-source="typeahead_click" data-shortcut="true" data-ds="account_search" id="typeahead-item-0"></a></li>
                                                        </ul></div>
                                                </div>

                                            </form>
                                        </div>
                                        <ul class="nav right-actions"> 
                                
                                                <li class="me dropdown session js-session" data-global-action="t1me" id="user-dropdown"> 
                                                    <!--
                                                    <a href="/settings/account" class="js-tooltip settings dropdown-toggle js-dropdown-toggle" id="user-dropdown-toggle" title="Settings and help" data-placement="bottom" role="button" aria-haspopup="true"> 
                                                        <span class="Icon Icon--cog Icon--large"></span> 
                                                        <span class="visuallyhidden">Settings and help</span> 
                                                    </a> 
                                                    -->
                                                    <a href="./logout.jsp" class="js-tooltip settings dropdown-toggle js-dropdown-toggle" id="user-dropdown-toggle" title="Logout" data-placement="bottom" role="button" aria-haspopup="true"> 
                                                        <span class="Icon Icon--cog Icon--large"></span> 
                                                        <span class="visuallyhidden">Logout</span> 
                                                    </a>
                                                    <div class="dropdown-menu">
                                                    <div class="dropdown-caret">
                                                        <span class="caret-outer"></span>
                                                        <span class="caret-inner"></span>
                                                    </div>
                                                  
                                                    


                                                        

                                                    </ul>
                                                  
                                                </div>
                                             
                                             </div>




                                </div>
                            </div>
                        </div>

                    </div>

                    <div id="page-outer">
                        <div id="page-container" class="AppContent wrapper wrapper-home white">







                            <div class="dashboard dashboard-left ">

                                <div class="DashboardProfileCard  module">

                                    <a class="DashboardProfileCard-bg u-bgUserColor u-block" href="" tabindex="-1" aria-hidden="true">
                                    </a>
                                    
                                    <!--
                                    <div class="DashboardProfileCard-content">
                                        <a class="DashboardProfileCard-avatarLink u-inlineBlock" href="./verPerfil.jsp?username=<%=lu.getUsername()%>" title="<%=lu.getUsername()%>" tabindex="-1" aria-hidden="true">
                                            <img class="DashboardProfileCard-avatarImage js-action-profile-avatar" src="<%= lu.getFotoUsuario()%>" alt="">
                                        </a>

                                        <div class="DashboardProfileCard-userFields">
                                            <div class="DashboardProfileCard-name u-textTruncate">
                                                <a class="u-textInheritColor" href="./verPerfil.jsp?username=<%=lu.getUsername()%>"><%=lu.getNombre()%></a>
                                            </div>
                                            <span class="DashboardProfileCard-screenname u-inlineBlock u-dir" dir="ltr">
                                                <a class="DashboardProfileCard-screennameLink u-linkComplex u-linkClean" href="./verPerfil.jsp?username=<%=lu.getUsername()%>">
                                                    @<span class="u-linkComplex-target"><%=lu.getUsername()%>

                                                    </span>
                                                </a>
                                            </span>
                                        </div>

                                        <div class="DashboardProfileCard-stats">
                                            <ul class="DashboardProfileCard-statList Arrange Arrange--bottom Arrange--equal">
                                                <li class="DashboardProfileCard-stat Arrange-sizeFit">
                                                    <a class="DashboardProfileCard-statLink u-textUserColor u-linkClean u-block" title="8,869 Tweets" href="./verPerfil.jsp?username=<%=lu.getUsername()%>" data-element-term="tweet_stats">
                                                        <span class="DashboardProfileCard-statLabel u-block">Tweets</span>
                                                        <span class="DashboardProfileCard-statValue" data-is-compact="false"><%=ts.getCantTweetsUsuario(lu)%></span>
                                                    </a>
                                                </li><li class="DashboardProfileCard-stat Arrange-sizeFit">
                                                    <a class="DashboardProfileCard-statLink u-textUserColor u-linkClean u-block" title="183 Following" href="https://twitter.com/following" data-element-term="follower_stats">
                                                        <span class="DashboardProfileCard-statLabel u-block">Following</span>
                                                        <span class="DashboardProfileCard-statValue" data-is-compact="false"><%=ts.getFollowingCount(lu)%></span>
                                                    </a>
                                                </li><li class="DashboardProfileCard-stat Arrange-sizeFit">
                                                    <a class="DashboardProfileCard-statLink u-textUserColor u-linkClean u-block" title="340 Followers" href="https://twitter.com/followers" data-element-term="following_stats">
                                                        <span class="DashboardProfileCard-statLabel u-block">Followers</span>
                                                        <span class="DashboardProfileCard-statValue" data-is-compact="false"><%=ts.getFollowersCount(lu)%></span>
                                                    </a>
                                                </li>
                                            </ul>
                                        </div>




                                        <div class="home-tweet-box tweet-box component tweet-user
                                             DashboardProfileCard-tweetbox u-bgUserColorLightest u-borderUserColorLighter">
                                            <form name="formCrearTweet" action="./ct" method="POST" enctype="multipart/form-data" class="t1-form tweet-form condensed">
                                                Contenido<br><textarea rows="5" cols="70" name="contenido" maxlength="200">@</textarea><br>
                                                Imagen(Opcional): <input type="file" value="" name="imagenTweet"/><br>
                                                Tweet Publico:<input type="checkbox" value="yes" name="isPublic" checked/>




                                                <div class="tweet-content">










                                                    <button class="btn primary-btn tweet-action tweet-btn js-tweet-btn" type="submit">
                                                        <span class="button-text tweeting-text">
                                                            <span class="Icon Icon--tweet"></span>
                                                            Enviar Cigua
                                                        </span>
                                                    </button>

                                                </div>
                                            </form>

                                        </div>

                                    </div>
                                    -->
                                </div>
                            </div>


                            <div role="main" aria-labelledby="content-main-heading" class="content-main " id="timeline">


                                <div class="content-header">
                                    <div class="header-inner">
                                        <h2 id="content-main-heading" class="js-timeline-title">
                                            <c:choose>
                                                <c:when test="<%=tweetsByHT != null && userByMatchingQuery == null%>">
                                                    Ciguas
                                                </c:when>
                                                <c:when test="<%=userByMatchingQuery != null && tweetsByHT == null%>">
                                                    Usuarios
                                                </c:when>
                                            </c:choose>
                                        </h2>
                                    </div>
                                </div>
                                <div class="stream-container conversations-enabled persistent-inline-actions light-inline-actions" data-max-position="486178457261711361" data-min-position="486172655801106432">

                                    <div class="stream-item js-new-items-bar-container">
                                    </div>

                                    <div class="stream home-stream">
                                        <ol class="stream-items js-navigable-stream" id="stream-items-id">  
                                            
                                            <c:choose>
                                                <c:when test="<%=qForHt%>">
                                                    <c:choose>
                                                        <c:when test="<%= tweetsByHT != null%>">
                                                            <li class="js-stream-item stream-item stream-item expanding-stream-item" data-item-id="484430288244572162" id="stream-item-tweet-484430288244572162" data-item-type="tweet">

                                                                <%
                                                                    tieneImagen = false;
                                                                    for (int i = 0; i < tweetsByHT.size(); i++) {
                                                                        Tweet t = tweetsByHT.get(i);
                                                                        if(t.getImagen() != null){
                                                                            tieneImagen = true;
                                                                        }
                                                                %>
                                                                <div class="tweet original-tweet js-stream-tweet js-actionable-tweet js-profile-popup-actionable js-original-tweet">

                                                                    <div class="context"> </div>
                                                                    <div class="content">


                                                                        <div class="stream-item-header">

                                                                            <a class="account-group js-account-group js-action-profile js-user-profile-link js-nav" href="./verPerfil.jsp?username=<%=t.getIdUsuario().getUsername()%>" data-user-id="43534995">
                                                                                <img class="avatar js-action-profile-avatar" src="<%="../build/" + t.getIdUsuario().getFotoUsuario()%>" alt="">
                                                                                <strong class="fullname js-action-profile-name show-popup-with-id"><%=t.getIdUsuario().getNombre()%></strong>
                                                                                <span>
                                                                                    </span><span class="username js-action-profile-name"><s>@</s><b><%=t.getIdUsuario().getUsername()%></b></span>


                                                                            </a>

                                                                            <small class="time">
                                                                                <a href="https://twitter.com/PeriodicoHoy/status/486178457261711361" class="tweet-timestamp js-permalink js-nav js-tooltip" title="11:32 AM - 7 Jul 2014"><span class="_timestamp js-short-timestamp js-relative-timestamp" data-time="1404748951" data-time-ms="1404748951000" data-long-form="true">-</span></a>
                                                                            </small>
                                                                        </div>

                                                                        <p class="js-tweet-text tweet-text">
                                                                            <%=t.getContenido()%>

                                                                        </p>
                                                                        <c:choose>
                                                                                <c:when test="<%=tieneImagen%>">
                                                                                    <img src="../build/<%=t.getImagen()%>">
                                                                                </c:when>
                                                                        </c:choose>

                                                                        <div class="expanded-content js-tweet-details-dropdown"> </div>
                                                                        <div class="stream-item-footer">  
                                                                            </ul>
                                                                        </div>            
                                                                    </div>
                                                                </div>
                                                                <%}%>        
                                                            </li>
                                                        </c:when>
                                                        <c:when test="<%=tweetsByHT == null%>">
                                                            <br>No se encontraron Tweets conteniendo ese hashtag.<br>
                                                        </c:when>
                                                    </c:choose>
                                                    
                                                </c:when>
                                                <c:when test="<%=qForUsers%>">
                                                    <c:choose>
                                                        <c:when test="<%=userByMatchingQuery != null%>">
                                                            <li class="js-stream-item stream-item stream-item expanding-stream-item" data-item-id="484430288244572162" id="stream-item-tweet-484430288244572162" data-item-type="tweet">

                                                                <%
                                                                    //boolean tieneImagen = false;
                                                                    for (int i = 0; i < userByMatchingQuery.size(); i++) {
                                                                        Usuario u = userByMatchingQuery.get(i);
                                                                %>
                                                                <div class="tweet original-tweet js-stream-tweet js-actionable-tweet js-profile-popup-actionable js-original-tweet">

                                                                    <div class="context"> </div>
                                                                    <div class="content">


                                                                        <div class="stream-item-header">

                                                                            <a class="account-group js-account-group js-action-profile js-user-profile-link js-nav" href="./verPerfil.jsp?username=<%=u.getUsername()%>" data-user-id="43534995">
                                                                                <img class="avatar js-action-profile-avatar" src="<%="../build/" + u.getFotoUsuario()%>" alt="">
                                                                                <strong class="fullname js-action-profile-name show-popup-with-id"><%=u.getNombre()%></strong>
                                                                                <span>
                                                                                    </span><span class="username js-action-profile-name"><s>@</s><b><%=u.getUsername()%></b></span>


                                                                            </a>

                                                                            <small class="time">
                                                                                <a href="https://twitter.com/PeriodicoHoy/status/486178457261711361" class="tweet-timestamp js-permalink js-nav js-tooltip" title="11:32 AM - 7 Jul 2014"><span class="_timestamp js-short-timestamp js-relative-timestamp" data-time="1404748951" data-time-ms="1404748951000" data-long-form="true">-</span></a>
                                                                            </small>
                                                                        </div>

                                                                        <p class="js-tweet-text tweet-text">
                                                                            <!-- Aqui iba el tweet content, replaced with...? -->

                                                                        </p>

                                                                        <div class="expanded-content js-tweet-details-dropdown"> </div>
                                                                        <div class="stream-item-footer">  
                                                                            </ul>
                                                                        </div>            
                                                                    </div>
                                                                </div>

                                                                <%}%>        


                                                            </li>
                                                        </c:when>
                                                        <c:when test="<%=userByMatchingQuery == null%>">
                                                            <br>No se encotraron usuarios por ese username.<br>
                                                        </c:when>
                                                    </c:choose>
                                                </c:when>
                                            </c:choose>





                                        </ol>
                                        <div class="stream-footer ">
                                            <div class="timeline-end has-items has-more-items">
                                                <div class="stream-end">
                                                    <div class="stream-end-inner ">
                                                        <span class="Icon Icon--large Icon--logo"></span>

                                                        <p class="empty-text">
                                                            Your timeline is currently empty. Follow people and topics you find interesting to see their Tweets in your timeline.
                                                        </p>


                                                        <p><button type="button" class="btn-link back-to-top hidden" style="display: inline-block;">Back to top ↑</button></p>

                                                    </div>
                                                </div>



                                            </div>
                                        </div>
                                        <div class="stream-fail-container">
                                            <div class="js-stream-whale-end stream-whale-end stream-placeholder centered-placeholder">
                                                <div class="stream-end-inner">
                                                    <h2 class="title">Loading seems to be taking a while.</h2>
                                                    <p>
                                                        Twitter may be over capacity or experiencing a momentary hiccup. <a role="button" href="https://twitter.com/#" class="try-again-after-whale">Try again</a> or visit <a target="_blank" href="http://status.twitter.com/">Twitter Status</a> for more information.
                                                    </p>
                                                </div>
                                            </div>
                                        </div>

                                        <ol class="hidden-replies-container"></ol>
                                    </div>
                                </div>
                                <div id="sensitive_flag_dialog" class="modal-container">
                                    <div class="close-modal-background-target"></div>
                                    <div class="modal modal-small draggable">
                                        <div class="modal-content">
                                            <button type="button" class="modal-btn modal-close js-close">
                                                <span class="Icon Icon--close Icon--medium">
                                                    <span class="visuallyhidden">Close</span>
                                                </span>
                                            </button>

                                            <div class="modal-header">
                                                <h3 class="modal-title">Flag this media</h3>
                                            </div>
                                            <div class="modal-body">
                                                <p class="sensitive-title">This has already been marked as containing sensitive content.</p>
                                                <label class="t1-label checkbox" for="sensitive-illegal-checkbox">
                                                    <input type="checkbox" id="sensitive-illegal-checkbox" value="illegal">
                                                    Flag this as containing potentially illegal content.
                                                </label>
                                            </div>
                                            <div class="modal-footer">
                                                <button id="submit_flag_confirmation" type="button" class="btn">Submit</button>
                                                <button id="cancel_flag_confirmation" type="button" class="btn primary-btn js-close">Cancel</button>

                                                <div class="sensitive-confirmation">
                                                    <a class="sensitive-learn-more" target="_blank" href="https://support.twitter.com/articles/20069937">Learn more about flagging media</a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="modal-overlay"></div>
                                </div>



                            </div>

                            <div class="dashboard dashboard-right"><div id="dashboard-matches" class="roaming-module"></div><div class="Footer module roaming-module ">
                                    <div class="flex-module">
                                        <div class="flex-module-inner js-items-container">
                                            <ul class="u-cf">
                                                <li class="Footer-item Footer-copyright copyright">© 2014 Cigua</li>

                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>


                        </div>
                    </div>


                </div>
            </body>
        </html>
    </c:when>
</c:choose>
