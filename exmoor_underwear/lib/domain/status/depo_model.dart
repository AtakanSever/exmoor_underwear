import 'package:cloud_firestore/cloud_firestore.dart';

class Depo {
  String id;
  bool alinanVerilenUrun;
  String atolyeAdi;
  String image;
  double kalanTutar;
  String urunAdi;
  int urunMiktari;
  int sakatMal;
  String birimi;
  double urunBasiUcret;
  double toplamUcret;
  double odeme;
  List<dynamic> odemeGecmisi;
  List<dynamic> odemeTarihleri;
  DateTime urunTarihi;

  Depo({
    required this.id,
    required this.alinanVerilenUrun,
    required this.atolyeAdi,
    required this.image,
    required this.kalanTutar,
    required this.urunAdi,
    required this.urunMiktari,
    required this.sakatMal,
    required this.birimi,
    required this.urunBasiUcret,
    required this.toplamUcret,
    required this.odeme,
    required this.odemeGecmisi,
    required this.odemeTarihleri,
    required this.urunTarihi,
  });

  factory Depo.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

    return Depo(
      id: snapshot.id,
      alinanVerilenUrun: data?["alinanVerilenUrun"] ?? false,
      atolyeAdi: data?["atolyeAdi"] ?? "",
      image: data?["image"] ?? "",
      kalanTutar: (data?["kalanTutar"] ?? 0).toDouble(),
      urunAdi: data?["urunAdi"] ?? "",
      urunMiktari: (data?["urunMiktari"] ?? 0).toInt(),
      sakatMal: (data?["sakatMal"] ?? 0).toInt(),
      birimi: data?["birimi"] ?? "",
      urunBasiUcret: (data?["urunBasiUcret"] ?? 0).toDouble(),
      toplamUcret: (data?["toplamUcret"] ?? 0).toDouble(),
      odeme: (data?["odeme"] ?? 0).toDouble(),
      odemeGecmisi: (data?['odemeGecmisi'] ?? []),
      odemeTarihleri: (data?['odemeTarihleri'] as List<dynamic>?)
              ?.map((timestamp) => (timestamp as Timestamp).toDate())
              .toList() ??
          [],
      urunTarihi: (data?['urunTarihi'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'alinanVerilenUrun': alinanVerilenUrun,
      'atolyeAdi': atolyeAdi,
      'image': image,
      'kalanTutar': kalanTutar,
      'urunAdi': urunAdi,
      'urunMiktari': urunMiktari,
      'sakatMal': sakatMal,
      'birimi': birimi,
      'urunBasiUcret': urunBasiUcret,
      'toplamUcret': toplamUcret,
      'odeme': odeme,
      'odemeGecmisi': odemeGecmisi,
      'odemeTarihleri': odemeTarihleri,
      'urunTarihi': urunTarihi
    };
  }

  factory Depo.fromMap(Map<String, dynamic> map) {
    return Depo(
        id: map['id'],
        alinanVerilenUrun: map['alinanVerilenUrun'],
        atolyeAdi: map['atolyeAdi'],
        image: map['image'],
        kalanTutar: map['kalanTutar'],
        urunAdi: map['urunAdi'],
        urunMiktari: map['urunMiktari'],
        sakatMal: map['sakatMal'],
        birimi: map['birimi'],
        urunBasiUcret: map['urunBasiUcret'],
        toplamUcret: map['toplamUcret'],
        odeme: map['odeme'],
        odemeGecmisi: map['odemeGecmisi'],
        odemeTarihleri: map['odemeTarihleri'],
        urunTarihi: map['urunTarihi']);
  }
  @override
  String toString() {
    return 'Depo{id: $id, alinanVerilenUrun: $alinanVerilenUrun, atolyeAdi: $atolyeAdi, image: $image, kalanTutar: $kalanTutar, urunAdi: $urunAdi, urunMiktari: $urunMiktari, sakatMal: $sakatMal, birimi: $birimi, urunBasiUcret: $urunBasiUcret, toplamUcret: $toplamUcret, odeme: $odeme, odemeGecmisi: $odemeGecmisi, odemeTarihleri: $odemeTarihleri, urunTarihi: $urunTarihi}';
  }

  void updateOdemeGecmisi(
      List<dynamic> updatedOdemeGecmisi, List<dynamic> updatedOdemeTarihleri) {
    odemeGecmisi = updatedOdemeGecmisi;
    odemeTarihleri = updatedOdemeTarihleri;
  }
}
