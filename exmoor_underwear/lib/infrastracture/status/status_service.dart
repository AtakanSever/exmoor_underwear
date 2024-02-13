import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exmoor_underwear/domain/status/depo_model.dart';
import 'package:exmoor_underwear/infrastracture/status/storage_service.dart';
import 'package:image_picker/image_picker.dart';

class StatusService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final StorageService _storageService = StorageService();
  String mediaUrl = "";

  Future<Depo> addStatus(
      bool alinanVerilenUrun,
      String atolyeAdi,
      PickedFile pickedFile,
      double kalanTutar,
      String urunAdi,
      int urunMiktari,
      int sakatMal,
      String birimi,
      double urunBasiUcret,
      double toplamUcret,
      double odeme,
      List<dynamic> odemeGecmisi,
      List<dynamic> odemeTarihleri,
      DateTime urunTarihi) async {
    var ref = _firestore.collection("Status");

    if (pickedFile == null) {
      mediaUrl = "";
    } else {
      mediaUrl = await _storageService.uploadMedia(File(pickedFile.path));
      print(mediaUrl);
    }

    DateTime now = DateTime.now();
    List<dynamic> defaultOdemeGecmisi = [0.0];
    List<dynamic> defaultOdemeTarihleri = [now];

    var documentRef = await ref.add({
      'atolyeAdi': atolyeAdi,
      'image': mediaUrl,
      'kalanTutar': kalanTutar,
      'urunAdi': urunAdi,
      'urunMiktari': urunMiktari,
      'sakatMal': sakatMal,
      'birimi': birimi,
      'urunBasiUcret': urunBasiUcret,
      'toplamUcret': toplamUcret,
      'alinanVerilenUrun': alinanVerilenUrun,
      'odeme': odeme,
      'odemeGecmisi': defaultOdemeGecmisi,
      'odemeTarihleri': defaultOdemeTarihleri,
      'urunTarihi': urunTarihi
    });
    return Depo.fromSnapshot(await documentRef.get());
  }

  Future<void> updateStatus(
      String documentId, Map<String, dynamic> updatedData) async {
    var ref = _firestore.collection("Status").doc(documentId);
    await ref.update(updatedData);
  }

  Future<List<Depo>> getStatusList() async {
    QuerySnapshot snapshot = await _firestore.collection("Status").get();

    return snapshot.docs.map((doc) => Depo.fromSnapshot(doc)).toList();
  }
}
