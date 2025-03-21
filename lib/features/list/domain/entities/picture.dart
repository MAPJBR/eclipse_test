import 'package:equatable/equatable.dart';

import '../../data/models/picture_model.dart';


class Picture extends Equatable {
  final String date;
  final String title;
  final String explanation;
  final String url;
  final String mediaType;
  final String? thumbnailUrl;
  final String? hdImageUrl;

  const Picture(
    this.date,
    this.title,
    this.explanation,
    this.url,
    this.mediaType,
    this.thumbnailUrl,
    this.hdImageUrl,
  );

  String get featuredImageUrl => thumbnailUrl ?? hdImageUrl!;

  @override
  List<Object?> get props => [
        date,
        title,
        explanation,
        url,
        mediaType,
        thumbnailUrl,
        hdImageUrl,
      ];
}

extension XPictureModel on PictureModel {
  Picture toEntity() => Picture(
        date,
        title,
        explanation,
        url,
        mediaType,
        thumbnailUrl,
        hdurl,
      );
}
