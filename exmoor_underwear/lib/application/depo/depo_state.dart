import 'package:exmoor_underwear/domain/status/depo_model.dart';

class DepoState {
  final bool isInprogress;
  final bool isUpdated;
  final bool isFailed;
  final List<Depo> products;
  final List<String> atolyeler;
  final List<Depo> updatedForAtolyeProducts;
  final List<Depo> alinanMallar;
  final List<Depo> verilenMallar;
  final List<dynamic> odemeGecmisi;
  final double kalanTutar;

  DepoState({
    this.isInprogress = false,
    this.isUpdated = false,
    this.isFailed = false,
    this.products = const [],
    this.atolyeler = const [],
    this.updatedForAtolyeProducts = const [],
    this.alinanMallar = const [],
    this.verilenMallar = const [],
    this.odemeGecmisi = const [],
    this.kalanTutar = 0,
  });

  DepoState copyWith({
    bool? isInprogress,
    bool? isUpdated,
    bool? isFailed,
    List<Depo>? products,
    List<String>? atolyeler,
    List<Depo>? updatedForAtolyeProducts,
    List<Depo>? alinanMallar,
    List<Depo>? verilenMallar,
    List<double>? odemeGecmisi,
    double? kalanTutar,
  }) {
    return DepoState(
        isInprogress: isInprogress ?? this.isInprogress,
        isUpdated: isUpdated ?? this.isUpdated,
        isFailed: isFailed ?? this.isFailed,
        products: products ?? this.products,
        atolyeler: atolyeler ?? this.atolyeler,
        updatedForAtolyeProducts:
            updatedForAtolyeProducts ?? this.updatedForAtolyeProducts,
        alinanMallar: alinanMallar ?? this.alinanMallar,
        verilenMallar: verilenMallar ?? this.verilenMallar,
        odemeGecmisi: odemeGecmisi ?? this.odemeGecmisi,
        kalanTutar: kalanTutar ?? this.kalanTutar
        );
  }
}
