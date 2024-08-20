import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/product_bloc.dart';
import '../bloc/product_event.dart';
import '../bloc/product_state.dart';
import '../widgets/product_card.dart';
import '../widgets/search_bar.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ProductBloc>().add(LoadAllProductEvent());
    return Scaffold(
        appBar: AppBar(
          leading: IconButton.outlined(
            color: Colors.white,
            style: IconButton.styleFrom(
                backgroundColor: Colors.white,
                side: const BorderSide(
                  width: 0,
                  color: Colors.white,
                )),
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Color(0xFF3F51F3),
            ),
          ),
          centerTitle: true,
          title: const Text(
            'Search Product',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF3E3E3E),
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
        ),
        body: Column(
          children: [
            const MySearchBar(),
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
                    child: ListView.builder(
                      itemCount: state.products.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ProductCard(
                          product: state.products[index],
                        );
                      },
                    ),
                  );
                }
                if (state is ProductLoadFailure) {
                  return Center(
                    heightFactor: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                  );
                }
                return Container();
              },
            ),
          ],
        ));
  }
}
