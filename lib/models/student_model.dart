class Student {
  int? status;
  var createdAt;
  String? name;
  String? email;
  String? password;
  String? phoneNumber;
  String? gender;
  String? academicYear;
  String? course;
  String? role; // Add the role attribute
  String? uid; // Add uid property

  Student(
      {required this.name,
      required this.email,
      required this.password,
      required this.phoneNumber,
      required this.gender,
      required this.academicYear,
      required this.course,
      this.role, // Include the role in the constructor
      this.uid,
      this.createdAt,
      this.status});

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
        name: json['name'],
        email: json['email'],
        password: json['password'],
        phoneNumber: json['phoneNumber'],
        gender: json['gender'],
        academicYear: json['academicYear'],
        course: json['course'],
        role: json['role'], // Initialize the role
        uid: json['uid'],
        status: json['status'],
        createdAt: json['createdAt']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'name': name,
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
      'gender': gender,
      'academicYear': academicYear,
      'course': course,
      'role': role, // Include the role in the JSON data
      'uid': uid,
      'status': status,
      'createdAt': createdAt
    };
    return data;
  }
}
