<!DOCTYPE html>
<html lang="en">
<%@ page import="com.appdynamics.tools.gerritstats.EntryPoint" %>
<html>
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>AppDynamics Gerrit Stats</title>
        <link href="/bootstrap-3.3.6-dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="/bootstrap-3.3.6-dist/css/starter-template.css" rel="stylesheet">
        <link href="/bootstrap-3.3.6-dist/css/grid.css" rel="stylesheet">
        <link href="/bootstrap-3.3.6-dist/css/theme.css" rel="stylesheet">
        <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
          <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <![endif]-->
        </script>
    </head>
    <body>
        <nav class="navbar navbar-inverse navbar-fixed-top">
          <div class="container">
            <div class="navbar-header">
              <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
              </button>
              <a class="navbar-brand" href="#">Gerrit Stats</a>
            </div>
            <div id="navbar" class="collapse navbar-collapse">
              <ul class="nav navbar-nav">
                <li class="active"><a href="#">User Stats</a></li>
              </ul>
            </div><!--/.nav-collapse -->
          </div>
        </nav>
        <div class="container">
            <div class="starter-template">
                <h1>User Stats</h1>
                <p>LDAP of User:
                    <form action="index.jsp">
                        <input type="text" name="user" value=""/>
                        <button type="button" class="btn btn-sm btn-success">View</button>
                    </form>
                    <br>
                </p>
            </div>
        </div>
<%
        String result = EntryPoint.getResult();
%>
        <h3><%=result%></h3>
    </body>
</html>
