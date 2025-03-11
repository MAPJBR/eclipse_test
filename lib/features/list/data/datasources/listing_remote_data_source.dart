import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:teste_to_eclipse/core/device/network_info.dart';
import 'package:teste_to_eclipse/features/list/data/exceptions/network_exception.dart';
import 'package:teste_to_eclipse/features/list/data/exceptions/server_exception.dart';


import '../models/picture_model.dart';

abstract class ListingRemoteDataSourceContract {
  Future<List<PictureModel>> getPictures();
}

class ListingRemoteDataSource extends ListingRemoteDataSourceContract {
  static const _picturesUrl = 'https://api.nasa.gov/planetary/apod';

  final NetworkInfo _networkInfo;
  final Dio _httpCaller;

  ListingRemoteDataSource(this._networkInfo, this._httpCaller);

  @override
  Future<List<PictureModel>> getPictures() async {
    final isConnected = await _networkInfo.isConnected;
    if (!isConnected) {
      throw const NetworkException('You are offline.');
    }

    try {
      final dateFormatter = DateFormat('yyyy-MM-dd');
      final now = DateTime.now();
      final response = await _httpCaller.get(_picturesUrl, queryParameters: {
        'api_key': '0NYlc7TzTP3wQxWLXGZBwZzSRScpQTwE3jRjG4B0',
        'start_date': dateFormatter.format(now.subtract(const Duration(days: 30))),
        'end_date': dateFormatter.format(now),
        'thumbs': true,
      });

      return (response.data as List).map((e) => PictureModel.fromMap(e)).toList();
    } on DioError catch (e) {
      throw ServerException(e.message);
    }
  }
}
