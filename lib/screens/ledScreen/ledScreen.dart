import 'dart:math' as math;
import 'dart:math';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class LedScreen extends StatefulWidget {
  @override
  _LedScreen createState() => _LedScreen();
}

class _LedScreen extends State<LedScreen> {


  DatabaseReference _ledSwitchRef = FirebaseDatabase.instance.ref('ledswitch');
  DatabaseReference _ledValueRef = FirebaseDatabase.instance.ref('ledvalue');

  @override
  void initState() {
    super.initState();


  }

  bool _enable = false;
  Future<void> ledSwitchSetter(bool finalinput) async {
    await _ledSwitchRef.set({
      "ledswitch": finalinput,
    }
    );
  }

  CustomSwitch switchLED(){
    return CustomSwitch(
      value: _enable,
      onChanged: (bool val){
        setState(() {
          _enable = val;
          ledSwitchSetter(_enable);

        });
      },
    );
  }

  Future<void> ledValueSetter(double number) async {
    await _ledValueRef.set({
      "ledvalue": number,
    }
    );
  }

  double _hue = 0.0;
  double _saturation = 1.0;
  double _value = 1.0;

  void _onColorChanged(double hue, double saturation, double value) {
    setState(() {
      _hue = hue;
      _saturation = saturation;
      _value = value;
      ledValueSetter(_hue);


    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LED Switch Screen'),
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
      child:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment:MainAxisAlignment.center,children: [Text("LED Switch",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),
            ),
              const SizedBox(width: 30,),
              switchLED(),
            ],),
            const SizedBox(height: 40,),
            Container(
              child: Center(child: Text("LED Color Wheel Picker",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),
              ),),
            ),
            const SizedBox(height: 20,),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 200,
                  height: 200,
                  child: CustomPaint(
                    painter: ColorWheelPainter(_hue, _saturation, _value),
                  ),
                ),
                Transform.rotate(
                  angle: _hue * pi / 180,
                  child: Container(
                    width: 160,
                    height: 160,
                    child: CustomPaint(
                      painter: HueGaugePainter(_hue),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'RGB: ${HSVColor.fromAHSV(1.0, _hue, _saturation, _value).toColor().red}, '
                  '${HSVColor.fromAHSV(1.0, _hue, _saturation, _value).toColor().green}, '
                  '${HSVColor.fromAHSV(1.0, _hue, _saturation, _value).toColor().blue}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Slider(
              value: _hue,
              min: 0,
              max: 180,
              onChanged: (value) {
                _onColorChanged(value, _saturation, _value);
              },
              label: 'Hue',
              divisions: 360,
            ),

          ],
        ),
      ),


      ))



    );
  }
}

class CustomSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  CustomSwitch({Key? key, required this.value, required this.onChanged})
      : super(key: key);

  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch>
    with SingleTickerProviderStateMixin {
  Animation? _circleAnimation;
  AnimationController? _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 60));
    _circleAnimation = AlignmentTween(
        begin: widget.value ? Alignment.centerRight : Alignment.centerLeft,
        end: widget.value ? Alignment.centerLeft : Alignment.centerRight)
        .animate(CurvedAnimation(
        parent: _animationController!, curve: Curves.linear));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController!,
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            if (_animationController!.isCompleted) {
              _animationController!.reverse();
            } else {
              _animationController!.forward();
            }
            widget.value == false
                ? widget.onChanged(true)
                : widget.onChanged(false);
          },
          child: Container(
            width: 45.0,
            height: 28.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.0),
              color: _circleAnimation!.value == Alignment.centerLeft
                  ? Colors.grey
                  : Colors.blue,
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 2.0, bottom: 2.0, right: 2.0, left: 2.0),
              child: Container(
                alignment:
                widget.value ? ((Directionality.of(context) == TextDirection.rtl) ? Alignment.centerRight : Alignment.centerLeft ) : ((Directionality.of(context) == TextDirection.rtl) ? Alignment.centerLeft : Alignment.centerRight),
                child: Container(
                  width: 20.0,
                  height: 20.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}










class ColorWheelPainter extends CustomPainter {
  final double hue;
  final double saturation;
  final double value;

  ColorWheelPainter(this.hue, this.saturation, this.value);

  @override
  void paint(Canvas canvas, Size size) {
    double radius = size.width / 2;
    Offset center = Offset(size.width / 2, size.height / 2);

    for (double angle = 0; angle < 360; angle++) {
      double startAngle = (angle - 2) * (pi / 180);
      double endAngle = (angle + 2) * (pi / 180);

      Paint paint = Paint()
        ..shader = SweepGradient(
          colors: [
            HSVColor.fromAHSV(1.0, angle, saturation, value).toColor(),
            HSVColor.fromAHSV(1.0, angle + 1, saturation, value).toColor()
          ],
        ).createShader(Rect.fromCircle(center: center, radius: radius))
        ..style = PaintingStyle.fill;

      canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle, endAngle - startAngle, true, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}




class HueGaugePainter extends CustomPainter {
  final double hue;

  HueGaugePainter(this.hue);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    double radius = size.width / 2;
    Offset center = Offset(size.width / 2, size.height / 2);

    canvas.drawCircle(center, radius, paint);

    double pointerAngle = hue * pi / 180;
    double pointerX = center.dx + (radius - 20) * cos(pointerAngle);
    double pointerY = center.dy + (radius - 20) * sin(pointerAngle);
    canvas.drawCircle(Offset(pointerX, pointerY), 4.0, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

