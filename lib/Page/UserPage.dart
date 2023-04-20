import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_cs/Service/http_config.dart';
import 'package:flutter_cs/Service/http_service.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: FutureBuilder(
       future: Future.wait([
         post(postUser,data: {"UserName":"user1"})
       ]),
       builder: (context, snapshot) {
         if(snapshot.connectionState == ConnectionState.done){
           if(snapshot.hasData){
             var data = json.decode(snapshot.data.toString());

             List<Map> postuser = (data[0]['ROWS_DETAIL'] as List).cast();

             return ListView(
               padding: EdgeInsets.all(10),
               children: [
                 user(newsListView: postuser),
               ],
             );
           }
         }
         return Text("11111");
       },
     ),
    );
  }
}

class user extends StatefulWidget {

  final List newsListView;
  user({Key? key,required this.newsListView}):super(key: key);

  @override
  _userState createState() => _userState(newsListView);
}

class _userState extends State<user> {
  final List newsListView;
  _userState(this.newsListView);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 1500,
      child: Column(
        children: [
          _newsList(context),
        ],
      ),
    );
  }
  Widget _newsList(BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: ListView.builder(itemCount: newsListView.length,itemBuilder: (context, index) {

        return _item(index, context);
      },
      ),
    );
  }
  Widget _item(index, context) {
    return Slidable(
      key: UniqueKey(),
      actionPane: SlidableBehindActionPane(),
      // actions: [],
      secondaryActions: [
        IconSlideAction(
          caption: '删除',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () {
            setState(() {
              newsListView.removeAt(index);
            });
          },
        ),
        IconSlideAction(
          caption: '收藏',
          color: Colors.green,
          icon: Icons.mark_email_read_outlined,
          onTap: () {},
        ),
      ],
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(width: 0.5, color: Colors.black),
          ),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 300,
              height: 60,
              child: Column(
                children: [
                  Text("${newsListView[index]["pname"]}"),
                  Text("${newsListView[index]["ptel"]}"),
                  Text("${newsListView[index]["pcardid"]}"),
                ],
              ),
            ),
           ElevatedButton(onPressed: (){}, child: Text("详情")),
          ],
        ),
      ),
    );
  }



}

