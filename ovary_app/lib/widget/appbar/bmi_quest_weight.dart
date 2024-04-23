import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:ovary_app/widget/body/bmi_quest_weight_widget.dart';
class BmiQuestWeight extends StatelessWidget {
  const BmiQuestWeight({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'BMI',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
          child: IconButton(
            onPressed: () {
              Get.back();
            }, 
            icon: const Icon(Icons.home)
          ),
        ),
      ),
      body: BmiQuestWeightWidget(),
    );
  }
}