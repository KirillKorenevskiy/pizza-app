import 'package:domain/domain.dart';

import '../../data.dart';

class UserMapper{

  static MyUser fromEntity(MyUserEntity entity){
    return MyUser(
      userId: entity.userId, 
      email: entity.email, 
      name: entity.name, 
      hasActiveCart: entity.hasActiveCart,
    );
  }

  static MyUserEntity toEntity(MyUser model){
    return MyUserEntity(
      userId: model.userId, 
      email: model.email, 
      name: model.name, 
      hasActiveCart: model.hasActiveCart,
    );
  }
}