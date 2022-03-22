
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String? otherName;
  final String? myImage;
  final String? otherImage;

  const CustomDialog({
    Key? key,
    required this.otherName,
    required this.myImage,
    required this.otherImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Consts.padding),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context, otherName, myImage, otherImage),
    );
  }
}

dialogContent(BuildContext context, String? otherName, String? myImage, String? otherImage) {
  return Stack(
    children: <Widget>[
      //...bottom card part,
      Container(
        padding: const EdgeInsets.only(
          top: Consts.avatarRadius + Consts.padding,
          bottom: Consts.padding,
          left: Consts.padding,
          right: Consts.padding,
        ),
        margin: const EdgeInsets.only(top: Consts.avatarRadius),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(Consts.padding),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: const Offset(0.0, 10.0),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // To make the card compact
          children: <Widget>[
            SizedBox(height: 16.0),
             Text(
              "yeeeey a new match with " + otherName.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 24.0),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // To close the dialog
                },
                child: Text("ok"),
              ),
            ),
          ],
        ),
      ),

      //...top circlular image part,
       Positioned(
        left: Consts.padding,
        right: Consts.padding-100,
        child: CircleAvatar(
          backgroundImage:  NetworkImage(myImage ??
              "assets/images/empty_profile_picture.jpg"),
                    
          radius: Consts.avatarRadius,
        ),
      ),


      Positioned(
          left: Consts.padding-100,
          right: Consts.padding,
          child: CircleAvatar(
            backgroundImage:  NetworkImage(otherImage ??
                "assets/images/empty_profile_picture.jpg"),     
            radius: Consts.avatarRadius,
          ),
      ),




    ],
  );
}

class Consts {
  Consts._();

  static const double padding = 50.0;
  static const double avatarRadius = 60.0;
}

// showDialog(
//   context: context,
//   builder: (BuildContext context) => CustomDialog(
//         title: "Success",
//         description:
//             "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
//         buttonText: "Okay",
//       ),
// );
