import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestWidget extends StatelessWidget {
  final String text = "deneme";
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        count++;
        print(count);
      },
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Text("$text - $count"),
      ),
    );
  }
}

class StatefulTestWidget extends StatefulWidget {
  @override
  Stateful_TestWidgetState createState() => Stateful_TestWidgetState();
}

class Stateful_TestWidgetState extends State<StatefulTestWidget> {
  final String text = "deneme";
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          count++;
        });
        print(count);
      },
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Text("$text - $count"),
      ),
    );
  }
}

class TestController extends GetxController {
  RxInt count = 0.obs;

  increase() {
    count.value += 1;
    print(count);
  }
}

class Test2Widget extends StatelessWidget {
  final String name, text;
  final TestController _controller = Get.put(TestController());

  Test2Widget({this.name, this.text});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _controller.increase();
      },
      child: Obx(() => Text("$name - ${_controller.count}")),
    );
  }
}
