import 'package:e_khata/bar%20graph/individual_bar.dart';

class BarData {
  final double sunAmount;
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thurAmount;
  final double friAmount;
  final double satAmount;

  BarData({
    required this.sunAmount,
    required this.monAmount,
    required this.tueAmount,
    required this.wedAmount,
    required this.thurAmount,
    required this.friAmount,
    required this.satAmount,
  });
  List<IndividualBar> barData = [];

  void initializeBardata() {
    barData = [
      //Sunday
      IndividualBar(x: 0, y: sunAmount),
      //Monday
      IndividualBar(x: 1, y: monAmount),
      //tuesday
      IndividualBar(x: 2, y: tueAmount),
      //wednesday
      IndividualBar(x: 3, y: wedAmount),
      //thursday
      IndividualBar(x: 4, y: thurAmount),
      //Friday
      IndividualBar(x: 5, y: friAmount),
      //Saturday
      IndividualBar(x: 6, y: satAmount),
    ];
  }
}
