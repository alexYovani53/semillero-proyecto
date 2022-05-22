
import 'package:flutter/material.dart';
import 'package:universales_proyecto/widget/navigation_drawer_custom.dart';

class Profile extends StatelessWidget {
  
  Profile({Key? key}) : super(key: key);


  double coverHeight = 280;
  double profileHeight = 144;

  @override
  Widget build(BuildContext context) {

    final top = coverHeight - profileHeight/2;
    return Scaffold(
      appBar: AppBar(
        
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      drawer: NavigationDrawerCustom(),
      body: Stack(
        clipBehavior:Clip.none,
        alignment: Alignment.center,
        children: [
          background(),
          Positioned(
            top: top,
            child: profileImage()
          ),
        ],
      ),
    );
  }

  Widget background(){
    return Container(
      color:Colors.grey,
      child: Image.asset(
        "assets/images/profile_background.jpg",
        width: double.infinity,
        height: coverHeight,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget profileImage(){
    return CircleAvatar(
      radius: profileHeight/2,
      backgroundColor: Colors.grey.shade800,
      backgroundImage: getImage(""),
    );
  }

  ImageProvider? getImage(photoUrl){
    if(photoUrl != ""){
      return NetworkImage(photoUrl);
    }else{
      return const AssetImage("assets/images/setting.png");
    }
  }
}