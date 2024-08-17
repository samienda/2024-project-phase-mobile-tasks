import 'package:flutter/material.dart';

class MySearchBar extends StatefulWidget {
  const MySearchBar({super.key});

  @override
  State<MySearchBar> createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  final _formKey = GlobalKey<FormState>();
  String? _catagory;
  static const min = 0.0;
  static const max = 10.0;
  double low = min;
  double high = max;

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }
  }

  void showForm() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SizedBox(
        height: 300,
        child: Column(
          children: [
            Form(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  textBaseline: TextBaseline.alphabetic,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Catagory',
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 218, 213, 213),
                        ),
                      )),
                      initialValue: _catagory,
                      onSaved: (value) => _catagory = value,
                      // validator: (value),
                    ),
                    const Text('Price'),
                    RangeSlider(
                      activeColor: const Color(0xFF3F51F3),
                      min: min,
                      max: max,
                      values: RangeValues(low, high),
                      onChanged: (values) => setState(() {
                        low = values.start;
                        high = values.end;
                      }),
                    ),
                    Center(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            backgroundColor: const Color(0xFF3F51F3),
                            fixedSize: const Size(300, 40),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            )),
                        onPressed: _submitForm,
                        child: const Text(
                          'Apply',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFFFFFFFF),
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 15.0),
                /* -- Text and Icon -- */
                hintText: "Leather",
                hintStyle: const TextStyle(
                    fontSize: 20,
                    color: Color(0xFF666666),
                    fontWeight: FontWeight.w400), // TextStyle
                suffixIcon: const Icon(
                  Icons.arrow_forward,
                  size: 26,
                  weight: 5,
                  color: Color(0xFF3F51F3),
                ), // Icon
                /* -- Border Styling -- */
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6.0),
                  borderSide: const BorderSide(
                    width: 1.0,
                    color: Color(0xFF3F51F3),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6.0),
                  borderSide: const BorderSide(
                    width: 1.0,
                    color: Color.fromARGB(255, 205, 204, 204),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6.0),
                  borderSide: const BorderSide(
                    width: 1.0,
                    color: Color.fromARGB(255, 228, 224, 224),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              backgroundColor: const Color(0xFF3F51F3),
              fixedSize: const Size(48, 48),
              padding: const EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            onPressed: () {
              showForm();
            },
            child: const Center(
              child: Icon(
                Icons.filter_list,
                color: Colors.white,
                size: 40,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
