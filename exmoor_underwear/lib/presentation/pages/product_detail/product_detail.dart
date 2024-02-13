import 'package:exmoor_underwear/application/depo/depo_bloc.dart';
import 'package:exmoor_underwear/application/depo/depo_event.dart';
import 'package:exmoor_underwear/application/depo/depo_state.dart';
import 'package:exmoor_underwear/domain/status/depo_model.dart';
import 'package:exmoor_underwear/infrastracture/status/status_service.dart';
import 'package:exmoor_underwear/presentation/core/utils/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class ProductDetailPage extends StatefulWidget {
  Depo selectedProduct;
  ProductDetailPage({super.key, required this.selectedProduct});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  TextEditingController odemeController = TextEditingController();
  @override
  void initState() {
    super.initState();
    BlocProvider.of<DepoBloc>(context)
        .add(EventGetKalanTutar(product: widget.selectedProduct));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DepoBloc, DepoState>(
      builder: (context, state) {
        if (state.isInprogress) {
          return const Center(child: CircularProgressIndicator());
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text('Ürün detayı'),
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: ClipRect(
                      child: widget.selectedProduct.image == ""
                          ? Image.asset("assets/images/spiderman.png")
                          : Image.network(widget.selectedProduct.image)),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Container(
                    width: 400,
                    decoration: BoxDecoration(
                        color: Colors.deepOrange.shade100,
                        borderRadius: BorderRadius.circular(30)),
                    child: Text(
                      widget.selectedProduct.urunAdi,
                      style: AppTextStyle.urunAdiStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Divider(
                        thickness: 1,
                        height: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 226, 217),
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Text(
                                  'Atölye Adı: ',
                                  style: AppTextStyle.detailPublicStyle,
                                ),
                                Text(
                                  widget.selectedProduct.atolyeAdi,
                                  style: AppTextStyle.detailDescriptionStyle,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            const Divider(
                              thickness: 1,
                              height: 20,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Ürün Miktarı (${widget.selectedProduct.birimi}) : ',
                                  style: AppTextStyle.detailPublicStyle,
                                ),
                                Text(
                                  widget.selectedProduct.urunMiktari.toString(),
                                  style: AppTextStyle.detailDescriptionStyle,
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                const Text(
                                  'Sakat Mal: ',
                                  style: AppTextStyle.detailPublicStyle,
                                ),
                                Text(
                                  widget.selectedProduct.sakatMal.toString(),
                                  style: AppTextStyle.detailDescriptionStyle,
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                const Text(
                                  'Sağlam Mal: ',
                                  style: AppTextStyle.detailPublicStyle,
                                ),
                                Text(
                                  "${widget.selectedProduct.urunMiktari - widget.selectedProduct.sakatMal}",
                                  style: AppTextStyle.detailDescriptionStyle,
                                )
                              ],
                            ),
                            const Divider(
                              thickness: 1,
                              height: 20,
                            ),
                            Row(
                              children: [
                                const Text(
                                  'Ürün Başı Ücret:  ',
                                  style: AppTextStyle.detailPublicStyle,
                                ),
                                Text("₺${widget.selectedProduct.urunBasiUcret}",
                                    style: AppTextStyle.detailDescriptionStyle)
                              ],
                            ),
                            const Divider(
                              thickness: 1,
                              height: 20,
                            ),
                            Row(
                              children: [
                                const Text(
                                  'Toplam Ücret: ',
                                  style: AppTextStyle.detailPublicStyle,
                                ),
                                Text("₺${widget.selectedProduct.toplamUcret}",
                                    style: AppTextStyle.detailDescriptionStyle)
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        thickness: 1,
                        height: 20,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 75,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                            color: Colors.deepOrange,
                            border: Border.all(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 3,
                                child: TextField(
                                  controller: odemeController,
                                  style: const TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                      labelText: 'Ödeme tutarını gir',
                                      labelStyle: const TextStyle(
                                          color: Colors.white70),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.white54),
                                          borderRadius:
                                              BorderRadius.circular(20))),
                                )),
                            const SizedBox(
                              width: 20,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  BlocProvider.of<DepoBloc>(context).add(
                                      EventAddOdemeGecmisi(
                                          odeme: double.tryParse(
                                                  odemeController.text) ??
                                              0,
                                          product: widget.selectedProduct,
                                          odemeGecmisi: widget
                                              .selectedProduct.odemeGecmisi,
                                          odemeTarihleri: widget
                                              .selectedProduct.odemeTarihleri));
                                  BlocProvider.of<DepoBloc>(context).add(
                                      EventGetKalanTutar(
                                          product: widget.selectedProduct));
                                },
                                child: const Text('Ödeme Yap'))
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 226, 217),
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            const Center(
                              child: Text(
                                'Ödeme Geçmişi: ',
                                style: AppTextStyle.odemeGecmisiPubliStyle,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                  color: Colors.deepOrange.shade200,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Kalan Tutar: ',
                                    style: AppTextStyle.kalanTutarPublicStyle,
                                  ),
                                  Text(
                                    "₺${state.kalanTutar}",
                                    style:
                                        AppTextStyle.kalanTutarDescriptionStyle,
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: 250,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              decoration: BoxDecoration(
                                  color: Colors.deepOrange,
                                  borderRadius: BorderRadius.circular(20)),
                              child: ListView.separated(
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        const Divider(),
                                shrinkWrap: true,
                                itemCount:
                                    widget.selectedProduct.odemeGecmisi.length,
                                itemBuilder: (context, index) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "-₺${widget.selectedProduct.odemeGecmisi[index]}",
                                        style:
                                            AppTextStyle.odemeDescriptionStyle,
                                      ),
                                      Column(
                                        children: [
                                          const Text('Ödeme Tarihi'),
                                          Text(
                                            DateFormat('dd.MM.yyyy HH:mm')
                                                .format(widget.selectedProduct
                                                    .odemeTarihleri[index]),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
