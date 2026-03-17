package com.mediaedit.ai;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import lombok.extern.slf4j.Slf4j;
import okhttp3.*;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import java.io.IOException;
import java.util.concurrent.TimeUnit;

@Service
@Slf4j
public class OpenAIService {
    
    @Value("${ai.openai.api-key}")
    private String apiKey;
    
    @Value("${ai.openai.base-url}")
    private String baseUrl;
    
    private final OkHttpClient httpClient = new OkHttpClient.Builder()
            .connectTimeout(60, TimeUnit.SECONDS)
            .readTimeout(120, TimeUnit.SECONDS)
            .writeTimeout(60, TimeUnit.SECONDS)
            .build();
    
    private final Gson gson = new Gson();
    
    public String enhanceImage(String imageBase64, String prompt) {
        try {
            JsonObject requestBody = new JsonObject();
            requestBody.addProperty("model", "gpt-4-vision-preview");
            requestBody.addProperty("max_tokens", 1000);
            
            JsonObject message = new JsonObject();
            message.addProperty("role", "user");
            
            JsonObject content = new JsonObject();
            content.addProperty("type", "text");
            content.addProperty("text", prompt != null ? prompt : "请分析这张图片并提供美化建议");
            
            JsonObject imageUrl = new JsonObject();
            JsonObject imageUrlObj = new JsonObject();
            imageUrlObj.addProperty("url", "data:image/jpeg;base64," + imageBase64);
            imageUrl.add("image_url", imageUrlObj);
            imageUrl.addProperty("type", "image_url");
            
            requestBody.add("messages", gson.toJsonTree(new JsonObject[]{
                    message
            }));
            
            Request request = new Request.Builder()
                    .url(baseUrl + "/chat/completions")
                    .addHeader("Authorization", "Bearer " + apiKey)
                    .addHeader("Content-Type", "application/json")
                    .post(RequestBody.create(requestBody.toString(), MediaType.parse("application/json")))
                    .build();
            
            try (Response response = httpClient.newCall(request).execute()) {
                if (!response.isSuccessful()) {
                    throw new RuntimeException("AI服务调用失败: " + response.code());
                }
                return response.body().string();
            }
        } catch (Exception e) {
            log.error("图片增强失败", e);
            throw new RuntimeException("图片增强失败: " + e.getMessage());
        }
    }
    
    public String analyzePose(String imageBase64) {
        String prompt = "请分析这张照片中人物的姿势，并提供以下建议：\n" +
                "1. 当前姿势的优点\n" +
                "2. 可以改进的地方\n" +
                "3. 最佳姿势建议\n" +
                "4. 角度和光线建议\n" +
                "请以JSON格式返回结果。";
        return enhanceImage(imageBase64, prompt);
    }
    
    public String generateEditSuggestions(String imageDescription) {
        try {
            JsonObject requestBody = new JsonObject();
            requestBody.addProperty("model", "gpt-4");
            requestBody.addProperty("max_tokens", 500);
            
            JsonObject message = new JsonObject();
            message.addProperty("role", "user");
            message.addProperty("content", "基于以下图片描述，提供专业的修图建议：\n" + imageDescription);
            
            requestBody.add("messages", gson.toJsonTree(new JsonObject[]{message}));
            
            Request request = new Request.Builder()
                    .url(baseUrl + "/chat/completions")
                    .addHeader("Authorization", "Bearer " + apiKey)
                    .addHeader("Content-Type", "application/json")
                    .post(RequestBody.create(requestBody.toString(), MediaType.parse("application/json")))
                    .build();
            
            try (Response response = httpClient.newCall(request).execute()) {
                if (!response.isSuccessful()) {
                    throw new RuntimeException("AI服务调用失败: " + response.code());
                }
                return response.body().string();
            }
        } catch (Exception e) {
            log.error("生成编辑建议失败", e);
            throw new RuntimeException("生成编辑建议失败: " + e.getMessage());
        }
    }
}
