import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:product_6/data/product_data.dart';

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like multitouchDragStrategy
  @override
  MultitouchDragStrategy getMultitouchDragStrategy(BuildContext context) =>
      MultitouchDragStrategy.sumAllPointers;
}

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Product product =
        ModalRoute.of(context)?.settings.arguments as Product;
    print(product.name);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset('assets/shoe.jpg'),
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
                      Navigator.pop(context);
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.catagory,
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
                        onPressed: null,
                        child: const Text('DELETE'),
                      ),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            backgroundColor: const Color(0xFF3F51F3),
                            elevation: 4,
                            fixedSize: const Size(152, 50),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6))),
                        onPressed: null,
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
      ),
    );
  }
}
