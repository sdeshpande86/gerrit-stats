package com.appdynamics.tools.gerritstats;

import com.google.gson.JsonArray;
import org.apache.log4j.Logger;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 * Created by henry.wu on 6/22/16.
 */
public class FetchGerritStatsServlet extends HttpServlet {
    public static final Logger LOGGER = Logger.getLogger(FetchGerritStatsServlet.class);

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String user = request.getParameter("user");
        JsonArray jsonArray = FetchGerritStatsUtility
                .readGetUrl("http://gerrit.corp.appdynamics.com:8080/changes/?q=owner:"
                        + user + "+and+status:merged+and+project:codebase");
        response.getWriter().println(jsonArray.getAsString());
        FetchGerritStatsUtility.getUserCommitsHistoryMap(jsonArray);
    }
}
