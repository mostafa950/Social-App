import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/models/shop_app_model/board_model.dart';

Future navigateTo(context, screen) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );

Future navigateToFinish(context, screen) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => screen), (route) => false);

Widget onItemBoard(ShopBoardModel list) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
          image: AssetImage('${list.image}'),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          '${list.title}',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontFamily: 'Janna',
          ),
        ),
        Text(
          '${list.body}',
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontFamily: 'Janna',
          ),
        ),
      ],
    );

Widget defaultTextFormedFailed({
  IconData? prefixIcon,
  IconData? suffixIcon,
  String? name,
  String? hintText,
  required TextInputType? type,
  Function()? onTap,
  required TextEditingController? controller,
  var validate,
  var onChange,
  bool isSecure = false,
  var sufPressed,
  int? maxLength,
  var onSubmit,
}) {
  return TextFormField(
    controller: controller,
    onTap: onTap,
    keyboardType: type,
    validator: validate,
    decoration: InputDecoration(
      prefixIcon: Icon(prefixIcon),
      labelText: name,
      hintText: hintText,
      hintStyle: TextStyle(
        fontSize: 12,
      ),
      suffixIcon: InkWell(
        onTap: sufPressed,
        child: Icon(
          suffixIcon,
        ),
      ),
      border: OutlineInputBorder(),
    ),
    onChanged: onChange,
    obscureText: isSecure,
    maxLength: maxLength,
    onFieldSubmitted: onSubmit,
  );
}

Widget inputButton({String? text, Color? color, Function()? onTap , double height = 50,}) {
  return Container(
    height: height,
    width: double.infinity,
    decoration: BoxDecoration(
      borderRadius: BorderRadiusDirectional.circular(4.0,),
      color: color,
    ),
    child: MaterialButton(
      onPressed: onTap,
      child: Center(
        child: Text(
          text!.toUpperCase(),
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    ),
  );
}

Widget textButton({
  var onPressed,
  String? text,
  double fontSize = 16,
}) {
  return TextButton(onPressed: onPressed, child: Text(text!.toUpperCase() , style: TextStyle(
    fontSize: fontSize,
  ),));
}

//   state is! LoginLoadingState = false ,
Widget conditionalBuilder({bool? condition = false, builder, fallback}) {
  if (condition == true) {
    return builder;
  } else {
    return fallback;
  }
}

void showToast({required String message , required ToastStates? state}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state!),
      textColor: Colors.white,
      fontSize: 16.0);
}

enum ToastStates { success, failed, warning }

Color? chooseToastColor(ToastStates? state) {
  Color color;
  switch (state!)
  {
    case ToastStates.success:
      color = Colors.green;
      break;
    case ToastStates.failed:
      color = Colors.red;
      break;
    case ToastStates.warning:
      color = Colors.orange;
      break;
  }
  return color;
}

Widget myDivider(){
  return Container(
    height: 1,
    width: double.infinity,
    color: Colors.grey[300],
  );
}
