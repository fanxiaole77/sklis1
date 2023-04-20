import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cs/Service/http_service.dart';

import '../Service/http_config.dart';

const List<String> list = <String>['路口升序', '路口降序', '红灯时间升序(S)', '红灯时间降序(S)'];

bool a = false;

List<dynamic> data = [];

String dropdownValue = list.first;

class HldPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _HldPageState();
}

class _HldPageState extends State<HldPage>{
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: Text("红绿灯管理系统"),
       leading: Icon(Icons.menu),
       centerTitle: true,
     ),
     body:ListView(
       padding: EdgeInsets.all(10),
       children: [
         hldPage(),
         pxPage(),
       ],
     ),
   );
  }
}
//红绿灯图片切换
class hldPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _hldpageState();
}

class _hldpageState extends State<hldPage>{

  int _currentIndex = 0;
  Timer? _timer;
  List<String> _images = [
    'images/hongdeng.png',
    'images/huangdeng.png',
    'images/lvdeng.png',
  ];

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
   _stopTimer();
    super.dispose();
  }

  void _startTimer(){
    _timer = Timer.periodic(Duration(seconds: 3), (_){
      setState(() {
        _currentIndex = (_currentIndex +1) % _images.length;
      });
    });
  }

  void _stopTimer(){
    _timer?.cancel();
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 200,
        height: 100,
        child: Center(
          child: Image.asset(
            _images[_currentIndex],
            width: 150,
            height: 100,
          ),
        )
    );
  }
}


//排序方式

class pxPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _pxPageState();
}

class _pxPageState extends State<pxPage>{



  @override
  Widget build(BuildContext context) {
   return SizedBox(
     width:MediaQuery.of(context).size.width,
     height: MediaQuery.of(context).size.height,
     child: Column(
       children: [
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceAround,
           children: [
             Text("排序",style: TextStyle(fontSize: 20),),
             DropdownButton(
               items: list.map((String value){
                 return DropdownMenuItem(child: Text(value),value: value);
               }).toList(),
               onChanged: (String? value){
                 setState(() {
                   dropdownValue = value!;
                 });
               },
               value: dropdownValue,
             ),
             ElevatedButton(onPressed: (){
               setState(() {
                 data.sort((a,b){
                   int a1 = int.parse((a["index"] as String));
                   // print("${a1}");
                   int b1 = int.parse((b["index"] as String));
                   int a2 = a["RedTime"];
                   int b2 = b["RedTime"];
                   switch (dropdownValue){
                     case "路口升序":
                       return a1.compareTo(b1);
                     case "路口降序":
                       return b1.compareTo(a1);
                     case "红灯时间升序(S)":
                       return a2.compareTo(b2);
                     case "红灯时间降序(S)":
                       return b2.compareTo(a2);
                     default:
                       return 0;
                   }
                 });
               });
             }, child: Text("搜索")),
           ],
         ),
         Container(
           width: MediaQuery.of(context).size.width,
           height: 20,
           child: Table(
             border: TableBorder.all(),
             children: List.generate(1, (index) => TableRow(
               children: [
                 Text("路口编号"),
                 Text("红灯时长(S)"),
                 Text("绿灯时长(S)"),
                 Text("黄灯时长(S)"),
               ]
             )),
           ),
         ),
         Container(
           width: MediaQuery.of(context).size.width,
           height: 500,
           child: FutureBuilder(
             future: Future.wait([
               post(posthlld,data: {"TrafficLightId":"1","UserName":"user1"}),
               post(posthlld,data: {"TrafficLightId":"2","UserName":"user1"}),
               post(posthlld,data: {"TrafficLightId":"3","UserName":"user1"}),
               post(posthlld,data: {"TrafficLightId":"4","UserName":"user1"}),
               post(posthlld,data: {"TrafficLightId":"5","UserName":"user1"}),
             ]),
             builder: (context, snapshot) {
               if(snapshot.connectionState == ConnectionState.done){
                 if(snapshot.hasData){
                   if(a == false){
                     data = json.decode(snapshot.data.toString());

                     for(int i = 0;i<data.length;i++){
                       data[i]["index"] = "${i+1}";
                     }
                     a = true;
                   }
                   return Table(
                     border: TableBorder.all(),
                     children: List.generate(5, (index) => TableRow(
                         children: [
                           Text("${data[index]['index']}"),
                           Text("${data[index]['RedTime']}"),
                           Text("${data[index]['GreenTime']}"),
                           Text("${data[index]['YellowTime']}"),
                         ]
                     )),
                   );
                 }
               }
               return const Text("1111");
             },
           ),
         )

       ],
     ),
   );
  }
}