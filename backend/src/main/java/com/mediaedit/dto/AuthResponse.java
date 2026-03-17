package com.mediaedit.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class AuthResponse {
    
    private String token;
    private String tokenType;
    private Long id;
    private String username;
    private String email;
    private String avatar;
    private String nickname;
    private Boolean vip;
    
    public static AuthResponse of(String token, Long id, String username, String email) {
        return AuthResponse.builder()
                .token(token)
                .tokenType("Bearer")
                .id(id)
                .username(username)
                .email(email)
                .build();
    }
}
