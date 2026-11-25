import 'package:flutter/material.dart';

enum RoomPreference { single, double, family }

class RoomType {
  RoomType({
    required this.preference,
    required this.name,
    required this.icon,
    required this.description,
    required this.assetPath,
    required this.rateLabel,
    this.isExpanded = false,
  });

  final RoomPreference preference;
  final String name;
  final IconData icon;
  final String description;
  final String assetPath;
  final String rateLabel;
  bool isExpanded;
}

List<RoomType> buildRooms(RoomPreference preferred) {
  return [
    RoomType(
      preference: RoomPreference.single,
      name: 'Single Room',
      icon: Icons.single_bed,
      description: 'One guest, serene Gangnam city view, oak-accented sanctuary. RM 120 per night.',
      assetPath: 'assets/images/single.jpg',
      rateLabel: 'RM 120 / night',
      isExpanded: preferred == RoomPreference.single,
    ),
    RoomType(
      preference: RoomPreference.double,
      name: 'Double Room',
      icon: Icons.bed,
      description: 'Two guests, floor-to-ceiling skyline glass, spa bath & lounge. RM 180 per night.',
      assetPath: 'assets/images/double.jpg',
      rateLabel: 'RM 180 / night',
      isExpanded: preferred == RoomPreference.double,
    ),
    RoomType(
      preference: RoomPreference.family,
      name: 'Family Room',
      icon: Icons.family_restroom,
      description: 'Four guests, expansive suite layout, dining salon & panoramic view. RM 260 per night.',
      assetPath: 'assets/images/family.jpg',
      rateLabel: 'RM 260 / night',
      isExpanded: preferred == RoomPreference.family,
    ),
  ];
}
