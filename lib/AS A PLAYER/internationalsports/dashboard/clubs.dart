import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalyear/AS%20A%20PLAYER/internationalsports/Details/clubdetail.dart';
import 'package:finalyear/AS%20A%20PLAYER/internationalsports/dashboard/home.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class clubs extends StatefulWidget {
  const clubs({super.key});

  @override
  State<clubs> createState() => _clubsState();
}

navigatetodetail(DocumentSnapshot post) {
  Get.to(clubdetail(post: post));
}

class _clubsState extends State<clubs> {
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
            // flexibleSpace: FlexibleSpaceBar(
            //     background: Image.asset(
            //   "assets/mixsport.jpeg",
            //   fit: BoxFit.cover,
            // )),
            centerTitle: true,
          )
        ],
        body: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('clubs').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    shrinkWrap: true,
                    itemBuilder: (context, i) {
                      var data = snapshot.data!.docs[i];
                      return Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Card(
                              color: Colors.grey.shade300,
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    color: Color.fromARGB(255, 25, 9, 117),
                                    width: 1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ListTile(
                                  title: Text(data["Clubname"],
                                      style: const TextStyle(fontSize: 20)),
                                  leading: CircleAvatar(
                                      radius: 35,
                                      backgroundImage:
                                          NetworkImage(data['Clubimage']),
                                      backgroundColor: Colors.white),
                                  subtitle: Text(data["Location"],
                                      style: const TextStyle(fontSize: 15)),
                                  trailing: const Icon(
                                    FontAwesomeIcons.arrowRight,
                                  ),
                                  onTap: () => navigatetodetail(data))),
                        ],
                      );
                    });
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
    ));
  }
}
