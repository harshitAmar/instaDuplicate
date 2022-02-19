// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta/resources/auth_methods.dart';
import 'package:insta/responsive/mobile_screen_layout.dart';
import 'package:insta/responsive/responsive_layout_screen.dart';
import 'package:insta/responsive/web_screen_layout.dart';
import 'package:insta/screens/login_screen.dart';
import 'package:insta/utils/colors.dart';
import 'package:insta/utils/utils.dart';
import 'package:insta/widgets/text_field_input.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 32,
        ),
        // width: double.infinity,
        child: ListView(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/images/ic_instagram.svg",
                color: primaryColor,
                height: 64,
              ),
              SizedBox(
                height: 40,
              ),
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 64, backgroundImage: MemoryImage(_image!))
                      : CircleAvatar(
                          radius: 64,
                          backgroundImage: NetworkImage(
                              "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.pngarts.com%2Fexplore%2Ftag%2Fdefault-profile-picture&psig=AOvVaw1wSMsD48F1yFX31JiekxMR&ust=1644515328737000&source=images&cd=vfe&ved=0CAsQjRxqFwoTCID6rJOX8_UCFQAAAAAdAAAAABAJ"),
                        ),
                  Positioned(
                      bottom: -10,
                      left: 80,
                      child: IconButton(
                        icon: Icon(Icons.add_a_photo),
                        onPressed: () {
                          selectImage();
                        },
                      ))
                ],
              ),
              SizedBox(
                height: 30,
              ),
              TextFieldInput(
                  textEditingController: _usernameController,
                  hintText: "Choose an username",
                  textInputType: TextInputType.text),
              SizedBox(
                height: 30,
              ),
              TextFieldInput(
                  textEditingController: _emailController,
                  hintText: "Please Enter your email Address",
                  textInputType: TextInputType.emailAddress),
              SizedBox(
                height: 30,
              ),
              TextFieldInput(
                textEditingController: _passwordController,
                hintText: "Please Enter Your Password",
                textInputType: TextInputType.text,
                isPass: true,
              ),
              SizedBox(
                height: 30,
              ),
              TextFieldInput(
                  textEditingController: _bioController,
                  hintText: "Add a bio",
                  textInputType: TextInputType.text),
              SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: signUpUser,
                child: Container(
                  child: _isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        )
                      : Text("Sign Up"),
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          4,
                        ),
                      ),
                    ),
                    color: blueColor,
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text("Already have an account?"),
                    padding: EdgeInsets.symmetric(vertical: 8),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => LoginScreen()));
                    },
                    child: Container(
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 8),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ]),
      ),
    ));
  }

  void selectImage() async {
    Uint8List inn = await pickImage(ImageSource.gallery);
    setState(() {
      _image = inn;
    });
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethod().signUpUser(
        userName: _usernameController.text,
        bio: _bioController.text,
        email: _emailController.text,
        password: _passwordController.text,
        file: _image!);
    setState(() {
      _isLoading = false;
    });
    if (res != 'success') {
      showSnackBar(res, context);
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => ResponsiveLayout(
                mobileScreenLayout: MobileScreenLayout(),
                webScreenLayout: WebScreenLayout(),
              )));
    }
  }
}
