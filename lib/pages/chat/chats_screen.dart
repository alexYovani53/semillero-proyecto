
import 'package:flutter/material.dart';
import 'package:universales_proyecto/pages/chat/chat_card.dart';
import 'package:universales_proyecto/pages/chat/group/group_page.dart';
import 'package:universales_proyecto/pages/chat/messagges/message_screen.dart';
import 'package:universales_proyecto/utils/config.dart';
import 'package:universales_proyecto/widget/navigation_drawer_custom.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {

  
  int _selectedIndex = 0;
  PageController page = PageController(initialPage: 0);
  int pageIndex = 0;


  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
      appBar: buildAppBar(),
      drawer: NavigationDrawerCustom(),
      body: PageView(
        controller: page,
        pageSnapping: false,
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
      title:Text("Chats"),
      actions: [
        IconButton(onPressed: (){}, icon: Icon(Icons.search))
      ],
    );
  }

  Widget buildViewMessages(){
    return  Column(
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
            itemCount: 4,
            itemBuilder: (context,index)=>ChatCard(
              press:()=>Navigator.push(context, MaterialPageRoute(builder: (context) => MessageScreen())
            )),
        ))
      ],
    );
  }
}
