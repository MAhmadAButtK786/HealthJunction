enum Gender { male, female, others }

class DonorModel {
  final String? id;
  final String fullName;
  final String email;
  final String bloodtype;
  final String phoneNumber;
  final double age;
  final String city;
  final String province;

  DonorModel({
    this.id,
    required this.fullName,
    required this.email,
    required this.bloodtype,
    required this.phoneNumber,
    required this.age,
    required this.city,
    required this.province,
  });

  // ... rest of your DonorModel class code

  toJason() {
    return {
      "id": id,
      "FullName": fullName,
      "Email": email,
      "BloodType": bloodtype,
      "Phone": phoneNumber,
      "Age": age,
      "City": city,
      "Province": province,
    };
  }
}
