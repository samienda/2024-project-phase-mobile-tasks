import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/product_bloc.dart';
import '../bloc/product_event.dart';
import '../bloc/product_state.dart';
import '../widgets/product_card.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ProductBloc>().add(LoadAllProductEvent());

    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.white,
        toolbarHeight: 80,
        leadingWidth: 80,
        leading: Container(
          width: 50,
          margin: const EdgeInsets.only(left: 15, top: 10),
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 217, 215, 215),
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
        ),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'July 14, 2023',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w300,
                color: CupertinoColors.inactiveGray,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Text(
                  'Hello, ',
                  style: TextStyle(
                    fontSize: 15,
                    color: CupertinoColors.inactiveGray,
                  ),
                ),
                Text(
                  'Yohannes',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: const [
          IconButton(
            onPressed: null,
            icon: Icon(
              Icons.notifications_none_rounded,
              color: Colors.black54,
            ),
            color: Colors.black,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: const Color(0xFF3F51F3),
        onPressed: () {
          Navigator.pushNamed(context, '/add_product');
        },
        child: const Icon(
          Icons.add,
          semanticLabel: 'Add Product',
          size: 40,
          color: Colors.white,
        ),
      ),
      body: BlocListener<ProductBloc, ProductState>(
        listener: (context, state) {},
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 24.0, right: 24, top: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Available Products',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                      color: Color.fromARGB(192, 0, 0, 0),
                    ),
                  ),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        fixedSize: const Size(40, 48),
                        padding: const EdgeInsets.all(0),
                        side: const BorderSide(
                          width: 1,
                          color: Colors.black12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                    onPressed: () {
                      Navigator.pushNamed(context, '/search');
                    },
                    child: const Icon(
                      Icons.search_sharp,
                      color: Colors.black26,
                      size: 35,
                      weight: 10,
                    ),
                  )
                ],
              ),
            ),
            BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is LoadingState) {
                  return const Center(
                    heightFactor: 10,
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is LoadedAllProductState) {
                  return Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        context.read<ProductBloc>().add(LoadAllProductEvent());
                      },
                      child: ListView.builder(
                          itemCount: state.products.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ProductCard(
                              product: state.products[index],
                            );
                          }),
                    ),
                  );
                }
                if (state is ProductLoadFailure) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      context.read<ProductBloc>().add(LoadAllProductEvent());
                    },
                    child: Center(
                      heightFactor: 5,
                      child: Column(
                        children: [
                          Text(state.message),
                          IconButton.outlined(
                            onPressed: () {
                              context
                                  .read<ProductBloc>()
                                  .add(LoadAllProductEvent());
                            },
                            icon: const Icon(Icons.refresh_outlined),
                          )
                        ],
                      ),
                    ),
                  );
                }

                return Center(
                  heightFactor: 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton.outlined(
                        onPressed: () {
                          context
                              .read<ProductBloc>()
                              .add(LoadAllProductEvent());
                        },
                        icon: const Icon(Icons.refresh_outlined),
                      )
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
