
import 'package:flutter/material.dart';
import 'package:universales_proyecto/widget/navigation_drawer_custom.dart';

class Profile extends StatefulWidget {
  
  Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  double coverHeight = 280;

  double profileHeight = 144;

  bool _expanded = false;
  int _index = 0;

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    final top = coverHeight - profileHeight/2;
    return Scaffold(
      key: _scaffoldKey,
      drawer: NavigationDrawerCustom(),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
      floatingActionButton: FloatingActionButton(        
        child: const Icon(Icons.menu),
        onPressed: (){
          _scaffoldKey.currentState!.openDrawer();
        },
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Stack(
            clipBehavior:Clip.none,
            alignment: Alignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: profileHeight/2),
                child: background()
              ),
              Positioned(
                top: top,
                child: profileImage(),
              ),
            ],
          ),
          profileInfo(),
          configuration(context),
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
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      child: CircleAvatar(
        radius: (profileHeight/2)-10,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        backgroundImage: getImage("https://scontent-gua1-1.xx.fbcdn.net/v/t39.30808-6/270011001_4394168207379141_2498431562754588565_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=aEUaXWH4Zx8AX_zd0cH&_nc_ht=scontent-gua1-1.xx&oh=00_AT-4Oo8_66LMCtK5UPevejHgJjImBxkgbJCjOzdSWrCMlQ&oe=628DDD34"),
      )
      ,
    );
  }

  Widget profileInfo(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "hola",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w600
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "aleyovani53@gmail.com",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w300
            ),
          )
        ],
      ),
    );
  }

  Widget configuracion(){
    return Container(
      child: ExpansionPanelList(
      animationDuration: Duration(milliseconds: 200),
      children: [
        ExpansionPanel(
            headerBuilder: (context, isExpanded) {
              return configuration(context);
            },
            body: steper(),
          isExpanded: _expanded,
          backgroundColor: Colors.transparent,
          canTapOnHeader: true,
        ),
      ],
      expansionCallback: (panelIndex, isExpanded) {
        _expanded = !_expanded;
        setState(() {
          
        });
      },

      ),
     );
  }  

  Widget steper(){
    return  Stepper(
      currentStep: _index,
      onStepCancel: () {
        if (_index > 0) {
          setState(() {
            _index -= 1;
          });
        }
      },
      onStepContinue: () {
        if (_index <= 0) {
          setState(() {
            _index += 1;
          });
        }
      },
      onStepTapped: (int index) {
        setState(() {
          _index = index;
        });
      },
      steps: <Step>[
        Step(
          title: const Text('Step 1 title'),
          content: Container(
              alignment: Alignment.centerLeft,
              child: const Text('Content for Step 1')),
        ),
        const Step(
          title: Text('Step 2 title'),
          content: Text('Content for Step 2'),
        ),
      ],
    );
  }

  Widget configuration(context) {
    return Container(
      height: 50,
      padding: EdgeInsets.symmetric(horizontal: 15),
      margin: EdgeInsets.only(
        bottom: 20, top: 20,
        left: 50, right:50
      ),
      decoration: BoxDecoration(
        color: Colors.grey.shade400,
        borderRadius: BorderRadius.circular(50)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.settings),
              Divider(height: 48,),
              Text("Configurar perfil")
            ],
          ),
          IconButton(onPressed: (){}, icon: Icon(Icons.arrow_right))
        ],
      ),
    );
  }

  ImageProvider? getImage(photoUrl){
    if(photoUrl != ""){
      return NetworkImage(photoUrl);
    }else{
      return const AssetImage("assets/images/iconoFacebook.png");
    }
  }
}