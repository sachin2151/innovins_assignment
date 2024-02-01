import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:innovins_assignment/core/http_error.dart';
import 'package:innovins_assignment/core/network_info.dart';
import 'package:innovins_assignment/modules/home/data/data_source/home_view_api.dart';
import 'package:innovins_assignment/modules/home/data/models/add_product_model.dart';
import 'package:innovins_assignment/modules/home/data/models/product_list.dart';
import 'package:innovins_assignment/modules/home/domain/repositories/home_repositories.dart';
import 'package:innovins_assignment/modules/home/domain/usecases/add_product_usecase.dart';
import 'package:innovins_assignment/modules/home/domain/usecases/delete_product_usecase.dart';
import 'package:innovins_assignment/modules/home/domain/usecases/edit_prodcut_usecase.dart';
import 'package:innovins_assignment/modules/home/domain/usecases/home_usecases.dart';

class HomeRepositoryImpl implements HomeRepository {
  HomeRepositoryImpl(this.homeApi, this.networkInfo);

  final HomeApi homeApi;
  final NetworkInfo networkInfo;

  @override
  Future<Either<HttpError, List<ProductListModel>>> fetchProductList(
    HomeUsecaseParams params,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        List<ProductListModel> response =
            await homeApi.fetchProductList(params);
        return Right(response);
      } on DioException catch (e) {
        return Left(
          AppError(errorCode: e.response?.statusCode)
              .appErrorType(e.type, e.message),
        );
      }
    } else {
      return Left(NoInternetError());
    }
  }

  @override
  Future<Either<HttpError, AddProductModel>> addProduct(
    AddProductUsecaseParams params,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        AddProductModel response = await homeApi.addProduct(params);
        return Right(response);
      } on DioException catch (e) {
        return Left(
          AppError(errorCode: e.response?.statusCode)
              .appErrorType(e.type, e.message),
        );
      }
    } else {
      return Left(NoInternetError());
    }
  }

  @override
  Future<Either<HttpError, AddProductModel>> editProduct(
    EditProductUsecaseParams params,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        AddProductModel response = await homeApi.editProduct(params);
        return Right(response);
      } on DioException catch (e) {
        return Left(
          AppError(errorCode: e.response?.statusCode)
              .appErrorType(e.type, e.message),
        );
      }
    } else {
      return Left(NoInternetError());
    }
  }

  @override
  Future<Either<HttpError, AddProductModel>> deleteProduct(
    DeleteProductUsecaseParams params,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        AddProductModel response = await homeApi.deleteProduct(params);
        return Right(response);
      } on DioException catch (e) {
        return Left(
          AppError(errorCode: e.response?.statusCode)
              .appErrorType(e.type, e.message),
        );
      }
    } else {
      return Left(NoInternetError());
    }
  }
}
