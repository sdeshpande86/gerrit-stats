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

    public static Map<String, CommitsStats> getUserCommitsHistoryMap(JsonArray jsonArray) {
        Map<String, CommitsStats> userCommitHistoryMap = new HashMap<String, CommitsStats>();
        for (JsonElement applicationJsonElement : jsonArray) {
            String date = applicationJsonElement.getAsJsonObject().getAsJsonPrimitive("created").getAsString();
            String day = date.substring(0, date.indexOf(" "));
            if (!userCommitHistoryMap.containsKey(day)) {
                CommitsStats commitsStats =
                        new CommitsStats(1,
                                applicationJsonElement.getAsJsonObject().getAsJsonPrimitive("insertions").getAsInt(),
                                applicationJsonElement.getAsJsonObject().getAsJsonPrimitive("deletions").getAsInt());
                userCommitHistoryMap.put(day, commitsStats);
            } else {
                CommitsStats commitsStats = userCommitHistoryMap.get(day);
                commitsStats.setNumOfCommits(commitsStats.getNumOfCommits() + 1);
                commitsStats.setLinesOfInsertion(commitsStats.getLinesOfInsertion()
                        + applicationJsonElement.getAsJsonObject().getAsJsonPrimitive("insertions").getAsInt());
                commitsStats.setLinesOfDeletion(commitsStats.getLinesOfDeletion()
                        + applicationJsonElement.getAsJsonObject().getAsJsonPrimitive("deletions").getAsInt());
            }
        }
        return userCommitHistoryMap;
    }
}
