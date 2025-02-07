package DTO;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ReservationDTO {
	private int reservationId;
	private Date reservationTime;
	private int userId;
	private int scheduleId;
	private int hobbyId;
}