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
                  child: Text("Visitor"),
                ),
                Tab(
                  child: Text("Vendors"),
                ),

                Tab(
                  child: Text("91 Lead"),
                ),
                Tab(
                  child: Text("Couriers"),
                ),

                Tab(
                  child: Text("DayPass"),
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
