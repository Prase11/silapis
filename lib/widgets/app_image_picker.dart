import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:silapis/widgets/widget.dart';
import 'package:silapis/configs/config.dart';
import 'package:silapis/models/model.dart';
import 'package:dotted_border/dotted_border.dart';
import 'dart:io';

class AppImagePicker extends StatelessWidget {
  final Function onTap;
  final Function(String) onChange;
  final Function onCloseFile;
  final String title;
  final String placeholder;
  final String previewImage;
  final String errorText;
  const AppImagePicker(
      {Key key,
      this.onTap,
      this.onChange,
      this.placeholder,
      this.previewImage,
      this.onCloseFile,
      this.errorText,
      this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 2),
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.subtitle2.copyWith(
                        fontWeight: FontWeight.w600, color: Colors.grey[800]),
                  ),
                ),
              ],
            ),
          ],
          Container(
            height: 150,
            width: double.infinity,
            margin: EdgeInsets.only(top: 10, bottom: 5),
            decoration: BoxDecoration(),
            child: Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: previewImage == null
                    ? () {
                        _modalBottomSheet(context);
                      }
                    : () {
                        Navigator.pushNamed(context, Routes.photoPreview,
                            arguments: {
                              'index': 0,
                              'photo': [
                                ImageModel(0, previewImage, previewImage)
                              ]
                            });
                      },
                child: Stack(
                  children: [
                    DottedBorder(
                      strokeWidth: 2,
                      color: Colors.grey.withOpacity(.5),
                      borderType: BorderType.RRect,
                      dashPattern: [4, 4],
                      radius: Radius.circular(12),
                      child: previewImage != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              child: Container(
                                height: 150,
                                width: double.infinity,
                                child: Image.file(new File(previewImage),
                                    fit: BoxFit.cover),
                              ),
                            )
                          : Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.filter,
                                    size: 80,
                                    color: Colors.grey[200],
                                  ),
                                  SizedBox(height: 10),
                                  Text(placeholder ?? 'Pilih Berkas'),
                                ],
                              ),
                            ),
                    ),
                    if (previewImage != null) ...[
                      Positioned(
                        right: 10,
                        top: 10,
                        child: InkWell(
                          onTap: onCloseFile,
                          child: Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ]
                  ],
                ),
              ),
            ),
          ),
          if (errorText != null) ...[
            Container(
              // padding: EdgeInsets.only(left: Dimens.padding),
              child: Text(
                errorText,
                style: Theme.of(context)
                    .textTheme
                    .caption
                    .copyWith(color: Theme.of(context).errorColor),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ]
        ],
      ),
    );
  }

  _modalBottomSheet(BuildContext context) {
    final ImagePicker _picker = ImagePicker();

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.0),
          topRight: Radius.circular(8.0),
        ),
      ),
      isDismissible: false,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            padding:
                EdgeInsets.symmetric(vertical: 10, horizontal: Dimens.padding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  width: 60,
                  height: 6,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3.0),
                      color: Theme.of(context).highlightColor),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: AppRoundedButton(
                        title: 'Gallery',
                        textStyle: TextStyle(
                            fontSize: 12.0, fontWeight: FontWeight.bold),
                        borderSide:
                            BorderSide(color: Theme.of(context).primaryColor),
                        elevation: 0.0,
                        color: Theme.of(context).canvasColor,
                        onPressed: () async {
                          Navigator.of(context).pop();

                          final pickedFile = await _picker.getImage(
                            source: ImageSource.gallery,
                          );
                          if (pickedFile?.path != null) {
                            onChange(pickedFile.path);
                            print('FILE PATH ' + pickedFile.path);
                          }
                        },
                      ),
                    ),
                    SizedBox(width: Dimens.padding),
                    Expanded(
                      child: AppRoundedButton(
                        title: 'Camera',
                        textStyle: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                        color: Theme.of(context).primaryColor,
                        elevation: 0.0,
                        onPressed: () async {
                          Navigator.of(context).pop();

                          final pickedFile = await _picker.getImage(
                            source: ImageSource.camera,
                          );
                          if (pickedFile?.path != null) {
                            onChange(pickedFile.path);
                            print('FILE PATH ' + pickedFile.path);
                          }
                        },
                      ),
                    )
                  ],
                ),
                SizedBox(height: 15),
              ],
            ),
          ),
        );
      },
    );
  }
}
