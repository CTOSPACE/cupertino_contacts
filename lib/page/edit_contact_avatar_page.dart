/*
 * Copyright (c) 2020 CHANGLEI. All rights reserved.
 */

import 'dart:typed_data';

import 'package:cupertinocontacts/presenter/edit_contact_avatar_presenter.dart';
import 'package:cupertinocontacts/resource/assets.dart';
import 'package:cupertinocontacts/widget/circle_avatar.dart';
import 'package:cupertinocontacts/widget/cupertino_divider.dart';
import 'package:cupertinocontacts/widget/framework.dart';
import 'package:cupertinocontacts/widget/navigation_bar_action.dart';
import 'package:cupertinocontacts/widget/widget_group.dart';
import 'package:flutter/cupertino.dart';

/// Created by box on 2020/4/1.
///
/// 编辑联系人头像
const int _crossCount = 4;
const double _padding = 16;
const double _spacing = 24;

class EditContactAvatarPage extends StatefulWidget {
  final Uint8List picture;

  const EditContactAvatarPage({Key key, this.picture}) : super(key: key);

  @override
  _EditContactAvatarPageState createState() => _EditContactAvatarPageState();
}

class _EditContactAvatarPageState extends PresenterState<EditContactAvatarPage, EditContactAvatarPresenter> {
  _EditContactAvatarPageState() : super(EditContactAvatarPresenter());

  @override
  Widget builds(BuildContext context) {
    var textTheme = CupertinoTheme.of(context).textTheme;
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.secondarySystemBackground,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.secondarySystemBackground,
        border: null,
        leading: NavigationBarAction(
          child: Text('取消'),
          onPressed: presenter.onCancelPressed,
        ),
        trailing: NavigationBarAction(
          child: Text('完成'),
          onPressed: presenter.picture == null ? null : presenter.onDonePressed,
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: WidgetGroup(
          alignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          direction: Axis.vertical,
          divider: CupertinoDivider(),
          children: [
            Container(
              padding: EdgeInsets.only(
                top: 4,
                bottom: 16,
              ),
              child: WidgetGroup.spacing(
                spacing: 8,
                alignment: MainAxisAlignment.start,
                direction: Axis.vertical,
                children: [
                  CupertinoCircleAvatar.memory(
                    assetName: Images.ic_default_avatar,
                    bytes: presenter.picture,
                    borderSide: BorderSide.none,
                    size: 144,
                    onPressed: presenter.isInvalidAvatar
                        ? null
                        : () {
                            presenter.editPicture(presenter.picture);
                          },
                  ),
                  CupertinoButton(
                    minSize: 14,
                    padding: EdgeInsets.zero,
                    borderRadius: BorderRadius.zero,
                    onPressed: () {
                      presenter.editPicture(presenter.picture);
                    },
                    child: presenter.isInvalidAvatar
                        ? SizedBox.shrink()
                        : Text(
                            '编辑',
                            style: TextStyle(
                              fontSize: 14,
                              color: CupertinoTheme.of(context).primaryColor,
                              height: 1.0,
                            ),
                          ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverPadding(
                    padding: EdgeInsets.only(
                      left: _padding,
                      top: 10,
                      right: _padding,
                      bottom: 24,
                    ),
                    sliver: SliverToBoxAdapter(
                      child: WidgetGroup.spacing(
                        alignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '建议',
                            style: textTheme.textStyle,
                          ),
                          CupertinoButton(
                            child: Text('所有照片'),
                            borderRadius: BorderRadius.zero,
                            padding: EdgeInsets.zero,
                            minSize: 0,
                            onPressed: presenter.onAllPicturePressed,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.only(
                      left: _padding,
                      right: _padding,
                      bottom: _padding + MediaQuery.of(context).padding.bottom,
                    ),
                    sliver: SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          var avatar = presenter.proposals.elementAt(index);
                          return CupertinoCircleAvatar.memory(
                            assetName: Images.ic_default_avatar,
                            bytes: avatar,
                            borderSide: BorderSide.none,
                            size: double.infinity,
                            onPressed: () {
                              presenter.editPicture(avatar);
                            },
                          );
                        },
                        childCount: presenter.proposals.length,
                        addAutomaticKeepAlives: true,
                        addRepaintBoundaries: true,
                        addSemanticIndexes: true,
                      ),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: _crossCount,
                        crossAxisSpacing: _spacing,
                        mainAxisSpacing: _spacing,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}