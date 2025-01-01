class User {
  final int id;
  final String email;
  final String password;
  final String fullName;
  final String address;
  final String phoneNumber;
  final String imgUrl;

  User({
    required this.id,
    required this.email,
    required this.password,
    required this.fullName,
    required this.address,
    required this.phoneNumber,
    required this.imgUrl,
  });

  // Hàm chuyển đổi từ JSON sang đối tượng User
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      password: json['password'],
      fullName: json['full_name'],
      address: json['address'],
      phoneNumber: json['phone_number'],
      imgUrl: json['imgUrl'],
    );
  }

  // Hàm chuyển đổi từ đối tượng User sang JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'full_name': fullName,
      'address': address,
      'phone_number': phoneNumber,
      'imgUrl': imgUrl,
    };
  }
}
