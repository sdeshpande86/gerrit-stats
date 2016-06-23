package com.appdynamics.tools.gerritstats;

import com.google.gson.JsonArray;

public class EntryPoint {
    public static void main(String[] args) throws Exception{
        System.out.println(getResult());
        JsonArray jsonArray =
                FetchGerritStatsUtility.readGetUrl("http://gerrit.corp.appdynamics.com:8080/a/changes/?q=owner:Henry+and+status:merged+and+project:codebase");
        FetchGerritStatsUtility.getUserCommitsHistoryMap(jsonArray);
    }

    public static String getResult() {
        return "Hello World!!!";
    }
}
