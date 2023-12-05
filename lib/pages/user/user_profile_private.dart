import 'package:experimental/theme/profile_theme_extensions.dart';
import 'package:experimental/utils/constants.dart';
import 'package:experimental/utils/form_regex.dart';
import 'package:experimental/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class UserProfilePrivate extends StatefulWidget {
  final String? username;
  final String? imageUrl;
  const UserProfilePrivate({
    super.key,
    this.username = 'Username',
    this.imageUrl,
  });

  static const String routeName = '/user-profile-private';

  @override
  State<UserProfilePrivate> createState() => _UserProfilePrivateState();
}

class _UserProfilePrivateState extends State<UserProfilePrivate> {
  final GlobalKey<FormState> _formProfileKey = GlobalKey<FormState>();
  final bool _isLoading = false;
  late final TextEditingController _emailController;
  late final TextEditingController _usernameController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _usernameController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('user-profile-private-page'),
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const MassiveHeadlineText(
                text: 'Profile',
              ),
              const Gap(16),
              JaggedContainer(
                strokeWidth: 4,
                onEdit: () {},
                aspectRatio: 1.0,
                networkImage: widget.imageUrl,
                maxHeight: 100,
              ),
              const Gap(8),
              Text(
                'Username',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: GoogleFonts.staatliches().fontFamily,
                ),
              ),
              const Gap(16),
              Form(
                key: _formProfileKey,
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
                        decoration: Theme.of(context)
                            .emailInputDecoration(), // Using the extension method
                      ),
                      const Gap(8),
                      TextFormField(
                        controller: _usernameController,
                        validator: (value) =>
                            FormRegex.authValidateEmail(_emailController.text),
                        style: Theme.of(context).emailTextStyle(),
                        cursorColor: Theme.of(context).emailCursorColor,
                        cursorWidth: Theme.of(context).emailCursorWidth,
                        decoration: Theme.of(context)
                            .usernameInputDecoration(), // Using the extension method
                      ),
                      const Gap(24),
                      SizedBox(
                        width: double
                            .infinity, // Make the button expand horizontally
                        child: ElevatedButton(
                          onPressed: _isLoading
                              ? null
                              : () {
                                  if (_formProfileKey.currentState!
                                      .validate()) {
                                    // Perform login logic if form is valid
                                  }
                                },
                          style: Theme.of(context).blackSquareButtonStyle(),
                          child: Text(_isLoading
                              ? 'Loading'
                              : 'Save'), // Apply the custom button style
                        ),
                      ),
                      const Gap(8),
                      SizedBox(
                        width: double
                            .infinity, // Make the button expand horizontally
                        child: TextButton(
                          onPressed: () {
                            // TODO: implement logout
                            Navigator.of(context).pushNamed('/splash-page');
                          },
                          style: Theme.of(context).blackTextButtonStyle(),
                          child: const Text('Logout'),
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
