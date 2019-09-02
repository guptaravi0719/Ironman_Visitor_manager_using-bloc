import 'package:flutter/material.dart';
import 'package:visitor_management/visitor/exit_section/Lists/couriers_list.dart';

import 'Lists/AllList.dart';
import 'Lists/DayPassList.dart';
import 'Lists/lead_list.dart';
import 'Lists/vendors_list.dart';
import 'Lists/visitors_list.dart';

class AdminScreenTabs extends StatefulWidget {
  @override
  _AdminScreenTabsState createState() => _AdminScreenTabsState();
}

class _AdminScreenTabsState extends State<AdminScreenTabs> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Exit",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(30.0),
            child: TabBar(

              unselectedLabelColor: Colors.white.withOpacity(0.3),
              indicatorColor: Colors.white,
              isScrollable: true,
              tabs: [
                Tab(
                  child: Text("Visitor",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20.0),),
                ),
                Tab(
                  child: Text("Vendors",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20.0),),
                ),

                Tab(
                  child: Text("91 Lead",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20.0),),
                ),
                Tab(
                  child: Text("Couriers",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20.0),),
                ),

                Tab(
                  child: Text("DayPass",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20.0),),
                ),
                //   Tab(child: Text("All"),),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            VisitorsList(),
            VendorsList(),
            LeadList(),
            CouriersList(),
            DayPassList(),
            //    AllList()
          ],
        ),
      ),
    );
  }
}
