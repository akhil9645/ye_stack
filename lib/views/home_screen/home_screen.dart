import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ye_stack/views/common_widgets/common_widgets.dart';
import '../../controller/api_service_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final ApiServiceController apiServiceController =
      Get.put(ApiServiceController());
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        title: Text(
          'Text Translation',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 15,
            children: [
              Divider(color: Colors.grey),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                    () => CommonWidgets().languageSelector(
                      context: context,
                      label: 'Source Language',
                      selectedLanguage:
                          apiServiceController.sourceLanguage.value,
                      ontap: () => CommonWidgets().selectLanguage(
                          isSource: true,
                          context: context,
                          apiServiceController: apiServiceController),
                    ),
                  ),
                  Icon(
                    Icons.compare_arrows_rounded,
                    color: Colors.grey.shade800,
                  ),
                  Obx(
                    () => CommonWidgets().languageSelector(
                      context: context,
                      label: 'Target Language',
                      selectedLanguage:
                          apiServiceController.targetLanguage.value,
                      ontap: () => CommonWidgets().selectLanguage(
                          isSource: false,
                          context: context,
                          apiServiceController: apiServiceController),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Obx(() => apiServiceController.sourceLanguage.isNotEmpty &&
                      apiServiceController.targetLanguage.isNotEmpty
                  ? Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Translate From',
                              style: TextStyle(color: Colors.grey.shade500),
                            ),
                            Obx(
                              () => Text(
                                ' (${apiServiceController.sourceLanguage.value})',
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade800,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextFormField(
                              controller: textController,
                              keyboardType: TextInputType.text,
                              cursorColor: Colors.white,
                              maxLines: 6,
                              maxLength: 2300,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                hintText: 'Enter text to translate',
                                hintStyle: TextStyle(color: Colors.white),
                                contentPadding: EdgeInsets.all(12),
                              ),
                              onChanged: (value) {
                                CommonWidgets().translate(
                                    apiServiceController: apiServiceController,
                                    textController: textController);
                              }),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text(
                              'Translate To',
                              style: TextStyle(color: Colors.grey.shade500),
                            ),
                            Obx(
                              () => Text(
                                ' (${apiServiceController.targetLanguage})',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade800,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextFormField(
                            maxLines: 6,
                            controller: TextEditingController(
                                text:
                                    apiServiceController.translatedText.value),
                            keyboardType: TextInputType.text,
                            cursorColor: Colors.white,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              contentPadding: EdgeInsets.all(12),
                            ),
                          ),
                        ),
                      ],
                    )
                  : SizedBox())
            ],
          ),
        ),
      ),
    );
  }
}
