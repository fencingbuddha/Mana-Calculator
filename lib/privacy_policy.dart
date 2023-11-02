import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    String privacyPolicyText = '''
Effective Date: February 13, 2023
This Privacy Policy applies to the app (Mana Calculator) developed by Appsbycam LLC. The App does not collect any personal information from its users. This means that we do not collect, store, or use any information that can be used to identify individual users of the App.
This Privacy Policy sets forth our policy with respect to information that is collected from users of the App. Please read this Privacy Policy carefully to understand our practices regarding your information.
Information We Collect
We do not collect any personal information from users of the App. This means that we do not ask for, and do not receive, any information such as your name, address, telephone number, or email address.
We may collect non-personal information about how you use the App. This information may include the type of device you use, the type of operating system you use, and other technical information about your device and how you use the App.
Use of Information
We do not use the information we collect from users of the App for any purpose other than to improve the App. We may use non-personal information to improve the App and to better understand how users use the App.
Sharing of Information
We do not share the information we collect from users of the App with third parties. We do not sell or rent personal information to third parties.
Data Security
We take appropriate security measures to protect against unauthorized access to or unauthorized alteration, disclosure, or destruction of data. We limit access to personal information to our employees, contractors, and agents who need to know that information in order to operate, develop, or improve the App.
Changes to this Privacy Policy
We may change this Privacy Policy from time to time. If we make a change to this Privacy Policy that, in our sole discretion, is material, we will provide notice to our users by sending an email to the email address associated with your account and/or by prominently posting notice of the change on our App.
Contact Information
If you have any questions or concerns about this Privacy Policy, please contact us at appsbycam@gmail.com.
Last Updated: February 13, 2023
''';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(
            privacyPolicyText,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
