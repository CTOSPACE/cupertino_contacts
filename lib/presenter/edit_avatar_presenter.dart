/*
 * Copyright (c) 2020 CHANGLEI. All rights reserved.
 */

import 'package:cupertinocontacts/page/crop_image_page.dart';
import 'package:cupertinocontacts/page/edit_avatar_page.dart';
import 'package:cupertinocontacts/presenter/presenter.dart';
import 'package:cupertinocontacts/route/route_provider.dart';
import 'package:flutter/cupertino.dart';

enum EditAvatarType {
  formulate,
  edit,
  copy,
  delete,
}

class EditAvatarPresenter extends Presenter<EditAvatarPage> {
  onFormulatePressed() {
    Navigator.pop(context, {
      'data': widget.avatar,
      'type': EditAvatarType.formulate,
    });
  }

  onEditPressed() {
    Navigator.push(
      context,
      RouteProvider.buildRoute(
        CropImagePage(bytes: widget.avatar.src),
        fullscreenDialog: true,
      ),
    ).then((value) {
      if (value == null) {
        return;
      }
      widget.avatar.target = value;
      Navigator.pop(context, {
        'data': widget.avatar,
        'type': EditAvatarType.edit,
      });
    });
  }

  onCopyPressed() {
    Navigator.pop(context, {
      'data': widget.avatar,
      'type': EditAvatarType.copy,
    });
  }

  onDeletePressed() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return CupertinoActionSheet(
          actions: <Widget>[
            CupertinoActionSheetAction(
              child: Text('删除'),
              isDestructiveAction: true,
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            child: Text('取消'),
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context, false);
            },
          ),
        );
      },
    ).then((value) {
      if (value ?? false) {
        Navigator.pop(context, {
          'data': widget.avatar,
          'type': EditAvatarType.delete,
        });
      }
    });
  }
}
