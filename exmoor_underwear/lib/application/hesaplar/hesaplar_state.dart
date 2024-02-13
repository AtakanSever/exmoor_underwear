import 'package:exmoor_underwear/domain/status/depo_model.dart';

class HesaplarState {
  final bool isInprogress;
  final bool isUpdated;
  final bool isFailed;
  final List<Depo> products;
  final double aylikYapilanOdeme;
  final double aylikToplamUcret;
  final double aylikKalanUcret;
  final int aylikToplamAlinanMal;
  final int aylikToplamVerilenMal;
  final int aylikToplamSakatMal;
  final List<String> atolyeler;
  HesaplarState({
    this.isInprogress = false,
    this.isUpdated = false,
    this.isFailed = false,
    this.products = const [],
    this.aylikYapilanOdeme = 0,
    this.aylikToplamUcret = 0,
    this.aylikKalanUcret = 0,
    this.aylikToplamAlinanMal = 0,
    this.aylikToplamVerilenMal = 0,
    this.aylikToplamSakatMal = 0,
    this.atolyeler = const [],
  });

  HesaplarState copyWith({
    bool? isInprogress,
    bool? isUpdated,
    bool? isFailed,
    List<Depo>? products,
    double? aylikYapilanOdeme,
    double? aylikToplamUcret,
    double? aylikKalanUcret,
    int? aylikToplamAlinanMal,
    int? aylikToplamVerilenMal,
    int? aylikToplamSakatMal,
    List<String>? atolyeler,
  }) {
    return HesaplarState(
      isInprogress: isInprogress ?? this.isInprogress,
      isUpdated: isUpdated ?? this.isUpdated,
      isFailed: isFailed ?? this.isFailed,
      products: products ?? this.products,
      aylikYapilanOdeme: aylikYapilanOdeme ?? this.aylikYapilanOdeme,
      aylikToplamUcret: aylikToplamUcret ?? this.aylikToplamUcret,
      aylikKalanUcret: aylikKalanUcret ?? this.aylikKalanUcret,
      aylikToplamAlinanMal: aylikToplamAlinanMal ?? this.aylikToplamAlinanMal,
      aylikToplamVerilenMal:
          aylikToplamVerilenMal ?? this.aylikToplamVerilenMal,
      aylikToplamSakatMal: aylikToplamSakatMal ?? this.aylikToplamSakatMal,
      atolyeler: atolyeler ?? this.atolyeler,
    );
  }
}
