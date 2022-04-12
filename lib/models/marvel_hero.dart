import 'dart:developer';

class MarvelHero {
  final String name;
  final String realName;
  final String team;
  final String firstAppearance;
  final String createdBy;
  final String publisher;
  final String imageUrl;
  final String bio;

  MarvelHero({
    required this.name,
    required this.realName,
    required this.team,
    required this.firstAppearance,
    required this.createdBy,
    required this.publisher,
    required this.imageUrl,
    required this.bio,
  });

  MarvelHero.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        realName = json['realname'],
        team = json['team'],
        firstAppearance = json['firstappearance'],
        createdBy = json['createdby'],
        publisher = json['publisher'],
        imageUrl = json['imageurl'],
        bio = json['bio'];
}
