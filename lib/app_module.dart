

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teste_to_eclipse/core/device/network_info.dart';
import 'package:teste_to_eclipse/core/services/storage/preferences.dart';
import 'package:teste_to_eclipse/features/list/data/datasources/listing_local_data_source.dart';
import 'package:teste_to_eclipse/features/list/data/datasources/listing_remote_data_source.dart';
import 'package:teste_to_eclipse/features/list/data/repositories/listing_repository.dart';
import 'package:teste_to_eclipse/features/list/domain/repositories/listing_repository_contract.dart';
import 'package:teste_to_eclipse/features/list/domain/usecases/get_pictures_list.dart';



import 'package:teste_to_eclipse/features/list/presentation/pages/details_page.dart';
import 'package:teste_to_eclipse/features/list/presentation/pages/listing_page.dart';
import 'package:teste_to_eclipse/features/list/presentation/state/listing_bloc.dart';
import 'package:teste_to_eclipse/features/splash/splash_page.dart';

class AppModule extends Module {
@override
  void routes(RouteManager r) {
   r.child('/', child: (BuildContext context)=> SplashPage());
   r.child('/listPage', child: (BuildContext context)=> ListingPage());
   r.child('/detailPage', child: (BuildContext context)=>DetailsPage(picture: r.args.data));
    super.routes(r);
  }
}

class Routes{
  static const listpage ='/listPage';
  static const detailPage= '/detailPage';
}

GetIt di = GetIt.instance;

Future<void> setup() async {
  // Shared
  di.registerSingleton<NetworkInfo>(NetworkInfo(Connectivity()));
  di.registerSingleton<Preferences>(Preferences(await SharedPreferences.getInstance()));

  // Features
  // # Listing
  // # Listing - data
  di.registerSingleton<ListingLocalDataSourceContract>(ListingLocalDataSource());
  di.registerSingleton<ListingRemoteDataSourceContract>(ListingRemoteDataSource(di(), Dio()));
  // # Listing - domain
  di.registerSingleton<ListingRepositoryContract>(ListingRepository(di(), di()));
  di.registerSingleton<GetPicturesList>(GetPicturesList(di()));
  // # Listing - presentation
  di.registerSingleton<ListingBloc>(ListingBloc(di()));
}