package com.mediaedit.ai;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import lombok.extern.slf4j.Slf4j;
import okhttp3.*;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import java.util.concurrent.TimeUnit;

@Service
@Slf4j
public class BaiduAIService {
    
    @Value("${ai.baidu.api-key}")
    private String apiKey;
    
    @Value("${ai.baidu.secret-key}")
    private String secretKey;
    
    private final OkHttpClient httpClient = new OkHttpClient.Builder()
            .connectTimeout(30, TimeUnit.SECONDS)
            .readTimeout(60, TimeUnit.SECONDS)
            .build();
    
    private final Gson gson = new Gson();
    
    private String accessToken;
    
    private String getAccessToken() throws IOException {
        if (accessToken != null) {
            return accessToken;
        }
        
        Request request = new Request.Builder()
                .url("https://aip.baidubce.com/oauth/2.0/token?grant_type=client_credentials" +
                        "&client_id=" + apiKey +
                        "&client_secret=" + secretKey)
                .post(RequestBody.create("", MediaType.parse("application/json")))
                .build();
        
        try (Response response = httpClient.newCall(request).execute()) {
            if (!response.isSuccessful()) {
                throw new RuntimeException("获取百度AI访问令牌失败");
            }
            JsonObject json = gson.fromJson(response.body().string(), JsonObject.class);
            accessToken = json.get("access_token").getAsString();
            return accessToken;
        }
    }
    
    public String faceDetect(String imageBase64) {
        try {
            String token = getAccessToken();
            
            RequestBody body = RequestBody.create(
                    "image=" + imageBase64 + "&image_type=BASE64",
                    MediaType.parse("application/x-www-form-urlencoded")
            );
            
            Request request = new Request.Builder()
                    .url("https://aip.baidubce.com/rest/2.0/face/v3/detect?access_token=" + token)
                    .post(body)
                    .build();
            
            try (Response response = httpClient.newCall(request).execute()) {
                return response.body().string();
            }
        } catch (Exception e) {
            log.error("人脸检测失败", e);
            throw new RuntimeException("人脸检测失败: " + e.getMessage());
        }
    }
    
    public String bodyAnalysis(String imageBase64) {
        try {
            String token = getAccessToken();
            
            RequestBody body = RequestBody.create(
                    "image=" + imageBase64 + "&type=BASE64",
                    MediaType.parse("application/x-www-form-urlencoded")
            );
            
            Request request = new Request.Builder()
                    .url("https://aip.baidubce.com/rest/2.0/image-classify/v1/body_analysis?access_token=" + token)
                    .post(body)
                    .build();
            
            try (Response response = httpClient.newCall(request).execute()) {
                return response.body().string();
            }
        } catch (Exception e) {
            log.error("人体分析失败", e);
            throw new RuntimeException("人体分析失败: " + e.getMessage());
        }
    }
    
    public String imageQualityEnhance(String imageBase64) {
        try {
            String token = getAccessToken();
            
            RequestBody body = RequestBody.create(
                    "image=" + imageBase64,
                    MediaType.parse("application/x-www-form-urlencoded")
            );
            
            Request request = new Request.Builder()
                    .url("https://aip.baidubce.com/rest/2.0/image-process/v1/image_quality_enhance?access_token=" + token)
                    .post(body)
                    .build();
            
            try (Response response = httpClient.newCall(request).execute()) {
                return response.body().string();
            }
        } catch (Exception e) {
            log.error("图片增强失败", e);
            throw new RuntimeException("图片增强失败: " + e.getMessage());
        }
    }
    
    public String styleTransfer(String imageBase64, String style) {
        try {
            String token = getAccessToken();
            
            RequestBody body = RequestBody.create(
                    "image=" + imageBase64 + "&option=" + style,
                    MediaType.parse("application/x-www-form-urlencoded")
            );
            
            Request request = new Request.Builder()
                    .url("https://aip.baidubce.com/rest/2.0/image-process/v1/style_transfer?access_token=" + token)
                    .post(body)
                    .build();
            
            try (Response response = httpClient.newCall(request).execute()) {
                return response.body().string();
            }
        } catch (Exception e) {
            log.error("风格转换失败", e);
            throw new RuntimeException("风格转换失败: " + e.getMessage());
        }
    }
}
