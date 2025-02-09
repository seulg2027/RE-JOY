# RE-JOY 🎉

## 1. Team 구구구칠

|<img src="https://avatars.githubusercontent.com/u/87555330?v=4" width="150" height="150"/>|<img src="https://avatars.githubusercontent.com/u/55776421?v=4" width="150" height="150"/>|<img src="https://avatars.githubusercontent.com/u/71498489?v=4" width="150" height="150"/>|<img src="https://avatars.githubusercontent.com/u/82265395?v=4" width="150" height="150"/>|
|:-:|:-:|:-:|:-:|
|김민성<br/>[@minsung159357](https://github.com/minsung159357)|SeulGi_LEE<br/>[@seulg2027](https://github.com/seulg2027)|HanJH<br/>[@letsgojh0810](https://github.com/letsgojh0810)|구민지<br/>[@minjee83](https://github.com/minjee83)|

## 2. Project 개요 및 주제

💡 기간 : `2025.02.03` ~ `2025.02.10`

💡 프로젝트 명 : RE-JOY <br/>
    
    RE-JOY 의미 : "다시(Re) 즐기자(Joy)!" 🎉
    - 5060 세대가 인생 2막을 즐길 수 있는 취미 예약 플랫폼

💡 개요 : 본 프로젝트는 `Servlet`, `jsp`와 `Apache Tomcat`을 사용하여 사용자들에게 중단되지 않는 편리한 웹 서비스를 제공하는 것을 목표로 한다. 5060세대들이 선호하는 취미 종류를 `ELK`를 활용하여 분석하고, 선호도가 높은 취미를 검색 시 우선으로 노출시킴으로써 사용자 친화적인 서비스를 제공한다. 또한, 5060세대들이 통계적으로 어떤 취미를 선호하는지 한 눈에 볼 수 있게 한다.

💡 주제 : 5060의 즐거움을 위한 취미 통합 예약 사이트

💡 데이터 출처 : [취미 선호도 데이터](https://www.kosis.kr/index/index.do)를 CSV 파일로 받아서 연령대별, 성별별로 선호도 분석 📈


## 3. Stack & Tools

| Elements       | Tools                        | 설명                         |
|----------------|------------------------------|------------------------------|
| Database   | <img src="https://img.shields.io/badge/MySQL-4479A1?style=flat-square&logo=MySQL&logoColor=white"> | 사용자, 취미 센터, 예약 정보 등의 데이터를 저장   |
| Server   | <img src="https://img.shields.io/badge/apache tomcat-F8DC75?style=flat-square&logo=apachetomcat&logoColor=white"> <img src="https://img.shields.io/badge/Linux-FCC624?style=flat-square&logo=linux&logoColor=black"> | 각각 WAS 서버, 데이터베이스 서버로 사용 |
| Data Anaysis   | <img src="https://img.shields.io/badge/elastic stack-005571?style=flat-square&logo=elasticstack&logoColor=white"> | 데이터 수집, 검색, 분석 도구 |
| WEB System  | <img src="https://img.shields.io/badge/servlet-000000?style=flat-square&logo=openjdk&logoColor=white"> <img src="https://img.shields.io/badge/gradle-02303A?style=flat-square&logo=gradle&logoColor=white"> <img src="https://img.shields.io/badge/html5-E34F26?style=flat-square&logo=html5&logoColor=white"> <img src="https://img.shields.io/badge/css-663399?style=flat-square&logo=css&logoColor=white"> | 웹 서비스 개발 도구 |


## 4. 기능 소개 및 구현 결과

### 🔧 주요 기능

### 📢 구현 결과

## 5. 데이터베이스

4개의 테이블을 만들어 데이터베이스를 제작하였다. [SQL DDL문 보러가기](./sql/ddl.sql)

| Table명       | 설명             | 용도                         |
|----------------|-----------------|------------------------------|
| Users | 사용자 정보 테이블 | 사용자 정보를 저장하는 테이블. 사용자의 나이, 성별을 입력받아 해당 정보를 기반으로 취미 리스트를 보여줌 |
| Schedules | 예약 가능 시간 정보 테이블 | 예약이 가능한 시간대를 저장하는 테이블 |
| Reservation | 예약 정보 테이블 | 사용자가 예약한 정보를 저장하는 테이블 |
| center_info | 취미 센터 테이블 | 취미 센터 정보들을 저장하는 테이블 |

<details>
<summary>Reservation 테이블 Partitioning 자동화</summary>

```sql
CREATE EVENT AddMonthlyPartition
ON SCHEDULE EVERY 1 MONTH
STARTS TIMESTAMP(CURRENT_DATE + INTERVAL 1 DAY)  -- 매달 1일 실행
DO
BEGIN
    SET @next_partition = DATE_FORMAT(DATE_ADD(CURRENT_DATE, INTERVAL 1 MONTH), '%Y%m');
    SET @next_value = YEAR(DATE_ADD(CURRENT_DATE, INTERVAL 1 MONTH)) * 100 + MONTH(DATE_ADD(CURRENT_DATE, INTERVAL 1 MONTH));
    
    SET @sql = CONCAT(
        'ALTER TABLE Reservation ADD PARTITION (PARTITION p', 
        @next_partition, ' VALUES LESS THAN (', @next_value, '))'
    );
    
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END;
```

</details>

## 6. Trouble Shooting

## 7. Team member's Review