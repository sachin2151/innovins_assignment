import 'package:dio/dio.dart';
import 'package:innovins_assignment/core/dio.dart';
import 'package:innovins_assignment/core/urls.dart';
import 'package:innovins_assignment/modules/home/data/models/add_product_model.dart';
import 'package:innovins_assignment/modules/home/data/models/product_list.dart';
import 'package:innovins_assignment/modules/home/domain/usecases/add_product_usecase.dart';
import 'package:innovins_assignment/modules/home/domain/usecases/delete_product_usecase.dart';
import 'package:innovins_assignment/modules/home/domain/usecases/edit_prodcut_usecase.dart';
import 'package:innovins_assignment/modules/home/domain/usecases/home_usecases.dart';

abstract class HomeApi {
  HomeApi();

  Future<List<ProductListModel>> fetchProductList(
    HomeUsecaseParams params,
  );

  Future<AddProductModel> addProduct(
    AddProductUsecaseParams params,
  );

  Future<AddProductModel> editProduct(
    EditProductUsecaseParams params,
  );

  Future<AddProductModel> deleteProduct(
    DeleteProductUsecaseParams params,
  );
}

class HomeApiImpl with baseDio implements HomeApi {
  HomeApiImpl() : super();

  @override
  Future<List<ProductListModel>> fetchProductList(
      HomeUsecaseParams params) async {
    Dio dio = await getBaseDio();
    final response = await dio.post(
      Urls.productListApi,
      data: FormData.fromMap(params.toJson()),
    );
    List<ProductListModel> res = [];
    try {
      List<dynamic> l = response.data as List<dynamic>;
      res = List<ProductListModel>.from(
          l.map((model) => ProductListModel.fromJson(model)));
    } catch (e) {}
    return res;
  }

  @override
  Future<AddProductModel> addProduct(AddProductUsecaseParams params) async {
    Dio dio = await getBaseDio();
    final response = await dio.post(
      Urls.addProductApi,
      data: FormData.fromMap(params.toJson()),
    );

    AddProductModel res = AddProductModel.fromJson(response.data);

    return res;
  }

  @override
  Future<AddProductModel> editProduct(EditProductUsecaseParams params) async {
    Dio dio = await getBaseDio();
    final response = await dio.post(
      Urls.editProductApi,
      data: FormData.fromMap(params.toJson()),
    );

    AddProductModel res = AddProductModel.fromJson(response.data);

    return res;
  }

  @override
  Future<AddProductModel> deleteProduct(
      DeleteProductUsecaseParams params) async {
    Dio dio = await getBaseDio();
    final response = await dio.post(
      Urls.deleteProductApi,
      data: FormData.fromMap(params.toJson()),
    );

    AddProductModel res = AddProductModel.fromJson(response.data);

    return res;
  }
}
