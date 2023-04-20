import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cs/Service/http_config.dart';
import 'package:flutter_cs/Service/http_service.dart';


const List<String> car = <String>['1', '2', '3', '4'];
const List<String> money = <String>['50', '100', '150', '200'];
const List<String> car2 = <String>['1', '2', '3', '4'];

bool a = false;
bool b = false;
bool c = false;

//
String dropdownValue = car.first;
String dropdownValue1 = money.first;
String dropdownValue2 = car2.first;
String btn = dropdownValue2;

Map<String,dynamic> data = {};

List<dynamic> data1 = [];



class EtcPage extends StatefulWidget {
  const EtcPage({Key? key}) : super(key: key);

  @override
  _EtcPageState createState() => _EtcPageState();
}

class _EtcPageState extends State<EtcPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ETC账户"),
        leading: Icon(Icons.menu),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Text("ETC账户信息",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          SizedBox(height: 10,),
          EtcUserPage(),
          SizedBox(height: 10,),
          Text("查询充值记录",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          SizedBox(width: 10,),
          EtcLs(),
        ],
      ),
    );
  }
}

class EtcUserPage extends StatefulWidget {
  const EtcUserPage({Key? key}) : super(key: key);

  @override
  _EtcUserPageState createState() => _EtcUserPageState();
}

class _EtcUserPageState extends State<EtcUserPage> {

  String money1 = "";

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 120,
      child: Column(
        children: [
          Row(
            children: [
              Text("账户余额",style: TextStyle(fontSize: 16),),
              SizedBox(width: 20,),
              Text("$money1元",style: TextStyle(fontSize: 16)),
            ],
          ),
          Row(
            children: [
              Text("车  号",style: TextStyle(fontSize: 16)),
              SizedBox(width: 40,),
              SizedBox(
                width: 100,
                child: DropdownButton(
                  items: car.map((String value){
                    return DropdownMenuItem(child: Text(value),value: value,);
                  }).toList(),
                  onChanged: (String? value){
                    setState(() {
                      dropdownValue = value!;
                    });
                  },
                  isExpanded: true,
                  value: dropdownValue,
                ),
              ),
              SizedBox(width: 40,),
              SizedBox(height: 30,child: ElevatedButton(onPressed: (){
                post(postEtcGetMoney,data: {"CarId":"$dropdownValue","UserName":"user1"})
                    .then((value){
                      var data = json.decode(value.toString());
                      if(data["RESULT"] == "S"){
                        setState(() {
                          money1 = "${data["Balance"]}";
                          a = true;
                          Timer(const Duration(seconds: 2),(){
                           setState(() {
                             a = false;
                           });
                         });
                        });
                      }
                });
              }, child: Text("查询")),),
              SizedBox(width: 20,),
              Visibility(visible:a,child: Text("查询完成",style: TextStyle(color: Colors.red),),)
            ],
          ),
          Row(
            children: [
              Text("充值余额",style: TextStyle(fontSize: 16),),
              SizedBox(width: 20,),
              SizedBox(
                width: 100,
                child: DropdownButton(
                  items: money.map((String value){
                    return DropdownMenuItem(child: Text(value),value: value,);
                  }).toList(),
                  onChanged: (String? value){
                    setState(() {
                      dropdownValue1 = value!;
                    });
                  },
                  isExpanded: true,
                  value: dropdownValue1,
                ),
              ),
              SizedBox(width: 35,),
              SizedBox(height: 30,child: ElevatedButton(
                  onPressed: (){
                    post(postEtcSetMoney,data: {"CarId":"$dropdownValue","Money":"$dropdownValue1","UserName":"user1"})
                        .then((value){
                      var data = json.decode(value.toString());
                      if(data["RESULT"] == "S"){
                        setState(() {
                          b = true;
                          Timer(const Duration(seconds: 2),(){
                            setState(() {
                              b = false;
                            });
                          });
                        });
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(primary: Colors.white,
                      side: BorderSide(color: Colors.blue,width: 1)),
                  child: Text("充值",style: TextStyle(color: Colors.blue),)),),
              SizedBox(width: 20,),
              Visibility(visible: b,child: Text("充值成功"))
            ],
          ),
        ],
      ),
    );
  }
}

class EtcLs extends StatefulWidget {
  const EtcLs({Key? key}) : super(key: key);

  @override
  _EtcLsState createState() => _EtcLsState();
}

class _EtcLsState extends State<EtcLs> {
  int _part = 1;
  int _partGroupValue = 1;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 500,
      child: Column(
        children: [
          Row(
            children: [
              Text("车           号",style: TextStyle(fontSize: 16),),
              SizedBox(width: 40,),
              SizedBox(
                width: 100,
                child: DropdownButton(
                  items: car2.map((String value){
                    return DropdownMenuItem(child: Text(value),value: value,);
                  }).toList(),
                  onChanged: (String? value){
                    setState(() {
                      dropdownValue2 = value!;
                    });
                  },
                  isExpanded: true,
                  value: dropdownValue2,
                ),
              )
            ],
          ),
          Row(
            children: [
              Text("排序方式",style: TextStyle(fontSize:16),),
              SizedBox(width: 40,),
              Radio(
                  value: 1,
                  groupValue: _part,
                  onChanged: (value) {
                    debugPrint(value.toString());
                    setState(() {
                      this._part = 1;
                    });
                  },
              ),
              Text("时间降序"),
              Radio(
                value: 2,
                groupValue: _part,
                onChanged: (value) {
                  debugPrint(value.toString());
                  setState(() {
                    this._part = 2;
                  });
                },
              ),
              Text("时间升序"),
            ],
          ),
          Row(
            children: [
              Text("查询方式",style: TextStyle(fontSize: 16),),
              SizedBox(width: 40,),
              SizedBox(height: 30,child: ElevatedButton(onPressed: (){
                setState(() {
                  btn = dropdownValue2;
                });
              }, child: Text("查询")),)
            ],
          ),
          Row(
            children: [
              Container(
                width: 370,
                height: 20,
                child: Table(
                  border: TableBorder.all(),
                  children: List.generate(1, (index) =>TableRow(
                    children: [
                      Text("序号"),
                      Text("车号"),
                      Text("充值金额"),
                      Text("操作人"),
                      Text("充值时间"),
                    ],
                  )),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                width: 370,
                height: 300,
                child: FutureBuilder(
                  future: Future.wait([
                    post(postGetCar,data: {"UserName":"user1","CarId":"$btn"})
                  ]),
                  builder: (context, snapshot) {
                    if(snapshot.connectionState == ConnectionState.done){
                      if(snapshot.hasData){
                        print(json.decode(snapshot.data![0].toString()));
                        data = json.decode(snapshot.data![0].toString());
                        data1 = data["ROWS_DETAIL"] as List;
                        print("$data");

                        for(int i =0; i<data1.length;i++){
                          data1[i]["index"] = "${i+1}";
                        }
                        return Table(
                          border: TableBorder.all(),
                          columnWidths: {
                            0:FixedColumnWidth(10),
                            1:FixedColumnWidth(20),
                            2:FixedColumnWidth(20),
                            3:FixedColumnWidth(20),
                            4:FixedColumnWidth(20),
                          },
                          children: List.generate(data1.length, (index) => TableRow(
                            children: [
                              Text("${data1[index]["index"]}"),
                              Text("${data1[index]["CarId"]}"),
                              Text("${data1[index]["Cost"]}"),
                              Text("admin1"),
                              Text("${data1[index]["Time"]}"),
                            ]
                          )),
                        );
                      }
                    }
                    return Text("!1111");
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
