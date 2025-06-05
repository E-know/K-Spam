![K-Spam Banner](https://github.com/user-attachments/assets/7c21be21-6df5-42ac-9bac-e5d4c921c82e)

# K-Spam: 한국 특화 스팸 필터 앱

스팸 문자에 지친 사용자들을 위해 개발자가 직접 만든 강력한 스팸 필터 앱, K-Spam!
설정만 하면 자동으로 스팸 문자 차단이 시작됩니다.

## 주요 기능

- ✅ **기본 탑재 스팸 필터**  
  자주 사용되는 스팸 유형을 자동으로 차단합니다.

- 🔍 **정규식을 이용한 번호 필터링**  
  숫자 패턴을 정규식으로 분석하여 유동적인 스팸 번호도 차단합니다.  
  예: `010-94XX-1234`

- 🧠 **단어 화이트리스트 & 블랙리스트 필터링**  
  사용자 정의 키워드로 더욱 정교하게 문자 필터링!

- ⚙️ **리스트 커스터마이징 지원**  
  필터링 단어와 번호를 직접 추가하거나 삭제할 수 있어요.

- 🎰 **카지노/도박/충전 문자 전용 필터**  
  '카지노', '슬롯', '충전' 등 도박성 문자를 자동으로 차단합니다.

- 📵 **광고 수신 동의 문구 차단**  
  "무료 수신거부", "광고 수신 동의" 문구가 포함된 광고 문자까지 필터링!

## 설치하기

👉 [App Store에서 다운로드](https://apps.apple.com/kr/app/k-spam-%ED%95%9C%EA%B5%AD-%ED%8A%B9%ED%99%94-%EC%8A%A4%ED%8C%B8-%ED%95%84%ED%84%B0-%EC%95%B1/id6503290039)

## 사용 방법

1. 앱 설치 후 설정으로 이동합니다.  
2. [설정 → 메시지 → 알 수 없는 발신자 및 스팸 → K-Spam 활성화]  
3. 이제 K-Spam이 스팸 문자를 자동으로 걸러드립니다.

---
개발자의 뚝심으로 탄생한 K-Spam!  
더는 스팸 문자에 스트레스받지 마세요 📵  

## 아키텍쳐

### MVI 패턴 적용
![아키텍쳐](https://private-user-images.githubusercontent.com/55151796/451938394-f4294926-94a0-4ea7-9613-f3abdaf667b1.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NDkxMzU3ODMsIm5iZiI6MTc0OTEzNTQ4MywicGF0aCI6Ii81NTE1MTc5Ni80NTE5MzgzOTQtZjQyOTQ5MjYtOTRhMC00ZWE3LTk2MTMtZjNhYmRhZjY2N2IxLnBuZz9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFWQ09EWUxTQTUzUFFLNFpBJTJGMjAyNTA2MDUlMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjUwNjA1VDE0NTgwM1omWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPTFlODY1NzE3NzZkOGM5OGM3NTFkY2MwMTJhODUzMzVlNTEwOGIyNTMxYTQ0MTlhYTcyMDg2NDYyNzhjMDBjNmEmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0In0.H7zWgZIFMKmhHbvD9WfkswqEh5kLBndtoEMdLQ35oGQ)


