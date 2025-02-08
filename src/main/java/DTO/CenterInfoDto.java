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
	private int center_id;
	private String center_name;
	private String spot;
	private String category;
	private String city;
	private String district;
	private String center_address;
	private String phone;
	private int price;
}
