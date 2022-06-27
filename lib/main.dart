
// ignore_for_file: deprecated_member_use

import 'dart:developer';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'model/model_gunung.dart';
import 'package:info_pendakian/semua.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => HomeController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends GetView<HomeController> {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("Assalamu Alaikum",
                style: TextStyle(fontSize: 16, color: Colors.black)),
            Text("Rahmat Hidayat",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
          ],
        ),
        actions: <Widget>[
          Obx(
            () => (controller.isLogin.isFalse)
                ? Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: IconButton(
                      icon: const Icon(Icons.person,
                          size: 32, color: Colors.lightBlue),
                      onPressed: () {
                        controller.alerLogin(context);
                      },
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: IconButton(
                      icon: const Icon(Icons.exit_to_app,
                          size: 30, color: Colors.lightBlue),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => const Logout(),
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),
      body: Obx(
        () => controller.isLoading.isTrue
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  SizedBox(
                    height: 248,
                    child: Swiper(
                      onIndexChanged: (index) {
                        controller.counter.value = index;
                      },
                      viewportFraction: 0.94,
                      scale: 0.9,
                      itemCount: controller.imgList.length,
                      itemBuilder: (context, index) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(controller.imgList[index]),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: const [
                            Padding(padding: EdgeInsets.all(10)),
                            Text(
                              "   Lokasi Gunung",
                              style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: controller.listData.length,
                      padding: const EdgeInsets.only(bottom: 10),
                      itemBuilder: (context, index) {
                        return CardCostum(controller.listData[index]);
                        // return Text(controller.listProv[index].namaProvinsi);
                      },
                    ),
                  ),
                  // Expanded(
                  //   child: ListView.builder(
                  //     itemCount: controller.listData.length,
                  //     padding: const EdgeInsets.only(bottom: 10),
                  //     itemBuilder: (context, index) {
                  //       return CardCostum(controller.listData[index]);
                  //       // return Text(controller.listProv[index].namaProvinsi);
                  //     },
                  //   ),
                  // ),
                ],
              ),
      ),
    );
  }
}

class CardCostum extends GetView<HomeController> {
  final ListDataGunung dataGunung;
  const CardCostum(this.dataGunung, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      borderOnForeground: true,
      elevation: 5,
      margin: const EdgeInsets.only(bottom: 9, left: 12, right: 12, top: 7),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Get.to(
            Semua(
              modelGunung: dataGunung,
            ),
          );
        },
        child: Obx(
          () => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: NetworkImage(
                  controller.imgList[controller.counter.value],
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              heightFactor: 1.25,
              child: ListTile(
                title: Text(
                  dataGunung.modelProv.namaProvinsi,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HomeController extends GetxController {
  final counter = 0.obs;
  var isLogin = false.obs;
  final ip = 'http://10.0.2.2/contoh/';
  var isSearch = false.obs;

  final List<String> imgList = [
    'https://images.unsplash.com/photo-1518070588484-2b53926cba76?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8Z3VudW5nfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=600&q=60',
    'https://images.unsplash.com/photo-1538179277954-803c91b55fee?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OXx8Z3VudW5nfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=600&q=60',
    'https://images.unsplash.com/photo-1571967260643-8c677cf925df?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8Z3VudW5nfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=600&q=60',
    'https://images.unsplash.com/photo-1542261777448-23d2a287091c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1770&q=80 ',
    'https://images.unsplash.com/photo-1536077891673-5a03ebcd8ebe?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8Z3VudW5nfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=600&q=60',
    'https://images.unsplash.com/photo-1454496522488-7a8e488e8606?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxjb2xsZWN0aW9uLXBhZ2V8MXwyMTM5NzUyfHxlbnwwfHx8fA%3D%3D&auto=format&fit=crop&w=600&q=60',
  ];

  List<ListDataGunung> listData = [];
  var listDataGunung = <ModelGunung>[];
  var listSemua = <ModelGunung>[];
  var listProv = <ModelProv>[];

  final isLoading = false.obs;

  Future _getData() async {
    try {
      isLoading.value = true;
      final response = await http.get(Uri.parse("${ip}api/api.php"));
      final responseProv = await http.get(Uri.parse("${ip}api/apiprov.php"));

      if (response.statusCode == 200) {
        listDataGunung = modelGunungFromJson(response.body);
      } else {
        throw Exception('Failed to load data');
      }

      if (responseProv.statusCode == 200) {
        listProv = modelProvFromJson(responseProv.body);
        for (var value in listProv) {
          log(value.namaProvinsi);
          listData.add(
            ListDataGunung(
              modelGunung: listDataGunung
                  .where((element) => value.idProvinsi == element.idProvinsi)
                  .toList(),
              modelProv: value,
            ),
          );
        }
        listData.sort((a, b) =>
            a.modelProv.namaProvinsi.compareTo(b.modelProv.namaProvinsi));
        listData = [
          ListDataGunung(
            modelGunung: listDataGunung,
            modelProv: ModelProv(idProvinsi: "5", namaProvinsi: "Semua"),
          ),
          ...listData
        ];
      }
    } catch (e) {
      // throw Exception(e.toString());
    }
    isLoading.value = false;
  }

  void alerLogin(BuildContext context) {
    final myUsernameController = TextEditingController();
    final myPasswordController = TextEditingController();
    String username = "", password = "";
    //tambahkan form
    final _formKey = GlobalKey<FormState>();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Login"),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please input your username";
                  }
                  return null;
                },
                controller: myUsernameController,
                decoration: const InputDecoration(
                  labelText: "Username",
                ),
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please input password";
                  }
                  return null;
                },
                maxLength: 16,
                obscureText: true,
                // maxLengthEnforced: true,
                controller: myPasswordController,
                decoration: const InputDecoration(
                  labelText: "Password",
                ),
              ),
              MaterialButton(
                minWidth: 80.0,
                height: 40.0,
                color: Colors.lightBlue,
                textColor: Colors.white,
                onPressed: () {
                  isLogin.value = true;
                  username = myUsernameController.text;
                  password = myPasswordController.text;

                  if (_formKey.currentState!.validate()) {
                    if (username == "user" && password == "123") {
                      Navigator.pop(context);
                      // isSearch.value = true;
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Login Failed"),
                          content:
                              const Text("Username or password is incorrect"),
                          actions: <Widget>[
                            FlatButton(
                              child: const Text("OK"),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      );
                    }
                  }
                },
                child: const Text("Login"),
              ),
              FlatButton(
                child: const Text("Cancel"),
                onPressed: () {
                  isLogin.value = false;
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void onInit() async {
    await _getData();
    super.onInit();
  }
}

class Logout extends GetView<HomeController> {
  const Logout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AlertDialog(
        title: const Text("Logout"),
        content: const Text("Are you sure?"),
        actions: <Widget>[
          FlatButton(
            child: const Text("Yes"),
            onPressed: () {
              controller.isLogin.value = false;
              Navigator.pop(context);
            },
          ),
          FlatButton(
            child: const Text("No"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
