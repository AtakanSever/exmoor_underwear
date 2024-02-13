import 'package:exmoor_underwear/domain/status/depo_model.dart';

abstract class DepoEvent {}

class EventGetDepoProducts extends DepoEvent {
  EventGetDepoProducts();
}

class EventGetProductForAtolye extends DepoEvent {
  final String selectedAtolye;
  EventGetProductForAtolye({required this.selectedAtolye});
}

class EventAddOdemeGecmisi extends DepoEvent {
  final double odeme;
  final Depo product;
  final List<dynamic> odemeGecmisi;
  final List<dynamic> odemeTarihleri;
  EventAddOdemeGecmisi(
      {required this.odeme,
      required this.product,
      required this.odemeGecmisi,
      required this.odemeTarihleri});
}

class EventGetKalanTutar extends DepoEvent {
  final Depo product;
  EventGetKalanTutar({required this.product});
}

class EventGetHaftalikHesap extends DepoEvent {
  EventGetHaftalikHesap();
}

class EventGetPrivProduct extends DepoEvent {
  final String urunId;
  EventGetPrivProduct({required this.urunId});
}
