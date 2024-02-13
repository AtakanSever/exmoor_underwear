import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exmoor_underwear/application/depo/depo_bloc.dart';
import 'package:exmoor_underwear/application/depo/depo_event.dart';
import 'package:exmoor_underwear/application/depo/depo_state.dart';
import 'package:exmoor_underwear/infrastracture/status/status_service.dart';
import 'package:exmoor_underwear/presentation/core/utils/textStyle.dart';
import 'package:exmoor_underwear/presentation/pages/depo/add_product.dart';
import 'package:exmoor_underwear/presentation/pages/product_detail/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class StatusList extends StatefulWidget {
  const StatusList({Key? key});

  @override
  State<StatusList> createState() => _StatusListState();
}

class _StatusListState extends State<StatusList>
    with SingleTickerProviderStateMixin {
  String _selectedAtolyeAdi = 'tüm atölyeler';
  bool isAddedProduct = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => DepoBloc()..add(EventGetDepoProducts()),
      child: BlocBuilder<DepoBloc, DepoState>(
        builder: (context, state) {
          if (state.isInprogress) {
            return const Center(child: CircularProgressIndicator());
          }
          return Scaffold(
            appBar: AppBar(
              title: const Text('Statuss'),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: DropdownButton<String>(
                    value: _selectedAtolyeAdi,
                    items: state.atolyeler
                        .toSet()
                        .toList()
                        .map((String atolyeAdi) {
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
                        BlocProvider.of<DepoBloc>(context).add(
                            EventGetProductForAtolye(
                                selectedAtolye: newValue!));
                      });
                    },
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: state.verilenMallar.length,
                      itemBuilder: (context, index) {
                        var verilenProduct = state.verilenMallar[index];
                        // var alinanProduct = state.alinanMallar[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              children: [
                                Text('Verilen Mal'),
                                Container(
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ProductDetailPage(
                                                      selectedProduct:
                                                          verilenProduct)));
                                    },
                                    child: Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ListTile(
                                          title: Text(
                                            verilenProduct.urunAdi,
                                            style:
                                                AppTextStyle.detailTitleStyle,
                                          ),
                                          subtitle: Text(
                                            'Eklenme Tarihi: ${DateFormat('dd.MM.yyyy').format(verilenProduct.urunTarihi)}',
                                          ),
                                          leading: CircleAvatar(
                                            backgroundImage: verilenProduct.image == ""
                                                ? const AssetImage(
                                                    "assets/images/spiderman.png")
                                                : NetworkImage(verilenProduct.image)
                                                    as ImageProvider<Object>?,
                                            radius: 30,
                                          ),
                                          trailing: Text(
                                            verilenProduct.atolyeAdi,
                                            style: AppTextStyle
                                                .detailTrailingStyle,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Icon(
                                  Icons.keyboard_double_arrow_down_outlined,
                                  size: 40,
                                ),
                                Icon(
                                  Icons.keyboard_double_arrow_down_outlined,
                                  size: 40,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text('Alınan Mal'),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                          color: isAddedProduct
                                              ? Colors.black
                                              : Colors.grey.shade300)),
                                  child: isAddedProduct
                                      ? InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProductDetailPage(
                                                            selectedProduct:
                                                                verilenProduct)));
                                          },
                                          child: Card(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: ListTile(
                                                title: Text(
                                                  verilenProduct.urunAdi,
                                                  style: AppTextStyle
                                                      .detailTitleStyle,
                                                ),
                                                subtitle: Text(
                                                  'Eklenme Tarihi: ${DateFormat('dd.MM.yyyy').format(verilenProduct.urunTarihi)}',
                                                ),
                                                leading: CircleAvatar(
                                                  backgroundImage: verilenProduct
                                                              .image ==
                                                          ""
                                                      ? const AssetImage(
                                                          "assets/images/spiderman.png")
                                                      : NetworkImage(
                                                              verilenProduct.image)
                                                          as ImageProvider<
                                                              Object>?,
                                                  radius: 30,
                                                ),
                                                trailing: Text(
                                                  verilenProduct.atolyeAdi,
                                                  style: AppTextStyle
                                                      .detailTrailingStyle,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              isAddedProduct = true;
                                            });
                                            showModalBottomSheet(
                                              context: context,
                                              isScrollControlled: true,
                                              builder: (BuildContext context) {
                                                return SizedBox(
                                                  height: MediaQuery.of(context)
                                                      .size
                                                      .height,
                                                  child: AddProduct(),
                                                );
                                              },
                                            );
                                          },
                                          child:
                                              const Text('Alınan Malı Ekle')),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
