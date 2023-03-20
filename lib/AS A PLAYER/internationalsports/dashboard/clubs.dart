import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalyear/AS%20A%20PLAYER/internationalsports/Details/clubdetail.dart';
import 'package:finalyear/AS%20A%20PLAYER/internationalsports/dashboard/home.dart';
import 'package:finalyear/AS%20A%20PLAYER/internationalsports/statsandvideos/transferform.dart';
import 'package:finalyear/GETX/clubdatafirebase.dart';
import 'package:finalyear/GETX/getdatafromfirebase.dart';
import 'package:finalyear/model/clubsModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class clubs extends StatefulWidget {
  const clubs({super.key});

  @override
  State<clubs> createState() => _clubsState();
}

class _clubsState extends State<clubs> {
  var images = [
    'assets/club1.jpg',
    'assets/club2.jpg',
    'assets/club3.jpg',
    'assets/club4.jpg',
    'assets/club5.jpg',
    'assets/club6.jpg',
  ];
  final clubcontroller = Get.put(Getclubdata());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: () async {
            await clubcontroller.Getclubdatafirebase();
          },
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverAppBar(
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: IconButton(
                          onPressed: () {
                            showSearch(
                                context: context,
                                delegate: CustomSearchDelegate());
                          },
                          icon: const Icon(Icons.search)),
                    ),
                  ],
                  expandedHeight: 200,
                  pinned: true,
                  floating: true,
                  snap: true,
                  title: const Text(
                    "Clubs",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    background: Swiper(
                      autoplay: true,
                      itemBuilder: (BuildContext context, int index) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image(
                            image: AssetImage(images[index]),
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                      itemCount: 6,
                    ),
                    centerTitle: true,
                  ))
            ],
            body: GetBuilder(
                init: Getclubdata(),
                builder: (clubcontroller) {
                  return Column(
                    children: clubcontroller.clublist
                        .map(
                          (element) => Card(
                              color: Colors.grey.shade300,
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    color: Color.fromARGB(255, 25, 9, 117),
                                    width: 1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ListTile(
                                  title: Text(element.clubname,
                                      style: const TextStyle(fontSize: 20)),
                                  leading: CircleAvatar(
                                      radius: 35,
                                      backgroundImage:
                                          NetworkImage(element.clubimage),
                                      backgroundColor: Colors.white),
                                  subtitle: Text(element.location,
                                      style: const TextStyle(fontSize: 15)),
                                  trailing: const Icon(
                                    FontAwesomeIcons.arrowRight,
                                  ),
                                  onTap: () =>
                                      Get.to(clubdetail(post: element)))),
                        )
                        .toList(),
                  );
                }),
          ),
        ),
      ),
    );
  }
}
