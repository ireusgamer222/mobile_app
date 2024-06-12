import 'dart:ui';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart' as guages;
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

import '../../api/localNotification.dart';

class detailsScreen extends StatefulWidget {
  @override
  _detailsScreen createState() => _detailsScreen();
}

List temperatureCharts = [0,0,0,0,0];

class _detailsScreen extends State<detailsScreen> {

  int _selectedIndex = 0;
  double currentTempValue = 0;
  double currentAirQualityValue = 0;
  double currentHumidityValue = 0;


  late DatabaseReference _tempRef;
  late DatabaseReference _airQualityRef;
  late DatabaseReference _humidityRef;

  void navigateToNextScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyHomePage()));
  }



  @override
  void initState() {
    super.initState();
    _tempRef = FirebaseDatabase.instance.ref('esp32/temperature');
    tempReader();
    _airQualityRef = FirebaseDatabase.instance.ref('esp32/airquality');
    airQualityReader();
    _humidityRef = FirebaseDatabase.instance.ref('esp32/humidity');
    humidityReader();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Montiroing Screen'),
      ),
      body:SizedBox.expand(
      child: Container(
      decoration: BoxDecoration(
      gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Colors.purple, Colors.red],
    ),
    ),
        child:       tempANDair(currentAirQualityValue, currentTempValue, currentHumidityValue),

      )),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: (index){
          if(index == 1){
            navigateToNextScreen(context);
          }
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Guages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.description),
            label: 'Graphs',
          ),

        ],
      ),
    );
  }


  void tempReader(){
    _tempRef.onValue.listen((event){
      if(event.snapshot.value !=null){
        try{
          dynamic result = double.parse(event.snapshot.value.toString());
          setState(() {
            currentTempValue = result * 2;

            if(result >= 50) {
              NotificationService.showNotification(
                  result, "High Temperature Alert","Temperature is: ${result.toStringAsFixed(1)} Celsius,\n Call Emergency number");
            }
          });
        }
        catch(e){
          print(e);
        }
      }
      else{
        print("Nothing ");
      }
    });
  }

  void airQualityReader(){
    _airQualityRef.onValue.listen((event){
      if(event.snapshot.value !=null){
        try{
          dynamic result = double.parse(event.snapshot.value.toString());
          setState(() {

            currentAirQualityValue = result / 10;
            if(result >= 800) {
              NotificationService.showNotification(
                  result, "High Air quality value Alert","Carbon dixode concenration is too high: ${result.toStringAsFixed(1)} ppm");
            }
          });
        }
        catch(e){
          print(e);
        }
      }
      else{
        print("Nothing ");
      }
    });
  }

  void humidityReader(){
    _humidityRef.onValue.listen((event){
      if(event.snapshot.value !=null){
        try{
          dynamic result = double.parse(event.snapshot.value.toString());
          setState(() {
            currentHumidityValue = result;
          });
        }
        catch(e){
          print(e);
        }
      }
      else{
        print("Nothing ");
      }
    });
  }
}



Widget tempANDair(currentAirQualityValue,currentTempValue,x){
  return SingleChildScrollView(child : Center(
  child: Container(child:
  Column(children: [Text("\nAir quality Value\n",style: TextStyle(color: Colors.white,fontSize: 24),),gauge(currentAirQualityValue),Text("\nTemperautre Value\n",style: TextStyle(color: Colors.white,fontSize: 24),),gauge(currentTempValue),Text("\nHumidity Value\n",style: TextStyle(color: Colors.white,fontSize: 24),),gauge(x)]),width: 400,height: 1500,)
  ));
}

Widget gauge(double temp){

  return guages.SfRadialGauge(
      axes: <guages.RadialAxis>[
        guages.RadialAxis(
          pointers: <guages.GaugePointer>[
            guages.RangePointer(
                value: temp,
                cornerStyle: guages.CornerStyle.bothCurve,
                width: 25,
                sizeUnit: guages.GaugeSizeUnit.logicalPixel,
                gradient: const SweepGradient(
                    colors: <Color>[
                      Color(0xFFCC2B5E),
                      Color(0xFF753A88)
                    ],
                    stops: <double>[0.25, 0.75]
                )),
            guages.MarkerPointer(
                value: temp,
                enableDragging: true,
                markerHeight: 34,
                markerWidth: 34,
                markerType: guages.MarkerType.circle,
                color: Color(0xFF753A88),
                borderWidth: 2,
                borderColor: Colors.white54)
          ],      )
      ]
  );


}





class MyHomePage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<_SalesData> data = [
    _SalesData('Jan', 35),
    _SalesData('Feb', 28),
    _SalesData('Mar', 34),
    _SalesData('Apr', 32),
    _SalesData('May', 40)
  ];

  late DatabaseReference _tempRef;
  double currentTempValue = 0;
  List <double>temperatureValue  = [24,28,30,25,23];

  @override
  void initState() {
    super.initState();
    _tempRef = FirebaseDatabase.instance.ref('esp32/temperature');
    tempReader();
    for(int i = 0;i<5;i++){
      print(temperatureValue[i]);
      data[i] = _SalesData((i+1).toString(), temperatureValue[i]);
    }
  }


  int z = 0;
  void tempReader(){
    _tempRef.onValue.listen((event){
      if(event.snapshot.value !=null){
        try{
          dynamic result = double.parse(event.snapshot.value.toString());
          setState(() {
            currentTempValue = result;
            temperatureValue[z] = result;

            for(int i = 0;i<5;i++){
              print(temperatureValue[i]);
              data[i] = _SalesData((i+1).toString(), temperatureValue[i]);
            }
            z++;
            if(z>4){
              z = 0;
            }

          });
        }
        catch(e){
          print(e);
        }
      }
      else{
        print("Nothing bitch");
      }
    });
  }

  void navigateToNextScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => detailsScreen()));
  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(
        appBar: AppBar(
          title: const Text('Temperature Graph Chart'),
        ),
        body: SizedBox.expand(
      child: Container(
      decoration: BoxDecoration(
      gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Colors.purple, Colors.red],
    ),
    ),
        child:Center( child : Column(children: [
          const SizedBox(height: 225,),
          //Initialize the chart widget
          Container(
            color: Colors.white,
            width: 400,
            height: 310,
            child: SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                // Chart title
                title: ChartTitle(text: 'Temperature Graph'),
                // Enable legend
                legend: Legend(isVisible: true),
                // Enable tooltip
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <CartesianSeries<_SalesData, String>>[
                  LineSeries<_SalesData, String>(
                      dataSource: data,
                      xValueMapper: (_SalesData sales, _) => sales.year,
                      yValueMapper: (_SalesData sales, _) => sales.sales,
                      name: 'Temperatures',
                      // Enable data label
                      dataLabelSettings: DataLabelSettings(isVisible: true))
                ]),
          )

        ])),
      )),


      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.grey,
        currentIndex: 1,
        onTap: (index){
          if(index == 0){
            navigateToNextScreen(context);
          }
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Guages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.description),
            label: 'Graphs',
          ),

        ],
      ),);
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
