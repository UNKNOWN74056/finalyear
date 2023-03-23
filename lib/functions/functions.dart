import 'package:finalyear/AS%20A%20PLAYER/internationalsports/tabbar/Football.dart';
import 'package:finalyear/GETX/clubdatafirebase.dart';
import 'package:get/get.dart';

import '../GETX/getdatafromfirebase.dart';

class refreshdata {
  //controller
  final usercontroller = Get.put(FetchDataFirebase());
  //refresh function for the users
  void refresh_user_data() async {
    await Future.delayed(Duration(seconds: 2));
    usercontroller.GetDataFirebase();
  }

  // controller
  final clubcontroller = Get.put(Getclubdata());
  //refresh function fir the club data
  void refresh_club_data() async {
    await Future.delayed(Duration(seconds: 2));
    clubcontroller.Getclubdatafirebase();
  }
}

var functions = new refreshdata();
