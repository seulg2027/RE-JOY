package DTO;

import lombok.*;

import java.util.Date;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class ScheduleWithCenterDto {
	private int reservation_id;
    private int center_id;
    private String center_name;
    private String center_address;
    private int price;
    private Date schedule_date;
    private int start_time;
    private int end_time;
}
