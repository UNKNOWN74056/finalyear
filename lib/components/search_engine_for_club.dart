import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class clubsearchengine extends StatefulWidget {
  const clubsearchengine({super.key});

  @override
  _clubsearchengineState createState() => _clubsearchengineState();
}

class _clubsearchengineState extends State<clubsearchengine> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: (value) {
            setState(() {
              _searchQuery =
                  value.toLowerCase(); // Convert the search query to lowercase
            });
          },
          decoration: const InputDecoration(
            hintText: 'Search...',
            hintStyle: TextStyle(color: Colors.black),
          ),
          cursorHeight: 25.0,
          cursorColor: Colors.black,
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('clubs').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          // Perform a case-insensitive search and filter results based on the searchQuery
          final filteredDocs = snapshot.data!.docs
              .where((document) =>
                  document['Clubname'].toLowerCase().contains(_searchQuery))
              .toList();

          return ListView.builder(
            itemCount: filteredDocs.length,
            itemBuilder: (BuildContext context, int index) {
              final document = filteredDocs[index];
              return GestureDetector(
                onTap: () {
                  // Handle the tap on the club item.
                },
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(document['Clubimage']),
                  ),
                  title: Text(document['Clubname']),
                  subtitle: Text(document['Email']),
                  trailing: const Icon(FontAwesomeIcons.arrowRight),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
