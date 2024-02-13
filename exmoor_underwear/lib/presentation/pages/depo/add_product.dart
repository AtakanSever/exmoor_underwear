import 'dart:io';

import 'package:exmoor_underwear/domain/status/depo_model.dart';
import 'package:exmoor_underwear/infrastracture/status/status_service.dart';
import 'package:exmoor_underwear/presentation/core/common_widgets/cutom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key,});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  TextEditingController _atolyeAdi = TextEditingController();
  TextEditingController _urunAdi = TextEditingController();
  TextEditingController _urunMiktari = TextEditingController();
  TextEditingController _sakatMal = TextEditingController();
  TextEditingController _birimi = TextEditingController();
  TextEditingController _urunBasiUcret = TextEditingController();
  TextEditingController _toplamUcret = TextEditingController();
  StatusService _statusService = StatusService();
  final ImagePicker _pickerImage = ImagePicker();
  dynamic _pickImage;
  PickedFile? profileImage;
  bool isTake = false;

  Widget imagePlace() {
    double height = MediaQuery.of(context).size.height;
    if (profileImage != null) {
      return CircleAvatar(
        backgroundImage: FileImage(File(profileImage!.path)),
        radius: height * 0.15,
      );
    } else {
      if (_pickImage != null) {
        return CircleAvatar(
          backgroundImage: NetworkImage(_pickImage),
          radius: height * 0.15,
        );
      } else {
        return CircleAvatar(
          backgroundImage: const AssetImage('assets/images/spiderman.png'),
          radius: height * 0.15,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Depoya Ürün Ekle'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 24, right: 24, bottom: 100, top: 20),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.black,
                        width: 0.3,
                        style: BorderStyle.solid)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        _onImageButtonPress(ImageSource.gallery,
                            context: context);
                      },
                      icon: const Icon(Icons.photo),
                    ),
                    if (profileImage != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.file(
                          File(profileImage!.path),
                          fit: BoxFit.cover,
                          height: MediaQuery.of(context).size.height * 0.25,
                          width: MediaQuery.of(context).size.height * 0.25,
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isTake = !isTake;
                  });
                },
                child: Text(
                  isTake == true ? 'Alınan Mal' : 'Verilen Mal',
                  style: TextStyle(fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: isTake == true
                        ? Colors.deepOrange
                        : Color.fromARGB(255, 255, 235, 230),
                    elevation: 3,
                    foregroundColor: isTake == true
                        ? Colors.white
                        : const Color.fromARGB(255, 255, 60, 0),
                    minimumSize: Size(180, 50)),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: _atolyeAdi,
                icerik: 'Atölye/İşletme adı',
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: _urunAdi,
                icerik: 'Ürün Adı',
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: _urunMiktari,
                icerik: 'Ürün miktarı',
              ),
              const SizedBox(
                height: 20,
              ),
              isTake
                  ? CustomTextField(
                      controller: _sakatMal,
                      icerik: 'Sakat Mal',
                    )
                  : Text(
                      'Ürünü alırken sakat malı girmeyi unutmayın',
                      style: TextStyle(
                          fontSize: 16, decoration: TextDecoration.underline),
                    ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: _birimi,
                icerik: 'Birimi(adet,kg,paket...)',
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: _urunBasiUcret,
                icerik: 'Ürün başı ücret',
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: _toplamUcret,
                icerik: 'Toplam Ücret',
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_atolyeAdi.text.isEmpty ||
                      _urunAdi.text.isEmpty ||
                      _urunMiktari.text.isEmpty ||
                      _birimi.text.isEmpty ||
                      _urunBasiUcret.text.isEmpty) {
                    Fluttertoast.showToast(
                        msg: 'Lütfen tüm alanları doldurun!');
                  } else {
                    _statusService
                        .addStatus(
                            isTake,
                            _atolyeAdi.text,
                            profileImage!,
                            0,
                            _urunAdi.text,
                            int.tryParse(_urunMiktari.text) ?? 0,
                            int.tryParse(_sakatMal.text) ?? 0,
                            _birimi.text,
                            double.tryParse(_urunBasiUcret.text) ?? 0,
                            double.tryParse(_toplamUcret.text) ?? 0,
                            0,
                            [],
                            [],
                            DateTime.now())
                        .then((value) =>
                            Fluttertoast.showToast(msg: 'Ekleme başarılı'));
                  }
                },
                child: const Text(
                  'Depoya Ekle',
                  style: TextStyle(fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(200, 50), elevation: 7),
              )
            ],
          ),
        ),
      ),
    );
  }
  void _onImageButtonPress(ImageSource source,
      {required BuildContext context}) async {
    try {
      final pickedFile = await _pickerImage.pickImage(source: source);
      setState(() {
        profileImage = PickedFile(pickedFile!.path);
        print('resim ekleme');
        if (profileImage != null) {}
      });
    } catch (e) {
      setState(() {
        _pickImage = e;
        print("hatamız" + _pickImage);
      });
    }
  }
}
