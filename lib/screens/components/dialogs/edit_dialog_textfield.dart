import 'package:flutter/material.dart';
import 'package:project_seg/screens/components/buttons/pill_button_filled.dart';
import 'package:project_seg/screens/components/buttons/pill_button_outlined.dart';
import 'package:project_seg/services/context_state.dart';
import 'package:project_seg/services/user_state.dart';
import 'package:provider/provider.dart';
import 'package:project_seg/constants/colours.dart';
import '../../../constants/borders.dart';
import '../../../constants/textStyles.dart';

class EditDialogTextField extends StatefulWidget {
  String value;
  final Function(String?, String) onSave;

  EditDialogTextField({Key? key, required this.value, required this.onSave}) : super(key: key);

  @override
  State<EditDialogTextField> createState() => _EditDialogTextFieldState();
}

class _EditDialogTextFieldState extends State<EditDialogTextField> {
  TextEditingController _textFieldController = TextEditingController();

  bool isLoading = false;

  void _save(UserState userState) async {
    setState(() {
      isLoading = true;
    });

    widget.onSave(userState.user?.user?.uid, _textFieldController.text);

    setState(() {
      isLoading = false;
    });

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final _contextState = Provider.of<ContextState>(context);
    final _userState = Provider.of<UserState>(context);

    _textFieldController.text = widget.value;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: kTertiaryColour.withOpacity(0.1),
              ),
              child: TextField(
                controller: _textFieldController,
                minLines: 1,
                maxLength: _contextState.context?.maxBioLength ?? 200,
                maxLines: 10,
                decoration: InputDecoration(border: InputBorder.none),
                style: kTertiaryStyle,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: PillButtonOutlined(
                    text: "Cancel",
                    color: kTertiaryColour,
                    padding: EdgeInsets.symmetric(vertical: 7),
                    textStyle: Theme.of(context).textTheme.titleLarge,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: PillButtonFilled(
                    text: "Save",
                    isLoading: isLoading,
                    padding: EdgeInsets.symmetric(vertical: 7),
                    backgroundColor: kTertiaryColour,
                    textStyle: Theme.of(context).textTheme.titleLarge?.apply(color: kWhiteColour),
                    onPressed: () => _save(_userState),
                  ),
                  /*ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: kSecondaryColour,
                      fixedSize: const Size(100, 30),
                      //shadowColor: Color(0xFF0083A1),
                      //elevation: 4,
                      textStyle: const TextStyle(
                        fontSize: 17,
                      ),
                      shape: kRoundedRectangulareBorder15,
                    ),
                    onPressed: () async {
                      Navigator.of(context).pop();
                      await widget.onSave(_userState.user?.user?.uid, _textFieldController.text);
                    },
                    child: Text("Save"),
                  ),*/
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
