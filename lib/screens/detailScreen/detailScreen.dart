import 'package:flutter/material.dart';




Widget DetailDisplay(double temperature, double humidity, double mq135Value){

  return SingleChildScrollView( child : Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        WeatherInfo(
          icon: Icons.thermostat,
          label: 'Temperature',
          value: '21°C',
        ),
        SizedBox(height: 20.0),
        WeatherInfo(
          icon: Icons.water_damage,
          label: 'Humidity',
          value: '$humidity%',
        ),
        SizedBox(height: 20.0),
        WeatherInfo(
          icon: Icons.cloud,
          label: 'MQ135 Value',
          value: '$mq135Value ppm',
        ),

      ],
    ),
  ));

}


class WeatherInfo extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const WeatherInfo({
    Key? key,
    required this.icon,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 255,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade400, Colors.blue.shade800],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            icon,
            color: Colors.white,
            size: 48.0,
          ),
          SizedBox(height: 20.0),
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 36.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
