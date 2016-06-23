package com.appdynamics.tools.gerritstats;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonParser;
import org.apache.http.HttpHost;
import org.apache.http.HttpStatus;
import org.apache.http.auth.AuthScope;
import org.apache.http.auth.UsernamePasswordCredentials;
import org.apache.http.client.AuthCache;
import org.apache.http.client.CredentialsProvider;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.protocol.HttpClientContext;
import org.apache.http.impl.auth.DigestScheme;
import org.apache.http.impl.client.BasicAuthCache;
import org.apache.http.impl.client.BasicCredentialsProvider;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.apache.log4j.Logger;

import java.io.IOException;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;


/**
 * Created by henry.wu on 6/22/16.
 */
public class FetchGerritStatsUtility {
    public static final Logger LOGGER = Logger.getLogger(FetchGerritStatsUtility.class);

    public static JsonArray readGetUrl(String url) throws IOException {
        HttpHost target = new HttpHost("gerrit.corp.appdynamics.com", 8080, "http");
        CredentialsProvider credsProvider = new BasicCredentialsProvider();
        credsProvider.setCredentials(
                new AuthScope(target.getHostName(), target.getPort()),
                new UsernamePasswordCredentials("henry.wu", "/OUg5qLuAlXmjE+zRF3iuDgFXQx2zsWhmjdQYAVquw"));
        CloseableHttpClient httpclient = HttpClients.custom()
                .setDefaultCredentialsProvider(credsProvider)
                .build();
        AuthCache authCache = new BasicAuthCache();
        DigestScheme digestAuth = new DigestScheme();
        authCache.put(target, digestAuth);

        HttpClientContext localContext = HttpClientContext.create();
        localContext.setAuthCache(authCache);

        HttpGet httpget = new HttpGet(url);

        LOGGER.info("Executing request " + httpget.getRequestLine() + " to target " + target);
        CloseableHttpResponse response = httpclient.execute(target, httpget, localContext);
        int responseCode = response.getStatusLine().getStatusCode();
        JsonArray json = null;
        if (responseCode == HttpStatus.SC_OK) {
            String jsonText = EntityUtils.toString(response.getEntity()).replace(")]}'\n", "");
            System.out.println(jsonText);
            json = new JsonParser().parse(jsonText).getAsJsonArray();
        } else {
            LOGGER.info("Error occurred, server response with " + responseCode);
        }
        response.close();
        httpclient.close();
        return json;
    }

    public static Map<String, List<Integer>> getUserCommitsHistoryMap(JsonArray jsonArray) {
        Map<String, List<Integer>> userCommitHistoryMap = new HashMap<String, List<Integer>>();
        for (JsonElement applicationJsonElement : jsonArray) {
            String date = applicationJsonElement.getAsJsonObject().getAsJsonPrimitive("created").getAsString();
            String day = date.substring(0, date.indexOf(" "));
            if (!userCommitHistoryMap.containsKey(day)) {
                List<Integer> elementList = new LinkedList<Integer>();
                elementList.add(1);
                elementList.add(applicationJsonElement.getAsJsonObject().getAsJsonPrimitive("insertions").getAsInt());
                elementList.add(applicationJsonElement.getAsJsonObject().getAsJsonPrimitive("deletions").getAsInt());
                userCommitHistoryMap.put(day, elementList);
            } else {
                List<Integer> elementList = userCommitHistoryMap.get(day);
                elementList.set(0, elementList.get(0) + 1);
                elementList.set(1, elementList.get(1) + applicationJsonElement.getAsJsonObject()
                        .getAsJsonPrimitive("insertions").getAsInt());
                elementList.set(2, elementList.get(2) + applicationJsonElement.getAsJsonObject()
                        .getAsJsonPrimitive("deletions").getAsInt());
            }
        }
        return userCommitHistoryMap;
    }
}
