# 로그인 기능

Django REST API 설정:

1. Django REST Framework 라이브러리를 설치합니다.
사용자 모델을 정의하고, 로그인/회원가입을 위한 API 엔드포인트를 생성합니다.
JWT(JSON Web Token) 인증을 사용하여 사용자 인증을 구현합니다.
CORS(Cross-Origin Resource Sharing) 설정을 통해 Flutter 프론트엔드와의 통신을 허용합니다.


Flutter 프로젝트 설정:

2. Flutter 프로젝트를 생성하고, 필요한 라이브러리(예: http, jwt_decoder 등)를 설치합니다.
사용자 인증 관련 모델과 서비스를 정의합니다.
로그인, 회원가입, 로그아웃 등의 기능을 구현합니다.
JWT 토큰을 사용하여 Django REST API와 통신합니다.


Django REST API와 Flutter 프레임워크 연동:

3. Django REST API에서 생성한 로그인/회원가입 API 엔드포인트에 Flutter 프레임워크에서 HTTP 요청을 보냅니다.
요청에 JWT 토큰을 포함하여 사용자 인증을 수행합니다.
응답 데이터를 Flutter 프레임워크에서 처리하여 사용자 인터페이스를 업데이트합니다.
