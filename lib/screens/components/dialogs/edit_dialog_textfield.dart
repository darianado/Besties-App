import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    final _contextState = Provider.of<ContextState>(context);
    final _userState = Provider.of<UserState>(context);

    _textFieldController.text = widget.value;

    return Dialog(
      shape: kRoundedRectangulareBorder13,
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
              height: 5,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      onPrimary: Color(0xFF0A1128),
                      side: BorderSide(color: Colors.grey, width: 1),
                      //shadowColor: Color(0xFF0083A1),
                      //elevation: 4,
                      textStyle: const TextStyle(
                        fontSize: 17,
                      ),
                      shape: kRoundedRectangulareBorder15,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text("Cancel"),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: ElevatedButton(
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
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
