import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_seg/constants.dart';
import 'package:project_seg/screens/home/profile/components/cached_image.dart';
import 'package:project_seg/services/user_state.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    //double screenHeight = MediaQuery.of(context).size.height;
    final _userState = Provider.of<UserState>(context);

    const double profileImageRadius = 100;
    const double profileHeaderExtendedHeight = 220;
    const double profileHeaderCollapsedHeight = 220;

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
                onPressed: () => context.pushNamed("edit_profile", params: {'page': 'profile'}),
                icon: Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
              ),
            ],
            flexibleSpace: Stack(
              alignment: Alignment.bottomCenter,
              clipBehavior: Clip.none,
              children: [
                Container(
                  decoration: const BoxDecoration(
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
                    child: SizedBox(
                      height: 2 * profileImageRadius,
                      width: 2 * profileImageRadius,
                      child: CachedImage(url: _userState.user?.userData?.profileImageUrl),
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
              child: Column(
                children: [
                  Text(
                    _userState.user?.userData?.fullName ?? "-",
                    style: TextStyle(
                      color: kTertiaryColour,
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  chip(kTertiaryColour,
                      icon: FontAwesomeIcons.university, label: _userState.user?.userData?.university ?? "-", textColor: kTertiaryColour),
                  SizedBox(
                    height: 10,
                  ),
                  Wrap(
                    spacing: 6.0,
                    runSpacing: 6.0,
                    alignment: WrapAlignment.center,
                    runAlignment: WrapAlignment.center,
                    children: [
                      chip(kTertiaryColour, icon: FontAwesomeIcons.birthdayCake, label: "${_userState.user?.userData?.age}"),
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
                    child: Text(
                      _userState.user?.userData?.bio ?? "-",
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
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => _userState.signOut(),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Colors.red.shade100),
                            primary: Colors.red,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                FontAwesomeIcons.signOutAlt,
                                size: 18,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text("Sign out"),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              kTertiaryColour.withOpacity(0.4),
                            ),
                            elevation: MaterialStateProperty.all(0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                FontAwesomeIcons.cog,
                                size: 18,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text("Settings"),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget chip(Color color,
      {bool bordered = true, IconData? icon, Color? iconColor, String? label, bool capitalizeLabel = false, Color? textColor}) {
    return Container(
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
            (label != null)
                ? Text(
                    (capitalizeLabel == true) ? label[0].toUpperCase() + label.substring(1).toLowerCase() : label,
                    style: TextStyle(color: (textColor != null) ? textColor : color),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
