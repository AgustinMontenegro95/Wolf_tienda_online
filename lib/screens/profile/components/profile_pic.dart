import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wolf_tienda_online/constants.dart';

class ProfilePic extends StatelessWidget {
  final String? imagen;

  const ProfilePic({Key? key, this.imagen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      width: 250,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          _imagenPerfil(imagen!),
          /* CircleAvatar(
            backgroundImage: AssetImage("assets/images/perfil_image.png"),
          ), */
          Positioned(
            right: -10,
            bottom: 0,
            child: SizedBox(
              height: 70,
              width: 70,
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: const BorderSide(color: Colors.white),
                  ),
                  primary: Colors.white,
                  backgroundColor: kPrimaryColor,
                ),
                onPressed: () {
                  //posibilidad de cambiar la foto
                },
                child: SvgPicture.asset(
                  "assets/icons/Camera Icon.svg",
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  _imagenPerfil(String imgPerfil) {
    if (imgPerfil.isNotEmpty) {
      return CircleAvatar(
        radius: 30.0,
        backgroundImage: NetworkImage(imgPerfil),
        backgroundColor: Colors.transparent,
      );
    } else {
      return const CircleAvatar(
        backgroundImage: AssetImage("assets/images/perfil_image.png"),
      );
    }
  }
}
