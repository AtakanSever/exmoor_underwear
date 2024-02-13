import 'package:exmoor_underwear/application/hesaplar/hesaplar_bloc.dart';
import 'package:exmoor_underwear/application/hesaplar/hesaplar_event.dart';
import 'package:exmoor_underwear/application/hesaplar/hesaplar_state.dart';
import 'package:exmoor_underwear/presentation/core/utils/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HesaplarPage extends StatefulWidget {
  const HesaplarPage({super.key});

  @override
  State<HesaplarPage> createState() => _HesaplarPageState();
}

class _HesaplarPageState extends State<HesaplarPage> {
  late DateTime _selectedDate = DateTime.now();
  String _selectedAtolyeAdi = 'atakan atolye';

  @override
  void initState() {
    super.initState();
    BlocProvider.of<HesaplarBloc>(context).add(EventGetHaftalikHesaplar(
        selectedDate: _selectedDate, selectedAtolye: _selectedAtolyeAdi));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HesaplarBloc, HesaplarState>(
      builder: (context, state) {
        if (state.isInprogress) {
          return const Center(child: CircularProgressIndicator());
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text('Hesaplar'),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                DropdownButton(
                  value: _selectedAtolyeAdi,
                  items:
                      state.atolyeler.toSet().toList().map((String atolyeAdi) {
                    return DropdownMenuItem(
                      value: atolyeAdi,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 4),
                        decoration: BoxDecoration(
                            color: Colors.deepOrange.shade100,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          atolyeAdi,
                          style: AppTextStyle.dropdownStyle,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedAtolyeAdi = newValue!;
                      BlocProvider.of<HesaplarBloc>(context).add(
                          EventGetHaftalikHesaplar(
                              selectedAtolye: _selectedAtolyeAdi,
                              selectedDate: _selectedDate));
                    });
                    print(_selectedAtolyeAdi);
                  },
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.deepOrange.shade100,
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Aylık Hesap',
                            style: AppTextStyle.hesapDonemStyle,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 6, right: 16),
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 248, 182, 161),
                                border: Border.all(
                                    color: Colors.deepOrange.shade400,
                                    width: 2.5),
                                borderRadius: BorderRadius.circular(20)),
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      _selectDate(context);
                                      BlocProvider.of<HesaplarBloc>(context)
                                          .add(EventGetHaftalikHesaplar(
                                              selectedAtolye:
                                                  _selectedAtolyeAdi,
                                              selectedDate: _selectedDate));
                                    },
                                    icon: const Icon(
                                      Icons.date_range_outlined,
                                      size: 28,
                                    )),
                                Text(
                                  "${_selectedDate.month}/${_selectedDate.year}",
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const Text(
                            'Toplam Haftalık Tutar:  ',
                            style: AppTextStyle.hesapInfoPublicStyle,
                          ),
                          Text(
                            "₺" + state.aylikToplamUcret.toString(),
                            style: AppTextStyle.hesapInfoDescriptionStyle,
                          ),
                        ],
                      ),
                      const Divider(
                        thickness: 0.5,
                        height: 20,
                      ),
                      Row(
                        children: [
                          const Text('Toplam Yapılan Ödeme:  ',
                              style: AppTextStyle.hesapInfoPublicStyle),
                          Text(
                            "₺" + state.aylikYapilanOdeme.toString(),
                            style: AppTextStyle.hesapInfoDescriptionStyle,
                          ),
                        ],
                      ),
                      const Divider(
                        thickness: 0.5,
                        height: 20,
                      ),
                      Row(
                        children: [
                          const Text('Toplam Kalan Ödeme:  ',
                              style: AppTextStyle.hesapInfoPublicStyle),
                          Text("₺" + state.aylikKalanUcret.toString(),
                              style: AppTextStyle.hesapInfoDescriptionStyle),
                        ],
                      ),
                      const Divider(
                        thickness: 0.5,
                        height: 20,
                      ),
                      Row(
                        children: [
                          const Text('Toplam Alınan Mal:  ',
                              style: AppTextStyle.hesapInfoPublicStyle),
                          Text(state.aylikToplamAlinanMal.toString(),
                              style: AppTextStyle.hesapInfoDescriptionStyle),
                        ],
                      ),
                      const Divider(
                        thickness: 0.5,
                        height: 20,
                      ),
                      Row(
                        children: [
                          const Text('Toplam Verilen Mal:  ',
                              style: AppTextStyle.hesapInfoPublicStyle),
                          Text(state.aylikToplamVerilenMal.toString(),
                              style: AppTextStyle.hesapInfoDescriptionStyle),
                        ],
                      ),
                      const Divider(
                        thickness: 0.5,
                        height: 20,
                      ),
                      Row(
                        children: [
                          const Text('Toplam Sakat Mal:  ',
                              style: AppTextStyle.hesapInfoPublicStyle),
                          Text(state.aylikToplamSakatMal.toString(),
                              style: AppTextStyle.hesapInfoDescriptionStyle),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.deepOrange.shade300,
                      borderRadius: BorderRadius.circular(20)),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.deepOrange,
                      borderRadius: BorderRadius.circular(20)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.deepOrange,
            ),
          ),
          child: child!,
        );
      },
      initialDatePickerMode: DatePickerMode.year,
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
      BlocProvider.of<HesaplarBloc>(context).add(EventGetHaftalikHesaplar(
          selectedAtolye: _selectedAtolyeAdi, selectedDate: picked));
    }
  }
}
