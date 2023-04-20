import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cs/Page/WzContent.dart';
import 'package:flutter_cs/main.dart';
// import 'package:video_player/video_player.dart';

class WzPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _WzPageSate();

}

class _WzPageSate extends State<WzPage> with SingleTickerProviderStateMixin{

   // late VideoPlayerController _controller;

  List<String> _images = [
    'images/weizhang1.jpg',
    'images/weizhang2.jpg',
    'images/weizhang3.jpg',
    'images/weizhang4.jpg',
    'images/weizhang01.png',
    'images/weizhang02.png',
    'images/weizhang03.png',
    'images/weizhang04.png',
  ];

  // @override
  // void initState() {
  //   // _controller = VideoPlayerController.asset("images/car2.mp4")
  //   ..initialize().then((_){
  //     setState(() {
  //
  //     });
  //   });
  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  //   _controller.dispose();
  // }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: Text("车辆违章"),
       centerTitle: true,
       leading: Icon(Icons.menu),
     ),
     body: ListView(
       children: [
         DefaultTabController(
             length: 2,
             child:Container(
               width:MediaQuery.of(context).size.width,
               height: 1000,
               child: Column(
                 mainAxisSize: MainAxisSize.max,
                 children: [
                   Container(
                     width: MediaQuery.of(context).size.width,
                     height: 55,
                     child: TabBar(
                       tabs:[
                         Text("违规视频"),
                         Text("违规图片"),
                       ],
                       labelColor: Colors.blue,
                       unselectedLabelColor: Colors.grey,
                       // isScrollable: true,
                     ),
                   ),
                   Container(
                     width: MediaQuery.of(context).size.width,
                     height: 800,
                     child: TabBarView(
                       children: [
                         Text("data"),
                     // Center(
                     // child: _controller.value.isInitialized
                     //   ? AspectRatio(
                     //   aspectRatio: _controller.value.aspectRatio,
                     //   child: VideoPlayer(_controller),
                     // ): const CircularProgressIndicator(),),
                         GridView.builder(
                           shrinkWrap: true,
                           physics: NeverScrollableScrollPhysics(),
                           itemCount: 8,
                           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                               crossAxisCount: 2
                           ),
                           itemBuilder: (BuildContext context,int index){
                             return _item1(index, context);
                           },
                         ),
                       ],
                     ),
                   )
                 ],
               ),
             )
         )
       ],
     ),
   );
  }
  Widget _item1(index,context){
    return InkWell(
      onTap: (){
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => wzcotnett(image:_images[index])),
        );
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 0.5,color: Colors.grey)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(_images[index],width: 130,height: 150,fit: BoxFit.fill,),
            Text("违章图片${index + 1}"),
          ],
        ),
      ),
    );
  }


}

