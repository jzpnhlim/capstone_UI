

import 'package:flutter/material.dart';


const officeRoom = ['102','113','135'];
const washRoom = ['116','166','145','175'];
const lectureRoom = ['111',
  '114','115','117','136','167','154',
  '105','104','103'
];
List<String> roomlist=officeRoom+washRoom+lectureRoom;
class BoxTxt  extends StatelessWidget {
  final String _txt;

  BoxTxt(this._txt);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
      //constraints: BoxConstraints.expand(height:55.0),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color:Colors.grey),

      ),
      child: Text(_txt,style: Theme.of(context).textTheme.title),
    );
  }
}

class BoxImage extends StatelessWidget {
  final String _imagepath;
  BoxImage(this._imagepath);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(height: 200.0),
      decoration: BoxDecoration(color: Colors.grey),
      child: Image.asset(_imagepath, fit:BoxFit.cover),
    );
  }
}
String roomDetail(String roomID){
  if(washRoom.contains(roomID)){
    return 'WASHROOM';
  }
  else if(officeRoom.contains(roomID)){
    switch(roomID){
      case '124': return "124-SOMEONE'S OFFICE";
  }
  }
  return roomID;
  }



class RoomNumGet{
  final int id;
  final String roomtype;
  static const washroomId = 1;
  static const lectureId = 2;
  static const officeId = 3;
  final List roomNum;


  RoomNumGet(this.id, this.roomtype,this.roomNum);

  static List<RoomNumGet> fetchAll(){
    return [
      RoomNumGet(1,'WASHROOM',washRoom),
      RoomNumGet(2,'LECTURE ROOM',lectureRoom),
      RoomNumGet(3,'OFFICE ROOM',officeRoom)
    ];

  }
  static RoomNumGet fetchbyID(int typeID){
    List<RoomNumGet> types = RoomNumGet.fetchAll();
    for(var i =0;i< types.length; i++){
      if(types[i].id == typeID){
        return types[i];
      }
    }
    return null;
  }
}