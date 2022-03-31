import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:project_seg/models/User/other_user.dart';
import 'package:project_seg/models/User/user_data.dart';
import 'package:project_seg/screens/components/buttons/round_action_button.dart';
import 'package:project_seg/screens/components/dialogs/match_alert.dart';
import 'package:project_seg/services/firestore_service.dart';
import 'package:project_seg/states/user_state.dart';
import 'package:provider/provider.dart';

/// The [FloatingActionButton] to like the displayed profile.
///
/// The [likeProfile] method is called on-tap
class LikeProfileButton extends StatefulWidget {
  final UserData profile;
  final bool liked;
  final Function onLikeComplete;

  const LikeProfileButton({
    Key? key,
    required this.profile,
    required this.liked,
    required this.onLikeComplete,
  }) : super(key: key);

  @override
  State<LikeProfileButton> createState() => _LikeProfileButtonState();
}

class _LikeProfileButtonState extends State<LikeProfileButton> with TickerProviderStateMixin {
  final notLikedValue = 0.0;
  final likedValue = 1.0;

  late final FirestoreService _firestoreService;
  late final AnimationController _animationController;

  bool isLiked(UserState userState) => userState.user?.userData?.likes?.contains(widget.profile.uid) ?? false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final _userState = Provider.of<UserState>(context, listen: false);
    _firestoreService = Provider.of<FirestoreService>(context, listen: false);
    _animationController = AnimationController(vsync: this, value: (isLiked(_userState)) ? likedValue : notLikedValue);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _userState = Provider.of<UserState>(context);

    final _isLiked = isLiked(_userState);

    final _animationController = AnimationController(vsync: this, value: (_isLiked) ? likedValue : notLikedValue);

    return RoundActionButton(
      onPressed: () async {
        if (!_isLiked) {
          await _animationController.animateTo(likedValue, duration: const Duration(milliseconds: 600));

          widget.onLikeComplete();

          bool isMatch = await _firestoreService.setLike(widget.profile.uid);

          if (isMatch) {
            print("Showing dialog");
            showDialog(
              context: context,
              builder: (BuildContext context) => MatchDialog(
                otherUser: widget.profile,
              ),
            );
          }
        }
      },
      child: Transform.scale(
        scale: 1.35,
        child: Lottie.asset("assets/lotties/like.json", controller: _animationController),
      ),
    );
  }
}
