/*
 * Copyright (c) 2020 CHANGLEI. All rights reserved.
 */

import 'dart:async';

import 'package:cupertinocontacts/page/contact_detail_page.dart';
import 'package:cupertinocontacts/presenter/object_presenter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_contact/contact.dart';
import 'package:flutter_contact/contacts.dart';

class ContactDetailPresenter extends ObjectPresenter<ContactDetailPage, Contact> {
  final remarksController = TextEditingController();

  StreamSubscription<dynamic> _subscription;

  @override
  void initState() {
    setObject(widget.contact);
    _subscription = Contacts.contactEvents.listen((event) => onDefaultRefresh());
    super.initState();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Future<Contact> onLoad(bool showProgress) {
    return Contacts.getContact(widget.identifier);
  }

  @override
  void onLoaded(Contact object) {
    remarksController.text = object?.note;
    super.onLoaded(object);
  }
}
