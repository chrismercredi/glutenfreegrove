import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../utils/utils.dart';
import '../../theme/theme.dart' show AuthThemeExtensions;
import '../../widgets/widgets.dart';

class UserApplicationForm extends StatefulWidget {
  const UserApplicationForm({super.key});

  static const String routeName = '/user-application-form';

  @override
  State<UserApplicationForm> createState() => _UserApplicationFormState();
}

class _UserApplicationFormState extends State<UserApplicationForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final bool _isLoading = false;

  late final TextEditingController _emailController = TextEditingController();

  late final TextEditingController _referralCodeController =
      TextEditingController();

  @override
  void initState() {
    super.initState();

    _emailController.addListener(() {
      setState(() {});
    });

    _referralCodeController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _emailController.dispose();

    _referralCodeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('user-application-form-page'),
      appBar: AppBar(title: const Text('User Application')),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const MM(),
              const Text('Apply for Access'),
              Form(
                key: _formKey,
                child: Padding(
                  padding: formColumnPadding,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _emailController,
                        validator: (value) =>
                            FormRegex.authValidateEmail(_emailController.text),
                        style: Theme.of(context).emailTextStyle(),
                        cursorColor: Theme.of(context).emailCursorColor,
                        cursorWidth: Theme.of(context).emailCursorWidth,
                        decoration: Theme.of(context).emailInputDecoration(),
                      ),
                      const Gap(8),
                      TextFormField(
                        controller: _referralCodeController,
                        style: Theme.of(context).emailTextStyle(),
                        cursorColor: Theme.of(context).emailCursorColor,
                        cursorWidth: Theme.of(context).emailCursorWidth,
                        decoration: Theme.of(context).referralInputDecoration(),
                      ),
                      const Gap(24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _isLoading
                              ? null
                              : () {
                                  if (_formKey.currentState!.validate()) {
                                    // Application submission logic here
                                  }
                                },
                          style: Theme.of(context).blackSquareButtonStyle(),
                          child: Text(
                              _isLoading ? 'Loading' : 'Submit Application'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
