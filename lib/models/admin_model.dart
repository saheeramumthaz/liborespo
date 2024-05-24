

import 'package:cloud_firestore/cloud_firestore.dart';

class Admin {
  String? uid;
  String? name;
  String? email;
  String? password;
  String? phone;
  String? role; // Added role field
  int? status;
  DateTime? createdAt;

  Admin({
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
  factory Admin.fromJson(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Admin(
      uid: doc.id,
      name: data['name'],
      email: data['email'],
      password: data['password'],
      phone: data['phone'],
      role: data['role'], // Added role field
      status: data['status'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  // Convert UserModel object to Map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
      'role': role, // Added role field
      'status': status,
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
    };
  }
}
