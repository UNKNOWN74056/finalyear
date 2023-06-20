import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BasketballMatchesPage extends StatefulWidget {
  @override
  _BasketballMatchesPageState createState() => _BasketballMatchesPageState();
}

class _BasketballMatchesPageState extends State<BasketballMatchesPage> {
  List<dynamic> matches = [];
  bool isLoading = true;

  Future<void> fetchMatches(int leagueId) async {
    setState(() {
      isLoading = true;
    });

    final response = await http.get(
      Uri.parse(
          'https://api-basketball.p.rapidapi.com/games?league=${leagueId.toString()}'),
      headers: {
        'X-RapidAPI-Host': 'v3.basketball.api-sports.io',
        'X-RapidAPI-Key': '140ee45a666a430ce41bcc2943253b1e',
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        matches = jsonDecode(response.body)['response'];
        isLoading = false;
      });
    } else {
      print('Failed to fetch matches. Error: ${response.statusCode}');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchMatches(123); // Replace 123 with the desired league ID
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basketball Matches'),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: matches.length,
              itemBuilder: (context, index) {
                final match = matches[index];

                final countryName = match['league']['country']['name'];
                final homeTeamName = match['teams']['home']['name'];
                final awayTeamName = match['teams']['away']['name'];
                final homeTeamScore = match['scores']['home'];
                final awayTeamScore = match['scores']['away'];

                return Card(
                  child: ListTile(
                    title: Text(
                      '$countryName - $homeTeamName vs. $awayTeamName',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'Score: $homeTeamScore - $awayTeamScore',
                    ),
                  ),
                );
              },
            ),
    );
  }
}
