ALTER TABLE Reservation DROP FOREIGN KEY FK_Users_TO_Reservation_1;
ALTER TABLE Reservation DROP FOREIGN KEY FK_Schedules_TO_Reservation_1;
ALTER TABLE Reservation DROP FOREIGN KEY FK_CenterInfo_TO_Reservation_1;
ALTER TABLE Schedules DROP FOREIGN KEY FK_CenterInfo_TO_Schedules_1;

DROP TABLE IF EXISTS Reservation;

CREATE TABLE Reservation (
    reservation_id int NOT NULL AUTO_INCREMENT,
    reservation_time DATE NOT NULL DEFAULT (CURRENT_DATE),
    user_id int NOT NULL,
    schedule_id int NOT NULL,
    center_id int NOT NULL,
    PRIMARY KEY (reservation_id, reservation_time)
)
PARTITION BY RANGE (YEAR(reservation_time) * 100 + MONTH(reservation_time)) (
    PARTITION p202501 VALUES LESS THAN (202502),  -- 2025년 1월까지
    PARTITION p202502 VALUES LESS THAN (202503),
    PARTITION p202503 VALUES LESS THAN (202504),
    PARTITION pFuture VALUES LESS THAN MAXVALUE   -- 나머지 (예비)
);

DROP TABLE IF EXISTS center_info;

CREATE TABLE center_info (
    center_id INT AUTO_INCREMENT PRIMARY KEY,
    center_name VARCHAR(255) NOT NULL,
    spot VARCHAR(50) NOT NULL,
    category VARCHAR(100) NOT NULL,
    city VARCHAR(100) NOT NULL,
    district VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    price INT NOT NULL,
    center_address VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS Users;

CREATE TABLE Users (
    user_id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NULL,
    id VARCHAR(255) NOT NULL,
    pw VARCHAR(255) NOT NULL,
    age int NOT NULL,
    sex char(1) NOT NULL
);

DROP TABLE IF EXISTS Schedules;

CREATE TABLE Schedules (
    schedule_id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    start_time INT NOT NULL, -- 시작 시간 (10:00~11:00)까지이면 10이 들어감
    end_time INT NOT NULL, -- 끝 시간 (10:00~11:00)까지이면 11이 들어감
    schedule_date DATE NOT NULL, -- 예약된 시간, 즉 취미 센터에 가기로 정한 날짜
    is_booked VARCHAR(100) NULL DEFAULT 'N',
    center_id int NOT NULL
);

ALTER TABLE Reservation ADD CONSTRAINT FK_Users_TO_Reservation_1 FOREIGN KEY (
    user_id
) REFERENCES Users (
    user_id
);

ALTER TABLE Reservation ADD CONSTRAINT FK_Schedules_TO_Reservation_1 FOREIGN KEY (
    schedule_id
) REFERENCES Schedules (
    schedule_id
);

ALTER TABLE Reservation ADD CONSTRAINT FK_CenterInfo_TO_Reservation_1 FOREIGN KEY (
    center_id
) REFERENCES center_info (
    center_id
);

ALTER TABLE Schedules ADD CONSTRAINT FK_CenterInfo_TO_Schedules_1 FOREIGN KEY (
    center_id
) REFERENCES center_info (
    center_id
);