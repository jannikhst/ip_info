import 'package:ip_info/ip_info.dart';

void main() async {
  var x = await IPInfo.location;
  print(x);
}
