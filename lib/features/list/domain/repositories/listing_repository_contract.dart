import 'package:dartz/dartz.dart';
import 'package:teste_to_eclipse/features/list/domain/failures/custom_failure.dart';


import '../entities/picture.dart';

abstract class ListingRepositoryContract {
  Future<Either<CustomFailure, List<Picture>>> listPictures();
}
