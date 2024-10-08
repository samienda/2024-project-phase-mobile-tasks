import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_input/image_input.dart';

import '../../domain/entities/product.dart';
import '../bloc/product_bloc.dart';
import '../bloc/product_event.dart';
import '../bloc/product_state.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _formKey = GlobalKey<FormState>();

  File? _image;
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
            'Add Product',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ImageInput(
                    imageSize: const Size(380, 200),
                    allowMaxImage: 1,
                  onImageSelected: (image) {
                    _image = File(image.path);
                  },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'name',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  TextFormField(
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
                        if (state is ProductInserted) {
                          Navigator.of(context).pushNamed('/home');
                        }

                        if (state is ProductInsertedFailure) {
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
                                    _price != null &&
                                    _image != null) {
                                  context.read<ProductBloc>().add(
                                        InsertProductEvent(ProductEntity(
                                            id: 'id',
                                            name: _name!,
                                            description: _description!,
                                            price: _price!,
                                            imageUrl: _image!.path)),
                                      );
                                }
                              }
                            },
                            style: OutlinedButton.styleFrom(
                                backgroundColor: const Color(0xFF3F51F3),
                                fixedSize: const Size(380, 55),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            child: (state is ProductInserting)
                                ? const CircularProgressIndicator()
                                : const Text(
                                    'ADD',
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
                          'DELETE',
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
