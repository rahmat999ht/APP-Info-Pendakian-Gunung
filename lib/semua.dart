// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_pendakian/model/model_gunung.dart';
import 'main.dart';
import 'onview.dart';

class Semua extends StatefulWidget {
  final ListDataGunung modelGunung;
  const Semua({
    Key? key,
    required this.modelGunung,
  }) : super(key: key);

  @override
  State<Semua> createState() => _SemuaState();
}

class _SemuaState extends State<Semua> {
  //untuk mengontroll textfield saat ada perubahan
  final TextEditingController _controllerSearch = TextEditingController();
  //data bertipe widget ini mulanya kita buat text.

  final namlok = Get.put(HomeController().listData);
  Widget? searchTextField;
  Widget? searchIcon;

  //jika false maka tampilkan icon pencarian
  final controller = Get.put(HomeController());

  var list = <ModelGunung>[];

  @override
  void initState() {
    super.initState();
    //saat file ini dijalankan pertama kali
    //maka data list akan diisi dengan data dari data.dart
    list.addAll(widget.modelGunung.modelGunung);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Get.back();
          },
        ),
        elevation: 0.0,
        title: controller.isLogin.isTrue && controller.isSearch.isTrue
            ? searchTextField
            : Text(
                widget.modelGunung.modelProv.namaProvinsi,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
        titleTextStyle: const TextStyle(color: Colors.black),
        actions: <Widget>[
          Obx(
            () => (controller.isSearch.value == false)
                ? IconButton(
                    icon: const Icon(Icons.search, color: Colors.black),
                    onPressed: () {
                      setState(() {
                        if (controller.isLogin.value == false) {
                          showDialog(
                            barrierColor: Colors.transparent.withOpacity(0.5),
                            context: context,
                            builder: (context) => AlertDialog(
                              content: const Text(
                                  "Anda harus login terlebih dahulu"),
                              actions: [
                                FlatButton(
                                  child: const Text("LOGIN ?"),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    controller.alerLogin(context);
                                    _controllerSearch.clear();
                                  },
                                ),
                              ],
                            ),
                          );
                        } else {
                          controller.isSearch.value = true;
                          controller.isLogin.isTrue;
                          searchTextField = appSearch(context);
                          _controllerSearch.clear();
                        }
                      });
                    },
                  )
                : searchIcon = IconButton(
                    icon: const Icon(Icons.close, color: Colors.black),
                    onPressed: () {
                      setState(
                        () {
                          controller.isSearch.value = true;
                          controller.isLogin.isTrue;
                          _controllerSearch.clear();
                          searchTextField = null;
                          list.clear();
                          list.addAll(widget.modelGunung.modelGunung.obs);
                          controller.isSearch.value = false;
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
      body: GridView.builder(
        itemCount: list.length,
        padding: const EdgeInsets.all(10),
        //widget yang akan ditampilkan dalam 1 baris adalah 2
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.19,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (BuildContext context, int index) {
          var data = list[index];
          return InkWell(
            onTap: () {
              Get.to(() => OnView(
                    dataGunung: data,
                  ));
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 10,
              child: Column(
                children: [
                  Container(
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      image: DecorationImage(
                        image: NetworkImage(
                          "${controller.ip}gambar/${data.image1}",
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              data.nama,
                              style: const TextStyle(fontSize: 15),
                            ),
                            Text(
                              data.lokasi,
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget appSearch(BuildContext context) {
    // var data = widget.modelGunung.modelGunung;
    return SizedBox(
      height: 50.0,
      child: TextField(
        controller: _controllerSearch,
        style: const TextStyle(color: Colors.black, fontSize: 15),
        decoration: InputDecoration(
          // labelText: widget.modelGunung.namalokasi,
          // labelStyle: const TextStyle(color: Colors.black, fontSize: 20),
          hintText: "Search",
          hintStyle: const TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(17),
          ),
        ),
        onChanged: (String value) {
          _searchName(value);
        },
      ),
    );
  }

//fungsi ini akan mencari nama sesuai yang diketikkan
  _searchName(String name) {
    var data = widget.modelGunung.modelGunung;
    if (name.isNotEmpty) {
      setState(() {
        list.clear();
        //melakukan perulangan/looping
        for (var item in data) {
          if (item.nama.toLowerCase().contains(name.toLowerCase()) ||
              item.lokasi.toLowerCase().contains(name.toLowerCase())) {
            list.add(item);
          }
        }
      });
    } else {
      setState(() {
        list.clear();
        list.addAll(data);
      });
    }
  }
}
