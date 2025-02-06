package DTO;

import lombok.*;

@Getter
@Setter
@ToString
@NoArgsConstructor
//@AllArgsConstructor
public class UserInfoDto {
	private int userId; // autoIncrement
	private String name;
	private String id; // 실제 사용자 아이디
	private String pw;
	private int age;
	private char sex;
	private String phone;

	public UserInfoDto(int userId, String name, String id, String pw, int age, char sex, String phone) {
		this.userId = userId;
		this.name = name;
		this.id = id;
		this.pw = pw;
		this.age = age;
		this.sex = sex;
		this.phone = phone;
	}
}
