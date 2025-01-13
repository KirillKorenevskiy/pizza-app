import 'package:json_annotation/json_annotation.dart';

part 'my_user_entity.g.dart';

@JsonSerializable()
class UserEntity {
  String userId;
  String email;
  String name;
  bool hasActiveCart;

  UserEntity({
    required this.userId,
    required this.email,
    required this.name,
    required this.hasActiveCart,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) => _$MyUserEntityFromJson(json);

  Map<String, dynamic> toJson() => _$MyUserEntityToJson(this);
}
