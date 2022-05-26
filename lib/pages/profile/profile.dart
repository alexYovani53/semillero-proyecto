
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:universales_proyecto/bloc/user/user_bloc.dart';
import 'package:universales_proyecto/localizations/localizations.dart';
import 'package:universales_proyecto/pages/editProfile/edit_profile.dart';
import 'package:universales_proyecto/pages/settings/page_setting.dart';
import 'package:universales_proyecto/provider/languaje_provider.dart';
import 'package:universales_proyecto/utils/app_string.dart';
import 'package:universales_proyecto/widget/custo_page_router.dart';
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

  late UserBloc bloc;
  late LocalizationsApp diccionario;

  @override
  Widget build(BuildContext context) {

    bloc = BlocProvider.of<UserBloc>(context);
    

    final languajeProvider = Provider.of<LanguajeProvider>(context);
    diccionario = LocalizationsApp(languajeProvider.getLanguaje);

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
        backgroundImage: getImage(bloc.sesion?.photoURL??""),
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
            bloc.sesion!.name,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w600
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            bloc.sesion!.email,
            style: const TextStyle(
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
      child: InkWell(
        onTap: (){
          // Navigator.push(
          //     context, 
          //     MaterialPageRoute(
          //       builder: (ctx){
          //         return BlocProvider.value(
          //           value: BlocProvider.of<UserBloc>(context),
          //           child: const EditProfile(),
          //         );
          //       }
          //     )
          //   );
          Navigator.push(
              context, 
              CustomPageRoute(
                child: BlocProvider.value(
                  value: BlocProvider.of<UserBloc>(context),
                  child: const EditProfile(),
                )
              )
            );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.settings),
                Divider(height: 48,),
                Text(diccionario.diccionario(Strings.profileConfigButton))
              ],
            ),
            IconButton(onPressed: (){
              
            }, icon: Icon(Icons.arrow_right))
          ],
        ),
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