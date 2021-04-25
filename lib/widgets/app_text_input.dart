import 'package:flutter/material.dart';
import 'package:silapis/configs/config.dart';

class AppTextInput extends StatelessWidget {
  final String title;
  final String hintText;
  final TextEditingController controller;
  final FocusNode focusNode;
  final VoidCallback onTapIcon;
  final GestureTapCallback onTap;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSubmitted;
  final Icon icon;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final String errorText;
  final int maxLines;
  final bool readOnly;
  final Widget leading;
  final Color backgroundColor;

  AppTextInput({
    Key key,
    this.title,
    this.hintText,
    this.controller,
    this.focusNode,
    this.onTapIcon,
    this.onTap,
    this.onChanged,
    this.onSubmitted,
    this.icon,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.errorText,
    this.leading,
    this.readOnly,
    this.backgroundColor,
    this.maxLines = 1,
  }) : super(key: key);

  Widget _buildErrorLabel(BuildContext context) {
    if (errorText == null) {
      return Container();
    }

    return Container(
      padding: EdgeInsets.only(left: Dimens.padding),
      child: Text(
        errorText,
        style: Theme.of(context)
            .textTheme
            .caption
            .copyWith(color: Theme.of(context).errorColor),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.subtitle2.copyWith(
                      fontWeight: FontWeight.w600, color: Colors.grey[800]),
                ),
              ),
              leading ?? Container(),
            ],
          ),
        ],
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: backgroundColor ?? Colors.grey[100],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: <Widget>[
              TextField(
                readOnly: readOnly ?? false,
                onTap: onTap,
                textAlignVertical: TextAlignVertical.center,
                onSubmitted: onSubmitted,
                controller: controller,
                focusNode: focusNode,
                onChanged: onChanged,
                obscureText: obscureText,
                keyboardType: keyboardType,
                textInputAction: textInputAction,
                maxLines: maxLines,
                decoration: InputDecoration(
                  hintText: hintText,
                  suffixIcon: icon != null
                      ? IconButton(
                          icon: icon,
                          onPressed: onTapIcon,
                        )
                      : null,
                  border: InputBorder.none,
                ),
              ),
              _buildErrorLabel(context)
            ],
          ),
        ),
      ],
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
