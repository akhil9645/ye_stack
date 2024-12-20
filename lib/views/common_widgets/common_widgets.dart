import 'package:flutter/material.dart';
import 'package:ye_stack/controller/api_service_controller.dart';

class CommonWidgets {
  GestureDetector languageSelector(
      {String? label,
      String? selectedLanguage,
      Function()? ontap,
      BuildContext? context}) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: MediaQuery.of(context!).size.width / 2.5,
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.grey.shade800,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selectedLanguage == '' ? label! : selectedLanguage!,
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
            Icon(
              Icons.arrow_drop_down,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  Center loadingIndicator() {
    return Center(
      child: CircularProgressIndicator(
        color: Colors.white,
      ),
    );
  }

  void selectLanguage(
      {bool? isSource,
      BuildContext? context,
      ApiServiceController? apiServiceController}) async {
    showModalBottomSheet(
      backgroundColor: Colors.grey.shade800,
      context: context!,
      builder: (context) {
        return FutureBuilder(
          future: apiServiceController!.fetchLanguages(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return loadingIndicator();
            } else if (snapshot.hasError) {
              return Center(child: Text('Error loading languages'));
            } else {
              final languages = snapshot.data as List;
              return ListView.separated(
                separatorBuilder: (context, index) {
                  return Divider();
                },
                itemCount: languages.length,
                itemBuilder: (context, index) {
                  final language = languages[index];
                  final languageName = language['language'] ?? 'value';
                  return ListTile(
                    title: Text(
                      languageName,
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      if (isSource!) {
                        apiServiceController.sourceLanguage.value =
                            languageName;
                      } else {
                        apiServiceController.targetLanguage.value =
                            languageName;
                      }
                      Navigator.pop(context);
                    },
                  );
                },
              );
            }
          },
        );
      },
    );
  }

  void translate(
      {ApiServiceController? apiServiceController,
      TextEditingController? textController}) async {
    if (apiServiceController!.sourceLanguage.value.isNotEmpty &&
        apiServiceController.targetLanguage.value.isNotEmpty &&
        textController!.text.isNotEmpty) {
      final result = await apiServiceController.translateText(
          textController.text, apiServiceController.targetLanguage.value);

      apiServiceController.translatedText.value = result;
    }
  }
}
