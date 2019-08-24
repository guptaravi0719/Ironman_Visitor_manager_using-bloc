import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
class VisitorsList extends StatefulWidget {
  @override
  _VisitorsListState createState() => _VisitorsListState();
}

class _VisitorsListState extends State<VisitorsList> {
  var _stream;
  DocumentSnapshot _currentDocument;
  final db = Firestore.instance;
  @override
  void initState() {
    _stream=Firestore.instance.collection("locations/okhla/people/${DateFormat("dd-MM-yyyy").format(now)}/visitors").snapshots();
    super.initState();
  }
//  List _visitorList=List();
  var now= new DateTime.now();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: StreamBuilder(

        stream: _stream,
        builder: (context,snapshot){

          if(!snapshot.hasData){
          return Center(child: CircularProgressIndicator(),);

          }
          if(snapshot.hasData) {

//            for(int ind=0;ind<snapshot.data.documents.length;ind++){
//              if(snapshot.data.documents[ind]['exit']==null)
//                _visitorList.add(snapshot.data.documents[ind]);
//
//            }
            return ListView.builder(
//              itemCount: snapshot.data.documents.length,
                itemCount: snapshot.data.documents.length,
                itemBuilder: (BuildContext context, int i) {
                  return snapshot.data.documents[i]['exit']==null?Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height / 3,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            SizedBox(child: Image.network(
                                "https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height / 4 - 30,
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width / 4,)
                            ,

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(key: UniqueKey(),
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[

                                  Row(children: <Widget>[
                                    Text("Name:    ", style: TextStyle(
                                        fontWeight: FontWeight.bold),),
                                    Text(snapshot.data.documents[i]['name'])
                                  ],),
                                  SizedBox(height: 5.0,),

                                  Row(children: <Widget>[
                                    Text("meeting to:    ", style: TextStyle(
                                        fontWeight: FontWeight.bold),),
                                    Text(snapshot.data.documents[i]['person_to_meet'])
                                  ],),
                                  SizedBox(height: 5.0,),

                                  Row(children: <Widget>[
                                    Text("Mobile:    ", style: TextStyle(
                                        fontWeight: FontWeight.bold),),
                                    Text(snapshot.data.documents[i]['phone no'])
                                  ],)
                                  ,
                                  SizedBox(height: 5.0,),

                                  Row(children: <Widget>[
                                    Text("Time:    ", style: TextStyle(
                                        fontWeight: FontWeight.bold),),
                                    Text(snapshot.data.documents[i]['time'])
                                  ],),
                                  SizedBox(height: 5.0,),


                                  RaisedButton(child: Text("EXIT"),
                                    onPressed: () {
                                    try {
                                      Firestore.instance
                                          .collection('locations/okhla/people/${DateFormat("dd-MM-yyyy").format(now)}/visitors')
                                          .document(
                                          snapshot.data.documents[i].documentID)
                                          .updateData({
                                        'exit': '${DateFormat("H:m:s").format(
                                            now)}'
                                      });

                                    }catch(e){
                                      print("ERROR UPDATING\n ERROR UPDATING");

                                    }
//db.collection("locations/okhla/people/${DateFormat("dd-MM-yyyy").format(now)}/Vendor").document('${snapshot.data.documents[i]}');
                                    },

                                  )
                                ],),
                            )
                          ],

                        ),
                      ),

                    ),
                  ):Container();
                }

            );
          }

        },


      ),

    );
  }
}
