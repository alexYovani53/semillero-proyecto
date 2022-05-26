
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:universales_proyecto/bloc/canal/canal_bloc.dart';
import 'package:universales_proyecto/bloc/user/user_bloc.dart';
import 'package:universales_proyecto/localizations/localizations.dart';
import 'package:universales_proyecto/pages/chat/chat_card.dart';
import 'package:universales_proyecto/pages/chat/group/group_page.dart';
import 'package:universales_proyecto/pages/chat/messagges/message_screen.dart';
import 'package:universales_proyecto/provider/languaje_provider.dart';
import 'package:universales_proyecto/utils/app_string.dart';
import 'package:universales_proyecto/utils/config.dart';
import 'package:universales_proyecto/widget/navigation_drawer_custom.dart';
import 'package:universales_proyecto/widget/splash_screen.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {

  
  int _selectedIndex = 0;
  PageController page = PageController(initialPage: 0);
  int pageIndex = 0;

  late UserBloc bloc;
  late LocalizationsApp diccionario;

  List<String> canales = [];

  @override
  Widget build(BuildContext context) {
    
    bloc = BlocProvider.of<UserBloc>(context);
    
    final languajeProvider = Provider.of<LanguajeProvider>(context);
    diccionario = LocalizationsApp(languajeProvider.getLanguaje);

    return Scaffold(
      appBar: buildAppBar(),
      drawer: NavigationDrawerCustom(),
      body: PageView(
        controller: page,
        pageSnapping: false,
        onPageChanged: (valor){
          setState(() {
            _selectedIndex = valor;
          });
        },
        children: [
          buildViewMessages(),
          GroupPage()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (value){
          setState(() {
            _selectedIndex = value;
          });
          page.animateToPage(value, duration: Duration(milliseconds: 400), curve: Curves.linearToEaseOut);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.messenger_sharp),label: "Canales"),
          BottomNavigationBarItem(icon: Icon(Icons.group),label: "Agregar")
        ]
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      //automaticallyImplyLeading: false,
      title:Text(
        diccionario.diccionario(Strings.chatsTitle)
      ),
      actions: [
        IconButton(onPressed: (){}, icon: Icon(Icons.search))
      ],
    );
  }

  Widget buildViewMessages(){
    return  BlocProvider(
      create: (context) => CanalBloc(),
      child: BlocListener<CanalBloc,CanalState>(
        listener: (context, state) {
          switch (state.runtimeType) {
            case  CanalInitState:
              break;
            default:
          }
        },
        child: BlocBuilder<CanalBloc,CanalState>(
          builder: (context, state) {
            return StreamBuilder(
              stream: BlocProvider.of<CanalBloc>(context).streamCanalesUser(bloc.sesion!.uid).onValue,
              builder: (context, AsyncSnapshot  snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.active:
                  case ConnectionState.done:
                    if(!snapshot.hasData || snapshot.hasError ){
                      return const SplashScree();
                    }else{

                      final data = snapshot.data.snapshot.value;
                      Map<dynamic,dynamic> canalesRecived = json.decode(json.encode(data)); 

                      canalesRecived.forEach((key, value) {
                        if(canales.where((element) => element == key).isEmpty){
                          canales.add(key);
                        }
                      });

                      return crearLista();                     
                    }
                  default:
                    return crearLista();
                }
              },
            );            
          },
        ),
      ),
    );
  }

  Widget crearLista(){
    return Column(
      children: [
        Container(
          color: kPrimaryColor,
          child: Row(
            children: [
              //Text("hola")
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: canales.length,
            itemBuilder: (context,index)=>
            ChatCard(
              uidUser: bloc.sesion!.uid,
              idCanal: canales[index],
              press:(){}
            ),
        ))
      ],
    );
  }
}
