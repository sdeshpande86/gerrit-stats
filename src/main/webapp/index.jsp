<!DOCTYPE html>
<html lang="en">
<%@ page import="com.appdynamics.tools.gerritstats.EntryPoint" %>
<%@ page import="java.util.*" %>
 <%@ page import="java.util.HashMap" %> 
<%@ page import="com.appdynamics.tools.gerritstats.CommitsStats"%>
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

        <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css"> 

               <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script> 

               <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script> 

               <script src="https://cdnjs.cloudflare.com/ajax/libs/1000hz-bootstrap-validator/0.9.0/validator.min.js"></script>


        <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
          <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <![endif]-->
        <!--Load the AJAX API-->
        <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>


        <script type="text/javascript">

            var dataMap = new Map();
            var months = [0, 31, 28, 31, 30, 31, 30,31, 31, 30, 31, 30, 31];
            var copyDataMap = new Map();
            var username;

            // Load the Visualization API and the corechart package.
            google.charts.load('current', {'packages':['corechart']});

          function callMap()
          {
              // Set a callback to run when the Google Visualization API is loaded.
              google.charts.setOnLoadCallback(drawChart);
          }

          // Callback that creates and populates a data table,
          // instantiates the pie chart, passes in the data and
          // draws it.
          function drawChart() {

            // Create the data table.
            var data = new google.visualization.DataTable();
            data.addColumn('string', 'Date');
            data.addColumn('number', 'No of Commits');
            dataMap.forEach(function(value, key)
            {
                var arr = [];
                arr.push(key);
                arr.push(dataMap.get(key)[0]);
                data.addRow(arr);
            });


            // Set chart options
            var options = {'title':'No of commits vs Time',
                           'width':500,
                           'height':300};

            // Instantiate and draw our chart, passing in some options.
            var chart = new google.visualization.ColumnChart(document.getElementById('chart_div'));
            chart.draw(data, options);

            // Create the data table.
            var lineChartData = new google.visualization.DataTable();
            lineChartData.addColumn('string', 'Date');
            lineChartData.addColumn('number', 'Lines Inserted');
            lineChartData.addColumn('number', 'Lines Deleted');

            dataMap.forEach(function(value, key)
            {
                var arr = [];
                arr.push(key);
                arr.push(dataMap.get(key)[1]);
                arr.push(dataMap.get(key)[2]);
                lineChartData.addRow(arr);
            });


            // Set chart options
            var lineChartOptions = {'title':'How Much commits',
                                       'width':500,
                                       'height':300};

            // Instantiate and draw our chart, passing in some options.
            var lineChart = new google.visualization.LineChart(document.getElementById('line_chart_div'));
            lineChart.draw(lineChartData, lineChartOptions);

            // Create the dummy data table.
                        var dummyChartData = new google.visualization.DataTable();
                        dummyChartData.addColumn('string', 'Date');
                        dummyChartData.addColumn('number', 'Lines Inserted');
                        dummyChartData.addColumn('number', 'Lines Deleted');

                        dummyChartData.addRow(['2005-01-01',  1000,      400]);
                        dummyChartData.addRow(['2005-01-02',  1170,      460]);
                        dummyChartData.addRow(['2005-01-03',  660,       1120]);
                        dummyChartData.addRow(['2005-01-04',  1030,      540]);


                        // Set chart options
                        var dummyChartOptions = {'title':'Lines of Java code vs Time',
                                                            'width':500,
                                                            'height':300};
                        // Instantiate and draw our chart, passing in some options.
                        var dummyChart = new google.visualization.LineChart(document.getElementById('java_div'));
                        dummyChart.draw(dummyChartData, dummyChartOptions);

                        // Set chart options
                        dummyChartOptions = {'title':'Lines of C# code vs Time',
                                                           'width':500,
                                                           'height':300};

                        // Instantiate and draw our chart, passing in some options.
                        dummyChart = new google.visualization.LineChart(document.getElementById('cSharp_div'));
                        dummyChart.draw(dummyChartData, dummyChartOptions);

                        // Set chart options
                        dummyChartOptions = {'title':'Lines of C++ code vs Time',
                                                            'width' :500,
                                                            'height':300};
                        // Instantiate and draw our chart, passing in some options.
                        dummyChart = new google.visualization.LineChart(document.getElementById('php_div'));
                        dummyChart.draw(dummyChartData, dummyChartOptions);

                        // Set chart options
                        dummyChartOptions = {'title':'Lines of other code vs Time',
                                                            'width':500,
                                                            'height':300};
                        // Instantiate and draw our chart, passing in some options.
                        dummyChart = new google.visualization.LineChart(document.getElementById('others_div'));
                        dummyChart.draw(dummyChartData, dummyChartOptions);

          }
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
                    <form aid="myForm" action="index.jsp" method="post">
                        <input type="text" name="user" value="" required/>
                        <button type="submit" id="submit" class="btn btn-sm btn-success">View</button>
                    </form>
                    <br>
                </p>
            </div>
        </div>

        <script type="text/javascript">
            $(document).ready(function() {
                var year;

                $('#myForm').validator();

                $('#yearSelect').on('change', function() {
                    year = this.value;
                });

                $('#monthsSelect').on('change', function() {

                    var days = months[this.value];
                    dataMap = new Map();
                    var month;
                    if(this.value < 10)
                    {
                        month = "0"+this.value;
                    }
                    else
                        month = this.value;

                    var date;
                    var day;

                    for(i=1 ; i<days; i++)
                    {
                        if(i<10)
                        {
                            day = "0"+i;
                        }
                        else
                            day = i;

                          date = year+"-"+month+"-"+day;
                        //date = "2015-"+month+"-"+day;
                        if(copyDataMap.get(date) != undefined)
                        {
                        //    alert( date );
                            dataMap.set(date, copyDataMap.get(date));
                        }
                        else
                        {
                            dataMap.set(date, [0,0,0]);
                        }
                    }

                    //testing
                    //var month = "2015-0"+this.value+"-21";
                    //if(copyDataMap.get(month) != undefined)
                    //    alert( months[this.value] );

                    callMap();

                });

            });
        </script>

        <script type="text/javascript">

            var arr= [];
            var str;

            <%
                String user = request.getParameter("user");
                if(user != null && !user.equals(""))
                {
            %>
                    username = "<%= user %>";
            <%
                    Map<String, CommitsStats> result = EntryPoint.getResult(user);
                    if(result != null)
                    {
                        for(Map.Entry<String, CommitsStats> e : result.entrySet())
                        {
                            CommitsStats commitStat = e.getValue();
            %>

                            arr.push(<%= commitStat.getNumOfCommits() %>);
                            arr.push(<%= commitStat.getLinesOfInsertion() %>);
                            arr.push(<%= commitStat.getLinesOfDeletion() %>);
                            str = "<%= e.getKey() %>";
                            dataMap.set(str, arr);
                            copyDataMap.set(str, arr);
                            arr = [];

                    <%
                        }
                    }
                    else
                    {
                    %>
                       alert("User not present");
                    <%
                    }
                    }
                    %>
                    callMap();
        </script>

        <div class="container">
        <div class="row">

            <div class="col-xs-5" id="chart_div"></div>
            <div class="col-xs-2" id="selectItems">

                    <select id="yearSelect">
                      <option value="0" selected="selected">Year</option>
                      <option value="2016">2016</option>
                      <option value="2015">2015</option>
                      <option value="2014">2014</option>
                      <option value="2013">2013</option>
                    </select>
                <select id="monthsSelect">
                  <option value="0" selected="selected">Months</option>
                  <option value="1">Jan</option>
                  <option value="2">Feb</option>
                  <option value="3">Mar</option>
                  <option value="4">Apr</option>
                  <option value="5">May</option>
                  <option value="6">Jun</option>
                  <option value="7">Jul</option>
                  <option value="8">Aug</option>
                  <option value="9">Sep</option>
                  <option value="10">Oct</option>
                  <option value="11">Nov</option>
                  <option value="12">Dec</option>
                </select>

            </div>
            <div class="col-xs-5" id="line_chart_div"></div>
        </div>
        <div class="row">
            <div class="col-md-4" id="java_div"></div>
            <div class="col-md-4" id="php_div"></div>
            <div class="col-md-4" id="cSharp_div"></div>
            <div class="col-md-4" id="others_div"></div>
        </div>
        </div>
    </body>
</html>
