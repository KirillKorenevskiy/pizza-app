import 'package:domain/domain.dart';

import '../../data.dart';

class UserMapper{
  static MyUser fromEntity(UserEntity entity){
    return MyUser(
      userId: entity.userId, 
      email: entity.email, 
      name: entity.name, 
      hasActiveCart: entity.hasActiveCart,
    );
  }

  static UserEntity toEntity(MyUser model){
    return UserEntity(
      userId: model.userId, 
      email: model.email, 
      name: model.name, 
      hasActiveCart: model.hasActiveCart,
    );
  }
}
