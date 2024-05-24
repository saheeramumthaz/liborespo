

class Teacher {
  String? uid;
  String? name;
  String? email;
  String? password;
  String? phone;
  String? role; // Added role field
  int? status;
  var createdAt;

  Teacher({
    this.uid,
    this.name,
    this.email,
    this.password,
    this.createdAt,
    this.phone,
    this.role, // Added role field
    this.status,
  });

  // Convert DocumentSnapshot to UserModel object
  factory Teacher.fromJson(Map<String, dynamic> json) {
    return Teacher(
        uid: json['uid'],
        role: json['role'],
        name: json['name'],
        email: json['email'],
        password: json['password'],
        phone: json['phone'],
        status: json['status'],
        createdAt: json['createdAt']);
  }

  // Convert UserModel object tojson
  Map<String, dynamic> toJson() {
    return {
      'uid':uid,
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
      'role': role, // Added role field
      'status': status,
      'createdAt': createdAt
    };
  }
}
