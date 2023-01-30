import 'package:flutter/material.dart';
enum Pet { HR, Employee }
class MyEnum extends StatefulWidget {
  const MyEnum({ Key? key}) : super(key: key);
  @override
  State<MyEnum> createState() => _MyEnumState();
}
class _MyEnumState extends State<MyEnum> {
  Pet _pet = Pet.HR;

  @override
  Widget build(BuildContext context) {

    return Column(

      children: <Widget>[
        ListTile(
          title: const Text('HR'),
          leading: Radio<Pet>(
            value: Pet.HR,
            groupValue: _pet,
            onChanged: (value) {
              setState(() {
                _pet = value!;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Employee'),
          leading: Radio<Pet>(
            value: Pet.Employee,
            groupValue: _pet,
            onChanged: ( value) {
              setState(() {
                _pet = value!;
              });
            },
          ),
        ),
      ],
    );
  }
}