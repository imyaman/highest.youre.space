#Perl과 웹 API 서비스

## 개요
PHP, Java, Python, JavaScript의 유행에서 떨어져, 오래된 것으로 꾸준히 하는 사람도 필요합니다. 바로 28년 넘게 발전해온 Perl 말입니다.
그 오래된 것을 새로 배우는 사람도 필요합니다. 사람들이 Perl을 접하게 만들고자 합니다.

## 목적
사람들이 Perl로 만들어진 서비스를 이용하고, 소스코드를 접하게 합니다.

## 세부내용
- 웹 API 서비스를 제공합니다.
- 돈 되지 않고, 보안에 문제 되지 않고, 그러면서 유용한 기능 또는 데이터를 제공합니다.
- Perl과 Dancer를 이용하여 만듭니다.
- 소스코드를 공개합니다.

## 이용방법
- http://highest.youre.space/ 참조
- http://highest.youre.space/api/time
- API 목록과 상세설명은 github에 추가합니다.

## 이용 예시

### curl
```
$ curl -X GET -H 'Content-type: application/json' http://highest.youre.space/api/time
$ curl -X GET -H 'Content-type: text/html' http://highest.youre.space/api/time
$ curl -X GET -H 'Content-type: text/x-yaml' http://highest.youre.space/api/time
$ curl -X GET -H 'Content-type: text/xml' http://highest.youre.space/api/time
```
### JavaScript
```
$(document).ready(function(){
    $("#btnTime").click(function(){
      $.get("http://highest.youre.space/api/time", function(data, status){
        $("#hereTime").append(data.time + "<br />");
      });
    });
});
```
