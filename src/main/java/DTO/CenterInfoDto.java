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
public class CenterInfoDto {
	private int centerId;
	private String name;
	private String spot;
	private String category;
	private String city;
	private String disctrict;
	private String price;
	private String phone;
	private String address;
}
