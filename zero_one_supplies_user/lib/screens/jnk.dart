import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class HtmlController extends GetxController {
  RxBool showFullText = false.obs;

  void toggleText() {
    showFullText.value = !showFullText.value;
  }
}

class MyApp extends StatelessWidget {
  final HtmlController htmlController = Get.put(HtmlController());

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('HTML to Text'),
        ),
        body: CustomScrollView(
          slivers: [
            const SliverAppBar(
              expandedHeight: 200,
              flexibleSpace: FlexibleSpaceBar(
                title: Text('App Bar Title'),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() {
                    const htmlContent = '''
                      <p>
                        Your HTML content goes here. This is a long HTML text that will be truncated initially, 
                        and you can show more or less by clicking the button.
                      </p>
                    ''';

                    final displayedText = htmlController.showFullText.value
                        ? htmlContent
                        : htmlContent.substring(
                            0, 100); // Show first 100 characters as a summary

                    return Text(displayedText);
                  }),
                  GestureDetector(
                    onTap: () {
                      htmlController.toggleText();
                    },
                    child: Text(
                      htmlController.showFullText.value
                          ? 'Show Less'
                          : 'Show More',
                      style: const TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),
            // Other Sliver widgets if needed
          ],
        ),
      ),
    );
  }
}
