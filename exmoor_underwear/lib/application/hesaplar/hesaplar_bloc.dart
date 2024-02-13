import 'package:exmoor_underwear/application/hesaplar/hesaplar_event.dart';
import 'package:exmoor_underwear/application/hesaplar/hesaplar_state.dart';
import 'package:exmoor_underwear/domain/status/depo_model.dart';
import 'package:exmoor_underwear/infrastracture/status/status_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HesaplarBloc extends Bloc<HesaplarEvent, HesaplarState> {
  HesaplarBloc() : super(HesaplarState()) {
    on<EventGetHaftalikHesaplar>(_onGetHaftalikHesaplar);
  }
  StatusService _statusService = StatusService();

  Future<void> _onGetHaftalikHesaplar(
      EventGetHaftalikHesaplar event, Emitter<HesaplarState> emit) async {
    emit(state.copyWith(
      isInprogress: true,
      isUpdated: false,
    ));
    List<Depo> depoList = await _statusService.getStatusList();

    /// atolyeler listesi
    List<String> atolyeler = [];
    for (var depo in depoList) {
      atolyeler.add(depo.atolyeAdi);
    }

    /// aylık toplam yapılan ödeme
    double toplamAylikYapilanOdeme = 0;
    for (var depo in depoList) {
      if (depo.urunTarihi.year == event.selectedDate.year &&
          depo.urunTarihi.month == event.selectedDate.month &&
          event.selectedAtolye == depo.atolyeAdi) {
        for (var odeme in depo.odemeGecmisi) {
          if (odeme is num) {
            toplamAylikYapilanOdeme += odeme;
          }
        }
      }
    }
    
    /// aylık toplam ücretler
    double aylikToplamlUcret = 0;
    for (var depo in depoList) {
      if (depo.urunTarihi.year == event.selectedDate.year &&
          depo.urunTarihi.month == event.selectedDate.month &&
          event.selectedAtolye == depo.atolyeAdi) {
        if (depo.toplamUcret is num) {
          aylikToplamlUcret += depo.toplamUcret;
        }
      }
    }

    /// aylık kalan tutar
    double aylikKalanTutar = aylikToplamlUcret - toplamAylikYapilanOdeme;

    /// aylık toplam alınan mal
    /// aylık toplam verilen mal
    int aylikToplamAlinanMal = 0;
    int aylikToplamVerilenMal = 0;
    for (var depo in depoList) {
      if (depo.urunTarihi.year == event.selectedDate.year &&
          depo.urunTarihi.month == event.selectedDate.month &&
          event.selectedAtolye == depo.atolyeAdi) {
        if (depo.alinanVerilenUrun == true) {
          aylikToplamAlinanMal += depo.urunMiktari;
        } else {
          aylikToplamVerilenMal += depo.urunMiktari;
        }
      }
    }

    /// aylık toplam sakat mal
    int aylikToplamSakatMal = 0;
    for (var depo in depoList) {
      if (depo.urunTarihi.year == event.selectedDate.year &&
          depo.urunTarihi.month == event.selectedDate.month &&
          event.selectedAtolye == depo.atolyeAdi) {
        aylikToplamSakatMal += depo.sakatMal;
      }
    }

    emit(state.copyWith(
      isInprogress: false,
      isUpdated: true,
      aylikYapilanOdeme: toplamAylikYapilanOdeme,
      aylikToplamUcret: aylikToplamlUcret,
      aylikKalanUcret: aylikKalanTutar,
      aylikToplamAlinanMal: aylikToplamAlinanMal,
      aylikToplamVerilenMal: aylikToplamVerilenMal,
      aylikToplamSakatMal: aylikToplamSakatMal,
      atolyeler: atolyeler,
    ));
  }
}
