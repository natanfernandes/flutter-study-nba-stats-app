import 'dart:convert';


class Team {
  final int id;
  final String abbreviation;
  final String city;
  final String conference;
  final String division;
  final String fullName;
  final String name;


  Team({this.id, this.abbreviation, this.city, this.conference, this.division, this.fullName,this.name});

  factory Team.fromJson(Map<String, dynamic> json) {
    return new Team(
      id: json['id'],
      abbreviation: json['abbreviation'],
      city: json['city'],
      conference: json['conference'],
      division: json['division'],
      fullName: json['full_name'],
      name: json['name']
    );
  }

}