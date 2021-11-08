import 'package:flutter/material.dart';
import 'package:invapp/utils/icons_string_util.dart';

class ListTileCustom extends StatelessWidget {
  final Widget title;
  final Widget subtitle;
  final String iconName;
  final Function iconFunction;
  final Color iconColor;
  final String trailingIconName;
  final Function onTap;
  final bool divider;
  final Color dividerColor;
  final Color backgroundColor;
  final double diverThickness;
  final Widget leading;
  final Widget trailing;
  final EdgeInsetsGeometry padding;
  final bool active;

  ListTileCustom({
    this.title,
    this.subtitle,
    this.iconName = '',
    this.iconColor,
    this.iconFunction,
    this.onTap,
    this.trailingIconName = 'chevron_right',
    this.divider = true,
    this.dividerColor,
    this.diverThickness = 1.0,
    this.leading,
    this.trailing,
    this.backgroundColor,
    this.active,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0),
  });

  @override
  Widget build(BuildContext context) {
    final listTileCustom = Column(
      children: [
        Container(
          decoration: (this.active != null && this.active)
              ? BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  border: Border(
                    top: BorderSide(color: Colors.grey[400], width: 0.5),
                  ),
                )
              : null,
          child: ListTile(
            tileColor: (this.backgroundColor != null) ? this.backgroundColor : null,
            contentPadding: padding,
            leading: (leading == null)
                ? (iconName != '')
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: iconFunction != null ? iconFunction : () {},
                            child: Icon(
                              getIcon(iconName),
                              color: iconColor == null ? Theme.of(context).primaryColor : iconColor,
                              size: 25.0,
                            ),
                          ),
                        ],
                      )
                    : null
                : leading,
            trailing: (trailing == null)
                ? (trailingIconName != '')
                    ? Icon(getIcon(trailingIconName), color: (active != null && active) ? Theme.of(context).primaryColor : Colors.grey)
                    : null
                : trailing,
            onTap: this.onTap,
            title: title,
            subtitle: subtitle,
          ),
        ),
        this.divider
            ? Divider(
                height: 0.0,
                color: dividerColor == null ? Theme.of(context).dividerColor : dividerColor,
                thickness: this.diverThickness,
              )
            : Container(),
      ],
    );
    return (active != null && active)
        ? Material(
            elevation: 4.0,
            child: listTileCustom,
          )
        : listTileCustom;
  }
}
