import 'package:flutter/material.dart';
import 'package:pixart/config/main_theme.dart';
import 'package:pixart/screens/pictures/picture_detail/picture_detail_store.dart';
import 'package:pixart/store/pictures/picture.dart';
import 'package:pixart/widgets/picture/picture_detail/picture_detail_body.dart';
import 'package:provider/provider.dart';

class PictureDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Picture picture = Provider.of<Picture>(context);
    return Container(
      color: bgNavColor,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              '',
            ),
          ),
          body: SingleChildScrollView(
            child: Provider<PictureDetailStore>(
              builder: (_) => PictureDetailStore(picture),
              child: Consumer<PictureDetailStore>(
                builder: (_, store, child) => PictureDetailBody(
                  store: store,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
