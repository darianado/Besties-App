import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_seg/constants.dart';
import 'package:project_seg/screens/components/buttons/bio_field.dart';
import 'package:project_seg/screens/components/cached_image.dart';
import 'package:project_seg/screens/components/chip_widget.dart';
import 'package:project_seg/screens/components/buttons/edit_dob_button.dart';
import 'package:project_seg/screens/components/buttons/gender_button.dart';
import 'package:project_seg/screens/components/buttons/relationship_status_button.dart';
import 'package:project_seg/screens/components/buttons/university_button.dart';
import 'package:project_seg/screens/components/widget/display_interests.dart';
import 'package:project_seg/services/firestore_service.dart';
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
  final FirestoreService _firestoreService = FirestoreService.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _uniController = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  bool loadingPicture = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    //double screenHeight = MediaQuery.of(context).size.height;
    final _userState = Provider.of<UserState>(context);

    const double profileImageRadius = 100;
    const double profileHeaderExtendedHeight = 430;
    const double profileHeaderCollapsedHeight = 220;

    _uniController.text = _userState.user?.userData?.university ?? "";
    _bioController.text = _userState.user?.userData?.bio ?? "-";

    void pickImage() async {
      XFile? file = await _picker.pickImage(source: ImageSource.gallery, maxHeight: 800, maxWidth: 800, imageQuality: 90);
      if (file == null) return;

      setState(() {
        loadingPicture = true;
      });

      File? f = File(file.path);
      f = await ImageCropper().cropImage(
        sourcePath: file.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1.5),
        aspectRatioPresets: [CropAspectRatioPreset.ratio5x4],
      );
      String? url = await StorageService.instance.changeUserPhoto(_userState.user!.user!.uid, f);

      if (url != null) FirestoreService.instance.setProfileImageUrl(url);

      setState(() {
        loadingPicture = false;
      });
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
              Padding(
                padding: const EdgeInsets.only(right: 13.0),
                child: Material(
                  shape: CircleBorder(),
                  clipBehavior: Clip.antiAlias,
                  color: kTertiaryColour,
                  child: InkWell(
                    child: IconButton(
                      onPressed: () => context.pushNamed("home", params: {'page': 'profile'}),
                      icon: Icon(
                        Icons.check,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
            flexibleSpace: Material(
              child: (loadingPicture)
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : InkWell(
                      onTap: () => pickImage(),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          CachedImage(url: _userState.user?.userData?.profileImageUrl),
                          Column(
                            children: [
                              Expanded(
                                child: Container(),
                              ),
                              Container(
                                color: Colors.black.withOpacity(0.5),
                                height: 30,
                                alignment: Alignment.center,
                                child: Text(
                                  "EDIT",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
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
                    height: 25,
                  ),
                  UniversityButton(
                    editable: true,
                    wiggling: true,
                    label: _userState.user?.userData?.university ?? "",
                    onSave: (university) => saveUniversity(_userState.user?.user?.uid, university),
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
                      DateOfBirthButton(
                        editable: true,
                        wiggling: true,
                        label: "${_userState.user?.userData?.age}",
                        onSave: (dateOfBirth) => saveDateOfBirth(_userState.user?.user?.uid, dateOfBirth),
                      ),
                      GenderButtton(
                        editable: true,
                        wiggling: true,
                        label: _userState.user?.userData?.gender ?? "",
                        onSave: (gender) => saveGender(_userState.user?.user?.uid, gender),
                      ),
                      RelationshipStatusButton(
                          editable: true,
                          wiggling: true,
                          label: _userState.user?.userData?.relationshipStatus ?? "",
                          onSave: (relationshipStatus) => saveRelationshipStatus(_userState.user?.user?.uid, relationshipStatus)),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  BioField(
                    label: _userState.user?.userData?.bio ?? " ",
                    editable: true,
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
                  DisplayInterests(
                    wiggling: true,
                    onTap: () => print("Tapped!"),
                    items: _userState.user?.userData?.flattenedInterests ?? [],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> saveDateOfBirth(String? userId, DateTime? dateOfBirth) async {
    if (userId != null && dateOfBirth != null) {
      await _firestoreService.setDateOfBirth(userId, dateOfBirth);
    }
  }

  Future<void> saveRelationshipStatus(String? userId, String? relationshipStatus) async {
    if (userId != null && relationshipStatus != null) {
      await _firestoreService.setRelationshipStatus(userId, relationshipStatus);
    }
  }

  Future<void> saveGender(String? userId, String? gender) async {
    if (userId != null && gender != null) {
      await _firestoreService.setGender(userId, gender);
    }
  }

  Future<void> saveUniversity(String? userId, String? university) async {
    if (userId != null && university != null) {
      await _firestoreService.setUniversity(userId, university);
    }
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
