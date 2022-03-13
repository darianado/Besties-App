import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_seg/constants.dart';
import 'package:project_seg/screens/home/profile/components/cached_image.dart';
import 'package:project_seg/services/storage_service.dart';
import 'package:project_seg/services/user_state.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:animated_widgets/animated_widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _uniController = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    //double screenHeight = MediaQuery.of(context).size.height;
    final _userState = Provider.of<UserState>(context);

    const double profileImageRadius = 100;
    const double profileHeaderExtendedHeight = 220;
    const double profileHeaderCollapsedHeight = 220;

    _uniController.text = _userState.user?.userData?.university ?? "";
    _bioController.text = _userState.user?.userData?.bio ?? "-";

    void pickImage() async {
      XFile? file = await _picker.pickImage(source: ImageSource.gallery, maxHeight: 800, maxWidth: 800, imageQuality: 90);
      if (file == null) return;
      File? f = File(file.path);
      f = await ImageCropper().cropImage(
        sourcePath: file.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1.5),
        aspectRatioPresets: [CropAspectRatioPreset.ratio5x4],
      );
      await StorageService.instance.changeUserPhoto(_userState.user!.user!.uid, f);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: profileHeaderExtendedHeight,
            collapsedHeight: profileHeaderCollapsedHeight,
            automaticallyImplyLeading: false,
            excludeHeaderSemantics: false,
            actions: [
              IconButton(
                onPressed: () => context.pushNamed("home", params: {'page': 'profile'}),
                icon: Icon(
                  Icons.clear,
                  color: Colors.white,
                ),
              ),
            ],
            flexibleSpace: Stack(
              alignment: Alignment.bottomCenter,
              clipBehavior: Clip.none,
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.65, 1],
                      colors: [kTertiaryColour, kLightBlue],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50.0, bottom: 10.0),
                  child: Material(
                    shape: CircleBorder(),
                    clipBehavior: Clip.antiAlias,
                    elevation: 20.0,
                    child: InkWell(
                      onTap: () => pickImage(),
                      child: Container(
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            SizedBox(
                              height: 2 * profileImageRadius,
                              width: 2 * profileImageRadius,
                              child: CachedImage(url: _userState.user?.userData?.profileImageUrl),
                            ),
                            Container(
                              color: Colors.black.withOpacity(0.5),
                              width: 2 * profileImageRadius,
                              height: 30,
                              alignment: Alignment.center,
                              child: Text(
                                "EDIT",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text(
                      _userState.user?.userData?.fullName ?? "-",
                      style: TextStyle(
                        color: kTertiaryColour.withOpacity(0.2),
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ShakeAnimatedWidget(
                      duration: Duration(milliseconds: 200),
                      shakeAngle: Rotation.deg(z: 1),
                      child: chip(kTertiaryColour,
                          icon: FontAwesomeIcons.university,
                          label: _userState.user?.userData?.university ?? "-",
                          textColor: kTertiaryColour),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Wrap(
                      spacing: 6.0,
                      runSpacing: 6.0,
                      alignment: WrapAlignment.center,
                      runAlignment: WrapAlignment.center,
                      children: [
                        ShakeAnimatedWidget(
                          duration: Duration(milliseconds: 200),
                          shakeAngle: Rotation.deg(z: 3),
                          child: chip(kTertiaryColour, icon: FontAwesomeIcons.birthdayCake, label: "${_userState.user?.userData?.age}"),
                        ),
                        (_userState.user?.userData?.gender == "male")
                            ? chip(Colors.red.shade300, icon: FontAwesomeIcons.mars)
                            : chip(Colors.red.shade300, icon: FontAwesomeIcons.venus)
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: kTertiaryColour.withOpacity(0.1),
                      ),
                      child: TextFormField(
                        controller: _bioController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        minLines: 1,
                        maxLines: 10,
                        style: TextStyle(
                          fontSize: 17,
                          color: kTertiaryColour,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "INTERESTS",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: kPrimaryColour.withOpacity(0.3),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Wrap(
                      spacing: 9.0,
                      runSpacing: 9.0,
                      alignment: WrapAlignment.center,
                      runAlignment: WrapAlignment.center,
                      children: _userState.user?.userData?.interests
                              ?.map(
                                (interest) => chip(
                                  kTertiaryColour,
                                  bordered: false,
                                  label: interest,
                                  capitalizeLabel: true,
                                  textColor: Colors.white,
                                ),
                              )
                              .toList() ??
                          [],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget chip(Color color,
      {bool bordered = true,
      IconData? icon,
      Color? iconColor,
      String? label,
      FormField? formField,
      bool capitalizeLabel = false,
      Color? textColor}) {
    double shake(double animation) => sin(animation * pi * 4);

    Widget container = Container(
      decoration: BoxDecoration(
          border: (bordered == true)
              ? Border.all(
                  color: color,
                  width: 1,
                )
              : null,
          borderRadius: BorderRadiusDirectional.all(
            Radius.circular(100),
          ),
          color: (bordered == true) ? null : color),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            (icon != null)
                ? Icon(
                    icon,
                    color: (iconColor != null) ? iconColor : color,
                    size: 15,
                  )
                : Container(),
            (icon != null && label != null)
                ? SizedBox(
                    width: 5,
                  )
                : Container(),
            (formField != null)
                ? formField
                : (label != null)
                    ? Text(
                        (capitalizeLabel == true) ? label[0].toUpperCase() + label.substring(1).toLowerCase() : label,
                        style: TextStyle(color: (textColor != null) ? textColor : color),
                      )
                    : Container(),
          ],
        ),
      ),
    );

    return container;
  }
}

class ShakeWidget extends StatelessWidget {
  final Duration duration;
  final double deltaX;
  final Widget child;
  final Curve curve;

  const ShakeWidget({
    Key? key,
    this.duration = const Duration(milliseconds: 500),
    this.deltaX = 20,
    this.curve = Curves.bounceOut,
    required this.child,
  }) : super(key: key);

  /// convert 0-1 to 0-1-0
  double shake(double animation) => 2 * (0.5 - (0.5 - curve.transform(animation)).abs());

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      key: key,
      tween: Tween(begin: 0.0, end: 1.0),
      duration: duration,
      builder: (context, animation, child) => Transform.translate(
        offset: Offset(deltaX * shake(animation), 0),
        child: child,
      ),
      child: child,
    );
  }
}
