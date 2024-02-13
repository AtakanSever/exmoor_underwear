import 'package:exmoor_underwear/application/depo/depo_state.dart';
import 'package:exmoor_underwear/domain/status/depo_model.dart';
import 'package:exmoor_underwear/infrastracture/status/status_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:exmoor_underwear/application/depo/depo_event.dart';

class DepoBloc extends Bloc<DepoEvent, DepoState> {
  DepoBloc() : super(DepoState()) {
    on<EventGetDepoProducts>(_onGetDepoProducts);
    on<EventGetProductForAtolye>(_onGetProductsForAtolye);
    on<EventAddOdemeGecmisi>(_onGetOdemeGecmisi);
    on<EventGetKalanTutar>(_onGetKalanTutar);
    // on<EventGetPrivProduct>(_onGetPrivProduct);
  }
  StatusService _statusService = StatusService();

  Future<void> _onGetDepoProducts(
      EventGetDepoProducts event, Emitter<DepoState> emit) async {
    emit(state.copyWith(
      isInprogress: true,
      isUpdated: false,
    ));
    List<Depo> depoList = await _statusService.getStatusList();
    List<String> atolyeList = [];
    atolyeList.add('tüm atölyeler');
    for (var atolye in depoList) {
      atolyeList.add(atolye.atolyeAdi);
    }
    emit(state.copyWith(
        isInprogress: false,
        isUpdated: true,
        products: depoList,
        atolyeler: atolyeList));
  }

  Future<void> _onGetProductsForAtolye(
      EventGetProductForAtolye event, Emitter<DepoState> emit) async {
    emit(state.copyWith(isInprogress: true, isUpdated: false));

    List<Depo> updatedProducts = [];
    List<Depo> alinanMallar = [];
    List<Depo> verilenMallar = [];

    if (event.selectedAtolye == 'tüm atölyeler') {
      updatedProducts = state.products;
    } else {
      for (var product in state.products) {
        if (product.atolyeAdi == event.selectedAtolye) {
          updatedProducts.add(product);
        }
      }
    }

    for (var tumproduct in state.products) {
      if (tumproduct.alinanVerilenUrun == true &&
          tumproduct.atolyeAdi == event.selectedAtolye) {
        alinanMallar.add(tumproduct);
      } else if (tumproduct.alinanVerilenUrun == false &&
          tumproduct.atolyeAdi == event.selectedAtolye) {
        verilenMallar.add(tumproduct);
      }
    }

    emit(state.copyWith(
        isInprogress: false,
        isUpdated: true,
        alinanMallar: alinanMallar,
        verilenMallar: verilenMallar,
        updatedForAtolyeProducts: updatedProducts));
  }

  Future<void> _onGetOdemeGecmisi(
      EventAddOdemeGecmisi event, Emitter<DepoState> emit) async {
    emit(state.copyWith(isInprogress: true, isUpdated: false));

    DateTime now = DateTime.now();

    List<double> updatedOdemeGecmisi = List.from(event.odemeGecmisi);
    updatedOdemeGecmisi.add(event.odeme);

    List<dynamic> updatedOdemeTarihleri =
        List.from(event.product.odemeTarihleri);
    updatedOdemeTarihleri.add(now);

    event.product
        .updateOdemeGecmisi(updatedOdemeGecmisi, updatedOdemeTarihleri);

    await _statusService.updateStatus(event.product.id, {
      'odeme': event.odeme,
      'odemeGecmisi': updatedOdemeGecmisi,
      'odemeTarihleri': updatedOdemeTarihleri,
    });
    emit(state.copyWith(
      isInprogress: false,
      isUpdated: true,
      odemeGecmisi: updatedOdemeGecmisi,
    ));
  }

  Future<void> _onGetKalanTutar(
      EventGetKalanTutar event, Emitter<DepoState> emit) async {
    emit(state.copyWith(
      isInprogress: true,
      isUpdated: false,
    ));
    double kalanTutar = event.product.toplamUcret;

    for (var odeme in event.product.odemeGecmisi) {
      kalanTutar -= odeme;
    }
    emit(state.copyWith(
        isInprogress: false, isUpdated: true, kalanTutar: kalanTutar));
  }

  // Future<void> _onGetPrivProduct(
  //     EventGetPrivProduct event, Emitter<DepoState> emit) async {
  //   emit(state.copyWith(
  //     isInprogress: true,
  //     isUpdated: false,
  //   ));
  //   Depo product;
  //   for(var product in state.products) {
  //     if (
  //       product.id == event.urunId
  //     ) {
  //       product = 
  //     }
  //   }
  // }
}
