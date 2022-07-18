import 'package:another_flushbar/flushbar.dart';
import 'package:djubli/view/detail_view.dart';
import 'package:djubli/view_model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import 'package:get/get.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  late TooltipBehavior _tooltipBehavior;
  late PageController _pageController;
  int activePage = 1;
  TextEditingController id = TextEditingController();
  TextEditingController _validationstring = TextEditingController();

  List<Widget> indicators(dataLength,currentIndex) {
    return List<Widget>.generate(dataLength, (index) {
      return Container(
        margin: EdgeInsets.all(3),
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            color: currentIndex == index ? Colors.black : Colors.black26,
            shape: BoxShape.circle),
      );
    });
  }
  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(
      enable: true,
      // builder:changecarousel(idchart)
    );
    // tooltip();
    super.initState();
    _pageController = PageController(viewportFraction: 0.8);
  }

  @override
  Widget build(BuildContext context) {
    var _getdata = Get.put(HomeController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Penjualan Innova 2.5'),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Text("Echarts"),
              Container(
                width: Get.width,
                height: 250,
                color: Colors.red,
                child: Echarts(
                  option: '''
                  {
     title: {
    text: "Toyota Innova 2.5V AT",
    left: "center",
    textStyle: {
      fontSize: 20
    },},
      tooltip: {
    trigger: 'axis',
    axisPointer: {
      type: 'cross'
    }
  },
     xAxis: {},
  yAxis: {  },
  series: [
    {
      symbolSize: 20,
      data: [
        [15, 500],
        [16, 400],
        [17, 335],
        [17, 300],
        [18, 200]
      ],
      type: 'scatter'
    }
  ]
                  }
                ''',
                ),
              ),
              SizedBox(height: 10),
              Text("Syncfusion Chart"),
              Text('Penjualan Innova 2.5 AT',
              style: TextStyle(
                fontWeight: FontWeight.bold
              ),),
              Container(
                height: 250,
                width: Get.width,
                child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  series: <ChartSeries>[
                    ScatterSeries<SalesData, String>(
                        dataSource: <SalesData>[
                    SalesData('2015', 500000000),
                    SalesData('2016', 400000000),
                    SalesData('2017', 335000000),
                    SalesData('2017', 300000000),
                    SalesData('2018', 200000000)
                    ],
                      xValueMapper: (SalesData sales, _) => sales.year,
                      yValueMapper: (SalesData sales, _) => sales.sales,
                      xAxisName: "Tahun",
                      yAxisName: "Harga"
                    )
                  ],
                  tooltipBehavior: _tooltipBehavior,
                    onTooltipRender: (TooltipArgs args) {
                      // args.text = '1';
                      print(args.pointIndex);
                      changecarousel(int.parse("${args.pointIndex}"));
                    }
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(10),
              //   child: TextField(
              //     controller: id,
              //   ),
              // ),
              // ElevatedButton(
              //     onPressed: (){
              //       setState(() {
              //         activePage = int.parse(id.text);
              //         _pageController.jumpToPage(int.parse(id.text));
              //         print(activePage);
              //       });
              //     },
              //     child: Text("Test")),
            Text("Toyota Innova 2.5V AT",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),),
            SizedBox(height: 10),
            Container(
              height: 250,
              width: Get.width,
              child: PageView.builder(
                  itemCount: _getdata.datamobilinova.length,
                  pageSnapping: true,
                  controller: _pageController,
                  onPageChanged: (page) {
                    setState(() {
                      activePage = page;
                      print(activePage);
                    });
                  },
                  itemBuilder: (context, pagePosition) {
                    return InkWell(
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius:BorderRadius.all(Radius.circular(10)),
                            child: Image.network(_getdata.datamobilinova[pagePosition]["img"]),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Harga : "),
                              Text("Rp ${_getdata.datamobilinova[pagePosition]["harga"]}"),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("KM : "),
                              Text("${_getdata.datamobilinova[pagePosition]["KM"]}"),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Lokasi : "),
                              Text("${_getdata.datamobilinova[pagePosition]["lokasi"]}"),
                            ],
                          ),
                        ],
                      ),
                      onTap: (){
                        Get.to(() => Detail(), arguments: [
                          _getdata.datamobilinova[pagePosition]["img"],
                          _getdata.datamobilinova[pagePosition]["KM"],
                          _getdata.datamobilinova[pagePosition]["harga"],
                          _getdata.datamobilinova[pagePosition]["lokasi"],
                        ]);
                        print(_getdata.datamobilinova[pagePosition]["lokasi"]);
                      },
                    );
                  }),
            ),
              // Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: indicators(_getdata.datamobilinova.length,activePage))



            ],
          ),
        ),
      ),
    );
  }

   changecarousel(int idcharts){
    setState(() {
      activePage = idcharts;
      _pageController.jumpToPage(idcharts);
      print(activePage);
    });
  }
}
class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;

}
class Customer {
  String name;
  int age;
  Customer(this.name, this.age);
  @override
  String toString() {
    return '{ ${this.name}, ${this.age} }';
  }
}
