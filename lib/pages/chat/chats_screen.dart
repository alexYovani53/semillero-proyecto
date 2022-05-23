
import 'package:flutter/material.dart';
import 'package:universales_proyecto/pages/chat/chat_card.dart';
import 'package:universales_proyecto/pages/chat/messagges/message_screen.dart';
import 'package:universales_proyecto/utils/config.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {

  
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Column(
        children: [
          Container(
            color: Colors.blue,
            child: Row(
              children: [
                Text("hola")
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
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (value){
          setState(() {
            _selectedIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.messenger_sharp),label: "h"),
          BottomNavigationBarItem(icon: Icon(Icons.messenger_sharp),label: "hs")
        ]
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title:Text("Chats"),
      actions: [
        IconButton(onPressed: (){}, icon: Icon(Icons.search))
      ],
    );
  }
}
