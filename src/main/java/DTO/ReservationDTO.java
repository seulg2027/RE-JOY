package DTO;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class ReservationDTO {
	private int reservationId;
	private String reservationTime;
	private int userId;
	private int scheduleId;
	private int centerInfoId;
}
