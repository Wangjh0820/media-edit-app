package com.mediaedit.controller;

import com.mediaedit.ai.BaiduAIService;
import com.mediaedit.ai.OpenAIService;
import com.mediaedit.dto.ApiResponse;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.Map;

@RestController
@RequestMapping("/api/ai")
@RequiredArgsConstructor
@Tag(name = "AI服务", description = "AI功能相关接口")
public class AIController {
    
    private final OpenAIService openAIService;
    private final BaiduAIService baiduAIService;
    
    @PostMapping("/enhance")
    @Operation(summary = "AI图片增强")
    public ResponseEntity<ApiResponse<String>> enhanceImage(
            @RequestBody Map<String, String> request) {
        
        String imageBase64 = request.get("image");
        String prompt = request.get("prompt");
        
        String result = openAIService.enhanceImage(imageBase64, prompt);
        return ResponseEntity.ok(ApiResponse.success(result));
    }
    
    @PostMapping("/pose-analysis")
    @Operation(summary = "AI姿势分析")
    public ResponseEntity<ApiResponse<String>> analyzePose(
            @RequestBody Map<String, String> request) {
        
        String imageBase64 = request.get("image");
        String result = openAIService.analyzePose(imageBase64);
        return ResponseEntity.ok(ApiResponse.success(result));
    }
    
    @PostMapping("/edit-suggestions")
    @Operation(summary = "获取编辑建议")
    public ResponseEntity<ApiResponse<String>> getEditSuggestions(
            @RequestBody Map<String, String> request) {
        
        String description = request.get("description");
        String result = openAIService.generateEditSuggestions(description);
        return ResponseEntity.ok(ApiResponse.success(result));
    }
    
    @PostMapping("/face-detect")
    @Operation(summary = "人脸检测")
    public ResponseEntity<ApiResponse<String>> faceDetect(
            @RequestBody Map<String, String> request) {
        
        String imageBase64 = request.get("image");
        String result = baiduAIService.faceDetect(imageBase64);
        return ResponseEntity.ok(ApiResponse.success(result));
    }
    
    @PostMapping("/body-analysis")
    @Operation(summary = "人体分析")
    public ResponseEntity<ApiResponse<String>> bodyAnalysis(
            @RequestBody Map<String, String> request) {
        
        String imageBase64 = request.get("image");
        String result = baiduAIService.bodyAnalysis(imageBase64);
        return ResponseEntity.ok(ApiResponse.success(result));
    }
    
    @PostMapping("/quality-enhance")
    @Operation(summary = "图片质量增强")
    public ResponseEntity<ApiResponse<String>> qualityEnhance(
            @RequestBody Map<String, String> request) {
        
        String imageBase64 = request.get("image");
        String result = baiduAIService.imageQualityEnhance(imageBase64);
        return ResponseEntity.ok(ApiResponse.success(result));
    }
    
    @PostMapping("/style-transfer")
    @Operation(summary = "风格转换")
    public ResponseEntity<ApiResponse<String>> styleTransfer(
            @RequestBody Map<String, String> request) {
        
        String imageBase64 = request.get("image");
        String style = request.get("style");
        String result = baiduAIService.styleTransfer(imageBase64, style);
        return ResponseEntity.ok(ApiResponse.success(result));
    }
}
