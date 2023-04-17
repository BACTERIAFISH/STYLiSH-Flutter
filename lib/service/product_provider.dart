import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/product_model.dart';

enum ProductPath {
  women,
  men,
  accessories,
}

class ProductApiClient {
  final dio = Dio();
  final String domain = 'api.appworks-school.tw';
  final String apiVersion = '1.0';

  Future<ProductData> getProduct(ProductPath path) async {
    Response response;
    response =
        await dio.get('https://$domain/api/$apiVersion/products/${path.name}');
    ProductData productData = ProductData.fromJson(response.data);
    return productData;
  }
}

class ProductRepository {
  final ProductApiClient _productApiClient;

  ProductRepository({ProductApiClient? productApiClient})
      : _productApiClient = productApiClient ?? ProductApiClient();

  Future<ProductData> getWomen() async {
    final data = await _productApiClient.getProduct(ProductPath.women);
    return data;
  }

  Future<ProductData> getMen() async {
    final data = await _productApiClient.getProduct(ProductPath.men);
    return data;
  }

  Future<ProductData> getAccessories() async {
    final data = await _productApiClient.getProduct(ProductPath.accessories);
    return data;
  }
}

abstract class ProductEvent {}

class ProductGetEvent extends ProductEvent {}

abstract class ProductEventState {}

class ProductEventInitial extends ProductEventState {}

class ProductEventLoading extends ProductEventState {}

class ProductEventSuccess extends ProductEventState {
  final List<ProductData> allProductData;
  ProductEventSuccess(this.allProductData);
}

class ProductEventFailure extends ProductEventState {}

class ProductBloc extends Bloc<ProductEvent, ProductEventState> {
  ProductBloc(ProductRepository productRepository)
      : super(ProductEventInitial()) {
    on<ProductGetEvent>((event, emit) async {
      emit(ProductEventLoading());
      try {
        List<ProductData> allProductData = await Future.wait([
          productRepository.getWomen(),
          productRepository.getMen(),
          productRepository.getAccessories(),
        ]);
        emit(ProductEventSuccess(allProductData));
      } catch (error) {
        print(error);
      }
    });
  }
}
