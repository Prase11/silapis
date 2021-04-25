import 'package:flutter/material.dart';
import 'package:silapis/widgets/widget.dart';
import 'package:silapis/configs/config.dart';
import 'package:silapis/models/model.dart';
import 'package:dotted_border/dotted_border.dart';
import 'dart:io';

class AppImagePicker extends StatelessWidget {
  final Function onTap;
  final Function onCloseFile;
  final String title;
  final String placeholder;
  final String previewImage;
  final String errorText;
  const AppImagePicker(
      {Key key,
      this.onTap,
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
                    ? onTap
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
}
