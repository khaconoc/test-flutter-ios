import 'package:flutter/material.dart';

class DeliveryModel {
  String email;
  String gender;
  String phone;
  String avatar;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  DeliveryModel({
    @required this.email,
    @required this.gender,
    @required this.phone,
    @required this.avatar,
  });

  DeliveryModel copyWith({
    String email,
    String gender,
    String phone,
    String avatar,
  }) {
    return new DeliveryModel(
      email: email ?? this.email,
      gender: gender ?? this.gender,
      phone: phone ?? this.phone,
      avatar: avatar ?? this.avatar,
    );
  }

  @override
  String toString() {
    return 'DeliveryModel{email: $email, gender: $gender, phone: $phone, avatar: $avatar}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DeliveryModel &&
          runtimeType == other.runtimeType &&
          email == other.email &&
          gender == other.gender &&
          phone == other.phone &&
          avatar == other.avatar);

  @override
  int get hashCode => email.hashCode ^ gender.hashCode ^ phone.hashCode ^ avatar.hashCode;

  factory DeliveryModel.fromMap(Map<String, dynamic> map) {
    return new DeliveryModel(
      email: map['email'] as String,
      gender: map['gender'] as String,
      phone: map['phone'] as String,
      avatar: map['picture']['medium'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'email': this.email,
      'gender': this.gender,
      'phone': this.phone,
      'avatar': this.avatar,
    } as Map<String, dynamic>;
  }

//</editor-fold>

}