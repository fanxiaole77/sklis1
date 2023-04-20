import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cs/Page/EtcPage.dart';
import 'package:flutter_cs/Page/HldPage.dart';
import 'package:flutter_cs/Page/KqPage.dart';
import 'package:flutter_cs/Page/UserPage.dart';
import 'package:flutter_cs/Page/WzPage.dart';

class IndexPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("交通管理系统"),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
           DrawerHeader(
               child: Text("交通管理系统"),
             decoration: BoxDecoration(
               color: Colors.blue,
             ),
           ),
            ListTile(
              title:Text("红绿灯管理系统"),
              leading: Icon(Icons.traffic_outlined),
              onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>HldPage()));},
            ),
            ListTile(
              title:Text("车辆违规系统"),
              leading: Icon(Icons.directions_car),
              onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>WzPage()));},
            ),
            ListTile(
              title:Text("ETC账户信息"),
              leading: Icon(Icons.print),
              onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>EtcPage()));},
            ),
            ListTile(
              title:Text("路况查询"),
              leading: Icon(Icons.ac_unit),
              onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>KqPage()));},
            ),
            ListTile(
              title:Text("用户信息"),
              leading: Icon(Icons.account_circle),
              onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>UserPage()));},
            ),
          ],
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>HldPage()));}, child: Text("红绿灯管里系统")),
            ElevatedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>WzPage()));}, child: Text("车辆违规系统")),
          ],
        ),
      ),
    );
  }

}