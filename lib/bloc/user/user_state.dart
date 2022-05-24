

part of 'user_bloc.dart';

abstract class UserState extends Equatable{
 @override
  List<Object?> get props =>[];
}
class UserInitState extends UserState{}

class UserProfileState extends UserState{}
class UserSettingsState extends UserState{}
class UserEditState extends UserState{}
class UserChatState extends UserState{}

class UserActualizacionState extends UserState{}

class UserErrorState extends UserState{}
