

part of 'user_bloc.dart';

abstract class UserState extends Equatable{
 @override
  List<Object?> get props =>[];
}
class UserInitState extends UserState{}

class UserPageProfileState extends UserState{}
class UserPageSettingsState extends UserState{}
class UserPageEditState extends UserState{}
class UserPageChatState extends UserState{}

class UserActualizacionState extends UserState{}

class UserErrorState extends UserState{}
