// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  String? accessToken;
  String? refreshToken;
  String? tokenType;
  String? userId;
  String? username;
  String? userType;
  String? email;
  String? phoneNumber;
  String? profileImageUrl;
  dynamic additionalInfo;
  String? message;

  LoginModel({
    this.accessToken,
    this.refreshToken,
    this.tokenType,
    this.userId,
    this.username,
    this.userType,
    this.email,
    this.phoneNumber,
    this.profileImageUrl,
    this.additionalInfo,
    this.message,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        accessToken: json["access_token"],
        refreshToken: json["refresh_token"],
        tokenType: json["token_type"],
        userId: json["user_id"],
        username: json["username"],
        userType: json["user_type"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        profileImageUrl: json["profile_image_url"],
        additionalInfo: json["additional_info"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "refresh_token": refreshToken,
        "token_type": tokenType,
        "user_id": userId,
        "username": username,
        "user_type": userType,
        "email": email,
        "phone_number": phoneNumber,
        "profile_image_url": profileImageUrl,
        "additional_info": additionalInfo,
        "message": message,
      };
}
