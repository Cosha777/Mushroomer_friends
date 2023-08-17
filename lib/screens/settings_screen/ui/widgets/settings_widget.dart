import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mushroom_friends/generated/l10n.dart';
import 'package:mushroom_friends/screens/settings_screen/data/local_data_source.dart';
import 'package:mushroom_friends/screens/settings_screen/ui/bloc/settings_screen_bloc.dart';

class SettingsWidget extends StatelessWidget {
  SettingsWidget(this.localDataSourceSharedPref, {super.key});

  final TextEditingController _nameController = TextEditingController();
  final LocalDataService localDataSourceSharedPref;

  @override
  Widget build(BuildContext context) {
    localDataSourceSharedPref
        .getNameFromLocalSource()
        .then((value) => _nameController.text = value);

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          const _IdContainer(),
          const SizedBox(height: 40),
          _YourNameContainer(nameController: _nameController),
        ],
      ),
    );
  }
}

class _YourNameContainer extends StatelessWidget {
  const _YourNameContainer({
    super.key,
    required TextEditingController nameController,
  }) : _nameController = nameController;

  final TextEditingController _nameController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(20, 56, 64, 1),
        border: Border.all(),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text(
              S.of(context).enterYourNameText,
              style: const TextStyle(color: Colors.white),
            ),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(5),
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  borderSide: BorderSide(color: Colors.blue, width: 4),
                ),
                filled: true,
                fillColor: Colors.white70,
                hintText: S.of(context).textFieldHintYourName,
                hintStyle: const TextStyle(color: Colors.grey),
                suffixIcon: IconButton(
                    onPressed: () {
                      context
                          .read<SettingsScreenBloc>()
                          .add(SaveName(name: _nameController.text));
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:
                              Text(S.of(context).savedNameSnackBarMessage)));
                    },
                    icon: const Icon(Icons.save, color: Colors.blue)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _IdContainer extends StatelessWidget {
  const _IdContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(20, 56, 64, 1),
        border: Border.all(),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  S.of(context).yourIdText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Clipboard.setData(ClipboardData(
                            text: FirebaseAuth.instance.currentUser!.uid))
                        .then((_) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(S.of(context).copyIDSnackBarMessage)));
                    });
                  },
                  color: Colors.blue,
                  icon: const Icon(Icons.copy),
                )
              ],
            ),
            Text(
              FirebaseAuth.instance.currentUser?.uid ?? "ID",
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ],
        ),
      ),
    );
  }
}
