/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Util;

import Model.GoogleAccount;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import java.io.IOException;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.fluent.Form;
import org.apache.http.client.fluent.Request;

/**
 *
 * @author LAPTOP
 */
public class GoogleLogin {

    public static final String GOOGLE_CLIENT_ID = "973295766463-p6al40io1vaa2rv22sl5sf3j18j22a34.apps.googleusercontent.com";

    public static final String GOOGLE_CLIENT_SECRET = "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";

    // Update the redirect URI to match the RentEz application
    public static final String GOOGLE_REDIRECT_URI = "http://localhost:8080/RentEz/login-google-callback";

    public static final String GOOGLE_GRANT_TYPE = "authorization_code";

    public static final String GOOGLE_LINK_GET_TOKEN = "https://accounts.google.com/o/oauth2/token";

    public static final String GOOGLE_LINK_GET_USER_INFO = "https://www.googleapis.com/oauth2/v1/userinfo?access_token=";

    // This URL is used to initiate the Google OAuth flow
    public static final String GOOGLE_AUTH_URL = "https://accounts.google.com/o/oauth2/auth";

    // Get the Google login URL
    public static String getLoginUrl() {
        String url = GOOGLE_AUTH_URL + "?client_id=" + GOOGLE_CLIENT_ID + "&redirect_uri=" + GOOGLE_REDIRECT_URI
                + "&response_type=code&scope=email%20profile&approval_prompt=force";
        return url;
    }

    public static String getToken(String code) throws ClientProtocolException, IOException {
        String response = Request.Post(GOOGLE_LINK_GET_TOKEN)
                .bodyForm(
                        Form.form()
                                .add("client_id", GOOGLE_CLIENT_ID)
                                .add("client_secret", GOOGLE_CLIENT_SECRET)
                                .add("redirect_uri", GOOGLE_REDIRECT_URI)
                                .add("code", code)
                                .add("grant_type", GOOGLE_GRANT_TYPE)
                                .build()
                )
                .execute().returnContent().asString();

        JsonObject jobj = new Gson().fromJson(response, JsonObject.class);

        String accessToken = jobj.get("access_token").toString().replaceAll("\"", "");

        return accessToken;
    }

    public static GoogleAccount getUserInfo(final String accessToken) throws ClientProtocolException, IOException {
        String link = GOOGLE_LINK_GET_USER_INFO + accessToken;

        String response = Request.Get(link).execute().returnContent().asString();

        GoogleAccount googlePojo = new Gson().fromJson(response, GoogleAccount.class);

        return googlePojo;
    }
}
