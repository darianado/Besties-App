import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_seg/constants/colours.dart';
import 'package:project_seg/constants/constant.dart';
import 'package:project_seg/models/User/user_data.dart';
import 'package:project_seg/router/route_names.dart';
import 'package:project_seg/screens/components/buttons/pill_button_filled.dart';
import 'package:project_seg/screens/components/images/cached_image.dart';
import 'package:project_seg/screens/components/validation_error.dart';
import 'package:project_seg/states/user_state.dart';
import 'package:project_seg/utility/form_validators.dart';
import 'package:project_seg/utility/pick_image.dart';
import 'package:provider/provider.dart';

import '../../constants/borders.dart';

/**
 * The third screen that is displayed through the sign up process.
 *
 * It allows a user to choose their profile picture from the pictures
 * and images they have on their phone (e.g. in gallery, google drive etc.).
 */

class RegisterPhotoScreen extends StatefulWidget {
  const RegisterPhotoScreen({Key? key, required this.userData})
      : super(key: key);

  final UserData userData;

  @override
  State<RegisterPhotoScreen> createState() => _RegisterPhotoScreenState();
}

class _RegisterPhotoScreenState extends State<RegisterPhotoScreen> {
  final PickAndCropImage _pickAndCrop = PickAndCropImage();
  bool loadingPicture = false;

  String? validateProfileImageUrlError;

  void _pickImage(String uid) async {
    setState(() {
      loadingPicture = true;
    });

    String? url = await _pickAndCrop.pickImage(uid);

    widget.userData.profileImageUrl = url;

    setState(() {
      loadingPicture = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _userState = Provider.of<UserState>(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            automaticallyImplyLeading: false,
            foregroundColor: tertiaryColour,
            backgroundColor: whiteColour,
            expandedHeight: 120,
            collapsedHeight: 130,
            leading: IconButton(
              onPressed: () => context.goNamed(registerBasicInfoScreenName,
                  extra: widget.userData),
              icon: const Icon(Icons.arrow_back_ios, color: primaryColour),
            ),
            flexibleSpace: Container(
              width: double.infinity,
              height: double.infinity,
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                    leftRightPadding, 5, leftRightPadding, 5),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Great! Now a photo...',
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            ?.apply(color: secondaryColour, fontWeightDelta: 2),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                const SizedBox(height: 20),
                SizedBox(
                  // height: 400,
                  child: Material(
                    child: (loadingPicture)
                        ? const Center(
                            child: Padding(
                              padding: EdgeInsets.all(5.0),
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : InkWell(
                            onTap: () => _pickImage(_userState.user!.user!.uid),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                AspectRatio(
                                  aspectRatio: 1,
                                  child: Container(
                                    color: secondaryColour.withOpacity(0.2),
                                    width: double.infinity,
                                    child: (widget.userData.profileImageUrl !=
                                            null)
                                        ? CachedImage(
                                            url:
                                                widget.userData.profileImageUrl)
                                        : Image.asset(
                                            "assets/images/empty_profile_picture.jpg",
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.6),
                                    borderRadius: circularBorderRadius10,
                                  ),
                                  height: 55,
                                  width: 100,
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(Icons.photo, color: whiteColour),
                                      SizedBox(width: 10),
                                      Text(
                                        "EDIT",
                                        style: TextStyle(color: whiteColour),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),
                ),
                ValidationError(errorText: validateProfileImageUrlError),
                Container(
                  padding: const EdgeInsets.fromLTRB(
                      leftRightPadding, 20, leftRightPadding, 20),
                  width: double.infinity,
                  child: PillButtonFilled(
                    text: "Next",
                    textStyle: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.w600),
                    onPressed: () {
                      if (!validate()) return;

                      context.goNamed(registerDescriptionScreenName,
                          extra: widget.userData);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool validate() {
    setState(() {
      validateProfileImageUrlError =
          validateProfileImageUrl(widget.userData.profileImageUrl);
    });

    return (validateProfileImageUrlError == null);
  }
}
