<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/basepath.jsp"%>
<head>
    <meta charset="utf-8" />
    <title>测试</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
    <!--公共css开始-->
	<%@ include file="/public_module/public_css_new.jsp"%>
 	<!--公共css结束-->        
      <link href="<%=basePath%>assets/layouts/layout/css/layout.css" rel="stylesheet" type="text/css" />
      <link href="<%=basePath%>assets/layouts/layout/css/themes/darkblue.css" rel="stylesheet" type="text/css" id="style_color" />

    <head>
        <meta charset="utf-8" />
        <title>Metronic | Font Icons</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta content="width=device-width, initial-scale=1" name="viewport" />
        <meta content="" name="description" />
        <meta content="" name="author" />
        <!-- BEGIN GLOBAL MANDATORY STYLES -->
        <link href="http://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700&subset=all" rel="stylesheet" type="text/css" />
        <link href="../assets/global/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
        <link href="../assets/global/plugins/simple-line-icons/simple-line-icons.min.css" rel="stylesheet" type="text/css" />
        <link href="../assets/global/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="../assets/global/plugins/uniform/css/uniform.default.css" rel="stylesheet" type="text/css" />
        <link href="../assets/global/plugins/bootstrap-switch/css/bootstrap-switch.min.css" rel="stylesheet" type="text/css" />
        <!-- END GLOBAL MANDATORY STYLES -->
        <!-- BEGIN THEME GLOBAL STYLES -->
        <link href="../assets/global/css/components-rounded.min.css" rel="stylesheet" id="style_components" type="text/css" />
        <link href="../assets/global/css/plugins.min.css" rel="stylesheet" type="text/css" />
        <!-- END THEME GLOBAL STYLES -->
        <!-- BEGIN THEME LAYOUT STYLES -->
        <link href="../assets/layouts/layout/css/layout.min.css" rel="stylesheet" type="text/css" />
        <link href="../assets/layouts/layout/css/themes/darkblue.min.css" rel="stylesheet" type="text/css" id="style_color" />
        <link href="../assets/layouts/layout/css/custom.min.css" rel="stylesheet" type="text/css" />
        <!-- END THEME LAYOUT STYLES -->
        <link rel="shortcut icon" href="favicon.ico" /> </head>
    <!-- END HEAD -->

    <body class="page-header-fixed page-sidebar-closed-hide-logo page-content-white">
        <!-- BEGIN HEADER -->
        <div class="page-header navbar navbar-fixed-top">
            <!-- BEGIN HEADER INNER -->
            <div class="page-header-inner ">
                <!-- BEGIN LOGO -->
                <div class="page-logo">
                    <a href="index.html">
                        <img src="../assets/layouts/layout/img/logo.png" alt="logo" class="logo-default" /> </a>
                    <div class="menu-toggler sidebar-toggler"> </div>
                </div>
                <!-- END LOGO -->
                <!-- BEGIN RESPONSIVE MENU TOGGLER -->
                <a href="javascript:;" class="menu-toggler responsive-toggler" data-toggle="collapse" data-target=".navbar-collapse"> </a>
                <!-- END RESPONSIVE MENU TOGGLER -->
                <!-- BEGIN TOP NAVIGATION MENU -->
                <div class="top-menu">
                    <ul class="nav navbar-nav pull-right">
                        <!-- BEGIN NOTIFICATION DROPDOWN -->
                        <!-- DOC: Apply "dropdown-dark" class after below "dropdown-extended" to change the dropdown styte -->
                        <li class="dropdown dropdown-extended dropdown-notification" id="header_notification_bar">
                            <a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
                                <i class="icon-bell"></i>
                                <span class="badge badge-default"> 7 </span>
                            </a>
                            <ul class="dropdown-menu">
                                <li class="external">
                                    <h3>
                                        <span class="bold">12 pending</span> notifications</h3>
                                    <a href="page_user_profile_1.html">view all</a>
                                </li>
                                <li>
                                    <ul class="dropdown-menu-list scroller" style="height: 250px;" data-handle-color="#637283">
                                        <li>
                                            <a href="javascript:;">
                                                <span class="time">just now</span>
                                                <span class="details">
                                                    <span class="label label-sm label-icon label-success">
                                                        <i class="fa fa-plus"></i>
                                                    </span> New user registered. </span>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="javascript:;">
                                                <span class="time">3 mins</span>
                                                <span class="details">
                                                    <span class="label label-sm label-icon label-danger">
                                                        <i class="fa fa-bolt"></i>
                                                    </span> Server #12 overloaded. </span>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="javascript:;">
                                                <span class="time">10 mins</span>
                                                <span class="details">
                                                    <span class="label label-sm label-icon label-warning">
                                                        <i class="fa fa-bell-o"></i>
                                                    </span> Server #2 not responding. </span>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="javascript:;">
                                                <span class="time">14 hrs</span>
                                                <span class="details">
                                                    <span class="label label-sm label-icon label-info">
                                                        <i class="fa fa-bullhorn"></i>
                                                    </span> Application error. </span>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="javascript:;">
                                                <span class="time">2 days</span>
                                                <span class="details">
                                                    <span class="label label-sm label-icon label-danger">
                                                        <i class="fa fa-bolt"></i>
                                                    </span> Database overloaded 68%. </span>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="javascript:;">
                                                <span class="time">3 days</span>
                                                <span class="details">
                                                    <span class="label label-sm label-icon label-danger">
                                                        <i class="fa fa-bolt"></i>
                                                    </span> A user IP blocked. </span>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="javascript:;">
                                                <span class="time">4 days</span>
                                                <span class="details">
                                                    <span class="label label-sm label-icon label-warning">
                                                        <i class="fa fa-bell-o"></i>
                                                    </span> Storage Server #4 not responding dfdfdfd. </span>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="javascript:;">
                                                <span class="time">5 days</span>
                                                <span class="details">
                                                    <span class="label label-sm label-icon label-info">
                                                        <i class="fa fa-bullhorn"></i>
                                                    </span> System Error. </span>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="javascript:;">
                                                <span class="time">9 days</span>
                                                <span class="details">
                                                    <span class="label label-sm label-icon label-danger">
                                                        <i class="fa fa-bolt"></i>
                                                    </span> Storage server failed. </span>
                                            </a>
                                        </li>
                                    </ul>
                                </li>
                            </ul>
                        </li>
                        <!-- END NOTIFICATION DROPDOWN -->
                        <!-- BEGIN INBOX DROPDOWN -->
                        <!-- DOC: Apply "dropdown-dark" class after below "dropdown-extended" to change the dropdown styte -->
                        <li class="dropdown dropdown-extended dropdown-inbox" id="header_inbox_bar">
                            <a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
                                <i class="icon-envelope-open"></i>
                                <span class="badge badge-default"> 4 </span>
                            </a>
                            <ul class="dropdown-menu">
                                <li class="external">
                                    <h3>You have
                                        <span class="bold">7 New</span> Messages</h3>
                                    <a href="app_inbox.html">view all</a>
                                </li>
                                <li>
                                    <ul class="dropdown-menu-list scroller" style="height: 275px;" data-handle-color="#637283">
                                        <li>
                                            <a href="#">
                                                <span class="photo">
                                                    <img src="../assets/layouts/layout3/img/avatar2.jpg" class="img-circle" alt=""> </span>
                                                <span class="subject">
                                                    <span class="from"> Lisa Wong </span>
                                                    <span class="time">Just Now </span>
                                                </span>
                                                <span class="message"> Vivamus sed auctor nibh congue nibh. auctor nibh auctor nibh... </span>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#">
                                                <span class="photo">
                                                    <img src="../assets/layouts/layout3/img/avatar3.jpg" class="img-circle" alt=""> </span>
                                                <span class="subject">
                                                    <span class="from"> Richard Doe </span>
                                                    <span class="time">16 mins </span>
                                                </span>
                                                <span class="message"> Vivamus sed congue nibh auctor nibh congue nibh. auctor nibh auctor nibh... </span>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#">
                                                <span class="photo">
                                                    <img src="../assets/layouts/layout3/img/avatar1.jpg" class="img-circle" alt=""> </span>
                                                <span class="subject">
                                                    <span class="from"> Bob Nilson </span>
                                                    <span class="time">2 hrs </span>
                                                </span>
                                                <span class="message"> Vivamus sed nibh auctor nibh congue nibh. auctor nibh auctor nibh... </span>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#">
                                                <span class="photo">
                                                    <img src="../assets/layouts/layout3/img/avatar2.jpg" class="img-circle" alt=""> </span>
                                                <span class="subject">
                                                    <span class="from"> Lisa Wong </span>
                                                    <span class="time">40 mins </span>
                                                </span>
                                                <span class="message"> Vivamus sed auctor 40% nibh congue nibh... </span>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#">
                                                <span class="photo">
                                                    <img src="../assets/layouts/layout3/img/avatar3.jpg" class="img-circle" alt=""> </span>
                                                <span class="subject">
                                                    <span class="from"> Richard Doe </span>
                                                    <span class="time">46 mins </span>
                                                </span>
                                                <span class="message"> Vivamus sed congue nibh auctor nibh congue nibh. auctor nibh auctor nibh... </span>
                                            </a>
                                        </li>
                                    </ul>
                                </li>
                            </ul>
                        </li>
                        <!-- END INBOX DROPDOWN -->
                        <!-- BEGIN TODO DROPDOWN -->
                        <!-- DOC: Apply "dropdown-dark" class after below "dropdown-extended" to change the dropdown styte -->
                        <li class="dropdown dropdown-extended dropdown-tasks" id="header_task_bar">
                            <a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
                                <i class="icon-calendar"></i>
                                <span class="badge badge-default"> 3 </span>
                            </a>
                            <ul class="dropdown-menu extended tasks">
                                <li class="external">
                                    <h3>You have
                                        <span class="bold">12 pending</span> tasks</h3>
                                    <a href="app_todo.html">view all</a>
                                </li>
                                <li>
                                    <ul class="dropdown-menu-list scroller" style="height: 275px;" data-handle-color="#637283">
                                        <li>
                                            <a href="javascript:;">
                                                <span class="task">
                                                    <span class="desc">New release v1.2 </span>
                                                    <span class="percent">30%</span>
                                                </span>
                                                <span class="progress">
                                                    <span style="width: 40%;" class="progress-bar progress-bar-success" aria-valuenow="40" aria-valuemin="0" aria-valuemax="100">
                                                        <span class="sr-only">40% Complete</span>
                                                    </span>
                                                </span>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="javascript:;">
                                                <span class="task">
                                                    <span class="desc">Application deployment</span>
                                                    <span class="percent">65%</span>
                                                </span>
                                                <span class="progress">
                                                    <span style="width: 65%;" class="progress-bar progress-bar-danger" aria-valuenow="65" aria-valuemin="0" aria-valuemax="100">
                                                        <span class="sr-only">65% Complete</span>
                                                    </span>
                                                </span>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="javascript:;">
                                                <span class="task">
                                                    <span class="desc">Mobile app release</span>
                                                    <span class="percent">98%</span>
                                                </span>
                                                <span class="progress">
                                                    <span style="width: 98%;" class="progress-bar progress-bar-success" aria-valuenow="98" aria-valuemin="0" aria-valuemax="100">
                                                        <span class="sr-only">98% Complete</span>
                                                    </span>
                                                </span>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="javascript:;">
                                                <span class="task">
                                                    <span class="desc">Database migration</span>
                                                    <span class="percent">10%</span>
                                                </span>
                                                <span class="progress">
                                                    <span style="width: 10%;" class="progress-bar progress-bar-warning" aria-valuenow="10" aria-valuemin="0" aria-valuemax="100">
                                                        <span class="sr-only">10% Complete</span>
                                                    </span>
                                                </span>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="javascript:;">
                                                <span class="task">
                                                    <span class="desc">Web server upgrade</span>
                                                    <span class="percent">58%</span>
                                                </span>
                                                <span class="progress">
                                                    <span style="width: 58%;" class="progress-bar progress-bar-info" aria-valuenow="58" aria-valuemin="0" aria-valuemax="100">
                                                        <span class="sr-only">58% Complete</span>
                                                    </span>
                                                </span>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="javascript:;">
                                                <span class="task">
                                                    <span class="desc">Mobile development</span>
                                                    <span class="percent">85%</span>
                                                </span>
                                                <span class="progress">
                                                    <span style="width: 85%;" class="progress-bar progress-bar-success" aria-valuenow="85" aria-valuemin="0" aria-valuemax="100">
                                                        <span class="sr-only">85% Complete</span>
                                                    </span>
                                                </span>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="javascript:;">
                                                <span class="task">
                                                    <span class="desc">New UI release</span>
                                                    <span class="percent">38%</span>
                                                </span>
                                                <span class="progress progress-striped">
                                                    <span style="width: 38%;" class="progress-bar progress-bar-important" aria-valuenow="18" aria-valuemin="0" aria-valuemax="100">
                                                        <span class="sr-only">38% Complete</span>
                                                    </span>
                                                </span>
                                            </a>
                                        </li>
                                    </ul>
                                </li>
                            </ul>
                        </li>
                        <!-- END TODO DROPDOWN -->
                        <!-- BEGIN USER LOGIN DROPDOWN -->
                        <!-- DOC: Apply "dropdown-dark" class after below "dropdown-extended" to change the dropdown styte -->
                        <li class="dropdown dropdown-user">
                            <a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
                                <img alt="" class="img-circle" src="../assets/layouts/layout/img/avatar3_small.jpg" />
                                <span class="username username-hide-on-mobile"> Nick </span>
                                <i class="fa fa-angle-down"></i>
                            </a>
                            <ul class="dropdown-menu dropdown-menu-default">
                                <li>
                                    <a href="page_user_profile_1.html">
                                        <i class="icon-user"></i> My Profile </a>
                                </li>
                                <li>
                                    <a href="app_calendar.html">
                                        <i class="icon-calendar"></i> My Calendar </a>
                                </li>
                                <li>
                                    <a href="app_inbox.html">
                                        <i class="icon-envelope-open"></i> My Inbox
                                        <span class="badge badge-danger"> 3 </span>
                                    </a>
                                </li>
                                <li>
                                    <a href="app_todo.html">
                                        <i class="icon-rocket"></i> My Tasks
                                        <span class="badge badge-success"> 7 </span>
                                    </a>
                                </li>
                                <li class="divider"> </li>
                                <li>
                                    <a href="page_user_lock_1.html">
                                        <i class="icon-lock"></i> Lock Screen </a>
                                </li>
                                <li>
                                    <a href="page_user_login_1.html">
                                        <i class="icon-key"></i> Log Out </a>
                                </li>
                            </ul>
                        </li>
                        <!-- END USER LOGIN DROPDOWN -->
                        <!-- BEGIN QUICK SIDEBAR TOGGLER -->
                        <!-- DOC: Apply "dropdown-dark" class after below "dropdown-extended" to change the dropdown styte -->
                        <li class="dropdown dropdown-quick-sidebar-toggler">
                            <a href="javascript:;" class="dropdown-toggle">
                                <i class="icon-logout"></i>
                            </a>
                        </li>
                        <!-- END QUICK SIDEBAR TOGGLER -->
                    </ul>
                </div>
                <!-- END TOP NAVIGATION MENU -->
            </div>
            <!-- END HEADER INNER -->
        </div>
        <!-- END HEADER -->
        <!-- BEGIN HEADER & CONTENT DIVIDER -->
        <div class="clearfix"> </div>
        <!-- END HEADER & CONTENT DIVIDER -->
        <!-- BEGIN CONTAINER -->
        <div class="page-container">
            <!-- BEGIN SIDEBAR -->
            <div class="page-sidebar-wrapper">
                <!-- BEGIN SIDEBAR -->
                <!-- DOC: Set data-auto-scroll="false" to disable the sidebar from auto scrolling/focusing -->
                <!-- DOC: Change data-auto-speed="200" to adjust the sub menu slide up/down speed -->
                <div class="page-sidebar navbar-collapse collapse">
                    <!-- BEGIN SIDEBAR MENU -->
                    <!-- DOC: Apply "page-sidebar-menu-light" class right after "page-sidebar-menu" to enable light sidebar menu style(without borders) -->
                    <!-- DOC: Apply "page-sidebar-menu-hover-submenu" class right after "page-sidebar-menu" to enable hoverable(hover vs accordion) sub menu mode -->
                    <!-- DOC: Apply "page-sidebar-menu-closed" class right after "page-sidebar-menu" to collapse("page-sidebar-closed" class must be applied to the body element) the sidebar sub menu mode -->
                    <!-- DOC: Set data-auto-scroll="false" to disable the sidebar from auto scrolling/focusing -->
                    <!-- DOC: Set data-keep-expand="true" to keep the submenues expanded -->
                    <!-- DOC: Set data-auto-speed="200" to adjust the sub menu slide up/down speed -->
                    <ul class="page-sidebar-menu  page-header-fixed " data-keep-expanded="false" data-auto-scroll="true" data-slide-speed="200" style="padding-top: 20px">
                        <!-- DOC: To remove the sidebar toggler from the sidebar you just need to completely remove the below "sidebar-toggler-wrapper" LI element -->
                        <li class="sidebar-toggler-wrapper hide">
                            <!-- BEGIN SIDEBAR TOGGLER BUTTON -->
                            <div class="sidebar-toggler"> </div>
                            <!-- END SIDEBAR TOGGLER BUTTON -->
                        </li>
                        <!-- DOC: To remove the search box from the sidebar you just need to completely remove the below "sidebar-search-wrapper" LI element -->
                        <li class="sidebar-search-wrapper">
                            <!-- BEGIN RESPONSIVE QUICK SEARCH FORM -->
                            <!-- DOC: Apply "sidebar-search-bordered" class the below search form to have bordered search box -->
                            <!-- DOC: Apply "sidebar-search-bordered sidebar-search-solid" class the below search form to have bordered & solid search box -->
                            <form class="sidebar-search  " action="page_general_search_3.html" method="POST">
                                <a href="javascript:;" class="remove">
                                    <i class="icon-close"></i>
                                </a>
                                <div class="input-group">
                                    <input type="text" class="form-control" placeholder="Search...">
                                    <span class="input-group-btn">
                                        <a href="javascript:;" class="btn submit">
                                            <i class="icon-magnifier"></i>
                                        </a>
                                    </span>
                                </div>
                            </form>
                            <!-- END RESPONSIVE QUICK SEARCH FORM -->
                        </li>
                        <li class="nav-item start ">
                            <a href="javascript:;" class="nav-link nav-toggle">
                                <i class="icon-home"></i>
                                <span class="title">Dashboard</span>
                                <span class="arrow"></span>
                            </a>
                            <ul class="sub-menu">
                                <li class="nav-item start ">
                                    <a href="index.html" class="nav-link ">
                                        <i class="icon-bar-chart"></i>
                                        <span class="title">Dashboard 1</span>
                                    </a>
                                </li>
                                <li class="nav-item start ">
                                    <a href="dashboard_2.html" class="nav-link ">
                                        <i class="icon-bulb"></i>
                                        <span class="title">Dashboard 2</span>
                                        <span class="badge badge-success">1</span>
                                    </a>
                                </li>
                                <li class="nav-item start ">
                                    <a href="dashboard_3.html" class="nav-link ">
                                        <i class="icon-graph"></i>
                                        <span class="title">Dashboard 3</span>
                                        <span class="badge badge-danger">5</span>
                                    </a>
                                </li>
                            </ul>
                        </li>
                        <li class="heading">
                            <h3 class="uppercase">Features</h3>
                        </li>
                        <li class="nav-item  active open">
                            <a href="javascript:;" class="nav-link nav-toggle">
                                <i class="icon-diamond"></i>
                                <span class="title">UI Features</span>
                                <span class="selected"></span>
                                <span class="arrow open"></span>
                            </a>
                            <ul class="sub-menu">
                                <li class="nav-item  ">
                                    <a href="ui_colors.html" class="nav-link ">
                                        <span class="title">Color Library</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="ui_general.html" class="nav-link ">
                                        <span class="title">General Components</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="ui_buttons.html" class="nav-link ">
                                        <span class="title">Buttons</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="ui_confirmations.html" class="nav-link ">
                                        <span class="title">Popover Confirmations</span>
                                    </a>
                                </li>
                                <li class="nav-item  active open">
                                    <a href="ui_icons.html" class="nav-link ">
                                        <span class="title">Font Icons</span>
                                        <span class="selected"></span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="ui_socicons.html" class="nav-link ">
                                        <span class="title">Social Icons</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="ui_typography.html" class="nav-link ">
                                        <span class="title">Typography</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="ui_tabs_accordions_navs.html" class="nav-link ">
                                        <span class="title">Tabs, Accordions & Navs</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="ui_timeline.html" class="nav-link ">
                                        <span class="title">Timeline</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="ui_tree.html" class="nav-link ">
                                        <span class="title">Tree View</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="javascript:;" class="nav-link nav-toggle">
                                        <span class="title">Page Progress Bar</span>
                                        <span class="arrow"></span>
                                    </a>
                                    <ul class="sub-menu">
                                        <li class="nav-item ">
                                            <a href="ui_page_progress_style_1.html" class="nav-link "> Flash </a>
                                        </li>
                                        <li class="nav-item ">
                                            <a href="ui_page_progress_style_2.html" class="nav-link "> Big Counter </a>
                                        </li>
                                    </ul>
                                </li>
                                <li class="nav-item  ">
                                    <a href="ui_blockui.html" class="nav-link ">
                                        <span class="title">Block UI</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="ui_bootstrap_growl.html" class="nav-link ">
                                        <span class="title">Bootstrap Growl Notifications</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="ui_notific8.html" class="nav-link ">
                                        <span class="title">Notific8 Notifications</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="ui_toastr.html" class="nav-link ">
                                        <span class="title">Toastr Notifications</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="ui_bootbox.html" class="nav-link ">
                                        <span class="title">Bootbox Dialogs</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="ui_alerts_api.html" class="nav-link ">
                                        <span class="title">Metronic Alerts API</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="ui_session_timeout.html" class="nav-link ">
                                        <span class="title">Session Timeout</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="ui_idle_timeout.html" class="nav-link ">
                                        <span class="title">User Idle Timeout</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="ui_modals.html" class="nav-link ">
                                        <span class="title">Modals</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="ui_extended_modals.html" class="nav-link ">
                                        <span class="title">Extended Modals</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="ui_tiles.html" class="nav-link ">
                                        <span class="title">Tiles</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="ui_datepaginator.html" class="nav-link ">
                                        <span class="title">Date Paginator</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="ui_nestable.html" class="nav-link ">
                                        <span class="title">Nestable List</span>
                                    </a>
                                </li>
                            </ul>
                        </li>
                        <li class="nav-item  ">
                            <a href="javascript:;" class="nav-link nav-toggle">
                                <i class="icon-puzzle"></i>
                                <span class="title">Components</span>
                                <span class="arrow"></span>
                            </a>
                            <ul class="sub-menu">
                                <li class="nav-item  ">
                                    <a href="components_date_time_pickers.html" class="nav-link ">
                                        <span class="title">Date & Time Pickers</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="components_color_pickers.html" class="nav-link ">
                                        <span class="title">Color Pickers</span>
                                        <span class="badge badge-danger">2</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="components_select2.html" class="nav-link ">
                                        <span class="title">Select2 Dropdowns</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="components_bootstrap_select.html" class="nav-link ">
                                        <span class="title">Bootstrap Select</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="components_multi_select.html" class="nav-link ">
                                        <span class="title">Multi Select</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="components_bootstrap_select_splitter.html" class="nav-link ">
                                        <span class="title">Select Splitter</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="components_typeahead.html" class="nav-link ">
                                        <span class="title">Typeahead Autocomplete</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="components_bootstrap_tagsinput.html" class="nav-link ">
                                        <span class="title">Bootstrap Tagsinput</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="components_bootstrap_switch.html" class="nav-link ">
                                        <span class="title">Bootstrap Switch</span>
                                        <span class="badge badge-success">6</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="components_bootstrap_maxlength.html" class="nav-link ">
                                        <span class="title">Bootstrap Maxlength</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="components_bootstrap_fileinput.html" class="nav-link ">
                                        <span class="title">Bootstrap File Input</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="components_bootstrap_touchspin.html" class="nav-link ">
                                        <span class="title">Bootstrap Touchspin</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="components_form_tools.html" class="nav-link ">
                                        <span class="title">Form Widgets & Tools</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="components_context_menu.html" class="nav-link ">
                                        <span class="title">Context Menu</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="components_editors.html" class="nav-link ">
                                        <span class="title">Markdown & WYSIWYG Editors</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="components_code_editors.html" class="nav-link ">
                                        <span class="title">Code Editors</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="components_ion_sliders.html" class="nav-link ">
                                        <span class="title">Ion Range Sliders</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="components_noui_sliders.html" class="nav-link ">
                                        <span class="title">NoUI Range Sliders</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="components_knob_dials.html" class="nav-link ">
                                        <span class="title">Knob Circle Dials</span>
                                    </a>
                                </li>
                            </ul>
                        </li>
                        <li class="nav-item  ">
                            <a href="javascript:;" class="nav-link nav-toggle">
                                <i class="icon-settings"></i>
                                <span class="title">Form Stuff</span>
                                <span class="arrow"></span>
                            </a>
                            <ul class="sub-menu">
                                <li class="nav-item  ">
                                    <a href="form_controls.html" class="nav-link ">
                                        <span class="title">Bootstrap Form
                                            <br>Controls</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="form_controls_md.html" class="nav-link ">
                                        <span class="title">Material Design
                                            <br>Form Controls</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="form_validation.html" class="nav-link ">
                                        <span class="title">Form Validation</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="form_validation_states_md.html" class="nav-link ">
                                        <span class="title">Material Design
                                            <br>Form Validation States</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="form_validation_md.html" class="nav-link ">
                                        <span class="title">Material Design
                                            <br>Form Validation</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="form_layouts.html" class="nav-link ">
                                        <span class="title">Form Layouts</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="form_input_mask.html" class="nav-link ">
                                        <span class="title">Form Input Mask</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="form_editable.html" class="nav-link ">
                                        <span class="title">Form X-editable</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="form_wizard.html" class="nav-link ">
                                        <span class="title">Form Wizard</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="form_icheck.html" class="nav-link ">
                                        <span class="title">iCheck Controls</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="form_image_crop.html" class="nav-link ">
                                        <span class="title">Image Cropping</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="form_fileupload.html" class="nav-link ">
                                        <span class="title">Multiple File Upload</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="form_dropzone.html" class="nav-link ">
                                        <span class="title">Dropzone File Upload</span>
                                    </a>
                                </li>
                            </ul>
                        </li>
                        <li class="nav-item  ">
                            <a href="javascript:;" class="nav-link nav-toggle">
                                <i class="icon-bulb"></i>
                                <span class="title">Elements</span>
                                <span class="arrow"></span>
                            </a>
                            <ul class="sub-menu">
                                <li class="nav-item  ">
                                    <a href="elements_steps.html" class="nav-link ">
                                        <span class="title">Steps</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="elements_lists.html" class="nav-link ">
                                        <span class="title">Lists</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="elements_ribbons.html" class="nav-link ">
                                        <span class="title">Ribbons</span>
                                    </a>
                                </li>
                            </ul>
                        </li>
                        <li class="nav-item  ">
                            <a href="javascript:;" class="nav-link nav-toggle">
                                <i class="icon-briefcase"></i>
                                <span class="title">Tables</span>
                                <span class="arrow"></span>
                            </a>
                            <ul class="sub-menu">
                                <li class="nav-item  ">
                                    <a href="javascript:;" class="nav-link nav-toggle">
                                        <span class="title">Static Tables</span>
                                        <span class="arrow"></span>
                                    </a>
                                    <ul class="sub-menu">
                                        <li class="nav-item ">
                                            <a href="table_static_basic.html" class="nav-link "> Basic Tables </a>
                                        </li>
                                        <li class="nav-item ">
                                            <a href="table_static_responsive.html" class="nav-link "> Responsive Tables </a>
                                        </li>
                                    </ul>
                                </li>
                                <li class="nav-item  ">
                                    <a href="javascript:;" class="nav-link nav-toggle">
                                        <span class="title">Datatables</span>
                                        <span class="arrow"></span>
                                    </a>
                                    <ul class="sub-menu">
                                        <li class="nav-item ">
                                            <a href="table_datatables_managed.html" class="nav-link "> Managed Datatables </a>
                                        </li>
                                        <li class="nav-item ">
                                            <a href="table_datatables_buttons.html" class="nav-link "> Buttons Extension </a>
                                        </li>
                                        <li class="nav-item ">
                                            <a href="table_datatables_colreorder.html" class="nav-link "> Colreorder Extension </a>
                                        </li>
                                        <li class="nav-item ">
                                            <a href="table_datatables_rowreorder.html" class="nav-link "> Rowreorder Extension </a>
                                        </li>
                                        <li class="nav-item ">
                                            <a href="table_datatables_scroller.html" class="nav-link "> Scroller Extension </a>
                                        </li>
                                        <li class="nav-item ">
                                            <a href="table_datatables_fixedheader.html" class="nav-link "> FixedHeader Extension </a>
                                        </li>
                                        <li class="nav-item ">
                                            <a href="table_datatables_responsive.html" class="nav-link "> Responsive Extension </a>
                                        </li>
                                        <li class="nav-item ">
                                            <a href="table_datatables_editable.html" class="nav-link "> Editable Datatables </a>
                                        </li>
                                        <li class="nav-item ">
                                            <a href="table_datatables_ajax.html" class="nav-link "> Ajax Datatables </a>
                                        </li>
                                    </ul>
                                </li>
                            </ul>
                        </li>
                        <li class="nav-item  ">
                            <a href="?p=" class="nav-link nav-toggle">
                                <i class="icon-wallet"></i>
                                <span class="title">Portlets</span>
                                <span class="arrow"></span>
                            </a>
                            <ul class="sub-menu">
                                <li class="nav-item  ">
                                    <a href="portlet_boxed.html" class="nav-link ">
                                        <span class="title">Boxed Portlets</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="portlet_light.html" class="nav-link ">
                                        <span class="title">Light Portlets</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="portlet_solid.html" class="nav-link ">
                                        <span class="title">Solid Portlets</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="portlet_ajax.html" class="nav-link ">
                                        <span class="title">Ajax Portlets</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="portlet_draggable.html" class="nav-link ">
                                        <span class="title">Draggable Portlets</span>
                                    </a>
                                </li>
                            </ul>
                        </li>
                        <li class="nav-item  ">
                            <a href="javascript:;" class="nav-link nav-toggle">
                                <i class="icon-bar-chart"></i>
                                <span class="title">Charts</span>
                                <span class="arrow"></span>
                            </a>
                            <ul class="sub-menu">
                                <li class="nav-item  ">
                                    <a href="charts_amcharts.html" class="nav-link ">
                                        <span class="title">amChart</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="charts_flotcharts.html" class="nav-link ">
                                        <span class="title">Flot Charts</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="charts_flowchart.html" class="nav-link ">
                                        <span class="title">Flow Charts</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="charts_google.html" class="nav-link ">
                                        <span class="title">Google Charts</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="charts_echarts.html" class="nav-link ">
                                        <span class="title">eCharts</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="charts_morris.html" class="nav-link ">
                                        <span class="title">Morris Charts</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="javascript:;" class="nav-link nav-toggle">
                                        <span class="title">HighCharts</span>
                                        <span class="arrow"></span>
                                    </a>
                                    <ul class="sub-menu">
                                        <li class="nav-item ">
                                            <a href="charts_highcharts.html" class="nav-link "> HighCharts </a>
                                        </li>
                                        <li class="nav-item ">
                                            <a href="charts_highstock.html" class="nav-link "> HighStock </a>
                                        </li>
                                        <li class="nav-item ">
                                            <a href="charts_highmaps.html" class="nav-link "> HighMaps </a>
                                        </li>
                                    </ul>
                                </li>
                            </ul>
                        </li>
                        <li class="nav-item  ">
                            <a href="javascript:;" class="nav-link nav-toggle">
                                <i class="icon-pointer"></i>
                                <span class="title">Maps</span>
                                <span class="arrow"></span>
                            </a>
                            <ul class="sub-menu">
                                <li class="nav-item  ">
                                    <a href="maps_google.html" class="nav-link ">
                                        <span class="title">Google Maps</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="maps_vector.html" class="nav-link ">
                                        <span class="title">Vector Maps</span>
                                    </a>
                                </li>
                            </ul>
                        </li>
                        <li class="heading">
                            <h3 class="uppercase">Layouts</h3>
                        </li>
                        <li class="nav-item  ">
                            <a href="javascript:;" class="nav-link nav-toggle">
                                <i class="icon-layers"></i>
                                <span class="title">Page Layouts</span>
                                <span class="arrow"></span>
                            </a>
                            <ul class="sub-menu">
                                <li class="nav-item  ">
                                    <a href="layout_classic_page_head.html" class="nav-link ">
                                        <span class="title">Classic Page Head</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="layout_light_page_head.html" class="nav-link ">
                                        <span class="title">Light Page Head</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="layout_content_grey.html" class="nav-link ">
                                        <span class="title">Grey Bg Content</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="layout_search_on_header_1.html" class="nav-link ">
                                        <span class="title">Search Box On Header 1</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="layout_search_on_header_2.html" class="nav-link ">
                                        <span class="title">Search Box On Header 2</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="layout_language_bar.html" class="nav-link ">
                                        <span class="title">Header Language Bar</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="layout_footer_fixed.html" class="nav-link ">
                                        <span class="title">Fixed Footer</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="layout_boxed_page.html" class="nav-link ">
                                        <span class="title">Boxed Page</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="layout_blank_page.html" class="nav-link ">
                                        <span class="title">Blank Page</span>
                                    </a>
                                </li>
                            </ul>
                        </li>
                        <li class="nav-item  ">
                            <a href="javascript:;" class="nav-link nav-toggle">
                                <i class="icon-feed"></i>
                                <span class="title">Sidebar Layouts</span>
                                <span class="arrow"></span>
                            </a>
                            <ul class="sub-menu">
                                <li class="nav-item  ">
                                    <a href="layout_sidebar_menu_light.html" class="nav-link ">
                                        <span class="title">Light Sidebar Menu</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="layout_sidebar_menu_hover.html" class="nav-link ">
                                        <span class="title">Hover Sidebar Menu</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="layout_sidebar_search_1.html" class="nav-link ">
                                        <span class="title">Sidebar Search Option 1</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="layout_sidebar_search_2.html" class="nav-link ">
                                        <span class="title">Sidebar Search Option 2</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="layout_toggler_on_sidebar.html" class="nav-link ">
                                        <span class="title">Sidebar Toggler On Sidebar</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="layout_sidebar_reversed.html" class="nav-link ">
                                        <span class="title">Reversed Sidebar Page</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="layout_sidebar_fixed.html" class="nav-link ">
                                        <span class="title">Fixed Sidebar Layout</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="layout_sidebar_closed.html" class="nav-link ">
                                        <span class="title">Closed Sidebar Layout</span>
                                    </a>
                                </li>
                            </ul>
                        </li>
                        <li class="nav-item  ">
                            <a href="javascript:;" class="nav-link nav-toggle">
                                <i class="icon-paper-plane"></i>
                                <span class="title">Horizontal Menu</span>
                                <span class="arrow"></span>
                            </a>
                            <ul class="sub-menu">
                                <li class="nav-item  ">
                                    <a href="layout_mega_menu_light.html" class="nav-link ">
                                        <span class="title">Light Mega Menu</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="layout_mega_menu_dark.html" class="nav-link ">
                                        <span class="title">Dark Mega Menu</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="layout_full_width.html" class="nav-link ">
                                        <span class="title">Full Width Layout</span>
                                    </a>
                                </li>
                            </ul>
                        </li>
                        <li class="nav-item  ">
                            <a href="javascript:;" class="nav-link nav-toggle">
                                <i class=" icon-wrench"></i>
                                <span class="title">Custom Layouts</span>
                                <span class="arrow"></span>
                            </a>
                            <ul class="sub-menu">
                                <li class="nav-item  ">
                                    <a href="layout_disabled_menu.html" class="nav-link ">
                                        <span class="title">Disabled Menu Links</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="layout_full_height_portlet.html" class="nav-link ">
                                        <span class="title">Full Height Portlet</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="layout_full_height_content.html" class="nav-link ">
                                        <span class="title">Full Height Content</span>
                                    </a>
                                </li>
                            </ul>
                        </li>
                        <li class="heading">
                            <h3 class="uppercase">Pages</h3>
                        </li>
                        <li class="nav-item  ">
                            <a href="javascript:;" class="nav-link nav-toggle">
                                <i class="icon-basket"></i>
                                <span class="title">eCommerce</span>
                                <span class="arrow"></span>
                            </a>
                            <ul class="sub-menu">
                                <li class="nav-item  ">
                                    <a href="ecommerce_index.html" class="nav-link ">
                                        <i class="icon-home"></i>
                                        <span class="title">Dashboard</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="ecommerce_orders.html" class="nav-link ">
                                        <i class="icon-basket"></i>
                                        <span class="title">Orders</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="ecommerce_orders_view.html" class="nav-link ">
                                        <i class="icon-tag"></i>
                                        <span class="title">Order View</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="ecommerce_products.html" class="nav-link ">
                                        <i class="icon-graph"></i>
                                        <span class="title">Products</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="ecommerce_products_edit.html" class="nav-link ">
                                        <i class="icon-graph"></i>
                                        <span class="title">Product Edit</span>
                                    </a>
                                </li>
                            </ul>
                        </li>
                        <li class="nav-item  ">
                            <a href="javascript:;" class="nav-link nav-toggle">
                                <i class="icon-docs"></i>
                                <span class="title">Apps</span>
                                <span class="arrow"></span>
                            </a>
                            <ul class="sub-menu">
                                <li class="nav-item  ">
                                    <a href="app_todo.html" class="nav-link ">
                                        <i class="icon-clock"></i>
                                        <span class="title">Todo 1</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="app_todo_2.html" class="nav-link ">
                                        <i class="icon-check"></i>
                                        <span class="title">Todo 2</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="app_inbox.html" class="nav-link ">
                                        <i class="icon-envelope"></i>
                                        <span class="title">Inbox</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="app_calendar.html" class="nav-link ">
                                        <i class="icon-calendar"></i>
                                        <span class="title">Calendar</span>
                                    </a>
                                </li>
                            </ul>
                        </li>
                        <li class="nav-item  ">
                            <a href="javascript:;" class="nav-link nav-toggle">
                                <i class="icon-user"></i>
                                <span class="title">User</span>
                                <span class="arrow"></span>
                            </a>
                            <ul class="sub-menu">
                                <li class="nav-item  ">
                                    <a href="page_user_profile_1.html" class="nav-link ">
                                        <i class="icon-user"></i>
                                        <span class="title">Profile 1</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="page_user_profile_1_account.html" class="nav-link ">
                                        <i class="icon-user-female"></i>
                                        <span class="title">Profile 1 Account</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="page_user_profile_1_help.html" class="nav-link ">
                                        <i class="icon-user-following"></i>
                                        <span class="title">Profile 1 Help</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="page_user_profile_2.html" class="nav-link ">
                                        <i class="icon-users"></i>
                                        <span class="title">Profile 2</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="javascript:;" class="nav-link nav-toggle">
                                        <i class="icon-notebook"></i>
                                        <span class="title">Login</span>
                                        <span class="arrow"></span>
                                    </a>
                                    <ul class="sub-menu">
                                        <li class="nav-item ">
                                            <a href="page_user_login_1.html" class="nav-link " target="_blank"> Login Page 1 </a>
                                        </li>
                                        <li class="nav-item ">
                                            <a href="page_user_login_2.html" class="nav-link " target="_blank"> Login Page 2 </a>
                                        </li>
                                        <li class="nav-item ">
                                            <a href="page_user_login_3.html" class="nav-link " target="_blank"> Login Page 3 </a>
                                        </li>
                                        <li class="nav-item ">
                                            <a href="page_user_login_4.html" class="nav-link " target="_blank"> Login Page 4 </a>
                                        </li>
                                        <li class="nav-item ">
                                            <a href="page_user_login_5.html" class="nav-link " target="_blank"> Login Page 5 </a>
                                        </li>
                                        <li class="nav-item ">
                                            <a href="page_user_login_6.html" class="nav-link " target="_blank"> Login Page 6 </a>
                                        </li>
                                    </ul>
                                </li>
                                <li class="nav-item  ">
                                    <a href="page_user_lock_1.html" class="nav-link " target="_blank">
                                        <i class="icon-lock"></i>
                                        <span class="title">Lock Screen 1</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="page_user_lock_2.html" class="nav-link " target="_blank">
                                        <i class="icon-lock-open"></i>
                                        <span class="title">Lock Screen 2</span>
                                    </a>
                                </li>
                            </ul>
                        </li>
                        <li class="nav-item  ">
                            <a href="javascript:;" class="nav-link nav-toggle">
                                <i class="icon-social-dribbble"></i>
                                <span class="title">General</span>
                                <span class="arrow"></span>
                            </a>
                            <ul class="sub-menu">
                                <li class="nav-item  ">
                                    <a href="page_general_about.html" class="nav-link ">
                                        <i class="icon-info"></i>
                                        <span class="title">About</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="page_general_contact.html" class="nav-link ">
                                        <i class="icon-call-end"></i>
                                        <span class="title">Contact</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="javascript:;" class="nav-link nav-toggle">
                                        <i class="icon-notebook"></i>
                                        <span class="title">Portfolio</span>
                                        <span class="arrow"></span>
                                    </a>
                                    <ul class="sub-menu">
                                        <li class="nav-item ">
                                            <a href="page_general_portfolio_1.html" class="nav-link "> Portfolio 1 </a>
                                        </li>
                                        <li class="nav-item ">
                                            <a href="page_general_portfolio_2.html" class="nav-link "> Portfolio 2 </a>
                                        </li>
                                        <li class="nav-item ">
                                            <a href="page_general_portfolio_3.html" class="nav-link "> Portfolio 3 </a>
                                        </li>
                                        <li class="nav-item ">
                                            <a href="page_general_portfolio_4.html" class="nav-link "> Portfolio 4 </a>
                                        </li>
                                    </ul>
                                </li>
                                <li class="nav-item  ">
                                    <a href="javascript:;" class="nav-link nav-toggle">
                                        <i class="icon-magnifier"></i>
                                        <span class="title">Search</span>
                                        <span class="arrow"></span>
                                    </a>
                                    <ul class="sub-menu">
                                        <li class="nav-item ">
                                            <a href="page_general_search.html" class="nav-link "> Search 1 </a>
                                        </li>
                                        <li class="nav-item ">
                                            <a href="page_general_search_2.html" class="nav-link "> Search 2 </a>
                                        </li>
                                        <li class="nav-item ">
                                            <a href="page_general_search_3.html" class="nav-link "> Search 3 </a>
                                        </li>
                                        <li class="nav-item ">
                                            <a href="page_general_search_4.html" class="nav-link "> Search 4 </a>
                                        </li>
                                        <li class="nav-item ">
                                            <a href="page_general_search_5.html" class="nav-link "> Search 5 </a>
                                        </li>
                                    </ul>
                                </li>
                                <li class="nav-item  ">
                                    <a href="page_general_pricing.html" class="nav-link ">
                                        <i class="icon-tag"></i>
                                        <span class="title">Pricing</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="page_general_faq.html" class="nav-link ">
                                        <i class="icon-wrench"></i>
                                        <span class="title">FAQ</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="page_general_blog.html" class="nav-link ">
                                        <i class="icon-pencil"></i>
                                        <span class="title">Blog</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="page_general_blog_post.html" class="nav-link ">
                                        <i class="icon-note"></i>
                                        <span class="title">Blog Post</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="page_general_invoice.html" class="nav-link ">
                                        <i class="icon-envelope"></i>
                                        <span class="title">Invoice</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="page_general_invoice_2.html" class="nav-link ">
                                        <i class="icon-envelope"></i>
                                        <span class="title">Invoice 2</span>
                                    </a>
                                </li>
                            </ul>
                        </li>
                        <li class="nav-item  ">
                            <a href="javascript:;" class="nav-link nav-toggle">
                                <i class="icon-settings"></i>
                                <span class="title">System</span>
                                <span class="arrow"></span>
                            </a>
                            <ul class="sub-menu">
                                <li class="nav-item  ">
                                    <a href="page_system_coming_soon.html" class="nav-link " target="_blank">
                                        <span class="title">Coming Soon</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="page_system_404_1.html" class="nav-link ">
                                        <span class="title">404 Page 1</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="page_system_404_2.html" class="nav-link " target="_blank">
                                        <span class="title">404 Page 2</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="page_system_404_3.html" class="nav-link " target="_blank">
                                        <span class="title">404 Page 3</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="page_system_500_1.html" class="nav-link ">
                                        <span class="title">500 Page 1</span>
                                    </a>
                                </li>
                                <li class="nav-item  ">
                                    <a href="page_system_500_2.html" class="nav-link " target="_blank">
                                        <span class="title">500 Page 2</span>
                                    </a>
                                </li>
                            </ul>
                        </li>
                        <li class="nav-item">
                            <a href="javascript:;" class="nav-link nav-toggle">
                                <i class="icon-folder"></i>
                                <span class="title">Multi Level Menu</span>
                                <span class="arrow "></span>
                            </a>
                            <ul class="sub-menu">
                                <li class="nav-item">
                                    <a href="javascript:;" class="nav-link nav-toggle">
                                        <i class="icon-settings"></i> Item 1
                                        <span class="arrow"></span>
                                    </a>
                                    <ul class="sub-menu">
                                        <li class="nav-item">
                                            <a href="javascript:;" target="_blank" class="nav-link">
                                                <i class="icon-user"></i> Arrow Toggle
                                                <span class="arrow nav-toggle"></span>
                                            </a>
                                            <ul class="sub-menu">
                                                <li class="nav-item">
                                                    <a href="#" class="nav-link">
                                                        <i class="icon-power"></i> Sample Link 1</a>
                                                </li>
                                                <li class="nav-item">
                                                    <a href="#" class="nav-link">
                                                        <i class="icon-paper-plane"></i> Sample Link 1</a>
                                                </li>
                                                <li class="nav-item">
                                                    <a href="#" class="nav-link">
                                                        <i class="icon-star"></i> Sample Link 1</a>
                                                </li>
                                            </ul>
                                        </li>
                                        <li class="nav-item">
                                            <a href="#" class="nav-link">
                                                <i class="icon-camera"></i> Sample Link 1</a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="#" class="nav-link">
                                                <i class="icon-link"></i> Sample Link 2</a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="#" class="nav-link">
                                                <i class="icon-pointer"></i> Sample Link 3</a>
                                        </li>
                                    </ul>
                                </li>
                                <li class="nav-item">
                                    <a href="javascript:;" target="_blank" class="nav-link">
                                        <i class="icon-globe"></i> Arrow Toggle
                                        <span class="arrow nav-toggle"></span>
                                    </a>
                                    <ul class="sub-menu">
                                        <li class="nav-item">
                                            <a href="#" class="nav-link">
                                                <i class="icon-tag"></i> Sample Link 1</a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="#" class="nav-link">
                                                <i class="icon-pencil"></i> Sample Link 1</a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="#" class="nav-link">
                                                <i class="icon-graph"></i> Sample Link 1</a>
                                        </li>
                                    </ul>
                                </li>
                                <li class="nav-item">
                                    <a href="#" class="nav-link">
                                        <i class="icon-bar-chart"></i> Item 3 </a>
                                </li>
                            </ul>
                        </li>
                    </ul>
                    <!-- END SIDEBAR MENU -->
                    <!-- END SIDEBAR MENU -->
                </div>
                <!-- END SIDEBAR -->
            </div>
            <!-- END SIDEBAR -->
            <!-- BEGIN CONTENT -->
            <div class="page-content-wrapper">
                <!-- BEGIN CONTENT BODY -->
                <div class="page-content">
                    <!-- BEGIN PAGE HEADER-->
                    <!-- BEGIN THEME PANEL -->
                    <div class="theme-panel hidden-xs hidden-sm">
                        <div class="toggler"> </div>
                        <div class="toggler-close"> </div>
                        <div class="theme-options">
                            <div class="theme-option theme-colors clearfix">
                                <span> THEME COLOR </span>
                                <ul>
                                    <li class="color-default current tooltips" data-style="default" data-container="body" data-original-title="Default"> </li>
                                    <li class="color-darkblue tooltips" data-style="darkblue" data-container="body" data-original-title="Dark Blue"> </li>
                                    <li class="color-blue tooltips" data-style="blue" data-container="body" data-original-title="Blue"> </li>
                                    <li class="color-grey tooltips" data-style="grey" data-container="body" data-original-title="Grey"> </li>
                                    <li class="color-light tooltips" data-style="light" data-container="body" data-original-title="Light"> </li>
                                    <li class="color-light2 tooltips" data-style="light2" data-container="body" data-html="true" data-original-title="Light 2"> </li>
                                </ul>
                            </div>
                            <div class="theme-option">
                                <span> Theme Style </span>
                                <select class="layout-style-option form-control input-sm">
                                    <option value="square" selected="selected">Square corners</option>
                                    <option value="rounded">Rounded corners</option>
                                </select>
                            </div>
                            <div class="theme-option">
                                <span> Layout </span>
                                <select class="layout-option form-control input-sm">
                                    <option value="fluid" selected="selected">Fluid</option>
                                    <option value="boxed">Boxed</option>
                                </select>
                            </div>
                            <div class="theme-option">
                                <span> Header </span>
                                <select class="page-header-option form-control input-sm">
                                    <option value="fixed" selected="selected">Fixed</option>
                                    <option value="default">Default</option>
                                </select>
                            </div>
                            <div class="theme-option">
                                <span> Top Menu Dropdown</span>
                                <select class="page-header-top-dropdown-style-option form-control input-sm">
                                    <option value="light" selected="selected">Light</option>
                                    <option value="dark">Dark</option>
                                </select>
                            </div>
                            <div class="theme-option">
                                <span> Sidebar Mode</span>
                                <select class="sidebar-option form-control input-sm">
                                    <option value="fixed">Fixed</option>
                                    <option value="default" selected="selected">Default</option>
                                </select>
                            </div>
                            <div class="theme-option">
                                <span> Sidebar Menu </span>
                                <select class="sidebar-menu-option form-control input-sm">
                                    <option value="accordion" selected="selected">Accordion</option>
                                    <option value="hover">Hover</option>
                                </select>
                            </div>
                            <div class="theme-option">
                                <span> Sidebar Style </span>
                                <select class="sidebar-style-option form-control input-sm">
                                    <option value="default" selected="selected">Default</option>
                                    <option value="light">Light</option>
                                </select>
                            </div>
                            <div class="theme-option">
                                <span> Sidebar Position </span>
                                <select class="sidebar-pos-option form-control input-sm">
                                    <option value="left" selected="selected">Left</option>
                                    <option value="right">Right</option>
                                </select>
                            </div>
                            <div class="theme-option">
                                <span> Footer </span>
                                <select class="page-footer-option form-control input-sm">
                                    <option value="fixed">Fixed</option>
                                    <option value="default" selected="selected">Default</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <!-- END THEME PANEL -->
                    <!-- BEGIN PAGE BAR -->
                    <div class="page-bar">
                        <ul class="page-breadcrumb">
                            <li>
                                <a href="index.html">Home</a>
                                <i class="fa fa-circle"></i>
                            </li>
                            <li>
                                <span>UI Features</span>
                            </li>
                        </ul>
                        <div class="page-toolbar">
                            <div class="btn-group pull-right">
                                <button type="button" class="btn green btn-sm btn-outline dropdown-toggle" data-toggle="dropdown"> Actions
                                    <i class="fa fa-angle-down"></i>
                                </button>
                                <ul class="dropdown-menu pull-right" role="menu">
                                    <li>
                                        <a href="#">
                                            <i class="icon-bell"></i> Action</a>
                                    </li>
                                    <li>
                                        <a href="#">
                                            <i class="icon-shield"></i> Another action</a>
                                    </li>
                                    <li>
                                        <a href="#">
                                            <i class="icon-user"></i> Something else here</a>
                                    </li>
                                    <li class="divider"> </li>
                                    <li>
                                        <a href="#">
                                            <i class="icon-bag"></i> Separated link</a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <!-- END PAGE BAR -->
                    <!-- BEGIN PAGE TITLE-->
                    <h3 class="page-title"> Font Icons
                        <small>font icons and more</small>
                    </h3>
                    <!-- END PAGE TITLE-->
                    <!-- END PAGE HEADER-->
                    <div class="row">
                        <div class="col-md-12">
                            <div class="tabbable-line">
                                <ul class="nav nav-tabs">
                                    <li class="active">
                                        <a href="#tab_1_1" data-toggle="tab"> Fontawesome Icons </a>
                                    </li>
                                    <li>
                                        <a href="#tab_1_3" data-toggle="tab"> Simple Line Icons </a>
                                    </li>
                                    <li>
                                        <a href="#tab_1_2" data-toggle="tab"> Glyphicons </a>
                                    </li>
                                </ul>
                                <div class="tab-content">
                                    <div class="tab-pane active fontawesome-demo" id="tab_1_1">
                                        <div class="note note-success">
                                            <p> Font Awesome gives you scalable vector icons that can instantly be customized — size, color, drop shadow, and anything that can be done with the power of CSS. The complete set of 439 icons in Font Awesome 4.1.0
                                                </p> For more info check out:
                                            <a target="_blank" href="http://fortawesome.github.io/Font-Awesome/icons/">http://fortawesome.github.io/Font-Awesome/icons/</a>
                                        </div>
                                        <section id="new">
                                            <h3>66 New Icons in 4.4</h3>
                                            <div class="row fontawesome-icon-list">
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-500px"></i> 500px</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-amazon"></i> amazon</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-balance-scale"></i> balance-scale</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-battery-0"></i> battery-0
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-battery-1"></i> battery-1
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-battery-2"></i> battery-2
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-battery-3"></i> battery-3
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-battery-4"></i> battery-4
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-battery-empty"></i> battery-empty</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-battery-full"></i> battery-full</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-battery-half"></i> battery-half</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-battery-quarter"></i> battery-quarter</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-battery-three-quarters"></i> battery-three-quarters</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-black-tie"></i> black-tie</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-calendar-check-o"></i> calendar-check-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-calendar-minus-o"></i> calendar-minus-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-calendar-plus-o"></i> calendar-plus-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-calendar-times-o"></i> calendar-times-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-cc-diners-club"></i> cc-diners-club</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-cc-jcb"></i> cc-jcb</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-chrome"></i> chrome</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-clone"></i> clone</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-commenting"></i> commenting</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-commenting-o"></i> commenting-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-contao"></i> contao</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-creative-commons"></i> creative-commons</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-expeditedssl"></i> expeditedssl</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-firefox"></i> firefox</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-fonticons"></i> fonticons</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-genderless"></i> genderless</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-get-pocket"></i> get-pocket</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-gg"></i> gg</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-gg-circle"></i> gg-circle</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-hand-grab-o"></i> hand-grab-o
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-hand-lizard-o"></i> hand-lizard-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-hand-paper-o"></i> hand-paper-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-hand-peace-o"></i> hand-peace-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-hand-pointer-o"></i> hand-pointer-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-hand-rock-o"></i> hand-rock-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-hand-scissors-o"></i> hand-scissors-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-hand-spock-o"></i> hand-spock-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-hand-stop-o"></i> hand-stop-o
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-hourglass"></i> hourglass</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-hourglass-1"></i> hourglass-1
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-hourglass-2"></i> hourglass-2
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-hourglass-3"></i> hourglass-3
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-hourglass-end"></i> hourglass-end</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-hourglass-half"></i> hourglass-half</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-hourglass-o"></i> hourglass-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-hourglass-start"></i> hourglass-start</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-houzz"></i> houzz</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-i-cursor"></i> i-cursor</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-industry"></i> industry</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-internet-explorer"></i> internet-explorer</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-map"></i> map</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-map-o"></i> map-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-map-pin"></i> map-pin</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-map-signs"></i> map-signs</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-mouse-pointer"></i> mouse-pointer</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-object-group"></i> object-group</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-object-ungroup"></i> object-ungroup</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-odnoklassniki"></i> odnoklassniki</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-odnoklassniki-square"></i> odnoklassniki-square</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-opencart"></i> opencart</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-opera"></i> opera</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-optin-monster"></i> optin-monster</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-registered"></i> registered</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-safari"></i> safari</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-sticky-note"></i> sticky-note</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-sticky-note-o"></i> sticky-note-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-television"></i> television</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-trademark"></i> trademark</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-tripadvisor"></i> tripadvisor</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-tv"></i> tv
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-vimeo"></i> vimeo</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-wikipedia-w"></i> wikipedia-w</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-y-combinator"></i> y-combinator</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-yc"></i> yc
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                            </div>
                                        </section>
                                        <section id="web-application">
                                            <h2 class="page-header">Web Application Icons</h2>
                                            <div class="row fontawesome-icon-list">
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-adjust"></i> adjust</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-anchor"></i> anchor</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-archive"></i> archive</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-area-chart"></i> area-chart</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-arrows"></i> arrows</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-arrows-h"></i> arrows-h</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-arrows-v"></i> arrows-v</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-asterisk"></i> asterisk</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-at"></i> at</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-automobile"></i> automobile
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-balance-scale"></i> balance-scale</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-ban"></i> ban</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-bank"></i> bank
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-bar-chart"></i> bar-chart</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-bar-chart-o"></i> bar-chart-o
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-barcode"></i> barcode</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-bars"></i> bars</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-battery-0"></i> battery-0
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-battery-1"></i> battery-1
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-battery-2"></i> battery-2
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-battery-3"></i> battery-3
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-battery-4"></i> battery-4
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-battery-empty"></i> battery-empty</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-battery-full"></i> battery-full</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-battery-half"></i> battery-half</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-battery-quarter"></i> battery-quarter</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-battery-three-quarters"></i> battery-three-quarters</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-bed"></i> bed</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-beer"></i> beer</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-bell"></i> bell</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-bell-o"></i> bell-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-bell-slash"></i> bell-slash</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-bell-slash-o"></i> bell-slash-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-bicycle"></i> bicycle</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-binoculars"></i> binoculars</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-birthday-cake"></i> birthday-cake</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-bolt"></i> bolt</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-bomb"></i> bomb</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-book"></i> book</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-bookmark"></i> bookmark</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-bookmark-o"></i> bookmark-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-briefcase"></i> briefcase</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-bug"></i> bug</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-building"></i> building</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-building-o"></i> building-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-bullhorn"></i> bullhorn</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-bullseye"></i> bullseye</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-bus"></i> bus</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-cab"></i> cab
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-calculator"></i> calculator</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-calendar"></i> calendar</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-calendar-check-o"></i> calendar-check-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-calendar-minus-o"></i> calendar-minus-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-calendar-o"></i> calendar-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-calendar-plus-o"></i> calendar-plus-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-calendar-times-o"></i> calendar-times-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-camera"></i> camera</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-camera-retro"></i> camera-retro</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-car"></i> car</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-caret-square-o-down"></i> caret-square-o-down</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-caret-square-o-left"></i> caret-square-o-left</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-caret-square-o-right"></i> caret-square-o-right</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-caret-square-o-up"></i> caret-square-o-up</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-cart-arrow-down"></i> cart-arrow-down</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-cart-plus"></i> cart-plus</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-cc"></i> cc</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-certificate"></i> certificate</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-check"></i> check</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-check-circle"></i> check-circle</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-check-circle-o"></i> check-circle-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-check-square"></i> check-square</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-check-square-o"></i> check-square-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-child"></i> child</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-circle"></i> circle</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-circle-o"></i> circle-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-circle-o-notch"></i> circle-o-notch</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-circle-thin"></i> circle-thin</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-clock-o"></i> clock-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-clone"></i> clone</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-close"></i> close
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-cloud"></i> cloud</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-cloud-download"></i> cloud-download</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-cloud-upload"></i> cloud-upload</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-code"></i> code</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-code-fork"></i> code-fork</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-coffee"></i> coffee</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-cog"></i> cog</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-cogs"></i> cogs</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-comment"></i> comment</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-comment-o"></i> comment-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-commenting"></i> commenting</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-commenting-o"></i> commenting-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-comments"></i> comments</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-comments-o"></i> comments-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-compass"></i> compass</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-copyright"></i> copyright</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-creative-commons"></i> creative-commons</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-credit-card"></i> credit-card</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-crop"></i> crop</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-crosshairs"></i> crosshairs</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-cube"></i> cube</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-cubes"></i> cubes</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-cutlery"></i> cutlery</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-dashboard"></i> dashboard
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-database"></i> database</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-desktop"></i> desktop</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-diamond"></i> diamond</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-dot-circle-o"></i> dot-circle-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-download"></i> download</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-edit"></i> edit
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-ellipsis-h"></i> ellipsis-h</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-ellipsis-v"></i> ellipsis-v</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-envelope"></i> envelope</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-envelope-o"></i> envelope-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-envelope-square"></i> envelope-square</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-eraser"></i> eraser</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-exchange"></i> exchange</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-exclamation"></i> exclamation</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-exclamation-circle"></i> exclamation-circle</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-exclamation-triangle"></i> exclamation-triangle</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-external-link"></i> external-link</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-external-link-square"></i> external-link-square</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-eye"></i> eye</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-eye-slash"></i> eye-slash</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-eyedropper"></i> eyedropper</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-fax"></i> fax</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-feed"></i> feed
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-female"></i> female</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-fighter-jet"></i> fighter-jet</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-file-archive-o"></i> file-archive-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-file-audio-o"></i> file-audio-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-file-code-o"></i> file-code-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-file-excel-o"></i> file-excel-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-file-image-o"></i> file-image-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-file-movie-o"></i> file-movie-o
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-file-pdf-o"></i> file-pdf-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-file-photo-o"></i> file-photo-o
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-file-picture-o"></i> file-picture-o
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-file-powerpoint-o"></i> file-powerpoint-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-file-sound-o"></i> file-sound-o
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-file-video-o"></i> file-video-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-file-word-o"></i> file-word-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-file-zip-o"></i> file-zip-o
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-film"></i> film</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-filter"></i> filter</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-fire"></i> fire</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-fire-extinguisher"></i> fire-extinguisher</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-flag"></i> flag</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-flag-checkered"></i> flag-checkered</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-flag-o"></i> flag-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-flash"></i> flash
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-flask"></i> flask</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-folder"></i> folder</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-folder-o"></i> folder-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-folder-open"></i> folder-open</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-folder-open-o"></i> folder-open-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-frown-o"></i> frown-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-futbol-o"></i> futbol-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-gamepad"></i> gamepad</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-gavel"></i> gavel</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-gear"></i> gear
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-gears"></i> gears
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-gift"></i> gift</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-glass"></i> glass</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-globe"></i> globe</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-graduation-cap"></i> graduation-cap</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-group"></i> group
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-hand-grab-o"></i> hand-grab-o
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-hand-lizard-o"></i> hand-lizard-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-hand-paper-o"></i> hand-paper-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-hand-peace-o"></i> hand-peace-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-hand-pointer-o"></i> hand-pointer-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-hand-rock-o"></i> hand-rock-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-hand-scissors-o"></i> hand-scissors-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-hand-spock-o"></i> hand-spock-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-hand-stop-o"></i> hand-stop-o
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-hdd-o"></i> hdd-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-headphones"></i> headphones</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-heart"></i> heart</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-heart-o"></i> heart-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-heartbeat"></i> heartbeat</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-history"></i> history</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-home"></i> home</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-hotel"></i> hotel
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-hourglass"></i> hourglass</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-hourglass-1"></i> hourglass-1
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-hourglass-2"></i> hourglass-2
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-hourglass-3"></i> hourglass-3
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-hourglass-end"></i> hourglass-end</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-hourglass-half"></i> hourglass-half</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-hourglass-o"></i> hourglass-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-hourglass-start"></i> hourglass-start</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-i-cursor"></i> i-cursor</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-image"></i> image
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-inbox"></i> inbox</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-industry"></i> industry</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-info"></i> info</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-info-circle"></i> info-circle</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-institution"></i> institution
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-key"></i> key</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-keyboard-o"></i> keyboard-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-language"></i> language</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-laptop"></i> laptop</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-leaf"></i> leaf</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-legal"></i> legal
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-lemon-o"></i> lemon-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-level-down"></i> level-down</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-level-up"></i> level-up</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-life-bouy"></i> life-bouy
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-life-buoy"></i> life-buoy
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-life-ring"></i> life-ring</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-life-saver"></i> life-saver
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-lightbulb-o"></i> lightbulb-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-line-chart"></i> line-chart</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-location-arrow"></i> location-arrow</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-lock"></i> lock</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-magic"></i> magic</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-magnet"></i> magnet</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-mail-forward"></i> mail-forward
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-mail-reply"></i> mail-reply
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-mail-reply-all"></i> mail-reply-all
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-male"></i> male</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-map"></i> map</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-map-marker"></i> map-marker</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-map-o"></i> map-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-map-pin"></i> map-pin</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-map-signs"></i> map-signs</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-meh-o"></i> meh-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-microphone"></i> microphone</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-microphone-slash"></i> microphone-slash</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-minus"></i> minus</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-minus-circle"></i> minus-circle</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-minus-square"></i> minus-square</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-minus-square-o"></i> minus-square-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-mobile"></i> mobile</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-mobile-phone"></i> mobile-phone
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-money"></i> money</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-moon-o"></i> moon-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-mortar-board"></i> mortar-board
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-motorcycle"></i> motorcycle</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-mouse-pointer"></i> mouse-pointer</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-music"></i> music</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-navicon"></i> navicon
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-newspaper-o"></i> newspaper-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-object-group"></i> object-group</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-object-ungroup"></i> object-ungroup</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-paint-brush"></i> paint-brush</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-paper-plane"></i> paper-plane</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-paper-plane-o"></i> paper-plane-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-paw"></i> paw</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-pencil"></i> pencil</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-pencil-square"></i> pencil-square</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-pencil-square-o"></i> pencil-square-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-phone"></i> phone</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-phone-square"></i> phone-square</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-photo"></i> photo
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-picture-o"></i> picture-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-pie-chart"></i> pie-chart</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-plane"></i> plane</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-plug"></i> plug</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-plus"></i> plus</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-plus-circle"></i> plus-circle</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-plus-square"></i> plus-square</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-plus-square-o"></i> plus-square-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-power-off"></i> power-off</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-print"></i> print</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-puzzle-piece"></i> puzzle-piece</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-qrcode"></i> qrcode</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-question"></i> question</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-question-circle"></i> question-circle</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-quote-left"></i> quote-left</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-quote-right"></i> quote-right</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-random"></i> random</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-recycle"></i> recycle</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-refresh"></i> refresh</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-registered"></i> registered</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-remove"></i> remove
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-reorder"></i> reorder
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-reply"></i> reply</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-reply-all"></i> reply-all</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-retweet"></i> retweet</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-road"></i> road</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-rocket"></i> rocket</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-rss"></i> rss</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-rss-square"></i> rss-square</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-search"></i> search</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-search-minus"></i> search-minus</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-search-plus"></i> search-plus</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-send"></i> send
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-send-o"></i> send-o
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-server"></i> server</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-share"></i> share</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-share-alt"></i> share-alt</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-share-alt-square"></i> share-alt-square</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-share-square"></i> share-square</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-share-square-o"></i> share-square-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-shield"></i> shield</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-ship"></i> ship</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-shopping-cart"></i> shopping-cart</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-sign-in"></i> sign-in</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-sign-out"></i> sign-out</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-signal"></i> signal</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-sitemap"></i> sitemap</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-sliders"></i> sliders</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-smile-o"></i> smile-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-soccer-ball-o"></i> soccer-ball-o
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-sort"></i> sort</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-sort-alpha-asc"></i> sort-alpha-asc</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-sort-alpha-desc"></i> sort-alpha-desc</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-sort-amount-asc"></i> sort-amount-asc</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-sort-amount-desc"></i> sort-amount-desc</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-sort-asc"></i> sort-asc</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-sort-desc"></i> sort-desc</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-sort-down"></i> sort-down
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-sort-numeric-asc"></i> sort-numeric-asc</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-sort-numeric-desc"></i> sort-numeric-desc</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-sort-up"></i> sort-up
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-space-shuttle"></i> space-shuttle</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-spinner"></i> spinner</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-spoon"></i> spoon</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-square"></i> square</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-square-o"></i> square-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-star"></i> star</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-star-half"></i> star-half</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-star-half-empty"></i> star-half-empty
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-star-half-full"></i> star-half-full
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-star-half-o"></i> star-half-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-star-o"></i> star-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-sticky-note"></i> sticky-note</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-sticky-note-o"></i> sticky-note-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-street-view"></i> street-view</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-suitcase"></i> suitcase</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-sun-o"></i> sun-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-support"></i> support
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-tablet"></i> tablet</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-tachometer"></i> tachometer</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-tag"></i> tag</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-tags"></i> tags</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-tasks"></i> tasks</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-taxi"></i> taxi</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-television"></i> television</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-terminal"></i> terminal</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-thumb-tack"></i> thumb-tack</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-thumbs-down"></i> thumbs-down</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-thumbs-o-down"></i> thumbs-o-down</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-thumbs-o-up"></i> thumbs-o-up</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-thumbs-up"></i> thumbs-up</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-ticket"></i> ticket</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-times"></i> times</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-times-circle"></i> times-circle</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-times-circle-o"></i> times-circle-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-tint"></i> tint</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-toggle-down"></i> toggle-down
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-toggle-left"></i> toggle-left
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-toggle-off"></i> toggle-off</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-toggle-on"></i> toggle-on</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-toggle-right"></i> toggle-right
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-toggle-up"></i> toggle-up
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-trademark"></i> trademark</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-trash"></i> trash</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-trash-o"></i> trash-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-tree"></i> tree</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-trophy"></i> trophy</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-truck"></i> truck</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-tty"></i> tty</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-tv"></i> tv
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-umbrella"></i> umbrella</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-university"></i> university</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-unlock"></i> unlock</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-unlock-alt"></i> unlock-alt</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-unsorted"></i> unsorted
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-upload"></i> upload</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-user"></i> user</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-user-plus"></i> user-plus</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-user-secret"></i> user-secret</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-user-times"></i> user-times</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-users"></i> users</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-video-camera"></i> video-camera</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-volume-down"></i> volume-down</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-volume-off"></i> volume-off</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-volume-up"></i> volume-up</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-warning"></i> warning
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-wheelchair"></i> wheelchair</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-wifi"></i> wifi</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-wrench"></i> wrench</div>
                                            </div>
                                        </section>
                                        <section id="hand">
                                            <h2 class="page-header">Hand Icons</h2>
                                            <div class="row fontawesome-icon-list">
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-hand-grab-o"></i> hand-grab-o
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-hand-lizard-o"></i> hand-lizard-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-hand-o-down"></i> hand-o-down</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-hand-o-left"></i> hand-o-left</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-hand-o-right"></i> hand-o-right</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-hand-o-up"></i> hand-o-up</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-hand-paper-o"></i> hand-paper-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-hand-peace-o"></i> hand-peace-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-hand-pointer-o"></i> hand-pointer-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-hand-rock-o"></i> hand-rock-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-hand-scissors-o"></i> hand-scissors-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-hand-spock-o"></i> hand-spock-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-hand-stop-o"></i> hand-stop-o
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-thumbs-down"></i> thumbs-down</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-thumbs-o-down"></i> thumbs-o-down</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-thumbs-o-up"></i> thumbs-o-up</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-thumbs-up"></i> thumbs-up</div>
                                            </div>
                                        </section>
                                        <section id="transportation">
                                            <h2 class="page-header">Transportation Icons</h2>
                                            <div class="row fontawesome-icon-list">
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-ambulance"></i> ambulance</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-automobile"></i> automobile
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-bicycle"></i> bicycle</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-bus"></i> bus</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-cab"></i> cab
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-car"></i> car</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-fighter-jet"></i> fighter-jet</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-motorcycle"></i> motorcycle</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-plane"></i> plane</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-rocket"></i> rocket</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-ship"></i> ship</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-space-shuttle"></i> space-shuttle</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-subway"></i> subway</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-taxi"></i> taxi</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-train"></i> train</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-truck"></i> truck</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-wheelchair"></i> wheelchair</div>
                                            </div>
                                        </section>
                                        <section id="gender">
                                            <h2 class="page-header">Gender Icons</h2>
                                            <div class="row fontawesome-icon-list">
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-genderless"></i> genderless</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-intersex"></i> intersex
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-mars"></i> mars</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-mars-double"></i> mars-double</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-mars-stroke"></i> mars-stroke</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-mars-stroke-h"></i> mars-stroke-h</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-mars-stroke-v"></i> mars-stroke-v</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-mercury"></i> mercury</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-neuter"></i> neuter</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-transgender"></i> transgender</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-transgender-alt"></i> transgender-alt</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-venus"></i> venus</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-venus-double"></i> venus-double</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-venus-mars"></i> venus-mars</div>
                                            </div>
                                        </section>
                                        <section id="file-type">
                                            <h2 class="page-header">File Type Icons</h2>
                                            <div class="row fontawesome-icon-list">
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-file"></i> file</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-file-archive-o"></i> file-archive-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-file-audio-o"></i> file-audio-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-file-code-o"></i> file-code-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-file-excel-o"></i> file-excel-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-file-image-o"></i> file-image-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-file-movie-o"></i> file-movie-o
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-file-o"></i> file-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-file-pdf-o"></i> file-pdf-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-file-photo-o"></i> file-photo-o
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-file-picture-o"></i> file-picture-o
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-file-powerpoint-o"></i> file-powerpoint-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-file-sound-o"></i> file-sound-o
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-file-text"></i> file-text</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-file-text-o"></i> file-text-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-file-video-o"></i> file-video-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-file-word-o"></i> file-word-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-file-zip-o"></i> file-zip-o
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                            </div>
                                        </section>
                                        <section id="spinner">
                                            <h2 class="page-header">Spinner Icons</h2>
                                            <div class="alert alert-success">
                                                <ul class="fa-ul">
                                                    <li>
                                                        <i class="fa fa-info-circle fa-lg fa-li"></i> These icons work great with the <code>fa-spin</code> class. Check out the spinning icons example. </li>
                                                </ul>
                                            </div>
                                            <div class="row fontawesome-icon-list">
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-circle-o-notch"></i> circle-o-notch</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-cog"></i> cog</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-gear"></i> gear
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-refresh"></i> refresh</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-spinner"></i> spinner</div>
                                            </div>
                                        </section>
                                        <section id="form-control">
                                            <h2 class="page-header">Form Control Icons</h2>
                                            <div class="row fontawesome-icon-list">
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-check-square"></i> check-square</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-check-square-o"></i> check-square-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-circle"></i> circle</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-circle-o"></i> circle-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-dot-circle-o"></i> dot-circle-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-minus-square"></i> minus-square</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-minus-square-o"></i> minus-square-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-plus-square"></i> plus-square</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-plus-square-o"></i> plus-square-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-square"></i> square</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-square-o"></i> square-o</div>
                                            </div>
                                        </section>
                                        <section id="payment">
                                            <h2 class="page-header">Payment Icons</h2>
                                            <div class="row fontawesome-icon-list">
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-cc-amex"></i> cc-amex</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-cc-diners-club"></i> cc-diners-club</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-cc-discover"></i> cc-discover</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-cc-jcb"></i> cc-jcb</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-cc-mastercard"></i> cc-mastercard</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-cc-paypal"></i> cc-paypal</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-cc-stripe"></i> cc-stripe</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-cc-visa"></i> cc-visa</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-credit-card"></i> credit-card</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-google-wallet"></i> google-wallet</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-paypal"></i> paypal</div>
                                            </div>
                                        </section>
                                        <section id="chart">
                                            <h2 class="page-header">Chart Icons</h2>
                                            <div class="row fontawesome-icon-list">
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-area-chart"></i> area-chart</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-bar-chart"></i> bar-chart</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-bar-chart-o"></i> bar-chart-o
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-line-chart"></i> line-chart</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-pie-chart"></i> pie-chart</div>
                                            </div>
                                        </section>
                                        <section id="currency">
                                            <h2 class="page-header">Currency Icons</h2>
                                            <div class="row fontawesome-icon-list">
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-bitcoin"></i> bitcoin
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-btc"></i> btc</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-cny"></i> cny
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-dollar"></i> dollar
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-eur"></i> eur</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-euro"></i> euro
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-gbp"></i> gbp</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-gg"></i> gg</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-gg-circle"></i> gg-circle</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-ils"></i> ils</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-inr"></i> inr</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-jpy"></i> jpy</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-krw"></i> krw</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-money"></i> money</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-rmb"></i> rmb
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-rouble"></i> rouble
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-rub"></i> rub</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-ruble"></i> ruble
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-rupee"></i> rupee
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-shekel"></i> shekel
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-sheqel"></i> sheqel
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-try"></i> try</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-turkish-lira"></i> turkish-lira
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-usd"></i> usd</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-won"></i> won
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-yen"></i> yen
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                            </div>
                                        </section>
                                        <section id="text-editor">
                                            <h2 class="page-header">Text Editor Icons</h2>
                                            <div class="row fontawesome-icon-list">
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-align-center"></i> align-center</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-align-justify"></i> align-justify</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-align-left"></i> align-left</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-align-right"></i> align-right</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-bold"></i> bold</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-chain"></i> chain
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-chain-broken"></i> chain-broken</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-clipboard"></i> clipboard</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-columns"></i> columns</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-copy"></i> copy
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-cut"></i> cut
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-dedent"></i> dedent
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-eraser"></i> eraser</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-file"></i> file</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-file-o"></i> file-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-file-text"></i> file-text</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-file-text-o"></i> file-text-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-files-o"></i> files-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-floppy-o"></i> floppy-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-font"></i> font</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-header"></i> header</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-indent"></i> indent</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-italic"></i> italic</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-link"></i> link</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-list"></i> list</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-list-alt"></i> list-alt</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-list-ol"></i> list-ol</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-list-ul"></i> list-ul</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-outdent"></i> outdent</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-paperclip"></i> paperclip</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-paragraph"></i> paragraph</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-paste"></i> paste
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-repeat"></i> repeat</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-rotate-left"></i> rotate-left
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-rotate-right"></i> rotate-right
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-save"></i> save
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-scissors"></i> scissors</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-strikethrough"></i> strikethrough</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-subscript"></i> subscript</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-superscript"></i> superscript</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-table"></i> table</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-text-height"></i> text-height</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-text-width"></i> text-width</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-th"></i> th</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-th-large"></i> th-large</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-th-list"></i> th-list</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-underline"></i> underline</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-undo"></i> undo</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-unlink"></i> unlink
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                            </div>
                                        </section>
                                        <section id="directional">
                                            <h2 class="page-header">Directional Icons</h2>
                                            <div class="row fontawesome-icon-list">
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-angle-double-down"></i> angle-double-down</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-angle-double-left"></i> angle-double-left</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-angle-double-right"></i> angle-double-right</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-angle-double-up"></i> angle-double-up</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-angle-down"></i> angle-down</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-angle-left"></i> angle-left</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-angle-right"></i> angle-right</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-angle-up"></i> angle-up</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-arrow-circle-down"></i> arrow-circle-down</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-arrow-circle-left"></i> arrow-circle-left</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-arrow-circle-o-down"></i> arrow-circle-o-down</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-arrow-circle-o-left"></i> arrow-circle-o-left</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-arrow-circle-o-right"></i> arrow-circle-o-right</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-arrow-circle-o-up"></i> arrow-circle-o-up</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-arrow-circle-right"></i> arrow-circle-right</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-arrow-circle-up"></i> arrow-circle-up</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-arrow-down"></i> arrow-down</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-arrow-left"></i> arrow-left</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-arrow-right"></i> arrow-right</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-arrow-up"></i> arrow-up</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-arrows"></i> arrows</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-arrows-alt"></i> arrows-alt</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-arrows-h"></i> arrows-h</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-arrows-v"></i> arrows-v</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-caret-down"></i> caret-down</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-caret-left"></i> caret-left</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-caret-right"></i> caret-right</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-caret-square-o-down"></i> caret-square-o-down</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-caret-square-o-left"></i> caret-square-o-left</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-caret-square-o-right"></i> caret-square-o-right</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-caret-square-o-up"></i> caret-square-o-up</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-caret-up"></i> caret-up</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-chevron-circle-down"></i> chevron-circle-down</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-chevron-circle-left"></i> chevron-circle-left</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-chevron-circle-right"></i> chevron-circle-right</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-chevron-circle-up"></i> chevron-circle-up</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-chevron-down"></i> chevron-down</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-chevron-left"></i> chevron-left</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-chevron-right"></i> chevron-right</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-chevron-up"></i> chevron-up</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-exchange"></i> exchange</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-hand-o-down"></i> hand-o-down</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-hand-o-left"></i> hand-o-left</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-hand-o-right"></i> hand-o-right</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-hand-o-up"></i> hand-o-up</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-long-arrow-down"></i> long-arrow-down</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-long-arrow-left"></i> long-arrow-left</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-long-arrow-right"></i> long-arrow-right</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-long-arrow-up"></i> long-arrow-up</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-toggle-down"></i> toggle-down
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-toggle-left"></i> toggle-left
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-toggle-right"></i> toggle-right
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-toggle-up"></i> toggle-up
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                            </div>
                                        </section>
                                        <section id="video-player">
                                            <h2 class="page-header">Video Player Icons</h2>
                                            <div class="row fontawesome-icon-list">
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-arrows-alt"></i> arrows-alt</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-backward"></i> backward</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-compress"></i> compress</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-eject"></i> eject</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-expand"></i> expand</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-fast-backward"></i> fast-backward</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-fast-forward"></i> fast-forward</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-forward"></i> forward</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-pause"></i> pause</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-play"></i> play</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-play-circle"></i> play-circle</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-play-circle-o"></i> play-circle-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-random"></i> random</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-step-backward"></i> step-backward</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-step-forward"></i> step-forward</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-stop"></i> stop</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-youtube-play"></i> youtube-play</div>
                                            </div>
                                        </section>
                                        <section id="brand">
                                            <h2 class="page-header">Brand Icons</h2>
                                            <div class="alert alert-warning">
                                                <h4>
                                                    <i class="fa fa-warning"></i> Warning!</h4> Apparently, Adblock Plus can remove Font Awesome brand icons with their "Remove Social Media Buttons" setting. We will not use hacks to force them to display. Please report an issue
                                                with Adblock Plus if you believe this to be an error. To work around this, you'll need to modify the social icon class names. </div>
                                            <div class="row fontawesome-icon-list margin-bottom-lg">
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-500px"></i> 500px</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-adn"></i> adn</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-amazon"></i> amazon</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-android"></i> android</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-angellist"></i> angellist</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-apple"></i> apple</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-behance"></i> behance</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-behance-square"></i> behance-square</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-bitbucket"></i> bitbucket</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-bitbucket-square"></i> bitbucket-square</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-bitcoin"></i> bitcoin
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-black-tie"></i> black-tie</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-btc"></i> btc</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-buysellads"></i> buysellads</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-cc-amex"></i> cc-amex</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-cc-diners-club"></i> cc-diners-club</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-cc-discover"></i> cc-discover</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-cc-jcb"></i> cc-jcb</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-cc-mastercard"></i> cc-mastercard</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-cc-paypal"></i> cc-paypal</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-cc-stripe"></i> cc-stripe</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-cc-visa"></i> cc-visa</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-chrome"></i> chrome</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-codepen"></i> codepen</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-connectdevelop"></i> connectdevelop</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-contao"></i> contao</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-css3"></i> css3</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-dashcube"></i> dashcube</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-delicious"></i> delicious</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-deviantart"></i> deviantart</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-digg"></i> digg</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-dribbble"></i> dribbble</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-dropbox"></i> dropbox</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-drupal"></i> drupal</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-empire"></i> empire</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-expeditedssl"></i> expeditedssl</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-facebook"></i> facebook</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-facebook-f"></i> facebook-f
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-facebook-official"></i> facebook-official</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-facebook-square"></i> facebook-square</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-firefox"></i> firefox</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-flickr"></i> flickr</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-fonticons"></i> fonticons</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-forumbee"></i> forumbee</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-foursquare"></i> foursquare</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-ge"></i> ge
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-get-pocket"></i> get-pocket</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-gg"></i> gg</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-gg-circle"></i> gg-circle</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-git"></i> git</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-git-square"></i> git-square</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-github"></i> github</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-github-alt"></i> github-alt</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-github-square"></i> github-square</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-gittip"></i> gittip
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-google"></i> google</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-google-plus"></i> google-plus</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-google-plus-square"></i> google-plus-square</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-google-wallet"></i> google-wallet</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-gratipay"></i> gratipay</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-hacker-news"></i> hacker-news</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-houzz"></i> houzz</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-html5"></i> html5</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-instagram"></i> instagram</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-internet-explorer"></i> internet-explorer</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-ioxhost"></i> ioxhost</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-joomla"></i> joomla</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-jsfiddle"></i> jsfiddle</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-lastfm"></i> lastfm</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-lastfm-square"></i> lastfm-square</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-leanpub"></i> leanpub</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-linkedin"></i> linkedin</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-linkedin-square"></i> linkedin-square</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-linux"></i> linux</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-maxcdn"></i> maxcdn</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-meanpath"></i> meanpath</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-medium"></i> medium</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-odnoklassniki"></i> odnoklassniki</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-odnoklassniki-square"></i> odnoklassniki-square</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-opencart"></i> opencart</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-openid"></i> openid</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-opera"></i> opera</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-optin-monster"></i> optin-monster</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-pagelines"></i> pagelines</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-paypal"></i> paypal</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-pied-piper"></i> pied-piper</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-pied-piper-alt"></i> pied-piper-alt</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-pinterest"></i> pinterest</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-pinterest-p"></i> pinterest-p</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-pinterest-square"></i> pinterest-square</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-qq"></i> qq</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-ra"></i> ra
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-rebel"></i> rebel</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-reddit"></i> reddit</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-reddit-square"></i> reddit-square</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-renren"></i> renren</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-safari"></i> safari</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-sellsy"></i> sellsy</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-share-alt"></i> share-alt</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-share-alt-square"></i> share-alt-square</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-shirtsinbulk"></i> shirtsinbulk</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-simplybuilt"></i> simplybuilt</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-skyatlas"></i> skyatlas</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-skype"></i> skype</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-slack"></i> slack</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-slideshare"></i> slideshare</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-soundcloud"></i> soundcloud</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-spotify"></i> spotify</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-stack-exchange"></i> stack-exchange</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-stack-overflow"></i> stack-overflow</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-steam"></i> steam</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-steam-square"></i> steam-square</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-stumbleupon"></i> stumbleupon</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-stumbleupon-circle"></i> stumbleupon-circle</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-tencent-weibo"></i> tencent-weibo</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-trello"></i> trello</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-tripadvisor"></i> tripadvisor</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-tumblr"></i> tumblr</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-tumblr-square"></i> tumblr-square</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-twitch"></i> twitch</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-twitter"></i> twitter</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-twitter-square"></i> twitter-square</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-viacoin"></i> viacoin</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-vimeo"></i> vimeo</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-vimeo-square"></i> vimeo-square</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-vine"></i> vine</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-vk"></i> vk</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-wechat"></i> wechat
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-weibo"></i> weibo</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-weixin"></i> weixin</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-whatsapp"></i> whatsapp</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-wikipedia-w"></i> wikipedia-w</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-windows"></i> windows</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-wordpress"></i> wordpress</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-xing"></i> xing</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-xing-square"></i> xing-square</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-y-combinator"></i> y-combinator</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-y-combinator-square"></i> y-combinator-square
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-yahoo"></i> yahoo</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-yc"></i> yc
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-yc-square"></i> yc-square
                                                    <span class="text-muted">(alias)</span>
                                                </div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-yelp"></i> yelp</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-youtube"></i> youtube</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-youtube-play"></i> youtube-play</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-youtube-square"></i> youtube-square</div>
                                            </div>
                                            <div class="alert alert-success">
                                                <ul class="margin-bottom-none padding-left-lg">
                                                    <li>All brand icons are trademarks of their respective owners.</li>
                                                    <li>The use of these trademarks does not indicate endorsement of the trademark holder by Font Awesome, nor vice versa.</li>
                                                </ul>
                                            </div>
                                        </section>
                                        <section id="medical">
                                            <h2 class="page-header">Medical Icons</h2>
                                            <div class="row fontawesome-icon-list">
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-ambulance"></i> ambulance</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-h-square"></i> h-square</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-heart"></i> heart</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-heart-o"></i> heart-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-heartbeat"></i> heartbeat</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-hospital-o"></i> hospital-o</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-medkit"></i> medkit</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-plus-square"></i> plus-square</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-stethoscope"></i> stethoscope</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-user-md"></i> user-md</div>
                                                <div class="fa-item col-md-3 col-sm-4">
                                                    <i class="fa fa-wheelchair"></i> wheelchair</div>
                                            </div>
                                        </section>
                                    </div>
                                    <div class="tab-pane glyphicons-demo" id="tab_1_2">
                                        <div class="note note-success">
                                            <p> Includes 200 glyphs in font format from the Glyphicon Halflings set.
                                                <a href="http://glyphicons.com/" target="_blank"> Glyphicons </a> Halflings are normally not available for free, but their creator has made them available for Bootstrap free of cost. </p> For more info check out
                                            <a href="http://getbootstrap.com/components/#glyphicons"
                                            target="_blank">http://getbootstrap.com/components/#glyphicons</a>
                                        </div>
                                        <ul class="bs-glyphicons bs-glyphicons-list">
                                            <li>
                                                <span class="glyphicon glyphicon-asterisk"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-asterisk </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-plus"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-plus </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-euro"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-euro </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-minus"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-minus </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-cloud"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-cloud </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-envelope"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-envelope </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-pencil"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-pencil </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-glass"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-glass </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-music"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-music </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-search"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-search </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-heart"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-heart </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-star"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-star </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-star-empty"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-star-empty </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-user"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-user </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-film"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-film </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-th-large"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-th-large </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-th"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-th </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-th-list"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-th-list </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-ok"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-ok </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-remove"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-remove </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-zoom-in"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-zoom-in </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-zoom-out"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-zoom-out </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-off"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-off </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-signal"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-signal </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-cog"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-cog </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-trash"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-trash </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-home"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-home </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-file"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-file </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-time"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-time </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-road"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-road </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-download-alt"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-download-alt </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-download"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-download </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-upload"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-upload </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-inbox"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-inbox </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-play-circle"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-play-circle </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-repeat"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-repeat </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-refresh"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-refresh </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-list-alt"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-list-alt </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-lock"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-lock </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-flag"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-flag </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-headphones"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-headphones </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-volume-off"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-volume-off </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-volume-down"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-volume-down </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-volume-up"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-volume-up </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-qrcode"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-qrcode </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-barcode"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-barcode </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-tag"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-tag </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-tags"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-tags </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-book"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-book </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-bookmark"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-bookmark </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-print"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-print </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-camera"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-camera </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-font"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-font </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-bold"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-bold </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-italic"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-italic </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-text-height"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-text-height </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-text-width"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-text-width </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-align-left"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-align-left </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-align-center"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-align-center </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-align-right"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-align-right </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-align-justify"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-align-justify </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-list"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-list </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-indent-left"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-indent-left </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-indent-right"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-indent-right </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-facetime-video"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-facetime-video </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-picture"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-picture </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-map-marker"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-map-marker </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-adjust"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-adjust </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-tint"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-tint </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-edit"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-edit </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-share"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-share </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-check"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-check </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-move"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-move </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-step-backward"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-step-backward </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-fast-backward"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-fast-backward </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-backward"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-backward </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-play"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-play </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-pause"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-pause </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-stop"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-stop </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-forward"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-forward </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-fast-forward"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-fast-forward </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-step-forward"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-step-forward </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-eject"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-eject </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-chevron-left"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-chevron-left </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-chevron-right"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-chevron-right </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-plus-sign"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-plus-sign </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-minus-sign"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-minus-sign </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-remove-sign"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-remove-sign </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-ok-sign"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-ok-sign </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-question-sign"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-question-sign </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-info-sign"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-info-sign </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-screenshot"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-screenshot </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-remove-circle"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-remove-circle </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-ok-circle"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-ok-circle </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-ban-circle"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-ban-circle </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-arrow-left"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-arrow-left </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-arrow-right"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-arrow-right </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-arrow-up"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-arrow-up </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-arrow-down"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-arrow-down </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-share-alt"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-share-alt </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-resize-full"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-resize-full </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-resize-small"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-resize-small </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-exclamation-sign"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-exclamation-sign </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-gift"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-gift </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-leaf"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-leaf </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-fire"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-fire </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-eye-open"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-eye-open </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-eye-close"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-eye-close </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-warning-sign"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-warning-sign </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-plane"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-plane </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-calendar"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-calendar </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-random"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-random </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-comment"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-comment </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-magnet"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-magnet </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-chevron-up"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-chevron-up </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-chevron-down"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-chevron-down </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-retweet"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-retweet </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-shopping-cart"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-shopping-cart </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-folder-close"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-folder-close </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-folder-open"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-folder-open </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-resize-vertical"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-resize-vertical </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-resize-horizontal"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-resize-horizontal </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-hdd"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-hdd </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-bullhorn"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-bullhorn </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-bell"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-bell </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-certificate"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-certificate </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-thumbs-up"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-thumbs-up </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-thumbs-down"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-thumbs-down </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-hand-right"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-hand-right </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-hand-left"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-hand-left </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-hand-up"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-hand-up </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-hand-down"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-hand-down </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-circle-arrow-right"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-circle-arrow-right </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-circle-arrow-left"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-circle-arrow-left </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-circle-arrow-up"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-circle-arrow-up </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-circle-arrow-down"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-circle-arrow-down </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-globe"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-globe </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-wrench"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-wrench </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-tasks"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-tasks </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-filter"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-filter </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-briefcase"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-briefcase </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-fullscreen"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-fullscreen </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-dashboard"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-dashboard </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-paperclip"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-paperclip </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-heart-empty"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-heart-empty </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-link"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-link </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-phone"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-phone </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-pushpin"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-pushpin </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-usd"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-usd </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-gbp"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-gbp </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-sort"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-sort </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-sort-by-alphabet"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-sort-by-alphabet </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-sort-by-alphabet-alt"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-sort-by-alphabet-alt </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-sort-by-order"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-sort-by-order </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-sort-by-order-alt"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-sort-by-order-alt </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-sort-by-attributes"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-sort-by-attributes </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-sort-by-attributes-alt"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-sort-by-attributes-alt </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-unchecked"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-unchecked </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-expand"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-expand </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-collapse-down"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-collapse-down </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-collapse-up"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-collapse-up </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-log-in"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-log-in </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-flash"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-flash </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-log-out"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-log-out </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-new-window"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-new-window </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-record"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-record </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-save"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-save </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-open"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-open </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-saved"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-saved </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-import"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-import </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-export"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-export </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-send"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-send </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-floppy-disk"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-floppy-disk </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-floppy-saved"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-floppy-saved </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-floppy-remove"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-floppy-remove </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-floppy-save"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-floppy-save </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-floppy-open"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-floppy-open </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-credit-card"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-credit-card </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-transfer"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-transfer </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-cutlery"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-cutlery </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-header"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-header </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-compressed"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-compressed </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-earphone"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-earphone </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-phone-alt"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-phone-alt </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-tower"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-tower </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-stats"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-stats </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-sd-video"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-sd-video </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-hd-video"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-hd-video </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-subtitles"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-subtitles </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-sound-stereo"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-sound-stereo </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-sound-dolby"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-sound-dolby </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-sound-5-1"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-sound-5-1 </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-sound-6-1"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-sound-6-1 </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-sound-7-1"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-sound-7-1 </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-copyright-mark"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-copyright-mark </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-registration-mark"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-registration-mark </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-cloud-download"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-cloud-download </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-cloud-upload"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-cloud-upload </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-tree-conifer"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-tree-conifer </span>
                                            </li>
                                            <li>
                                                <span class="glyphicon glyphicon-tree-deciduous"> </span>
                                                <span class="bs-glyphicon-class"> glyphicon glyphicon-tree-deciduous </span>
                                            </li>
                                        </ul>
                                    </div>
                                    <div class="tab-pane" id="tab_1_3">
                                        <div class="note note-success">
                                            <p> Simple Line Icons. 162 Beautifully Crafted Webfont Icons.
                                                <br> For more info check out
                                                <a href="http://graphicburger.com/simple-line-icons-webfont/" target="_blank">http://graphicburger.com/simple-line-icons-webfont/</a>
                                            </p>
                                        </div>
                                        <div class="simplelineicons-demo">
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-user"></span> &nbsp;icon-user </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-user-female"></span> &nbsp;icon-user-female </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-users"></span> &nbsp;icon-users </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-user-follow"></span> &nbsp;icon-user-follow </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-user-following"></span> &nbsp;icon-user-following </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-user-unfollow"></span> &nbsp;icon-user-unfollow </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-trophy"></span> &nbsp;icon-trophy </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-speedometer"></span> &nbsp;icon-speedometer </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-social-youtube"></span> &nbsp;icon-social-youtube </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-social-twitter"></span> &nbsp;icon-social-twitter </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-social-tumblr"></span> &nbsp;icon-social-tumblr </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-social-facebook"></span> &nbsp;icon-social-facebook </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-social-dropbox"></span> &nbsp;icon-social-dropbox </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-social-dribbble"></span> &nbsp;icon-social-dribbble </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-shield"></span> &nbsp;icon-shield </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-screen-tablet"></span> &nbsp;icon-screen-tablet </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-screen-smartphone"></span> &nbsp;icon-screen-smartphone </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-screen-desktop"></span> &nbsp;icon-screen-desktop </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-plane"></span> &nbsp;icon-plane </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-notebook"></span> &nbsp;icon-notebook </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-moustache"></span> &nbsp;icon-moustache </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-mouse"></span> &nbsp;icon-mouse </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-magnet"></span> &nbsp;icon-magnet </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-magic-wand"></span> &nbsp;icon-magic-wand </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-hourglass"></span> &nbsp;icon-hourglass </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-graduation"></span> &nbsp;icon-graduation </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-ghost"></span> &nbsp;icon-ghost </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-game-controller"></span> &nbsp;icon-game-controller </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-fire"></span> &nbsp;icon-fire </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-eyeglasses"></span> &nbsp;icon-eyeglasses </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-envelope-open"></span> &nbsp;icon-envelope-open </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-envelope-letter"></span> &nbsp;icon-envelope-letter </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-energy"></span> &nbsp;icon-energy </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-emoticon-smile"></span> &nbsp;icon-emoticon-smile </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-disc"></span> &nbsp;icon-disc </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-cursor-move"></span> &nbsp;icon-cursor-move </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-crop"></span> &nbsp;icon-crop </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-credit-card"></span> &nbsp;icon-credit-card </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-chemistry"></span> &nbsp;icon-chemistry </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-bell"></span> &nbsp;icon-bell </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-badge"></span> &nbsp;icon-badge </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-anchor"></span> &nbsp;icon-anchor </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-action-redo"></span> &nbsp;icon-action-redo </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-action-undo"></span> &nbsp;icon-action-undo </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-bag"></span> &nbsp;icon-bag </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-basket"></span> &nbsp;icon-basket </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-basket-loaded"></span> &nbsp;icon-basket-loaded </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-book-open"></span> &nbsp;icon-book-open </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-briefcase"></span> &nbsp;icon-briefcase </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-bubbles"></span> &nbsp;icon-bubbles </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-calculator"></span> &nbsp;icon-calculator </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-call-end"></span> &nbsp;icon-call-end </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-call-in"></span> &nbsp;icon-call-in </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-call-out"></span> &nbsp;icon-call-out </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-compass"></span> &nbsp;icon-compass </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-cup"></span> &nbsp;icon-cup </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-diamond"></span> &nbsp;icon-diamond </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-direction"></span> &nbsp;icon-direction </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-directions"></span> &nbsp;icon-directions </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-docs"></span> &nbsp;icon-docs </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-drawer"></span> &nbsp;icon-drawer </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-drop"></span> &nbsp;icon-drop </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-earphones"></span> &nbsp;icon-earphones </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-earphones-alt"></span> &nbsp;icon-earphones-alt </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-feed"></span> &nbsp;icon-feed </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-film"></span> &nbsp;icon-film </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-folder-alt"></span> &nbsp;icon-folder-alt </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-frame"></span> &nbsp;icon-frame </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-globe"></span> &nbsp;icon-globe </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-globe-alt"></span> &nbsp;icon-globe-alt </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-handbag"></span> &nbsp;icon-handbag </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-layers"></span> &nbsp;icon-layers </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-map"></span> &nbsp;icon-map </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-picture"></span> &nbsp;icon-picture </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-pin"></span> &nbsp;icon-pin </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-playlist"></span> &nbsp;icon-playlist </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-present"></span> &nbsp;icon-present </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-printer"></span> &nbsp;icon-printer </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-puzzle"></span> &nbsp;icon-puzzle </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-speech"></span> &nbsp;icon-speech </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-vector"></span> &nbsp;icon-vector </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-wallet"></span> &nbsp;icon-wallet </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-arrow-down"></span> &nbsp;icon-arrow-down </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-arrow-left"></span> &nbsp;icon-arrow-left </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-arrow-right"></span> &nbsp;icon-arrow-right </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-arrow-up"></span> &nbsp;icon-arrow-up </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-bar-chart"></span> &nbsp;icon-bar-chart </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-bulb"></span> &nbsp;icon-bulb </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-calendar"></span> &nbsp;icon-calendar </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-control-end"></span> &nbsp;icon-control-end </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-control-forward"></span> &nbsp;icon-control-forward </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-control-pause"></span> &nbsp;icon-control-pause </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-control-play"></span> &nbsp;icon-control-play </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-control-rewind"></span> &nbsp;icon-control-rewind </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-control-start"></span> &nbsp;icon-control-start </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-cursor"></span> &nbsp;icon-cursor </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-dislike"></span> &nbsp;icon-dislike </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-equalizer"></span> &nbsp;icon-equalizer </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-graph"></span> &nbsp;icon-graph </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-grid"></span> &nbsp;icon-grid </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-home"></span> &nbsp;icon-home </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-like"></span> &nbsp;icon-like </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-list"></span> &nbsp;icon-list </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-login"></span> &nbsp;icon-login </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-logout"></span> &nbsp;icon-logout </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-loop"></span> &nbsp;icon-loop </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-microphone"></span> &nbsp;icon-microphone </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-music-tone"></span> &nbsp;icon-music-tone </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-music-tone-alt"></span> &nbsp;icon-music-tone-alt </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-note"></span> &nbsp;icon-note </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-pencil"></span> &nbsp;icon-pencil </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-pie-chart"></span> &nbsp;icon-pie-chart </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-question"></span> &nbsp;icon-question </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-rocket"></span> &nbsp;icon-rocket </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-share"></span> &nbsp;icon-share </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-share-alt"></span> &nbsp;icon-share-alt </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-shuffle"></span> &nbsp;icon-shuffle </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-size-actual"></span> &nbsp;icon-size-actual </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-size-fullscreen"></span> &nbsp;icon-size-fullscreen </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-support"></span> &nbsp;icon-support </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-tag"></span> &nbsp;icon-tag </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-trash"></span> &nbsp;icon-trash </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-umbrella"></span> &nbsp;icon-umbrella </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-wrench"></span> &nbsp;icon-wrench </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-ban"></span> &nbsp;icon-ban </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-bubble"></span> &nbsp;icon-bubble </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-camcorder"></span> &nbsp;icon-camcorder </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-camera"></span> &nbsp;icon-camera </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-check"></span> &nbsp;icon-check </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-clock"></span> &nbsp;icon-clock </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-close"></span> &nbsp;icon-close </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-cloud-download"></span> &nbsp;icon-cloud-download </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-cloud-upload"></span> &nbsp;icon-cloud-upload </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-doc"></span> &nbsp;icon-doc </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-envelope"></span> &nbsp;icon-envelope </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-eye"></span> &nbsp;icon-eye </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-flag"></span> &nbsp;icon-flag </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-folder"></span> &nbsp;icon-folder </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-heart"></span> &nbsp;icon-heart </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-info"></span> &nbsp;icon-info </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-key"></span> &nbsp;icon-key </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-link"></span> &nbsp;icon-link </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-lock"></span> &nbsp;icon-lock </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-lock-open"></span> &nbsp;icon-lock-open </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-magnifier"></span> &nbsp;icon-magnifier </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-magnifier-add"></span> &nbsp;icon-magnifier-add </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-magnifier-remove"></span> &nbsp;icon-magnifier-remove </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-paper-clip"></span> &nbsp;icon-paper-clip </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-paper-plane"></span> &nbsp;icon-paper-plane </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-plus"></span> &nbsp;icon-plus </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-pointer"></span> &nbsp;icon-pointer </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-power"></span> &nbsp;icon-power </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-refresh"></span> &nbsp;icon-refresh </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-reload"></span> &nbsp;icon-reload </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-settings"></span> &nbsp;icon-settings </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-star"></span> &nbsp;icon-star </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-symbol-female"></span> &nbsp;icon-symbol-female </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-symbol-male"></span> &nbsp;icon-symbol-male </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-target"></span> &nbsp;icon-target </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-volume-1"></span> &nbsp;icon-volume-1 </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-volume-2"></span> &nbsp;icon-volume-2 </span>
                                            </span>
                                            <span class="item-box">
                                                <span class="item">
                                                    <span aria-hidden="true" class="icon-volume-off"></span> &nbsp;icon-volume-off </span>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- END CONTENT BODY -->
            </div>
            <!-- END CONTENT -->
            <!-- BEGIN QUICK SIDEBAR -->
            <a href="javascript:;" class="page-quick-sidebar-toggler">
                <i class="icon-login"></i>
            </a>
            <div class="page-quick-sidebar-wrapper" data-close-on-body-click="false">
                <div class="page-quick-sidebar">
                    <ul class="nav nav-tabs">
                        <li class="active">
                            <a href="javascript:;" data-target="#quick_sidebar_tab_1" data-toggle="tab"> Users
                                <span class="badge badge-danger">2</span>
                            </a>
                        </li>
                        <li>
                            <a href="javascript:;" data-target="#quick_sidebar_tab_2" data-toggle="tab"> Alerts
                                <span class="badge badge-success">7</span>
                            </a>
                        </li>
                        <li class="dropdown">
                            <a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown"> More
                                <i class="fa fa-angle-down"></i>
                            </a>
                            <ul class="dropdown-menu pull-right">
                                <li>
                                    <a href="javascript:;" data-target="#quick_sidebar_tab_3" data-toggle="tab">
                                        <i class="icon-bell"></i> Alerts </a>
                                </li>
                                <li>
                                    <a href="javascript:;" data-target="#quick_sidebar_tab_3" data-toggle="tab">
                                        <i class="icon-info"></i> Notifications </a>
                                </li>
                                <li>
                                    <a href="javascript:;" data-target="#quick_sidebar_tab_3" data-toggle="tab">
                                        <i class="icon-speech"></i> Activities </a>
                                </li>
                                <li class="divider"></li>
                                <li>
                                    <a href="javascript:;" data-target="#quick_sidebar_tab_3" data-toggle="tab">
                                        <i class="icon-settings"></i> Settings </a>
                                </li>
                            </ul>
                        </li>
                    </ul>
                    <div class="tab-content">
                        <div class="tab-pane active page-quick-sidebar-chat" id="quick_sidebar_tab_1">
                            <div class="page-quick-sidebar-chat-users" data-rail-color="#ddd" data-wrapper-class="page-quick-sidebar-list">
                                <h3 class="list-heading">Staff</h3>
                                <ul class="media-list list-items">
                                    <li class="media">
                                        <div class="media-status">
                                            <span class="badge badge-success">8</span>
                                        </div>
                                        <img class="media-object" src="../assets/layouts/layout/img/avatar3.jpg" alt="...">
                                        <div class="media-body">
                                            <h4 class="media-heading">Bob Nilson</h4>
                                            <div class="media-heading-sub"> Project Manager </div>
                                        </div>
                                    </li>
                                    <li class="media">
                                        <img class="media-object" src="../assets/layouts/layout/img/avatar1.jpg" alt="...">
                                        <div class="media-body">
                                            <h4 class="media-heading">Nick Larson</h4>
                                            <div class="media-heading-sub"> Art Director </div>
                                        </div>
                                    </li>
                                    <li class="media">
                                        <div class="media-status">
                                            <span class="badge badge-danger">3</span>
                                        </div>
                                        <img class="media-object" src="../assets/layouts/layout/img/avatar4.jpg" alt="...">
                                        <div class="media-body">
                                            <h4 class="media-heading">Deon Hubert</h4>
                                            <div class="media-heading-sub"> CTO </div>
                                        </div>
                                    </li>
                                    <li class="media">
                                        <img class="media-object" src="../assets/layouts/layout/img/avatar2.jpg" alt="...">
                                        <div class="media-body">
                                            <h4 class="media-heading">Ella Wong</h4>
                                            <div class="media-heading-sub"> CEO </div>
                                        </div>
                                    </li>
                                </ul>
                                <h3 class="list-heading">Customers</h3>
                                <ul class="media-list list-items">
                                    <li class="media">
                                        <div class="media-status">
                                            <span class="badge badge-warning">2</span>
                                        </div>
                                        <img class="media-object" src="../assets/layouts/layout/img/avatar6.jpg" alt="...">
                                        <div class="media-body">
                                            <h4 class="media-heading">Lara Kunis</h4>
                                            <div class="media-heading-sub"> CEO, Loop Inc </div>
                                            <div class="media-heading-small"> Last seen 03:10 AM </div>
                                        </div>
                                    </li>
                                    <li class="media">
                                        <div class="media-status">
                                            <span class="label label-sm label-success">new</span>
                                        </div>
                                        <img class="media-object" src="../assets/layouts/layout/img/avatar7.jpg" alt="...">
                                        <div class="media-body">
                                            <h4 class="media-heading">Ernie Kyllonen</h4>
                                            <div class="media-heading-sub"> Project Manager,
                                                <br> SmartBizz PTL </div>
                                        </div>
                                    </li>
                                    <li class="media">
                                        <img class="media-object" src="../assets/layouts/layout/img/avatar8.jpg" alt="...">
                                        <div class="media-body">
                                            <h4 class="media-heading">Lisa Stone</h4>
                                            <div class="media-heading-sub"> CTO, Keort Inc </div>
                                            <div class="media-heading-small"> Last seen 13:10 PM </div>
                                        </div>
                                    </li>
                                    <li class="media">
                                        <div class="media-status">
                                            <span class="badge badge-success">7</span>
                                        </div>
                                        <img class="media-object" src="../assets/layouts/layout/img/avatar9.jpg" alt="...">
                                        <div class="media-body">
                                            <h4 class="media-heading">Deon Portalatin</h4>
                                            <div class="media-heading-sub"> CFO, H&D LTD </div>
                                        </div>
                                    </li>
                                    <li class="media">
                                        <img class="media-object" src="../assets/layouts/layout/img/avatar10.jpg" alt="...">
                                        <div class="media-body">
                                            <h4 class="media-heading">Irina Savikova</h4>
                                            <div class="media-heading-sub"> CEO, Tizda Motors Inc </div>
                                        </div>
                                    </li>
                                    <li class="media">
                                        <div class="media-status">
                                            <span class="badge badge-danger">4</span>
                                        </div>
                                        <img class="media-object" src="../assets/layouts/layout/img/avatar11.jpg" alt="...">
                                        <div class="media-body">
                                            <h4 class="media-heading">Maria Gomez</h4>
                                            <div class="media-heading-sub"> Manager, Infomatic Inc </div>
                                            <div class="media-heading-small"> Last seen 03:10 AM </div>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                            <div class="page-quick-sidebar-item">
                                <div class="page-quick-sidebar-chat-user">
                                    <div class="page-quick-sidebar-nav">
                                        <a href="javascript:;" class="page-quick-sidebar-back-to-list">
                                            <i class="icon-arrow-left"></i>Back</a>
                                    </div>
                                    <div class="page-quick-sidebar-chat-user-messages">
                                        <div class="post out">
                                            <img class="avatar" alt="" src="../assets/layouts/layout/img/avatar3.jpg" />
                                            <div class="message">
                                                <span class="arrow"></span>
                                                <a href="javascript:;" class="name">Bob Nilson</a>
                                                <span class="datetime">20:15</span>
                                                <span class="body"> When could you send me the report ? </span>
                                            </div>
                                        </div>
                                        <div class="post in">
                                            <img class="avatar" alt="" src="../assets/layouts/layout/img/avatar2.jpg" />
                                            <div class="message">
                                                <span class="arrow"></span>
                                                <a href="javascript:;" class="name">Ella Wong</a>
                                                <span class="datetime">20:15</span>
                                                <span class="body"> Its almost done. I will be sending it shortly </span>
                                            </div>
                                        </div>
                                        <div class="post out">
                                            <img class="avatar" alt="" src="../assets/layouts/layout/img/avatar3.jpg" />
                                            <div class="message">
                                                <span class="arrow"></span>
                                                <a href="javascript:;" class="name">Bob Nilson</a>
                                                <span class="datetime">20:15</span>
                                                <span class="body"> Alright. Thanks! :) </span>
                                            </div>
                                        </div>
                                        <div class="post in">
                                            <img class="avatar" alt="" src="../assets/layouts/layout/img/avatar2.jpg" />
                                            <div class="message">
                                                <span class="arrow"></span>
                                                <a href="javascript:;" class="name">Ella Wong</a>
                                                <span class="datetime">20:16</span>
                                                <span class="body"> You are most welcome. Sorry for the delay. </span>
                                            </div>
                                        </div>
                                        <div class="post out">
                                            <img class="avatar" alt="" src="../assets/layouts/layout/img/avatar3.jpg" />
                                            <div class="message">
                                                <span class="arrow"></span>
                                                <a href="javascript:;" class="name">Bob Nilson</a>
                                                <span class="datetime">20:17</span>
                                                <span class="body"> No probs. Just take your time :) </span>
                                            </div>
                                        </div>
                                        <div class="post in">
                                            <img class="avatar" alt="" src="../assets/layouts/layout/img/avatar2.jpg" />
                                            <div class="message">
                                                <span class="arrow"></span>
                                                <a href="javascript:;" class="name">Ella Wong</a>
                                                <span class="datetime">20:40</span>
                                                <span class="body"> Alright. I just emailed it to you. </span>
                                            </div>
                                        </div>
                                        <div class="post out">
                                            <img class="avatar" alt="" src="../assets/layouts/layout/img/avatar3.jpg" />
                                            <div class="message">
                                                <span class="arrow"></span>
                                                <a href="javascript:;" class="name">Bob Nilson</a>
                                                <span class="datetime">20:17</span>
                                                <span class="body"> Great! Thanks. Will check it right away. </span>
                                            </div>
                                        </div>
                                        <div class="post in">
                                            <img class="avatar" alt="" src="../assets/layouts/layout/img/avatar2.jpg" />
                                            <div class="message">
                                                <span class="arrow"></span>
                                                <a href="javascript:;" class="name">Ella Wong</a>
                                                <span class="datetime">20:40</span>
                                                <span class="body"> Please let me know if you have any comment. </span>
                                            </div>
                                        </div>
                                        <div class="post out">
                                            <img class="avatar" alt="" src="../assets/layouts/layout/img/avatar3.jpg" />
                                            <div class="message">
                                                <span class="arrow"></span>
                                                <a href="javascript:;" class="name">Bob Nilson</a>
                                                <span class="datetime">20:17</span>
                                                <span class="body"> Sure. I will check and buzz you if anything needs to be corrected. </span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="page-quick-sidebar-chat-user-form">
                                        <div class="input-group">
                                            <input type="text" class="form-control" placeholder="Type a message here...">
                                            <div class="input-group-btn">
                                                <button type="button" class="btn green">
                                                    <i class="icon-paper-clip"></i>
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane page-quick-sidebar-alerts" id="quick_sidebar_tab_2">
                            <div class="page-quick-sidebar-alerts-list">
                                <h3 class="list-heading">General</h3>
                                <ul class="feeds list-items">
                                    <li>
                                        <div class="col1">
                                            <div class="cont">
                                                <div class="cont-col1">
                                                    <div class="label label-sm label-info">
                                                        <i class="fa fa-check"></i>
                                                    </div>
                                                </div>
                                                <div class="cont-col2">
                                                    <div class="desc"> You have 4 pending tasks.
                                                        <span class="label label-sm label-warning "> Take action
                                                            <i class="fa fa-share"></i>
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col2">
                                            <div class="date"> Just now </div>
                                        </div>
                                    </li>
                                    <li>
                                        <a href="javascript:;">
                                            <div class="col1">
                                                <div class="cont">
                                                    <div class="cont-col1">
                                                        <div class="label label-sm label-success">
                                                            <i class="fa fa-bar-chart-o"></i>
                                                        </div>
                                                    </div>
                                                    <div class="cont-col2">
                                                        <div class="desc"> Finance Report for year 2013 has been released. </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col2">
                                                <div class="date"> 20 mins </div>
                                            </div>
                                        </a>
                                    </li>
                                    <li>
                                        <div class="col1">
                                            <div class="cont">
                                                <div class="cont-col1">
                                                    <div class="label label-sm label-danger">
                                                        <i class="fa fa-user"></i>
                                                    </div>
                                                </div>
                                                <div class="cont-col2">
                                                    <div class="desc"> You have 5 pending membership that requires a quick review. </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col2">
                                            <div class="date"> 24 mins </div>
                                        </div>
                                    </li>
                                    <li>
                                        <div class="col1">
                                            <div class="cont">
                                                <div class="cont-col1">
                                                    <div class="label label-sm label-info">
                                                        <i class="fa fa-shopping-cart"></i>
                                                    </div>
                                                </div>
                                                <div class="cont-col2">
                                                    <div class="desc"> New order received with
                                                        <span class="label label-sm label-success"> Reference Number: DR23923 </span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col2">
                                            <div class="date"> 30 mins </div>
                                        </div>
                                    </li>
                                    <li>
                                        <div class="col1">
                                            <div class="cont">
                                                <div class="cont-col1">
                                                    <div class="label label-sm label-success">
                                                        <i class="fa fa-user"></i>
                                                    </div>
                                                </div>
                                                <div class="cont-col2">
                                                    <div class="desc"> You have 5 pending membership that requires a quick review. </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col2">
                                            <div class="date"> 24 mins </div>
                                        </div>
                                    </li>
                                    <li>
                                        <div class="col1">
                                            <div class="cont">
                                                <div class="cont-col1">
                                                    <div class="label label-sm label-info">
                                                        <i class="fa fa-bell-o"></i>
                                                    </div>
                                                </div>
                                                <div class="cont-col2">
                                                    <div class="desc"> Web server hardware needs to be upgraded.
                                                        <span class="label label-sm label-warning"> Overdue </span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col2">
                                            <div class="date"> 2 hours </div>
                                        </div>
                                    </li>
                                    <li>
                                        <a href="javascript:;">
                                            <div class="col1">
                                                <div class="cont">
                                                    <div class="cont-col1">
                                                        <div class="label label-sm label-default">
                                                            <i class="fa fa-briefcase"></i>
                                                        </div>
                                                    </div>
                                                    <div class="cont-col2">
                                                        <div class="desc"> IPO Report for year 2013 has been released. </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col2">
                                                <div class="date"> 20 mins </div>
                                            </div>
                                        </a>
                                    </li>
                                </ul>
                                <h3 class="list-heading">System</h3>
                                <ul class="feeds list-items">
                                    <li>
                                        <div class="col1">
                                            <div class="cont">
                                                <div class="cont-col1">
                                                    <div class="label label-sm label-info">
                                                        <i class="fa fa-check"></i>
                                                    </div>
                                                </div>
                                                <div class="cont-col2">
                                                    <div class="desc"> You have 4 pending tasks.
                                                        <span class="label label-sm label-warning "> Take action
                                                            <i class="fa fa-share"></i>
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col2">
                                            <div class="date"> Just now </div>
                                        </div>
                                    </li>
                                    <li>
                                        <a href="javascript:;">
                                            <div class="col1">
                                                <div class="cont">
                                                    <div class="cont-col1">
                                                        <div class="label label-sm label-danger">
                                                            <i class="fa fa-bar-chart-o"></i>
                                                        </div>
                                                    </div>
                                                    <div class="cont-col2">
                                                        <div class="desc"> Finance Report for year 2013 has been released. </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col2">
                                                <div class="date"> 20 mins </div>
                                            </div>
                                        </a>
                                    </li>
                                    <li>
                                        <div class="col1">
                                            <div class="cont">
                                                <div class="cont-col1">
                                                    <div class="label label-sm label-default">
                                                        <i class="fa fa-user"></i>
                                                    </div>
                                                </div>
                                                <div class="cont-col2">
                                                    <div class="desc"> You have 5 pending membership that requires a quick review. </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col2">
                                            <div class="date"> 24 mins </div>
                                        </div>
                                    </li>
                                    <li>
                                        <div class="col1">
                                            <div class="cont">
                                                <div class="cont-col1">
                                                    <div class="label label-sm label-info">
                                                        <i class="fa fa-shopping-cart"></i>
                                                    </div>
                                                </div>
                                                <div class="cont-col2">
                                                    <div class="desc"> New order received with
                                                        <span class="label label-sm label-success"> Reference Number: DR23923 </span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col2">
                                            <div class="date"> 30 mins </div>
                                        </div>
                                    </li>
                                    <li>
                                        <div class="col1">
                                            <div class="cont">
                                                <div class="cont-col1">
                                                    <div class="label label-sm label-success">
                                                        <i class="fa fa-user"></i>
                                                    </div>
                                                </div>
                                                <div class="cont-col2">
                                                    <div class="desc"> You have 5 pending membership that requires a quick review. </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col2">
                                            <div class="date"> 24 mins </div>
                                        </div>
                                    </li>
                                    <li>
                                        <div class="col1">
                                            <div class="cont">
                                                <div class="cont-col1">
                                                    <div class="label label-sm label-warning">
                                                        <i class="fa fa-bell-o"></i>
                                                    </div>
                                                </div>
                                                <div class="cont-col2">
                                                    <div class="desc"> Web server hardware needs to be upgraded.
                                                        <span class="label label-sm label-default "> Overdue </span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col2">
                                            <div class="date"> 2 hours </div>
                                        </div>
                                    </li>
                                    <li>
                                        <a href="javascript:;">
                                            <div class="col1">
                                                <div class="cont">
                                                    <div class="cont-col1">
                                                        <div class="label label-sm label-info">
                                                            <i class="fa fa-briefcase"></i>
                                                        </div>
                                                    </div>
                                                    <div class="cont-col2">
                                                        <div class="desc"> IPO Report for year 2013 has been released. </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col2">
                                                <div class="date"> 20 mins </div>
                                            </div>
                                        </a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                        <div class="tab-pane page-quick-sidebar-settings" id="quick_sidebar_tab_3">
                            <div class="page-quick-sidebar-settings-list">
                                <h3 class="list-heading">General Settings</h3>
                                <ul class="list-items borderless">
                                    <li> Enable Notifications
                                        <input type="checkbox" class="make-switch" checked data-size="small" data-on-color="success" data-on-text="ON" data-off-color="default" data-off-text="OFF"> </li>
                                    <li> Allow Tracking
                                        <input type="checkbox" class="make-switch" data-size="small" data-on-color="info" data-on-text="ON" data-off-color="default" data-off-text="OFF"> </li>
                                    <li> Log Errors
                                        <input type="checkbox" class="make-switch" checked data-size="small" data-on-color="danger" data-on-text="ON" data-off-color="default" data-off-text="OFF"> </li>
                                    <li> Auto Sumbit Issues
                                        <input type="checkbox" class="make-switch" data-size="small" data-on-color="warning" data-on-text="ON" data-off-color="default" data-off-text="OFF"> </li>
                                    <li> Enable SMS Alerts
                                        <input type="checkbox" class="make-switch" checked data-size="small" data-on-color="success" data-on-text="ON" data-off-color="default" data-off-text="OFF"> </li>
                                </ul>
                                <h3 class="list-heading">System Settings</h3>
                                <ul class="list-items borderless">
                                    <li> Security Level
                                        <select class="form-control input-inline input-sm input-small">
                                            <option value="1">Normal</option>
                                            <option value="2" selected>Medium</option>
                                            <option value="e">High</option>
                                        </select>
                                    </li>
                                    <li> Failed Email Attempts
                                        <input class="form-control input-inline input-sm input-small" value="5" /> </li>
                                    <li> Secondary SMTP Port
                                        <input class="form-control input-inline input-sm input-small" value="3560" /> </li>
                                    <li> Notify On System Error
                                        <input type="checkbox" class="make-switch" checked data-size="small" data-on-color="danger" data-on-text="ON" data-off-color="default" data-off-text="OFF"> </li>
                                    <li> Notify On SMTP Error
                                        <input type="checkbox" class="make-switch" checked data-size="small" data-on-color="warning" data-on-text="ON" data-off-color="default" data-off-text="OFF"> </li>
                                </ul>
                                <div class="inner-content">
                                    <button class="btn btn-success">
                                        <i class="icon-settings"></i> Save Changes</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- END QUICK SIDEBAR -->
        </div>
        <!-- END CONTAINER -->
        <!-- BEGIN FOOTER -->
        <div class="page-footer">
            <div class="page-footer-inner"> 2014 &copy; Metronic by keenthemes.
                <a href="http://themeforest.net/item/metronic-responsive-admin-dashboard-template/4021469?ref=keenthemes" title="Purchase Metronic just for 27$ and get lifetime updates for free" target="_blank">Purchase Metronic!</a>
            </div>
            <div class="scroll-to-top">
                <i class="icon-arrow-up"></i>
            </div>
        </div>
        <!-- END FOOTER -->
          <!-- 公共js开始 -->
        <%@ include file="/public_module/public_js.jsp" %>
        <!-- 公共js结束 -->
        <script src="<%=basePath%>assets/global/scripts/app.js" type="text/javascript"></script>
        <script src="<%=basePath%>assets/layouts/layout/scripts/layout.js" type="text/javascript"></script>
        <script src="<%=basePath%>assets/layouts/layout/scripts/demo.js" type="text/javascript"></script>
        <script src="<%=basePath%>assets/layouts/global/scripts/quick-sidebar.min.js" type="text/javascript"></script>

    </body>

</html>