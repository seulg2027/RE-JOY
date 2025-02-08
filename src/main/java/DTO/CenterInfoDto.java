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
	private int id;
	private String name;
	private String spot;
	private String category;
	private String city;
	private String district;
	private String address;
	private String phone;
	private int price;
}
