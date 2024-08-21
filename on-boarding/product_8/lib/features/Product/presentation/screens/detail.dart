import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/product.dart';
import '../bloc/product_bloc.dart';
import '../bloc/product_event.dart';
import '../bloc/product_state.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    ProductEntity product =
        ModalRoute.of(context)?.settings.arguments as ProductEntity;

    context.read<ProductBloc>().add(GetSingleProductEvent(id: product.id));
    
    return Scaffold(
      body: BlocListener<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state is ProductDeletedFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }

          if (state is ProductDeleted) {
            context.read<ProductBloc>().add(LoadAllProductEvent());
            Navigator.of(context).pushNamed('/home');
          }
        },
        child:
            BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
          if (state is LoadingState) {
            const Center(
              child: CircularProgressIndicator(),
              heightFactor: 10,
            );
          }
          if (state is LoadedSingleProductState) {
            product = state.result;
            return SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      CachedNetworkImage(
                        imageUrl: product.imageUrl,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 29.0,
                          horizontal: 15,
                        ),
                        child: IconButton.outlined(
                          color: Colors.white,
                          style: IconButton.styleFrom(
                              backgroundColor: Colors.white,
                              side: const BorderSide(
                                width: 0,
                                color: Colors.white,
                              )),
                          onPressed: () {
                            context
                                .read<ProductBloc>()
                                .add(LoadAllProductEvent());
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios_new_outlined,
                            color: Color(0xFF3F51F3),
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(
                      20,
                    ),
                    child: Column(
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'product.catagory',
                              style: const TextStyle(
                                color: Color(0xFF928F86),
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Poppins',
                                fontSize: 16,
                              ),
                            ),
                            const Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Color(0xFFFFD700),
                                ),
                                Text(
                                  '(4.0)',
                                  style: TextStyle(
                                    color: Color(0xFF928F86),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    fontFamily: 'Sora',
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              product.name,
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromARGB(182, 0, 0, 0)),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              '\$${product.price}',
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                fontSize: 24,
                                color: Color.fromARGB(182, 0, 0, 0),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        SizedBox(
                          height: 100,
                          child: Column(
                            children: [
                              const Text(
                                'Size',
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Expanded(
                                  child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: List.generate(9, (index) {
                                  return SizedBox(
                                    height: 100,
                                    width: 80,
                                    child: Card(
                                      color: index + 39 == 41
                                          ? const Color(0xFF3F51F3)
                                          : Colors.white,
                                      elevation: 0,
                                      child: Center(
                                        child: Text(
                                          '${index + 39}',
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: index + 39 == 41
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              )),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(product.description
                            // maxLines: 9,
                            ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                // backgroundColor: const Color(0xFF3F51F3),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                fixedSize: const Size(152, 50),
                                elevation: 4,
                                side: const BorderSide(color: Colors.red),
                              ),
                              onPressed: () {
                                context
                                    .read<ProductBloc>()
                                    .add(DeleteProductEvent(id: product.id));
                              },
                              child: const Text('DELETE'),
                            ),
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  backgroundColor: const Color(0xFF3F51F3),
                                  elevation: 4,
                                  fixedSize: const Size(152, 50),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6))),
                              onPressed: () {
                                Navigator.of(context).pushNamed('/update',
                                    arguments: state.result);
                              },
                              child: const Text(
                                'UPDATE',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          } else if (state is ProductLoadFailure) {
            return Center(
              heightFactor: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.message),
                  IconButton.outlined(
                    onPressed: () {
                      context
                          .read<ProductBloc>()
                          .add(GetSingleProductEvent(id: product.id));
                    },
                    icon: const Icon(Icons.refresh_outlined),
                  )
                ],
              ),
            );
          } else {
            return Center(
              heightFactor: 100,
              child: IconButton(
                  icon: const Icon(Icons.refresh_outlined),
                  onPressed: () async {
                    context
                        .read<ProductBloc>()
                        .add(GetSingleProductEvent(id: product.id));
                  }),
            );
          }
        }),
      ),
    );
  }
}
