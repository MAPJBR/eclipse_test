// ignore_for_file: public_member_api_docs, sort_constructors_first



import 'dart:convert';






class PictureModel {
  final String date;
  final String title;
  final String explanation;
  final String url;

  final String mediaType;
  
  final String serviceVersion;

  final String? thumbnailUrl;
 
  final String? hdurl;
  final String? copyright;

  const PictureModel(
    this.date,
    this.title,
    this.explanation,
    this.url,
    this.mediaType,
    this.serviceVersion,
    this.thumbnailUrl,
    this.hdurl,
    this.copyright,
  );
  
 


    


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'date': date,
      'title': title,
      'explanation': explanation,
      'url': url,
      'media_type': mediaType,
      'service_version': serviceVersion,
      'thumbnail_url': thumbnailUrl,
      'hdurl': hdurl,
      'copyright': copyright,
    };
  }

  factory PictureModel.fromMap(Map<String, dynamic> map) {
    return PictureModel(
      map['date'] as String,
      map['title'] as String,
      map['explanation'] as String,
      map['url'] as String,
      map['media_type'] as String,
      map['service_version'] as String,
      map['thumbnail_url'] != null ? map['thumbnail_url'] as String : null,
      map['hdurl'] != null ? map['hdurl'] as String : null,
      map['copyright'] != null ? map['copyright'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PictureModel.fromJson(String source) => PictureModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PictureModel(date: $date, title: $title, explanation: $explanation, url: $url, media_type: $mediaType, service_version: $serviceVersion, thumbnail_url: $thumbnailUrl, hdurl: $hdurl, copyright: $copyright)';
  }

  @override
  bool operator ==(covariant PictureModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.date == date &&
      other.title == title &&
      other.explanation == explanation &&
      other.url == url &&
      other.mediaType == mediaType &&
      other.serviceVersion == serviceVersion &&
      other.thumbnailUrl == thumbnailUrl &&
      other.hdurl == hdurl &&
      other.copyright == copyright;
  }

  @override
  int get hashCode {
    return date.hashCode ^
      title.hashCode ^
      explanation.hashCode ^
      url.hashCode ^
      mediaType.hashCode ^
      serviceVersion.hashCode ^
      thumbnailUrl.hashCode ^
      hdurl.hashCode ^
      copyright.hashCode;
  }
}
