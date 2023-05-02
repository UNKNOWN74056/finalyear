import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class clubsearchengine extends StatefulWidget {
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
              _searchQuery = value;
            });
          },
          decoration: const InputDecoration(
            hintText: 'Search...',
            hintStyle: TextStyle(color: Colors.white),
          ),
          cursorHeight: 25.0,
          cursorColor: Colors.black,
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('clubs')
            .where('Clubname', isGreaterThanOrEqualTo: _searchQuery)
            .where('Clubname', isLessThanOrEqualTo: _searchQuery + '\uf8ff')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              final document = snapshot.data!.docs[index];
              return GestureDetector(
                onTap: () {},
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
