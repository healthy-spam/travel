package com.ja.travel.login.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

@RestController
public class KakaoLoginRestController {

    @PostMapping("/kakaoLogin")
    public Map<String, Object> kakaoLogin(@RequestBody Map<String, String> payload) {
        String accessToken = payload.get("access_token");
        
        // Kakao 사용자 정보 API URL
        String apiUrl = "https://kapi.kakao.com/v2/user/me";
        
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", "Bearer " + accessToken);

        HttpEntity<?> entity = new HttpEntity<>(headers);

        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<Map> response = restTemplate.exchange(apiUrl, HttpMethod.GET, entity, Map.class);
        
        if (response.getStatusCodeValue() == 200) {
            Map<String, Object> userInfo = response.getBody();

            // id, properties 및 kakao_account 정보 추출
            Long userId = (Long) userInfo.get("id");
            
            // properties 및 kakao_account 정보 추출
            Map<String, Object> properties = (Map<String, Object>) userInfo.getOrDefault("properties", new HashMap<>());
            Map<String, Object> kakaoAccount = (Map<String, Object>) userInfo.getOrDefault("kakao_account", new HashMap<>());

            String nickname = (String) properties.getOrDefault("nickname", "");
            String birthday = (String) kakaoAccount.getOrDefault("birthday", "");
            String gender = (String) kakaoAccount.getOrDefault("gender", "");
            String ageRange = (String) kakaoAccount.getOrDefault("age_range", "");
            
            System.out.println(userId);
            
            // 결과 Map 생성
            Map<String, Object> result = new HashMap<>();
            result.put("user_id", userId);
            result.put("nickname", nickname);
            result.put("birthday", birthday);
            result.put("gender", gender);
            result.put("age_range", ageRange);

            return result;
        }

        return null;
    }
    
    
//  String accessToken = payload.get("access_token");
//  // 카카오 API를 사용하여 추가 사용자 정보를 얻습니다...
//
//  // 사용자 정보를 DB에 저장합니다.
//  User user = new User();
//  user.setNickname( ... ); // 카카오로부터 받은 닉네임...
//  user.setBirthday(...); // 카카오로부터 받은 생년월일
//  user.setGender(...); // 카카오로부터 받은 성별
//
//  userService.saveUser(user); // 사용자 정보를 DB에 저장하는 메서드
//
//  // 세션을 생성하고 사용자에게 로그인 상태를 유지시킵니다.
//  // 이 부분은 Spring Security 등을 이용하여 처리할 수 있습니다.
//
//  // 클라이언트에게 응답을 전송합니다. 이 응답에는 리다이렉트 URL을 포함시킬 수 있습니다.
//  return ResponseEntity.ok("로그인 성공");
}