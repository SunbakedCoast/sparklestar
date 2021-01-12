import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sparklestar/BLOCS/add_bloc/add.dart';
import 'package:sparklestar/SRC/MODELS/models.dart';

class Add extends StatefulWidget {
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _titleTextController = TextEditingController();
  final _priceTextController = TextEditingController();
  final _descriptionTextController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File _image;
  LocationResult _pickedLocation;
  String apiKey = 'AIzaSyCluJKe_d_0CBPtZ8ia_JkxMHZiyimeA3k';

  Widget build(BuildContext context) {
    var _screenSize = MediaQuery.of(context).size;
    var _addBloc = BlocProvider.of<AddBloc>(context);

    Future _fetchImage() async {
      final pickedFile = await _picker.getImage(source: ImageSource.camera);

      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        } else {
          print('no image selected');
        }
      });
    }

    _addBtnPressed(){
      _addBloc.add(AddBtnPressed(item: Item(image: _image.toString(),
      title: _titleTextController.text,
      price: int.parse(_priceTextController.text),
      description: _descriptionTextController.text,
      location: _pickedLocation.toString())));
    }

    return BlocBuilder<AddBloc, AddState>(builder: (context, state) {
      if (state is AddBtnStateLoading) {
        return _showProgressIndicator();
      }
      if(state is AddBtnStateDone){
        Navigator.pop(context);
      }
      if (state is AddInitialState) {
        return SafeArea(
          child: Scaffold(
            persistentFooterButtons: [
              SizedBox(
                width: _screenSize.width,
                child: RaisedButton(
                  splashColor: Theme.of(context).accentColor,
                  onPressed: state is AddBtnPressed ? () {} : _addBtnPressed,
                  color: Theme.of(context).accentColor,
                  child: Text('ADD',
                      style: GoogleFonts.poppins(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
            body: Padding(
              padding: const EdgeInsets.only(left: 24, right: 24),
              child: Form(
                key: _key,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Text('Please provide input'),
                      ),
                      Container(
                        width: _screenSize.width,
                        child: TextButton(
                          onPressed: _fetchImage,
                          child: Text(
                            _image == null ? 'Upload a photo' : 'Change image',
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Container(
                        width: _screenSize.width,
                        child: _image == null
                            ? Text('no image selected')
                            : Image.file(_image),
                      ),
                      Container(
                        //margin: const EdgeInsets.only(left: 30, right: 30, top: 10),
                        child: TextFormField(
                          //autocorrect: false,
                          keyboardType: TextInputType.name,
                          controller: _titleTextController,
                          style: GoogleFonts.poppins(
                              color: Colors.white, fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            hintText: 'Title',
                            hintStyle: GoogleFonts.poppins(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Title is required';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      Container(
                        //margin: const EdgeInsets.only(left: 30, right: 30, top: 10),
                        child: TextFormField(
                          //autocorrect: false,
                          keyboardType: TextInputType.name,
                          controller: _priceTextController,
                          style: GoogleFonts.poppins(
                              color: Colors.white, fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            hintText: 'Price',
                            hintStyle: GoogleFonts.poppins(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Price is required';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        child: TextFormField(
                          //autocorrect: false,
                          keyboardType: TextInputType.name,
                          controller: _descriptionTextController,
                          style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            hintText: 'Description',
                            hintStyle: GoogleFonts.poppins(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Description is required';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      Container(
                        width: _screenSize.width,
                        child: TextButton(
                          onPressed: () async {
                            LocationResult result = await showLocationPicker(
                                context, apiKey,
                                initialCenter: LatLng(31.1975844, 29.9598339),
                                myLocationButtonEnabled: true,
                                layersButtonEnabled: true,
                                resultCardAlignment: Alignment.bottomCenter,
                                automaticallyAnimateToCurrentLocation: true);
                            print('result = $result');
                            setState(() => _pickedLocation = result);
                          },
                          child: Text(
                            _pickedLocation == null
                                ? 'Choose location'
                                : _pickedLocation.toString(),
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }
      ///TODO [RETURN]
    });
  }

  Widget _showProgressIndicator() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

/*return SafeArea(
      child: Scaffold(
        persistentFooterButtons: [
          SizedBox(
            width: _screenSize.width,
            child: RaisedButton(
              splashColor: Theme.of(context).accentColor,
              onPressed: () {},
              color: Theme.of(context).accentColor,
              child: Text('ADD',
                  style: GoogleFonts.poppins(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
        body: Padding(
          padding: const EdgeInsets.only(left: 24, right: 24),
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Text('Please provide input'),
                  ),
                  Container(
                    width: _screenSize.width,
                    child: TextButton(
                      onPressed: _fetchImage,
                      child: Text(
                        _image == null ? 'Upload a photo' : 'Change image',
                        style: GoogleFonts.poppins(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    width: _screenSize.width,
                    child: _image == null
                        ? Text('no image selected')
                        : Image.file(_image),
                  ),
                  Container(
                    //margin: const EdgeInsets.only(left: 30, right: 30, top: 10),
                    child: TextFormField(
                      //autocorrect: false,
                      keyboardType: TextInputType.name,
                      controller: _titleTextController,
                      style: GoogleFonts.poppins(
                          color: Colors.white, fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        hintText: 'Title',
                        hintStyle: GoogleFonts.poppins(
                            color: Colors.grey, fontWeight: FontWeight.bold),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Title is required';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Container(
                    //margin: const EdgeInsets.only(left: 30, right: 30, top: 10),
                    child: TextFormField(
                      //autocorrect: false,
                      keyboardType: TextInputType.name,
                      controller: _priceTextController,
                      style: GoogleFonts.poppins(
                          color: Colors.white, fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        hintText: 'Price',
                        hintStyle: GoogleFonts.poppins(
                            color: Colors.grey, fontWeight: FontWeight.bold),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Price is required';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: TextFormField(
                      //autocorrect: false,
                      keyboardType: TextInputType.name,
                      controller: _descriptionTextController,
                      style: GoogleFonts.poppins(
                          color: Colors.white, fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        hintText: 'Description',
                        hintStyle: GoogleFonts.poppins(
                            color: Colors.grey, fontWeight: FontWeight.bold),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Description is required';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Container(
                    width: _screenSize.width,
                    child: TextButton(
                      onPressed: () async {
                        LocationResult result = await showLocationPicker(
                            context, apiKey,
                            initialCenter: LatLng(31.1975844, 29.9598339),
                            myLocationButtonEnabled: true,
                            layersButtonEnabled: true, 
                            resultCardAlignment: Alignment.bottomCenter,
                            automaticallyAnimateToCurrentLocation: true);
                        print('result = $result');
                        setState(() => _pickedLocation = result);
                      },
                      child: Text(
                        _pickedLocation == null
                            ? 'Choose location'
                            : _pickedLocation.toString(),
                        style: GoogleFonts.poppins(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ); */
