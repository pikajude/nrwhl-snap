<!DOCTYPE html>
<!--[if lt IE 7]> <html class="no-js ie6 oldie" lang="en"> <![endif]-->
<!--[if IE 7]> <html class="no-js ie7 oldie" lang="en"> <![endif]-->
<!--[if IE 8]> <html class="no-js ie8 oldie" lang="en"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js" lang="en"> <!--<![endif]-->
  <head>
    <meta charset="UTF-8">

    <title><pageTitle/> » narwHaL</title>
    <meta name="description" content="narwHaL Haxball League">
    <meta name="author" content="Joel Taylor">

    <meta name="viewport" content="width=device-width,initial-scale=1">
    <link rel=icon href="/static/img/favicon.ico" type="image/x-icon">
    <link rel=stylesheet href="/static/css/normalize.css" type="text/css">
    <link rel=stylesheet href="/static/css/screen.css" type="text/css">
    <link rel=stylesheet href="/static/css/tipsy.css" type="text/css">
    <link rel=stylesheet href="/static/css/bootstrap.css" type="text/css">
    <link rel=stylesheet href="/static/css/bootstrap-sortable.css" type="text/css">
    <link rel=stylesheet href="/static/css/selectize.bootstrap3.css" type="text/css">

    <!--[if lt IE 9]>
    <script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
  </head>
  <body>
    <header class="navbar navbar-inverse navbar-fixed-top">
      <div class="container">
        <div class="navbar-header">
          <button class="navbar-toggle" type=button data-toggle=collapse data-target=#nrwhl-navbar>
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
        </div>
        <nav class="collapse navbar-collapse" id="nrwhl-navbar" role=navigation>
          <ul class="nav navbar-nav">
            <li-active context="home">
              <a href="${urlHome}" class="avatar-pic-link">
                <img src="/static/img/narwhal-light.svg" width=50 height=29>
              </a>
            </li-active>
            <li-active context="login">
              <a href="${urlLogin}">log in</a>
            </li-active>
            <li-active context="register">
              <a href="${urlRegister}">register</a>
            </li-active>
          </ul>
        </nav>
      </div>
    </header>

    <apply-content/>

    <script>
      document.documentElement.className = document.documentElement.className.replace(/\bno-js\b/,'js');
    </script>
  </body>
</html>
