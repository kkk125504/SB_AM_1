<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="MAIN" />
<%@ include file="../common/head.jspf" %>
<style>
/* 카카오 지도 API */
.map_wrap, .map_wrap * {margin:0;padding:0;font-family:'Malgun Gothic',dotum,'돋움',sans-serif;font-size:12px;}
.map_wrap a, .map_wrap a:hover, .map_wrap a:active{color:#000;text-decoration: none;}
.map_wrap {position:relative; width:100%; height:500px;}
#menu_wrap {position:absolute;top:0;left:0;bottom:0;width:250px;margin:10px 0 30px 10px;padding:5px;overflow-y:auto;background:rgba(255, 255, 255, 0.7);z-index: 1;font-size:12px;border-radius: 10px;}
.bg_white {background:#fff;}
#menu_wrap hr {display: block; height: 1px;border: 0; border-top: 2px solid #5F5F5F;margin:3px 0;}
#menu_wrap .option{text-align: center;}
#menu_wrap .option p {margin:10px 0;}  
#menu_wrap .option button {margin-left:5px;}
#placesList li {list-style: none;}
#placesList .item {position:relative;border-bottom:1px solid #888;overflow: hidden;cursor: pointer;min-height: 65px;}
#placesList .item span {display: block;margin-top:4px;}
#placesList .item h5, #placesList .item .info {text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
#placesList .item .info{padding:10px 0 10px 55px;}
#placesList .info .gray {color:#8a8a8a;}
#placesList .info .jibun {padding-left:26px;background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_jibun.png) no-repeat;}
#placesList .info .tel {color:#009900;}
#placesList .item .markerbg {float:left;position:absolute;width:36px; height:37px;margin:10px 0 0 10px;background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png) no-repeat;}
#placesList .item .marker_1 {background-position: 0 -10px;}
#placesList .item .marker_2 {background-position: 0 -56px;}
#placesList .item .marker_3 {background-position: 0 -102px}
#placesList .item .marker_4 {background-position: 0 -148px;}
#placesList .item .marker_5 {background-position: 0 -194px;}
#placesList .item .marker_6 {background-position: 0 -240px;}
#placesList .item .marker_7 {background-position: 0 -286px;}
#placesList .item .marker_8 {background-position: 0 -332px;}
#placesList .item .marker_9 {background-position: 0 -378px;}
#placesList .item .marker_10 {background-position: 0 -423px;}
#placesList .item .marker_11 {background-position: 0 -470px;}
#placesList .item .marker_12 {background-position: 0 -516px;}
#placesList .item .marker_13 {background-position: 0 -562px;}
#placesList .item .marker_14 {background-position: 0 -608px;}
#placesList .item .marker_15 {background-position: 0 -654px;}
#pagination {margin:10px auto;text-align: center;}
#pagination a {display:inline-block;margin-right:10px;}
#pagination .on {font-weight: bold; cursor: default;color:#777;}
</style>
<style>
/* 날씨 */
.card{
background: rgba(0, 0, 0, 0.884);
color: white;
padding: 1.5rem;
border-radius: 30px;
width: 100%;
max-width: 420px;
margin: 1rem;
}
.search{
display: flex;
align-items: center;
justify-content: center;
}
.search button{
margin: 1rem;
border-radius: 50%;
border: none;
height: 2.5rem;
width: 2.5rem;
outline: none;
background-color: rgba(92, 88, 88, 0.644);
color: white;
}
.search button:hover{
background-color: rgb(92, 88, 88);
cursor: pointer;
transition: 0.2s ease-in-out;
}
input.search-bar {
border: none;
outline: none;
padding: 1rem 1rem;
border-radius: 50px;
width: 15rem;
height: 2.5rem;
background-color: rgba(92, 88, 88, 0.644);
color: white;
font-family: inherit;
font-size: 100%;
}
.description{
text-transform: capitalize;
}
</style>
<style>
/* 메인 */
.main-box1{
position: absolute;
width: 1760px;
height: 521px;
left: 80px;
top: 214px;

background: #FFFAF3;
}

.main-box2{ 
position: absolute;
width: 1760px;
height: 516px;
left: 80px;
top: 881px;

background: #FFFAF3;
 } 

.main-box1-title{
position: absolute;
width: 368px;
height: 67px;
left: 194px;
top: 310px;

font-weight: 300;
font-size: 48px;
line-height: 65px;
text-align: center;
letter-spacing: 0.06em;

color: #000000;
}

.main-box2-title{
position: absolute;
width: 368px;
height: 67px;
left: 388px;
top: 901px;

font-weight: 300;
font-size: 30px;
line-height: 65px;
text-align: center;
letter-spacing: 0.06em;

color: #000000;
}

.main-box2-title2{
position: absolute;
width: 368px;
height: 67px;
left: 1164px;
top: 901px;

font-weight: 300;
font-size: 30px;
line-height: 65px;
text-align: center;
letter-spacing: 0.06em;

color: #000000;
}

.main-box1-text{
position: absolute;
width: 388px;
height: 136px;
left: 194px;
top: 468px;

font-weight: 700;
font-size: 18px;
line-height: 147.6%;
letter-spacing: 0.06em;
color: #000000;
}
.brush{
position: absolute;
width: 1760px;
height: 147px;
left: 80px;
top: 640px;
background: rgba(192, 141, 93, 0.2);
filter: blur(50px);
}

.brush2{
position: absolute;
width: 1760px;
height: 233.66px;
left: 80px;
top: 1298px;

background: rgba(192, 141, 93, 0.2);
filter: blur(50px);
}

.main-box1-image{
position: absolute;
width: 911px;
height: 415px;
left: 800px;
top: 267px;
}

.main-box1-weather{
position: absolute;
width: 369px;
height: 262px;
left: 1400px;
top: 334px;
}

.main-box2-content1{
position: absolute;
width: 756px;
height: 351px;
left: 194px;
top: 990px;

background: #D9D9D9;
}

.map-box{
position: absolute;
width: 756px;
height: 351px;
left: 970px;
top: 990px;
background: #D9D9D9;
}
</style>
<section>
	<div class="main-box1"></div>
	<div class="main-box1-title">
		<span>메인타이틀</span>
	</div>
	<div class="main-box1-text">
		<span>
			메인글메인글메인글메인글메인글메인글메인글메인글메인글메인글메인글메인글메인글메인글메인글메인글
		</span>
	</div>
	<div class="main-box1-image">
		<img src="https://cdn.pixabay.com/photo/2020/03/29/18/33/girl-4981766_960_720.jpg" width="600">
	</div>
	<div class="main-box1-weather">
		<div class="card">
		<div class="search">
			<input type="text" class="search-bar" placeholder="도시이름을 입력해주세요.">
			<button>
				<svg stroke="currentColor" fill="currentColor" stroke-width="0" viewBox="0 0 1024 1024" height="1em" width="1em" xmlns="http://www.w3.org/2000/svg"><path d="M909.6 854.5L649.9 594.8C690.2 542.7 712 479 712 412c0-80.2-31.3-155.4-87.9-212.1-56.6-56.7-132-87.9-212.1-87.9s-155.5 31.3-212.1 87.9C143.2 256.5 112 331.8 112 412c0 80.1 31.3 155.5 87.9 212.1C256.5 680.8 331.8 712 412 712c67 0 130.6-21.8 182.7-62l259.7 259.6a8.2 8.2 0 0 0 11.6 0l43.6-43.5a8.2 8.2 0 0 0 0-11.6zM570.4 570.4C528 612.7 471.8 636 412 636s-116-23.3-158.4-65.6C211.3 528 188 471.8 188 412s23.3-116.1 65.6-158.4C296 211.3 352.2 188 412 188s116.1 23.2 158.4 65.6S636 352.2 636 412s-23.3 116.1-65.6 158.4z"></path></svg>
			</button>
		</div>
		<div class="weather loading">
			<h2 class="city">Weather in</h2>
			<h1 class="temp">13°C</h1>
			<div class="description">Cloudy</div>
			<div class="humidity">Humid</div>
			<div class="wind">Fast</div>
		</div>
		</div>
	</div>
	<div class="brush"></div>
</section>
<section>	
	<div class="main-box2"></div>
	<div class="main-box2-title">명상 영상</div>
	<div class="main-box2-content1">
		<iframe width="756" height="351" src="https://www.youtube.com/embed/dZewQEbQQM0" 
		title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen>
		</iframe>
	</div>
	<div class="main-box2-title2">명상장소 검색하기</div>
	<div class="map_wrap map-box">
		<div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>	
	    <div id="menu_wrap" class="bg_white">
	        <div class="option">
	            <div>
	                <form onsubmit="searchPlaces(); return false;">
	                    키워드 : <input type="text" value="대전 명상" id="keyword" size="15"> 
	                    <button type="submit">검색하기</button> 
	                </form>
	            </div>
	        </div>
	        <hr>
	        <ul id="placesList"></ul>
	        <div id="pagination"></div>
	    </div>
	</div>		
	<div class="brush2"></div>
</section>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=2fc9b373fc33a2fd0bd584d5fb81482f&libraries=services,clusterer,drawing"></script>
<script>
	// 마커를 담을 배열입니다
	var markers = [];

	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = {
	        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
	        level: 3 // 지도의 확대 레벨
	    };  

	// 지도를 생성합니다    
	var map = new kakao.maps.Map(mapContainer, mapOption); 

	// 장소 검색 객체를 생성합니다
	var ps = new kakao.maps.services.Places();  

	// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
	var infowindow = new kakao.maps.InfoWindow({zIndex:1});

	// 키워드로 장소를 검색합니다
	searchPlaces();

	// 키워드 검색을 요청하는 함수입니다
	function searchPlaces() {

	    var keyword = document.getElementById('keyword').value;

	    if (!keyword.replace(/^\s+|\s+$/g, '')) {
	        alert('키워드를 입력해주세요!');
	        return false;
	    }

	    // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
	    ps.keywordSearch( keyword, placesSearchCB); 
	}

	// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
	function placesSearchCB(data, status, pagination) {
	    if (status === kakao.maps.services.Status.OK) {

	        // 정상적으로 검색이 완료됐으면
	        // 검색 목록과 마커를 표출합니다
	        displayPlaces(data);

	        // 페이지 번호를 표출합니다
	        displayPagination(pagination);

	    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {

	        alert('검색 결과가 존재하지 않습니다.');
	        return;

	    } else if (status === kakao.maps.services.Status.ERROR) {

	        alert('검색 결과 중 오류가 발생했습니다.');
	        return;

	    }
	}

	// 검색 결과 목록과 마커를 표출하는 함수입니다
	function displayPlaces(places) {

	    var listEl = document.getElementById('placesList'), 
	    menuEl = document.getElementById('menu_wrap'),
	    fragment = document.createDocumentFragment(), 
	    bounds = new kakao.maps.LatLngBounds(), 
	    listStr = '';
	    
	    // 검색 결과 목록에 추가된 항목들을 제거합니다
	    removeAllChildNods(listEl);

	    // 지도에 표시되고 있는 마커를 제거합니다
	    removeMarker();
	    
	    for ( var i=0; i<places.length; i++ ) {

	        // 마커를 생성하고 지도에 표시합니다
	        var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
	            marker = addMarker(placePosition, i), 
	            itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다

	        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
	        // LatLngBounds 객체에 좌표를 추가합니다
	        bounds.extend(placePosition);

	        // 마커와 검색결과 항목에 mouseover 했을때
	        // 해당 장소에 인포윈도우에 장소명을 표시합니다
	        // mouseout 했을 때는 인포윈도우를 닫습니다
	        (function(marker, title) {
	            kakao.maps.event.addListener(marker, 'mouseover', function() {
	                displayInfowindow(marker, title);
	            });

	            kakao.maps.event.addListener(marker, 'mouseout', function() {
	                infowindow.close();
	            });

	            itemEl.onmouseover =  function () {
	                displayInfowindow(marker, title);
	            };

	            itemEl.onmouseout =  function () {
	                infowindow.close();
	            };
	        })(marker, places[i].place_name);

	        fragment.appendChild(itemEl);
	    }

	    // 검색결과 항목들을 검색결과 목록 Element에 추가합니다
	    listEl.appendChild(fragment);
	    menuEl.scrollTop = 0;

	    // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
	    map.setBounds(bounds);
	}

	// 검색결과 항목을 Element로 반환하는 함수입니다
	function getListItem(index, places) {

	    var el = document.createElement('li'),
	    itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' + '<div class="info">' +'<h5>' + places.place_name + '</h5>';

	    if (places.road_address_name) {
	        itemStr += '<span>' + places.road_address_name + '</span>' + '<span class="jibun gray">' +  places.address_name  + '</span>';
	    } else {
	        itemStr += '<span>' +  places.address_name  + '</span>'; 
	    }
	                 
	      itemStr += '<span class="tel">' + places.phone  + '</span>' + '</div>';           

	    el.innerHTML = itemStr;
	    el.className = 'item';

	    return el;
	}

	// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
	function addMarker(position, idx, title) {
	    var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
	        imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
	        imgOptions =  {
	            spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
	            spriteOrigin : new kakao.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
	            offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
	        },
	        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
	            marker = new kakao.maps.Marker({
	            position: position, // 마커의 위치
	            image: markerImage 
	        });

	    marker.setMap(map); // 지도 위에 마커를 표출합니다
	    markers.push(marker);  // 배열에 생성된 마커를 추가합니다

	    return marker;
	}

	// 지도 위에 표시되고 있는 마커를 모두 제거합니다
	function removeMarker() {
	    for ( var i = 0; i < markers.length; i++ ) {
	        markers[i].setMap(null);
	    }   
	    markers = [];
	}

	// 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
	function displayPagination(pagination) {
	    var paginationEl = document.getElementById('pagination'),
	        fragment = document.createDocumentFragment(),
	        i; 

	    // 기존에 추가된 페이지번호를 삭제합니다
	    while (paginationEl.hasChildNodes()) {
	        paginationEl.removeChild (paginationEl.lastChild);
	    }

	    for (i=1; i<=pagination.last; i++) {
	        var el = document.createElement('a');
	        el.href = "#";
	        el.innerHTML = i;

	        if (i===pagination.current) {
	            el.className = 'on';
	        } else {
	            el.onclick = (function(i) {
	                return function() {
	                    pagination.gotoPage(i);
	                }
	            })(i);
	        }

	        fragment.appendChild(el);
	    }
	    paginationEl.appendChild(fragment);
	}

	// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
	// 인포윈도우에 장소명을 표시합니다
	function displayInfowindow(marker, title) {
	    var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';

	    infowindow.setContent(content);
	    infowindow.open(map, marker);
	}

	// 검색결과 목록의 자식 Element를 제거하는 함수입니다
	function removeAllChildNods(el) {   
	    while (el.hasChildNodes()) {
	        el.removeChild (el.lastChild);
	    }
	}		
</script>
<script>
		let weather = {
		  "apiKey" : "e5a59b3f594231b48a802fb095c74a97",
		  fetchWeather : function (city) {
		    fetch("https://api.openweathermap.org/data/2.5/weather?q=" + city + "&usits=metric&appid=" + this.apiKey)
		    .then((response) => response.json())
		    .then((data) => this.displayWeather(data));
		  }, //api에서 정보를 가져온 후 사용 할 수 있게 data로 넘김
		  displayWeather : function (data) {
		    const {name} = data;
		    const {icon, description} = data.weather[0];
		    const {temp,humidity} = data.main;
		    const {speed} = data.wind;
		    console.log(name,description,icon,temp,humidity,speed);
		    document.querySelector(".city").innerText = "Weather in " + name;
		    document.querySelector(".description").innerText = description;
		    document.querySelector(".temp").innerText = Math.round(temp - 273) + "℃";
		    document.querySelector(".humidity").innerText = "습기: " + humidity + "%";
		    document.querySelector(".wind").innerText = "풍속: " + speed + "km/h";
		    document.querySelector(".weather").classList.remove("loading");
		  }, //데이터를 어떻게 표기할 지
		  search: function() {			
		    this.fetchWeather(document.querySelector(".search-bar").value);							
		  } // 검색창에 검색한 도시이름이 fetchWeather에 들어갈 수 있도록
		};
		
		document.querySelector(".search button").addEventListener("click", function () {
		weather.search();
		});
		document.querySelector(".search-bar").addEventListener("keyup",function(event) {
		if (event.key=="Enter") {
		weather.search() }
		});
</script>
<%@ include file="../common/foot.jspf" %>