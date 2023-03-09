import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../../AS A PLAYER/internationalsports/Details/clubdetail.dart';
import '../../../AS A PLAYER/internationalsports/dashboard/home.dart';
import '../../../GETX/clubdatafirebase.dart';

class interclub extends StatefulWidget {
  const interclub({super.key});

  @override
  State<interclub> createState() => _interclubState();
}

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
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              actions: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: IconButton(
                      onPressed: () {
                        showSearch(
                            context: context, delegate: CustomSearchDelegate());
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
                  itemCount: 4,
                ),
              ),
              centerTitle: true,
            )
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
    );
  }
}
