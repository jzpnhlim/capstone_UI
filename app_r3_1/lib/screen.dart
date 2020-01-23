import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show WhitelistingTextInputFormatter;

import 'package:retina_app/system_text.dart';
import 'main.dart';
import 'json_valhalla.dart';
import 'package:flutter_tts/flutter_tts.dart';


String url;

pageToSecond(BuildContext context, int roomPageID){
  Navigator.pushNamed(context, secondPage,arguments: {'id': roomPageID});
}

pageToThird(BuildContext context, String roomSelected) {
  Navigator.pushNamed(context, thirdPage,arguments: {'roomid': roomSelected} );
}
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {

    final types = RoomNumGet.fetchAll();
    return Scaffold(
      appBar: AppBar(
        title: Text('ITB ROUTE'),
        leading:
          IconButton(
            icon:Icon(Icons.search),
            onPressed: ()=>showSearch(context: context, delegate: DataSearch()),
          ),

      ),

      body: ListView(

        children: [
          _searchBox(),
        ]..addAll(types.map((type)=>GestureDetector(
          child: BoxTxt(type.roomtype),
          onTap: ()=> pageToSecond(context, type.id)
        )).toList()),
      ),
      floatingActionButton:FloatingActionButton.extended(
        onPressed: ()=>pageToThird(context, (washRoom).first),
        label: Text("         WASHROOM  GO           ",
            style: Theme.of(context).textTheme.title,),
        backgroundColor: Colors.amber,
      ),
    );


  }
  _searchBox(){
    TextEditingController _searchboxcontrol = new TextEditingController();
    return TextField(
          controller: _searchboxcontrol,
          keyboardType: TextInputType.number,
          inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
          style: Theme.of(context).textTheme.title,
          decoration: InputDecoration(
              hintText: 'Quick Search... ',hintStyle: Theme.of(context).textTheme.title,
              suffixIcon:InkWell(
                  onTap: (){
                    if(roomlist.contains(_searchboxcontrol.text)){
                      pageToThird(context, _searchboxcontrol.text);
                    }
                    _searchboxcontrol.clear();
                  },
                  child:Icon(Icons.arrow_forward),

      ),

          )
    );
  }

}

class DataSearch extends SearchDelegate{
  final recentrooms = ['147','137','156'];
  String roomSec;
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon:Icon(Icons.clear),
        onPressed: (){
        query = "";
        close(context, null);
      },)

    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow, progress:transitionAnimation),
      onPressed: (){
      close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggList = query.isEmpty ? recentrooms :
    roomlist.where((p) => p.contains(query)).toList();

    return ListView.builder(
      itemBuilder: (context,index)=> ListTile(
        onTap : ()=>pageToThird(context, suggList[index]),
        title: BoxTxt(suggList[index]),
    ),
    itemCount: suggList.length,
    );
  }

}

class SecondScreen extends StatelessWidget {
  final int _typeid;

  SecondScreen(this._typeid);
  @override
  Widget build(BuildContext context) {
    final type = RoomNumGet.fetchbyID(_typeid);
    return Scaffold(
      appBar: AppBar(
        title: Text(type.roomtype),
      ),

      body: ListView(
        children: type.roomNum.map((roomn) => GestureDetector(
          child: BoxTxt(roomn),
          onTap: ()=> pageToThird(context,roomn),
        )).toList(),
      ),
    );
  }

}


class ThirdScreen extends StatefulWidget {
  final _roomid;

  ThirdScreen(this._roomid);

  @override
  _ThirdScreenState createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  final FlutterTts flutterTts = FlutterTts();
  var i,j;
  List<String> k = ["You are at ROOM 113.",
    "Walk north on the walkway for less than 10 meters. Then Turn left onto the walkway.",
    "Turn left onto the walkway. Then Turn right onto the walkway.",
    "Turn right onto the walkway. Then You will arrive at your destination."
        "You have arrived at your destination."];
  Future<List<Maneuver>> mans;
  String _assetloc = 'assets/json_examples/valhalla_output_113-102.json';

  @override
  void initState(){
    super.initState();
    mans = loadJsonAsset(_assetloc);
  }

  Widget jsonDisplay(){
//    Future _speak(String text) async{
//      await flutterTts.speak(text);
//    }
    return FutureBuilder(
      builder: (context,jsonSnap) {

        if (jsonSnap.data == null) {
          return Container(
            child: BoxTxt('loading ..'),
          );

        } else {
          return ListView.builder(
              itemCount: jsonSnap.data.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  child: BoxTxt("${jsonSnap.data[index].instruction} for ${(jsonSnap.data[index].length*1000).toString()} meters"),
                  onTap: (){
//                    final snackBar = SnackBar(content: Text(k[j]));
//                    j=j+1;
//                    Scaffold.of(context).showSnackBar(snackBar);
                  },

                );
              });
        }

      },
      future: mans,
    );
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('ROUTE TO ' + roomDetail(widget._roomid)),
//        leading: IconButton(
//          icon:Icon(Icons.account_box),
//          onPressed: (){
//            final snackBar = SnackBar(content: Text(k[j]));
//            j=j+1;
//            Scaffold.of(context).showSnackBar(snackBar);
//          },
//        ),
        textTheme: TextTheme(title: longAppBarStyle),

      ),

      body: jsonDisplay(),

//      floatingActionButton:FloatingActionButton.extended(
//      onPressed: (){
//          if(j<i)i++;
//
//      },
//      label: Text(k[i].instruction,
//      style: Theme.of(context).textTheme.title,),
//      backgroundColor: Colors.amber,
//
//    )
    );
  }
}

