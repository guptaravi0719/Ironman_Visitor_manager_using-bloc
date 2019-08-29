import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rating_bar/rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:meet_network_image/meet_network_image.dart';

class VendorsList extends StatefulWidget {
  @override
  _VendorsListState createState() => _VendorsListState();
}

class _VendorsListState extends State<VendorsList> {
  var _stream;
  DocumentSnapshot _currentDocument;
  final db = Firestore.instance;
  @override
  void initState() {
    _stream = Firestore.instance
        .collection(
            "locations/okhla/people/${DateFormat("dd-MM-yyyy").format(now)}/vendors")
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
                itemCount: snapshot.data.documents.length,
                itemBuilder: (BuildContext context, int i) {
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
                                          ? "https://random.dog/3f62f2c1-e0cb-4077-8cd9-1ca76bfe98d5.jpg"
                                          : snapshot.data.documents[i]['url'],
                                      loadingBuilder: (context) => Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                      errorBuilder: (context, e) => Center(
                                        child: Text('Error appear!'),
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
                                          filledColor: Colors.green,
                                          emptyColor: Colors.redAccent,
                                          halfFilledColor: Colors.amberAccent,
                                          size: 30,
                                        ),
                                        RaisedButton(
                                          child: Text("EXIT"),
                                          onPressed: () {
                                            try {
                                              Firestore.instance
                                                  .collection(
                                                      'locations/okhla/people/${DateFormat("dd-MM-yyyy").format(now)}/vendors')
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
