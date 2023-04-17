import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../service/product_provider.dart';
import '../widgets/product_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required ProductRepository productRepository})
      : _productRepository = productRepository;

  final ProductRepository _productRepository;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> categories = ['女裝', '男裝', '配件'];
  List<bool> visibilities = [true, true, true];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              ProductBloc(widget._productRepository)..add(ProductGetEvent()),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Image.asset(
            'assets/stylish_logo.png',
            width: 128,
          ),
          backgroundColor: const Color(0xFFEEEEEE),
          elevation: 1,
        ),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: 8,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8),
                      child: SizedBox(
                        width: 320,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            'assets/dodoro_bus.png',
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    if (constraints.maxWidth < 767) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (visibilities[index]) {
                                        visibilities[index] = false;
                                      } else {
                                        visibilities[index] = true;
                                      }
                                    });
                                  },
                                  child: Text(
                                    categories[index],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Visibility(
                                  visible: visibilities[index],
                                  child: BlocBuilder<ProductBloc,
                                      ProductEventState>(
                                    builder: (context, state) {
                                      return ProductList(
                                        products: state is ProductEventSuccess
                                            ? state.allProductData[index].data
                                            : [],
                                        isScrollable: false,
                                      );
                                    },
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    categories[0],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Expanded(
                                    child: BlocBuilder<ProductBloc,
                                        ProductEventState>(
                                      builder: (context, state) {
                                        return ProductList(
                                          products: state is ProductEventSuccess
                                              ? state.allProductData[0].data
                                              : [],
                                          isScrollable: false,
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    categories[1],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Expanded(
                                    child: BlocBuilder<ProductBloc,
                                        ProductEventState>(
                                      builder: (context, state) {
                                        return ProductList(
                                          products: state is ProductEventSuccess
                                              ? state.allProductData[1].data
                                              : [],
                                          isScrollable: false,
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    categories[2],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Expanded(
                                    child: BlocBuilder<ProductBloc,
                                        ProductEventState>(
                                      builder: (context, state) {
                                        return ProductList(
                                          products: state is ProductEventSuccess
                                              ? state.allProductData[2].data
                                              : [],
                                          isScrollable: false,
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
