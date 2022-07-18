import 'package:djubli/view_model/detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Detail extends StatelessWidget {
  const Detail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _getData = Get.put(DetailController());
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Mobil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              height: 300,
              width: Get.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.grey[400],
              ),
              child: Column(
                children: [
                  Container(
                    height: 200,
                    width: Get.width,
                    child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: Image.network(_getData.image,fit: BoxFit.cover,)),
                  ),
                  // Text(_getData.image),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Container(
                        width: Get.width,
                        child: Text("KM : ${_getData.km}",
                          style:TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                          ) ,)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Container(
                        width: Get.width,
                        child: Text("Harga : Rp ${_getData.harga}",
                            style:TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                            ))),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Container(
                        width: Get.width,
                        child: Text("Lokasi : ${_getData.lokasi}",
                            style:TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                            ))),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
