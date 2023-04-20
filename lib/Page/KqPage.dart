import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_cs/Service/http_config.dart';
import 'package:flutter_cs/Service/http_service.dart';

class KqPage extends StatefulWidget {
  const KqPage({Key? key}) : super(key: key);

  @override
  _KqPageState createState() => _KqPageState();
}

class _KqPageState extends State<KqPage> {
  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text("路况查询"),
      centerTitle: true,
      leading: Icon(Icons.menu),
    ),
    body: ListView(
      padding: EdgeInsets.all(10),
      children: [
        Text("室外空气指数",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
        SizedBox(height: 20,),
        pmPage(),
        SizedBox(height: 20,),
        DlPage(),
      ],
    ),
  );
  }
}


class pmPage extends StatefulWidget {
  const pmPage({Key? key}) : super(key: key);

  @override
  _pmPageState createState() => _pmPageState();
}

class _pmPageState extends State<pmPage> {
  
  String pm = "";
  String wd = "";
  String sd = "";

  @override
  void initState() {
    super.initState();
    post(postPm,data: {"UserName":"user1"})
        .then((value){
      var data = json.decode(value.toString());
      if(data["RESULT"] == "S"){
        setState(() {
          pm = "${data["pm2.5"]}";
          wd = "${data["temperature"]}";
          sd = "${data["humidity"]}";
        });
      }
    });
    Timer.periodic(Duration(seconds: 3), (timer) {
     post(postPm,data: {"UserName":"user1"})
         .then((value){
           var data = json.decode(value.toString());
           if(data["RESULT"] == "S"){
             setState(() {
               pm = "${data["pm2.5"]}";
               wd = "${data["temperature"]}";
               sd = "${data["humidity"]}";
             });
           }
     });
    },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text("PM2.5"),
            SizedBox(width: 20,),
            Text("$pm"),
          ],
        ),
        SizedBox(height: 10,),
        Row(
          children: [
            Text("温度"),
            SizedBox(width: 20,),
            Text("$wd"),
          ],
        ),
        SizedBox(height: 10,),
        Row(
          children: [
            Text("湿度"),
            SizedBox(width: 20,),
            Text("$sd"),
          ],
        ),
      ],
    );
  }
}

class DlPage extends StatefulWidget {
  const DlPage({Key? key}) : super(key: key);
  @override
  _DlPageState createState() => _DlPageState();
}

class _DlPageState extends State<DlPage> {

  String one = "";
  int ba1 = 0xffffffff;

  String two = "";
  int ba2 = 0xffffffff;

  String three = "";
  int ba3 = 0xffffffff;

  @override
  void initState() {
    super.initState();
    var dl = Future.wait([
      post(postDl,data: {"RoadId":"1","UserName":"user1"}),
      post(postDl,data: {"RoadId":"2","UserName":"user1"}),
      post(postDl,data: {"RoadId":"3","UserName":"user1"}),
    ]);
    dl.then((value){
      var data = json.decode(value.toString());

      if(data[0]["RESULT"] == "S"){

        setState(() {
          switch (data[0]["Status"]){
            case 1:one = "流畅";
            break;
            case 2:one = "较流畅";
            break;
            case 3:one = "拥挤";
            break;
            case 4:one = "堵塞";
            break;
            case 5:one = "爆表";
            break;
          }

          switch (data[0]["Status"]){
            case 1:ba1 = 0xff0ebd12;
            break;
            case 2:ba1 = 0xff98ed1f;
            break;
            case 3:ba1 = 0xffffff01;
            break;
            case 4:ba1 = 0xffff0103;
            break;
            case 5:ba1 = 0xff4c060e;
            break;
          }
        });
      };
      if(data[1]["RESULT"] == "S"){

        setState(() {
          switch (data[1]["Status"]){
            case 1:two = "流畅";
            break;
            case 2:two = "较流畅";
            break;
            case 3:two = "拥挤";
            break;
            case 4:two = "堵塞";
            break;
            case 5:two = "爆表";
            break;
          }

          switch (data[1]["Status"]){
            case 1:ba2 = 0xff0ebd12;
            break;
            case 2:ba2 = 0xff98ed1f;
            break;
            case 3:ba2 = 0xffffff01;
            break;
            case 4:ba2 = 0xffff0103;
            break;
            case 5:ba2 = 0xff4c060e;
            break;
          }
        });
      };
      if(data[2]["RESULT"] == "S"){

        setState(() {
          switch (data[2]["Status"]){
            case 1:three = "流畅";
            break;
            case 2:three = "较流畅";
            break;
            case 3:three = "拥挤";
            break;
            case 4:three = "堵塞";
            break;
            case 5:three = "爆表";
            break;
          }

          switch (data[2]["Status"]){
            case 1:ba3 = 0xff0ebd12;
            break;
            case 2:ba3 = 0xff98ed1f;
            break;
            case 3:ba3 = 0xffffff01;
            break;
            case 4:ba3 = 0xffff0103;
            break;
            case 5:ba3 = 0xff4c060e;
            break;
          }
        });
      };

    });
    Timer.periodic(Duration(seconds: 3), (timer) {
     var dl = Future.wait([
        post(postDl,data: {"RoadId":"1","UserName":"user1"}),
        post(postDl,data: {"RoadId":"2","UserName":"user1"}),
        post(postDl,data: {"RoadId":"3","UserName":"user1"}),
      ]);
     dl.then((value){
       var data = json.decode(value.toString());

       if(data[0]["RESULT"] == "S"){
         setState(() {
           switch (data[0]["Status"]){
             case 1:
               one = "流畅";
               ba1 = 0xff0ebd12;
             break;
             case 2:
               one = "较流畅";
               ba1 = 0xff98ed1f;
             break;
             case 3:
               one = "拥挤";
               ba1 = 0xffffff01;
             break;
             case 4:
               one = "堵塞";
               ba1 = 0xffff0103;
             break;
             case 5:
               one = "爆表";
               ba1 = 0xff4c060e;
             break;
           }

         });
       };
       if(data[1]["RESULT"] == "S"){

         setState(() {
           switch (data[1]["Status"]){
             case 1:
               two = "流畅";
               ba2 = 0xff0ebd12;
               break;
             case 2:
               two = "较流畅";
               ba2 = 0xff98ed1f;
               break;
             case 3:
               two = "拥挤";
               ba2 = 0xffffff01;
               break;
             case 4:
               two = "堵塞";
               ba2 = 0xffff0103;
               break;
             case 5:
               two = "爆表";
               ba2 = 0xff4c060e;
               break;
           }

         });
       };
       if(data[2]["RESULT"] == "S"){
         setState(() {
           switch (data[2]["Status"]){
             case 1:
               three = "流畅";
               ba3 = 0xff0ebd12;
               break;
             case 2:
               three = "较流畅";
               ba3 = 0xff98ed1f;
               break;
             case 3:
               three = "拥挤";
               ba3 = 0xffffff01;
               break;
             case 4:
               three = "堵塞";
               ba3 = 0xffff0103;
               break;
             case 5:
               three = "爆表";
               ba3 = 0xff4c060e;
               break;
           }

         });
       };
     });
    },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Text("$one"),
            Container(
              width: 60,
              height: 20,
              color: Color(ba1),
            )
          ],
        ),
        Column(
          children: [
            Text("$two"),
            Container(
              width: 60,
              height: 20,
              color: Color(ba2),
            )
          ],
        ),
        Column(
          children: [
            Text("$three"),
            Container(
              width: 60,
              height: 20,
              color: Color(ba3),
            )
          ],
        ),
      ],
    );
  }
}


