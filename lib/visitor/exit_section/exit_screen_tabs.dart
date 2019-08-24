import 'package:flutter/material.dart';
import 'package:visitor_management/visitor/exit_section/Lists/couriers_list.dart';

import 'Lists/AllList.dart';
import 'Lists/DayPassList.dart';
import 'Lists/lead_list.dart';
import 'Lists/vendors_list.dart';
import 'Lists/visitors_list.dart';
class ExitScreenTabs extends StatefulWidget {
  @override
  _ExitScreenTabsState createState() => _ExitScreenTabsState();
}

class _ExitScreenTabsState extends State<ExitScreenTabs> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(

        appBar: AppBar(

          title:Text("Exit",style: TextStyle(color: Colors.white),),
          centerTitle: true,
          bottom: TabBar(
          tabs: [
            Tab(child: Text("Visitor"),),
            Tab(icon: Icon(Icons.directions_transit,color: Colors.white,)),

            Tab(icon: Icon(Icons.directions_car,color: Colors.white,)),
            Tab(icon: Icon(Icons.directions_transit,color: Colors.white,)),

            Tab(icon: Icon(Icons.directions_car,color: Colors.white,)),
            Tab(icon: Icon(Icons.directions_transit,color: Colors.white,)),
          ],
        ),
        ),
        body:  TabBarView(
          children: [
            VisitorsList(),
            VendorsList(),
            LeadList(),
            CouriersList(),
            DayPassList(),
            AllList()


          ],
        ),
      ),
    );
  }
}
