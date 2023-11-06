<div align="center">
<img src="https://capsule-render.vercel.app/api?type=slice&color=auto&height=300&section=header&text=Rise%20to%20the%20challenge.%20i'm%20hoyeong&fontSize=20&rotate=19&animation=fadeIn&fontAlign=80&fontAlignY=45" />

<br>
	⭐ Platforms & Languages ⭐
	<br>
	<br>	
	<img src="https://img.shields.io/badge/Java-007396?style=flat&logo=java&logoColor=white" />
	<img src="https://img.shields.io/badge/HTML5-E34F26?style=flat&logo=HTML5&logoColor=white" />
	<img src="https://img.shields.io/badge/CSS3-1572B6?style=flat&logo=CSS3&logoColor=white" />
	<img src="https://img.shields.io/badge/JavaScript-F7DF1E?style=flat&logo=javascript&logoColor=white" />	
	<br>
	<img src="https://img.shields.io/badge/Oracle SQL-F80000?style=flat&logo=Oracle&logoColor=white" />
	<img src="https://img.shields.io/badge/Spring-6DB33F?style=flat&logo=Spring&logoColor=white" />
	<img src="https://img.shields.io/badge/Bootstrap-7952B3?style=flat&logo=bootstrap&logoColor=white" />
<br>
<br>
	🛠 Tools 🛠
	<br>
	<br>
	<img src="https://img.shields.io/badge/Eclipse IDE-2C2255?style=flat&logo=Eclipse IDE&logoColor=white" />
	<img src="https://img.shields.io/badge/Tomcat-F8DC75?style=flat&logo=apachetomcat&logoColor=black" />
	<img src="https://img.shields.io/badge/GitHub-181717?style=flat&logo=github&logoColor=white" />	
 	<br>
  	<br>
	
<br>

</div>
<h2>프로젝트명 : 트립 스테이션</h2>
"TripStation은 여행 동행을 찾는 사람들을 위한 웹 사이트입니다. 사용자는 원하는 여행지와 여행 일정을 입력하면, 동일한 여행지를 방문하는 다른 여행자를 찾아볼 수 있습니다. TripStation은 여행 계획을 공유하고 새로운 친구를 만나 여행 경험을 더욱 풍부하게 만들어줍니다."

<h2>주요기능</h2>
TripStation은 사용자가 여행을 계획하고 동행을 찾을 수 있는 다양한 기능을 제공합니다.
<br>
<br>

**1. 여행장소 및 숙소등록:** 사용자는 숙소와 여행 명소를 직접 등록할 수 있습니다. TripStation은 여행 관련 정보를 공유하고 커뮤니티 멤버들이 자신의 숙소나 발견한 멋진 여행 명소를 공유할 수 있는 플랫폼을 제공합니다.<br>
**2. 플랜 작성:** 사용자는 자신만의 여행 플랜을 작성할 수 있습니다. 또한, 다른 사용자가 작성한 플랜을 참조하여 새로운 플랜을 작성할 수도 있습니다.  
**3. 맞춤 여행:** 사용자는 자신이 작성한 플랜을 기반으로 동행을 모집하고, 같이 여행을 갈 수 있습니다.<br> 
**4. 패키지 여행:** 가이드가 작성한 플랜에 신청을 하면, 패키지 여행에 참여할 수 있습니다.<br>
**5. 크루 기능:** 사용자는 크루를 만들거나 기존 크루에 가입할 수 있습니다. 크루의 회원들은 동행 모집 기능을 통해 같이 여행을 갈 수 있습니다.  
<h2>ERD</h2>
URL: https://www.erdcloud.com/d/KNbGrYcK7uniAjFyH
<br>

![전체 erd화이트](https://github.com/knagki/web-portfolio/assets/125181086/266ba3d7-7f6b-4726-b188-aaac883096d3)

<h2>프로젝트에서의 나의 역할</h2>

**1. 플레이스 메인 페이지:** 사용자가 여행 장소를 등록하고 공유할 수 있는 페이지입니다. 페이지 상단에 Swiper API를 이용하여 카테고리 메뉴를 제공해 사용자가 원하는 지역을 쉽게 선택할 수 있도록 구현해보았습니다.로그인하면 "플레이스 등록" 버튼이 나타나, 사용자들이 간편하게 자신의 여행 장소를 등록할 수 있습니다.  
<br>
![localhost_8181_travel_planPlace_placePage (2)](https://github.com/healthy-spam/travel/assets/139120334/7f618e3e-03ae-441b-9843-23bcef49eebb)

**2. 플레이스 상세 페이지:** 사용자가 장소를 공유할 수 있게 좋아요와 댓글기능을 구현해보았습니다. 페이지 하단의 인기글은 SQL count 함수를 사용해서 임의로 좋아요는 4, 댓글은 1로 설정하여 출력해 보았습니다.
<br>
![localhost_8181_travel_planPlace_PlanPlaceDetailPage_plan_place_id=22](https://github.com/healthy-spam/travel/assets/139120334/94bbbc20-84b0-4161-b19c-43c069cdda0d)

**2. 플레이스 등록 페이지:** 로그인시 사용자가 여행 장소에 관련된 데이터들을 등록할 수 있게 구현해봤습니다.
<br>
![localhost_8181_travel_planPlace_registerPlacePage (1)](https://github.com/healthy-spam/travel/assets/139120334/e0c0a351-e155-4a15-a455-f31cd993d380)

**2. 숙소 메인 페이지:** 사용자가 숙소를 등록하고 예약할 수 있는 페이지입니다. 에어비엔비 사이트를 많이 참고했습니다. 플레이스와 동일하게 Swiper API를 이용하였고 로그인시 "숙소 등록" 버튼이 나타나 숙소를 등록할 수 있습니다. 
<br>
![localhost_8181_travel_hotel_hotelPage (3)](https://github.com/healthy-spam/travel/assets/139120334/fece7869-d3f9-4edd-b1ed-dea21c0a41de)

**2. 숙소 상세 페이지:** 사용자가 입력한 숙소 관련 데이터를 출력하며, 사용자 경험을 향상시키기 위해 숙소 이용 날짜를 클릭하면 일수에 맞는 총 금액이 계산되고, 이를 비동기적으로 Ajax를 사용하여 동적으로 응답하도록 구현하였습니다. 또한, 숙소의 주소를 지도에 표시하기 위해 카카오 지도 API를 활용하여 해당 숙소의 위치에 핀을 나타나게 하였습니다. 
<br>
![hotelDetailPage](https://github.com/healthy-spam/travel/assets/139120334/2085fd11-069b-4356-ab7e-303bf633d3ec)

**2. 숙소 예약 페이지:** 이 페이지는 결제로 이동하기 전에 사용자에게 최종 확인과 결정을 내릴 기회를 제공하기 위해 만들어보았습니다. 사용자가 예약한 숙소 정보를 요약하고, 예약 날짜, 가격  등의 세부 정보를 표시합니다
<br>
![localhost_8181_travel_hotel_hotelPaymentPage_hotel_id=2 guestNum=1 checkInDate=2023-08-15 checkOutDate=2023-08-16 totalFee=160000 numDays=1](https://github.com/healthy-spam/travel/assets/139120334/846a94b6-4382-4858-8bbb-953dc0086038)

**2. 숙소 등록 페이지들** 
![localhost_8181_travel_hotel_hotelRegisterPage1](https://github.com/healthy-spam/travel/assets/139120334/00ba5612-a81a-437b-aa85-447ec7d88281)
![localhost_8181_travel_hotel_hotelRegisterPage2 (1)](https://github.com/healthy-spam/travel/assets/139120334/09fb20ce-227f-4e54-b723-94e2d598ca67)
![localhost_8181_travel_hotel_hotelRegisterPage3](https://github.com/healthy-spam/travel/assets/139120334/e6ec7921-fc8b-4382-a546-eb7df76ada67)

이렇게 사용자의 입장에서 UI에 대해 생각해보고 백엔드까지 여행서비스와 관련된 프로젝트를 개발해봤습니다. 감사합니다.
![localhost_8181_travel_hotel_hotelRegisterPage4](https://github.com/healthy-spam/travel/assets/139120334/af83f2ee-bf63-43a0-a9d3-552778276d8d)
![localhost_8181_travel_hotel_hotelRegisterPage5](https://github.com/healthy-spam/travel/assets/139120334/6890da6c-8b16-4cb2-bbee-8e4a8a45eb74)




