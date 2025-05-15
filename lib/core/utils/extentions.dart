import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  double get height => MediaQuery.sizeOf(this).height;
  double get width => MediaQuery.sizeOf(this).width;
}
  
extension HeightExtension on num {

  double get h => this.toDouble();
  
  double hp(BuildContext context) => 
      MediaQuery.sizeOf(context).height * (this / 100);
}
extension WidthExtension on num {

  double get w => this.toDouble();
  
  double wp(BuildContext context) => 
      MediaQuery.sizeOf(context).width * (this / 100);
}

extension PaddingExtension on num {

  EdgeInsets get allPad => EdgeInsets.all(this.toDouble());
  
  EdgeInsets get hPad => EdgeInsets.symmetric(horizontal: this.toDouble());
  
  EdgeInsets get vPad => EdgeInsets.symmetric(vertical: this.toDouble());
  
  EdgeInsets get rightPad => EdgeInsets.only(right: this.toDouble());

  EdgeInsets get leftPad => EdgeInsets.only(left: this.toDouble());
  

  EdgeInsets get topPad => EdgeInsets.only(top: this.toDouble());
  
  EdgeInsets get bottomPad => EdgeInsets.only(bottom: this.toDouble());
}
extension SizedBoxExtension on num {

  SizedBox get widthBox => SizedBox(width: this.toDouble());
  SizedBox get heightBox => SizedBox(height: this.toDouble());
}

extension NavigatorExtension on BuildContext {
  void pushNamedAndRemoveUntil(String routeName) => Navigator.pushNamedAndRemoveUntil(this, routeName, (route) => false);
  void pushNamed(String routeName) => Navigator.pushNamed(this, routeName);
  void pop() => Navigator.pop(this);
  void pushReplacementNamed(String routeName) => Navigator.pushReplacementNamed(this, routeName);
  void pushReplacement(Widget routeName) => Navigator.pushReplacement(this, MaterialPageRoute(builder: (context) => routeName));
  void push(Widget routeName) => Navigator.push(this, MaterialPageRoute(builder: (context) => routeName));
  void popUntil(String routeName) => Navigator.popUntil(this, ModalRoute.withName(routeName));
  void popUntilRoot() => Navigator.popUntil(this, (route) => route.isFirst);
  
}