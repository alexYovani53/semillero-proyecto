
import 'package:flutter/material.dart';
import 'package:universales_proyecto/pages/chat/messagges/message.dart';
import 'package:universales_proyecto/utils/config.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context){
    return Column(
      children: [
        // Spacer(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: ListView.builder(
              itemCount: 100,
              itemBuilder: (context,index) => Message(isSender:false),
            ),
          ),
        ),
        buildInput(context),
      ],
    );
  }

  AppBar buildAppBar(BuildContext context){
    return AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios),
            ),
            CircleAvatar(
              backgroundImage: AssetImage("assets/images/chat.png"),
            ),
            SizedBox(width: kDefaultPadding*0.75,),
            Column(
              children: [
                Text(
                  "Alex Yovani",
                  style: TextStyle(fontSize: 16)
                ),
                Text(
                  "Activo ahora",
                  style: TextStyle(fontSize: 12)
                )
              ],
            )
          ]
        ),
      );
  }

  Widget buildInput(BuildContext context){
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding / 2
      ),
      decoration: BoxDecoration(
        //color:Colors.blue
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            offset: Offset(0,4),
            blurRadius: 32,
            color: Color(0xff087949).withOpacity(0.08)
          )
        ]
      ),
      child: SafeArea(
        child: Row(
          children: [
            SizedBox(width: kDefaultPadding * 2,),
            Expanded(
              child: Container(
                height: 50,
                padding: EdgeInsets.symmetric(
                  horizontal: kDefaultPadding * 0.75
                ),
                decoration: BoxDecoration(
                  color:Colors.red.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Row(
                  children: [
                    Icon(Icons.sentiment_satisfied_outlined),
                    SizedBox(width: kDefaultPadding / 4,),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Type message",
                          border: InputBorder.none
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
