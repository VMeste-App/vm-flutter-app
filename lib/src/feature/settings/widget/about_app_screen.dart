import 'package:flutter/material.dart';
import 'package:vm_app/src/core/ui-kit/scaffold.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return VmScaffold(
      appBar: AppBar(title: const Text('О приложении')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'VMeste App',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 12.0),
            Text('Приложение для поиска активностей, мест и участников.'),
          ],
        ),
      ),
    );
  }
}
