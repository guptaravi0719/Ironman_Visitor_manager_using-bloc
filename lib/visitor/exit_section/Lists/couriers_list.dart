import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meet_network_image/meet_network_image.dart';
import 'package:rating_bar/rating_bar.dart';
import 'package:visitor_management/settings/location.dart';

class CouriersList extends StatefulWidget {
  @override
  _CouriersListState createState() => _CouriersListState();
}

class _CouriersListState extends State<CouriersList> {
  var _stream;
  DocumentSnapshot _currentDocument;
  final db = Firestore.instance;
  @override
  void initState() {
    _stream = Firestore.instance
        .collection(
            "locations/$location/people/${DateFormat("dd-MM-yyyy").format(now)}/couriers")
        .snapshots();
    super.initState();
  }

//  List _visitorList=List();
  var now = new DateTime.now();
  @override
  Widget build(BuildContext context) {
    double _rating = 0.0;
    return Scaffold(
      body: StreamBuilder(
        stream: _stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
//            for(int ind=0;ind<snapshot.data.documents.length;ind++){
//              if(snapshot.data.documents[ind]['exit']==null)
//                _visitorList.add(snapshot.data.documents[ind]);
//
//            }
            return ListView.builder(

//              itemCount: snapshot.data.documents.length,
                itemCount: snapshot.data.documents.length,
                itemBuilder: (BuildContext context, int i) {
                  // var url="https://cdn.pixabay.com/photo/2015/03/04/22/35/head-659652_960_720.png";
                  // if(snapshot.data.documents[i]['url']!=null){
                  //   setState(() {
                  //     url=snapshot.data.documents[i]['url'];
                  //   });
                  // }
                  return snapshot.data.documents[i]['exit'] == null
                      ? Container(
                          height: MediaQuery.of(context).size.height / 3,
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: <Widget>[
                                  SizedBox(
                                    child: MeetNetworkImage(
                                      imageUrl: snapshot.data.documents[i]
                                                  ['url'] ==
                                              null
                                          ? "http://mobileinternationalfestival.org/wp-content/uploads/2017/07/dummy-man-570x570.png"
                                          : snapshot.data.documents[i]['url'],
                                      loadingBuilder: (context) => Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                      errorBuilder: (context, e) => Center(
                                      child: Image.asset('assets/person_dummy.png'),
                                      ),
                                    ),
                                    height:
                                        MediaQuery.of(context).size.height / 4 -
                                            30,
                                    width:
                                        MediaQuery.of(context).size.width / 4,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      key: UniqueKey(),
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Text(
                                              "Name:    ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(snapshot.data.documents[i]
                                                ['name'])
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Text(
                                              "meeting to:    ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(snapshot.data.documents[i]
                                                ['person_to_meet'])
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Text(
                                              "No. of Guests:    ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(snapshot.data.documents[i]
                                            ['no_of_guests']),

                                          ],
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Text(
                                              "Mobile:    ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(snapshot.data.documents[i]
                                                ['phone no'])
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Text(
                                              "Time:    ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(snapshot.data.documents[i]
                                                ['time'])
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        RatingBar(
                                          onRatingChanged: (rating) =>
                                              _rating = rating,
                                          filledIcon: Icons.star,
                                          emptyIcon: Icons.star_border,
                                          halfFilledIcon: Icons.star_half,
                                          isHalfAllowed: true,
                                          filledColor: Theme.of(context).primaryColor,
                                          emptyColor: Theme.of(context).primaryColor,
                                          halfFilledColor: Colors.amberAccent,
                                          size: 30,
                                        ),
                                        RaisedButton(
                                          shape: new RoundedRectangleBorder(
                                            borderRadius: new BorderRadius.circular(30.0),
                                          ),
                                          color: Theme.of(context).primaryColor,
                                          child: Text("EXIT"),
                                          onPressed: () {
                                            try {
                                              Firestore.instance
                                                  .collection(
                                                      'locations/$location/people/${DateFormat("dd-MM-yyyy").format(now)}/couriers')
                                                  .document(snapshot.data
                                                      .documents[i].documentID)
                                                  .updateData({
                                                'exit':
                                                    '${DateFormat("H:m:s").format(now)}',
                                                'rating': '$_rating'
                                              });
                                            } catch (e) {
                                              print(
                                                  "ERROR UPDATING\n ERROR UPDATING");
                                            }
//db.collection("locations/okhla/people/${DateFormat("dd-MM-yyyy").format(now)}/Vendor").document('${snapshot.data.documents[i]}');
                                          },
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      : Container();
                });
          }
        },
      ),
    );
  }
}
