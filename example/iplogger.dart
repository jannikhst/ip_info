import 'package:ip_info/ip_info.dart';

main() async {
  print(
      'Your current Location, based on your IP-Adress is: ${await IPInfo.location}');
  print('Your public IPv4 is: ${await IPInfo.ipv4}');
  print('Your public IPv6 is: ${await IPInfo.ipv6}');
}
