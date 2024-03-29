// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:ibb_university_images/pages/add_photo_page.dart';
import 'package:ibb_university_images/pages/login_page.dart';
import 'package:ibb_university_images/pages/registration_page.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            padding: EdgeInsets.only(top: 40),
            alignment: Alignment.center,
            color: Theme.of(context).accentColor,
            child: Text(
              'صور جامعة إب',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed(LoginPage.PAGE_ROUTE);
            },
            leading: Icon(
              Icons.login,
              size: 30,
              color: Colors.blue,
            ),
            title: Text(
              'تسجيل دخول',
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed(RegisterationPage.PAGE_ROUTE);
            },
            leading: Icon(
              Icons.person,
              size: 30,
              color: Colors.blue,
            ),
            title: Text(
              'إنشاء حساب',
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed(
                AddPhotoPage.PAGE_ROUTE,
              );
            },
            leading: Icon(
              Icons.add_a_photo,
              size: 30,
              color: Colors.blue,
            ),
            title: Text(
              'إضافة صورة',
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
