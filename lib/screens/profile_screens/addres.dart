import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skin_app/constants.dart';
import 'package:skin_app/models/address_model.dart';
import 'package:skin_app/providers/product.dart';


class AddressScreen extends StatefulWidget {
  const AddressScreen({key}) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  var adr = AddressModel(
      name: '',
      mobile: '',
      pincode: '',
      building: '',
      area: '',
      landmark: '',
      city: '');

  final _form = GlobalKey<FormState>();
  void _saveForm() {
    _form.currentState?.save();
  }

  @override
  Widget build(BuildContext context) {
    String hint = '';
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          toolbarHeight: 70,
          elevation: 0,
          backgroundColor: Colors.white,
          title:  const Text('Change address',
                      style: TextStyle(
                       
                          color: mainColor,
                          fontSize: 20,
                          fontFamily: 'Gilroy_Bold')),
          leading: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: const Icon(
              EvaIcons.arrowBackOutline,
              color: mainColor,
            ),
          )),
      body: SafeArea(
          child: Form(
        key: _form,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(children: [
            const Divider(
              thickness: 0.1,
              color: mainColor,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(' Full name',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: mainColor,
                          fontSize: 16,
                          fontFamily: 'Gilroy_Medium')),
                  const SizedBox(
                    height: 2,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(width: 1, color: mainColor),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.name,
                        onSaved: (value) {
                          adr = AddressModel(
                              name: value.toString(),
                              mobile: adr.mobile,
                              pincode: adr.pincode,
                              building: adr.building,
                              area: adr.area,
                              landmark: adr.landmark,
                              city: adr.city);
                        },
                        onFieldSubmitted: (_) {
                          _saveForm();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(' Mobile number',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: mainColor,
                          fontSize: 16,
                          fontFamily: 'Gilroy_Medium')),
                  const SizedBox(
                    height: 2,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(width: 1, color: mainColor),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: TextFormField(
                        decoration:  InputDecoration(
                          border: InputBorder.none,
                          label: const Text(
                            '10-digit mobile number',
                            style: TextStyle(fontFamily: 'Gilroy_Medium'),
                          ),
                          hintText: hint,
                        ),
                        keyboardType: TextInputType.phone,
                        onSaved: (value) {
                          adr = AddressModel(
                              name: adr.name,
                              mobile: value.toString(),
                              pincode: adr.pincode,
                              building: adr.building,
                              area: adr.area,
                              landmark: adr.landmark,
                              city: adr.city);
                        },
                        onFieldSubmitted: (_) {
                          _saveForm();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(' Pincode',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: mainColor,
                          fontSize: 16,
                          fontFamily: 'Gilroy_Medium')),
                  const SizedBox(
                    height: 2,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(width: 1, color: mainColor),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          label: Text('6 digit pincode',   style: TextStyle(fontFamily: 'Gilroy_Medium'),),
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.number,
                        onSaved: (value) {
                          adr = AddressModel(
                              name: adr.name,
                              mobile: adr.mobile,
                              pincode: value.toString(),
                              building: adr.building,
                              area: adr.area,
                              landmark: adr.landmark,
                              city: adr.city);
                        },
                        onFieldSubmitted: (_) {
                          _saveForm();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(' Flat, House no., Building, Apartment',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: mainColor,
                          fontSize: 16,
                          fontFamily: 'Gilroy_Medium')),
                  const SizedBox(
                    height: 2,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(width: 1, color: mainColor),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.name,
                        onSaved: (value) {
                          adr = AddressModel(
                              name: adr.name,
                              mobile: adr.mobile,
                              pincode: adr.pincode,
                              building: value.toString(),
                              area: adr.area,
                              landmark: adr.landmark,
                              city: adr.city);
                        },
                        onFieldSubmitted: (_) {
                          _saveForm();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(' Area, Street, Sector, Village',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: mainColor,
                          fontSize: 16,
                          fontFamily: 'Gilroy_Medium')),
                  const SizedBox(
                    height: 2,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(width: 1, color: mainColor),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.name,
                        onSaved: (value) {
                          adr = AddressModel(
                              name: adr.name,
                              mobile: adr.mobile,
                              pincode: adr.pincode,
                              building: adr.building,
                              area: value.toString(),
                              landmark: adr.landmark,
                              city: adr.city);
                        },
                        onFieldSubmitted: (_) {
                          _saveForm();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(' Landmark',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: mainColor,
                          fontSize: 16,
                          fontFamily: 'Gilroy_Medium')),
                  const SizedBox(
                    height: 2,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(width: 1, color: mainColor),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: TextFormField(
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            label: Text('E.g. near hp petrol pump',   style: TextStyle(fontFamily: 'Gilroy_Medium'),)),
                        keyboardType: TextInputType.name,
                        onSaved: (value) {
                          adr = AddressModel(
                              name: adr.name,
                              mobile: adr.mobile,
                              pincode: adr.pincode,
                              building: adr.building,
                              area: adr.area,
                              landmark: value.toString(),
                              city: adr.city);
                        },
                        onFieldSubmitted: (_) {
                          _saveForm();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(' Town/City',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: mainColor,
                          fontSize: 16,
                          fontFamily: 'Gilroy_Medium')),
                  const SizedBox(
                    height: 2,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(width: 1, color: mainColor),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: TextFormField(
                      
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.name,
                        onSaved: (value) {
                          adr = AddressModel(
                              name: adr.name,
                              mobile: adr.mobile,
                              pincode: adr.pincode,
                              building: adr.building,
                              area: adr.area,
                              landmark: adr.landmark,
                              city: value.toString());
                        },
                        onFieldSubmitted: (_) {
                          _saveForm();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(30)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: MaterialButton(
                    color: mainColor,
                    height: 50,
                    minWidth: double.infinity,
                    onPressed: () {
                        _saveForm();
                        
                      addAdrs();
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Update',
                      style: TextStyle(color: Colors.white, fontFamily: 'Gilroy_Bold', fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 60,
            )
          ]),
        ),
      )),
    );
  }

  Future<void> addAdrs() async {
    Provider.of<ProductsProvider>(context, listen: false).addAddress(adr);
    Provider.of<ProductsProvider>(context, listen: false).addAddresstodb();
    Provider.of<ProductsProvider>(context, listen: false).changeAddres(false);
  }
}
