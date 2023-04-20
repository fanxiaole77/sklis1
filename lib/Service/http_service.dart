import 'package:dio/dio.dart';

Future post(url,{data,Map<String,dynamic>?query}) async{
  try{
    Response response;
    Dio dio =Dio();
    response = await dio.post(url,data: data,queryParameters: query);
    return response;
  }catch(e){
    return null;
  }
}