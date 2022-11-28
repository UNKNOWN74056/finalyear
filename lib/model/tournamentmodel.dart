class tournamentmodel {
  final String avater;
  final String name;
  final String name2;

  tournamentmodel(
      {required this.avater, required this.name, required this.name2});
}

List<tournamentmodel> tourdata = [
  tournamentmodel(avater: "", name: "Karachi", name2: "Peshawar"),
  tournamentmodel(avater: "", name: "Islamabad", name2: "Lahore"),
  tournamentmodel(avater: "", name: "Lahore", name2: "Multan"),
  tournamentmodel(avater: "", name: "Peshawar", name2: "Karachi"),
  tournamentmodel(avater: "", name: "Multan", name2: "Lahore"),
  tournamentmodel(avater: "", name: "Islamabad", name2: "Karachi"),
  tournamentmodel(avater: "", name: "Peshawar", name2: "Lahore"),
];
