import 'package:flutter/cupertino.dart';

import '../controllers/home_controller.dart';
import 'package:biz_common/biz_common.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final HomeController controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
