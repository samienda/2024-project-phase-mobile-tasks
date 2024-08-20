import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/product.dart';
import '../bloc/product_bloc.dart';
import '../bloc/product_event.dart';
import '../bloc/product_state.dart';

class UpdateProduct extends StatefulWidget {
  const UpdateProduct({super.key});

  @override
  State<UpdateProduct> createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {
  final _formKey = GlobalKey<FormState>();

  String? _name;
  double? _price;
  String? _description;

  bool isNumeric(String? s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  @override
  Widget build(BuildContext context) {
    ProductEntity? product =
        ModalRoute.of(context)?.settings.arguments as ProductEntity;

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'name',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
                TextFormField(
                  initialValue: product.name,
                  onSaved: (value) {
                    if (value != null) {
                      _name = value;
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  maxLines: 1,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'price',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
                TextFormField(
                  initialValue: product.price.toString(),
                  onSaved: (value) {
                    if (value != null) {
                      _price = double.parse(value);
                    }
                  },
                  validator: (value) {
                    if (!isNumeric(value)) {
                      return 'Please enter the valid price';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'description',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
                TextFormField(
                  initialValue: product.description,
                  onSaved: (value) {
                    if (value != null) {
                      _description = value;
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  maxLines: 5,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Column(
                  children: [
                    BlocListener<ProductBloc, ProductState>(
                      listener: (context, state) {
                        if (state is ProductUpdated) {
                          Navigator.of(context).pop();
                        }

                        if (state is ProductUpdatedFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.message)),
                          );
                        }
                      },
                      child: BlocBuilder<ProductBloc, ProductState>(
                        builder: (context, state) {
                          return OutlinedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                if (_name != null &&
                                    _description != null &&
                                    _price != null) {
                                  context.read<ProductBloc>().add(
                                        UpdateProductEvent(
                                            product: ProductEntity(
                                                id: product.id,
                                                name: _name!,
                                                description: _description!,
                                                price: _price!,
                                                imageUrl: '')),
                                      );
                                }
                              }
                            },
                            style: OutlinedButton.styleFrom(
                                backgroundColor: const Color(0xFF3F51F3),
                                fixedSize: const Size(380, 55),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            child: (state is ProductUpdating)
                                ? const CircularProgressIndicator()
                                : const Text(
                                    'UPDATE',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        fixedSize: const Size(380, 55),
                        side: const BorderSide(
                          color: Colors.red,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'CANCEL',
                        style: TextStyle(
                          color: Color(0xC9FF1313),
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
