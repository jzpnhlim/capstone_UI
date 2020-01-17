import 'package:flutter/material.dart';
import 'screen.dart';
void main() {
   // print('heelo');
    runApp(RetinaApp());
}

const firstPage = '/';
const secondPage = '/second';
const thirdPage = '/third';

// styles
const AppBarTxtSize = 26.0;
const BoxTxtSize = 20.0;

const String Fontstyle = 'Montserrat';

const appBarStyle = TextStyle(
  fontFamily: Fontstyle,
  fontWeight: FontWeight.w900,
  fontSize: AppBarTxtSize,
  color: Colors.white,
);

const txtStyle = TextStyle(
  fontFamily: Fontstyle,
  fontWeight: FontWeight.w600,
  fontSize: BoxTxtSize,
  color: Colors.grey,
);

const longAppBarStyle = TextStyle(
  fontFamily: Fontstyle,
  fontWeight: FontWeight.w900,
  fontSize: 15,
  color: Colors.white,
);
class RetinaApp extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: _route(),
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Colors.orange,
          textTheme: TextTheme(title: appBarStyle),
        ),
        textTheme: TextTheme(title: txtStyle),
      ),
    );
  }

  RouteFactory _route(){
    return (settings){
      final Map<String, dynamic> arguments = settings.arguments;
      Widget screen;
      switch(settings.name){
        case firstPage:
          screen = HomeScreen();
          break;
        case secondPage:
          screen = SecondScreen(arguments['id']);
          break;
        case thirdPage:
          screen = ThirdScreen(arguments['roomid']);
          break;
        default:
          return null;
      }
      return MaterialPageRoute(builder: (BuildContext context) => screen);
    };
  }
}

