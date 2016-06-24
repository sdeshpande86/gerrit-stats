package com.appdynamics.tools.gerritstats;

import com.google.gson.JsonArray;

import java.io.IOException;
import java.util.Map;

public class EntryPoint {
    public static void main(String[] args) throws Exception {
        getResult("Henry");
    }

    public static Map<String, CommitsStats> getResult(String user) {
        JsonArray jsonArray = null;
        try {
            jsonArray = FetchGerritStatsUtility.readGetUrl("http://gerrit.corp.appdynamics.com:8080/a/changes/" +
                    "?q=owner:" +user+ "+and+status:merged+and+project:codebase");
        } catch (IOException e) {
            e.printStackTrace();
        }
        if(jsonArray != null)
            return FetchGerritStatsUtility.getUserCommitsHistoryMap(jsonArray);
        return null;
    }
}