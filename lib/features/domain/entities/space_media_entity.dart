// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:equatable/equatable.dart';

class SpaceMediaEntity extends Equatable {
  final String description;
  final String mediaType;
  final String title;
  final String mediaUrl;

  SpaceMediaEntity({
    required this.description,
    required this.mediaType,
    required this.title,
    required this.mediaUrl,
  });

  @override
  List<Object?> get props => [
        description,
        mediaType,
        title,
        mediaUrl,
      ];
}
