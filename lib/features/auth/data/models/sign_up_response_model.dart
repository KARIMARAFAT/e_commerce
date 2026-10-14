import 'package:ecommerce_app_huma_volve/features/auth/domain/entities/sign_up_response_entity.dart';

class SignUpResponseModel extends SignUpEntity {
  SignUpResponseModel({
    super.id,
    super.email,
    super.password,
    super.name,
    super.role,
    super.avatar,
    super.creationAt,
    super.updatedAt,
  });
  SignUpResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    password = json['password'];
    name = json['name'];
    role = json['role'];
    avatar = json['avatar'];
    creationAt = json['creationAt'];
    updatedAt = json['updatedAt'];
  }
}
