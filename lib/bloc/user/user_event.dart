


part of 'user_bloc.dart';

abstract class UserEvent extends Equatable{
 @override
  List<Object?> get props =>[];
}

class UserEventPageSettings extends UserEvent{}
class UserEventPageProfile extends UserEvent{}
class UserEventPageEdit extends UserEvent{}
class UserEventPageChat extends UserEvent{}




class UserEventCarcarData extends UserEvent {  
 @override
  List<Object?> get props =>[];
}

class UserEventLoginEmailPass extends UserEvent{
  String correo;
  String password;
  UserEventLoginEmailPass({
    required this.correo,
    required this.password
  }); 
 @override
  List<Object?> get props =>[correo,password];
}


class UserEventCreateAcount extends UserEvent{
  String correo;
  String password;
  UserEventCreateAcount({
    required this.correo,
    required this.password
  });  
 @override
  List<Object?> get props =>[correo,password];
}

class userEventLogOut extends UserEvent {
 @override
  List<Object?> get props =>[];
}

class userEventLoginGoogle extends UserEvent{
 @override
  List<Object?> get props =>[];

}

class userEventLoginFacebook extends UserEvent{
 @override
  List<Object?> get props =>[];  
}

class userEventUpdateProfile extends UserEvent{
  String? usuario;
  String? password;
  userEventUpdateProfile({
    this.usuario,
    this.password
  });
  @override
  List<Object?> get props =>[usuario,password];  
}