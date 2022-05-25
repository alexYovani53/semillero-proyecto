
import 'package:universales_proyecto/model/chanel_model.dart';
import 'package:universales_proyecto/repository/firebase_chanel_api.dart';

class FirebaseChanelRepository {

  final firebaseChanelApi = FirebaseChanelApi();

  Future<void> crearCanal(ChanelModel chat) => firebaseChanelApi.crearCanal(chat);
    
}