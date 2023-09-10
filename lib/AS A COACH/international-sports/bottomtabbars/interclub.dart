import 'package:finalyear/AS%20A%20COACH/details_page/club_detail_page.dart';
import 'package:finalyear/wedgets/search_engine_for_club.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:get/get.dart';
import '../../../GETX/clubdatafirebase.dart';
import '../../../wedgets/data/Club-Data-Card.dart';

class interclub extends StatefulWidget {
  const interclub({super.key});

  @override
  State<interclub> createState() => _interclubState();
}

//getx controller
final clubcontroller = Get.put(Getclubdata());

//swiper images
var images = [
  'assets/club1.jpg',
  'assets/club2.jpg',
  'assets/club3.jpg',
  'assets/club4.jpg',
  'assets/club5.jpg',
  'assets/club6.jpg',
];

class _interclubState extends State<interclub> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: () async {
            clubcontroller.Getclubdatafirebase();
          },
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverAppBar(
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: IconButton(
                        onPressed: () {
                          Get.to(clubsearchengine());
                        },
                        icon: const Icon(
                          Icons.search,
                          color: Colors.white,
                        )),
                  ),
                ],
                automaticallyImplyLeading: false,
                expandedHeight: 200,
                pinned: true,
                floating: true,
                snap: true,
                title: const Text(
                  "CLUBS",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
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
                    itemCount: 4,
                  ),
                ),
              )
            ],
            body: GetBuilder(
                init: Getclubdata(),
                builder: (clubcontroller) {
                  return Obx(
                    () => SingleChildScrollView(
                      child: Column(
                        children: clubcontroller.clublist
                            .map((element) => ClubCard(
                                  clubname: element.clubname,
                                  clubimage: element.clubimage,
                                  location: element.location,
                                  onTap: () =>
                                      Get.to(club_detail_page(post: element)),
                                ))
                            .toList(),
                      ),
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}
