import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mushroom_friends/generated/l10n.dart';
import 'package:mushroom_friends/screens/auth_screen/data/repositories/firebase_auth_service.dart';
import 'package:mushroom_friends/screens/auth_screen/ui/bloc/auth_screen_bloc.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthScreenBloc>(
      create: (context) => AuthScreenBloc(FireBaseAuthService()),
      child: SafeArea(
        child: Stack(children: [
          Image.asset(
            'assets/images/splashWallpaper.webp',
            fit: BoxFit.fill,
            height: MediaQuery.of(context).size.height,
          ),
          Scaffold(
            backgroundColor: const Color.fromRGBO(70, 86, 86, 0.8),
            body: Center(
              child: BlocBuilder<AuthScreenBloc, AuthScreenState>(
                builder: (context, state) {
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(context.watch<AuthScreenBloc>().state.title,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.displayMedium),
                        const SizedBox(height: 20),
                        _buildTextField(
                            icon: const Icon(Icons.email),
                            hint: S.of(context).textFieldHintEmail,
                            controller: _emailController),
                        _buildTextField(
                            icon: const Icon(Icons.lock),
                            hint: S.of(context).textFieldHintPassword,
                            controller: _passwordController),
                        _elevatedButton(context),
                        const SizedBox(height: 40),
                        _checkBox(context)
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ]),
      ),
    );
  }

  SizedBox _elevatedButton(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 130,
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(10),
        ),
        onPressed: () {
          if (_emailController.text.isNotEmpty ||
              _passwordController.text.isNotEmpty) {
            context.read<AuthScreenBloc>().add(OnAuthButtonClick(
                context: context,
                email: _emailController.text.trim(),
                password: _passwordController.text.trim()));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                duration: const Duration(milliseconds: 1500),
                content: Text(S.of(context).validationSnackBarMessage)));
          }
        },
        child: Text(context.watch<AuthScreenBloc>().state.buttonTitle),
      ),
    );
  }

  Widget _checkBox(BuildContext context) {
    return Column(
      children: [
        Text(S.of(context).noAccountTitle,
            style: Theme.of(context).textTheme.displayMedium),
        Checkbox(
            side: const BorderSide(color: Colors.white70),
            activeColor: Colors.lightBlue,
            value: context.read<AuthScreenBloc>().state.checkBox, //unchecked
            onChanged: (bool? value) {
              value!
                  ? context.read<AuthScreenBloc>().add(CheckBoxClickOn())
                  : context
                      .read<AuthScreenBloc>()
                      .add(CheckBoxClickOff(context: context));
            })
      ],
    );
  }

  Widget _buildTextField(
      {required Icon icon,
      required String hint,
      required TextEditingController controller}) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        controller: controller,
        style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white70,
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(color: Colors.blue, width: 4),
          ),
          suffixIcon: icon,
          hintText: hint,
          hintStyle: const TextStyle(
              fontSize: 15, fontWeight: FontWeight.bold, color: Colors.grey),
        ),
      ),
    );
  }
}
