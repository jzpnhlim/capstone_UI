import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle,WhitelistingTextInputFormatter;
import 'dart:convert';
import 'dart:async' show Future;
import 'package:retina_app/system_text.dart';
import 'main.dart';
import 'json_valhalla.dart';
import 'package:flutter_tts/flutter_tts.dart';


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
        label: Text("               WASHROOM  GO                ",
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
    Future<List<Maneuver>> loadJsonAsset() async{
      var jsonTxt = await rootBundle.loadString('assets/json_examples/valhalla_output.json');
      Map<String, dynamic> jsonResponse = json.decode(jsonTxt);
      ValhallaOutput valData = ValhallaOutput.fromJson(jsonResponse);
      Trip trip = valData.trip;
      List<Leg> legs = trip.legs;
      return legs[0].maneuvers;

    }


  Widget jsonDisplay(){
//    Future _speak(String text) async{
//      await flutterTts.speak(text);
//    }

    return FutureBuilder(
      builder: (context,jsonSnap) {
        if (jsonSnap.data == null) {
          return Container(
            child: Text('loading ..'),
          );

        } else {

          return ListView.builder(
              itemCount: jsonSnap.data.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  child: BoxTxt(jsonSnap.data[index].instruction),
                  onTap: (){},

                );
              });
        }

      },
      future: loadJsonAsset(),
    );
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('ROUTE TO ' + roomDetail(widget._roomid)),
        textTheme: TextTheme(title: longAppBarStyle),
      ),

      body: jsonDisplay(),

    );
  }
}

