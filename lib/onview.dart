import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:info_pendakian/model/model_gunung.dart';
import 'main.dart';

class OnView extends StatelessWidget {
  final ModelGunung dataGunung;
  const OnView({Key? key, required this.dataGunung}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    late GoogleMapController mapController;
    HomeController controller = Get.put(HomeController());

    void _onMapCreated(GoogleMapController controller) {
      mapController = controller;
    }

    var imgList = [
      dataGunung.image1,
      dataGunung.image2,
      dataGunung.image3,
      dataGunung.image4,
      dataGunung.image5,
    ];

    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                height: 262,
                child: Swiper(
                  onIndexChanged: (index) {
                    controller.counter.value = index;
                  },
                  viewportFraction: 1,
                  scale: 0.9,
                  itemCount: imgList.length,
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      child: Image.network(
                          "${controller.ip}gambar/${imgList[index]}"),
                      // child: Image.network('https://i.imgur.com/tGbaZCY.jpg'),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                       Radius.circular(12),
                    ),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 35,
                        child: Text(
                          dataGunung.nama,
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        child: Row(
                          children: [
                            const Icon(Icons.location_on,
                                color: Colors.blueAccent),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              dataGunung.lokasi,
                              style: const TextStyle(fontSize: 17),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        dataGunung.deskripsi + '\n',
                        style: const TextStyle(fontSize: 15),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: SizedBox(
                          height: 200,
                          child: GoogleMap(
                            initialCameraPosition: CameraPosition(
                              bearing: 1.0,
                              target: LatLng(double.parse(dataGunung.lat),
                                  double.parse(dataGunung.lon)),
                              zoom: 11,
                            ),
                            onMapCreated: _onMapCreated,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 35,
                        // ignore: unnecessary_const
                        child: const Text("Jalur Pendakian",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold)),
                      ),
                      Text(dataGunung.jalurPendakian + '\n',
                          style: const TextStyle(fontSize: 17)),
                      const SizedBox(
                        height: 35,
                        child: Text("Informasi Gunung",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold)),
                      ),
                      Text(dataGunung.infoGunung + '\n',
                          style: const TextStyle(fontSize: 17)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
