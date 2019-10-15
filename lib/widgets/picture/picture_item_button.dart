import 'package:flutter/material.dart';
import 'package:pixart/locator.dart';
import 'package:pixart/service/navigation_service.dart';
import 'package:pixart/store/pictures/picture.dart';
import 'package:pixart/widgets/art_widget/pixel_art_widget_small.dart';
import 'package:pixart/constants/routes_path.dart' as constants;
import 'package:provider/provider.dart';

class PicturesItemButton extends StatelessWidget {
  final double size;
  final NavigationService _navigationService = locator<NavigationService>();

  PicturesItemButton({Key key, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
        child: PixelArtSmallWidget(Provider.of<Picture>(context), size),
        onTap: () {
          _navigationService.navigateTo(constants.PICTURE_ROUTE,
              arguments: Provider.of<Picture>(context));
        },
      );
}
