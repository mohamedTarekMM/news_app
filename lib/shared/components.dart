import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:product_app/modules/web_view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

Widget defaultMaterialTextButton({
  width = double.infinity,
  double radius = 0.0,
  Color background = Colors.blue,
  required VoidCallback onPressed,
  bool isUpperCase = true,
  required String label,
  Color textColor = Colors.white,
}) =>
    Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: background,
      ),
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(
          isUpperCase ? label.toUpperCase() : label,
          style: TextStyle(
            fontSize: 17,
            color: textColor,
          ),
        ),
      ),
    );

Widget defaultTextForm({
  required TextEditingController controller,
  required TextInputType keyboardType,
  ValueChanged<String>? onSubmitted,
  ValueChanged<String>? onChanged,
  FormFieldValidator<String>? validator,
  GestureTapCallback? onTap,
  required String label,
  IconData? prefixIcon,
  IconData? suffixIcon,
  VoidCallback? suffixPressed,
  OutlineInputBorder? outlineInputBorder,
  bool obscureText = false,
  bool borderCreate = true,
  EdgeInsetsGeometry? contentPadding,
  Color labelColor = Colors.black,
  Color prefixIconColor = Colors.black,
  Color suffixIconColor = Colors.black,
}) =>
    TextFormField(
      validator: validator,
      onTap: onTap,
      obscureText: obscureText ? true : obscureText,
      controller: controller,
      keyboardType: keyboardType,
      onFieldSubmitted: onSubmitted,
      onChanged: onChanged,
      autocorrect: false,
      decoration: InputDecoration(
        contentPadding: contentPadding,
        prefixIcon: Icon(
          prefixIcon,
          color: prefixIconColor,
        ),
        suffixIcon: suffixIcon != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(suffixIcon),
                color: suffixIconColor,
              )
            : null,
        labelText: label,
        labelStyle: TextStyle(
          color: labelColor,
        ),
        border: borderCreate ? outlineInputBorder : InputBorder.none,
      ),
    );

Widget defaultTextFormWithHintText({
  required TextEditingController controller,
  required TextInputType keyboardType,
  ValueChanged<String>? onSubmitted,
  ValueChanged<String>? onChanged,
  FormFieldValidator<String>? validator,
  GestureTapCallback? onTap,
  IconData? prefixIcon,
  IconData? suffixIcon,
  VoidCallback? suffixPressed,
  OutlineInputBorder? outlineInputBorder,
  bool obscureText = false,
  bool borderCreate = true,
  EdgeInsetsGeometry? contentPadding,
  Color labelColor = Colors.black,
  Color prefixIconColor = Colors.black,
  Color suffixIconColor = Colors.black,
  required String hintText,
}) =>
    TextFormField(
      validator: validator,
      onTap: onTap,
      obscureText: obscureText ? true : obscureText,
      controller: controller,
      keyboardType: keyboardType,
      onFieldSubmitted: onSubmitted,
      onChanged: onChanged,
      autocorrect: false,
      decoration: InputDecoration(
        contentPadding: contentPadding,
        prefixIcon: Icon(
          prefixIcon,
          color: prefixIconColor,
        ),
        suffixIcon: suffixIcon != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(suffixIcon),
                color: suffixIconColor,
              )
            : null,
        hintText: hintText,
        border: borderCreate ? outlineInputBorder : InputBorder.none,
      ),
    );

void defaultNavigatorTo(BuildContext context, {widget}) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void defaultNavigateAndKill(context, widget) {
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => widget), (route) => false);
}

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

void defaultKeyboardDismissed({context}) {
  FocusScopeNode currentFocus = FocusScope.of(context);

  if (!currentFocus.hasPrimaryFocus) {
    currentFocus.unfocus();
  }
}

void defaultToastMessage({
  required String message,
  required ToastState state,
}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: ChooseColorState(state: state),
      textColor: Colors.white,
      fontSize: 16.0);
}

Color ChooseColorState({required ToastState state}) {
  Color color;
  switch (state) {
    case ToastState.SUCCESS:
      color = Colors.green;
      break;
    case ToastState.ERROR:
      color = Colors.red;
      break;
    case ToastState.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

enum ToastState { ERROR, SUCCESS, WARNING }

Widget defaultSmoothIndicator({
  required indicatorController,
  required int count,
}) =>
    SmoothPageIndicator(
      controller: indicatorController,
      count: count,
      effect: CustomizableEffect(
        //الشكل بتاع indicator
        activeDotDecoration: DotDecoration(
          width: 32,
          height: 12,
          color: Colors.deepOrange,
          rotationAngle: 180,
          verticalOffset: -10,
          borderRadius: BorderRadius.circular(24),
        ),
        dotDecoration: DotDecoration(
          width: 24,
          height: 12,
          color: Colors.grey,
          borderRadius: BorderRadius.circular(16),
          verticalOffset: 0,
        ),
      ),
    );

void defaultScrollToEnd(
    {required ScrollController scrollController, int durationSeconds = 1}) {
  scrollController.animateTo(0,
      duration: Duration(
        seconds: durationSeconds,
      ),
      curve: Curves.fastLinearToSlowEaseIn);
}

Widget item(context, List<dynamic> list, index, bool isDark) => InkWell(
  onTap: (){
    defaultNavigatorTo(context,widget: WebViewScreen(url: list[index]['url']));
  },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          width: double.infinity,
          height: 120,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ConditionalBuilder(
                  condition: list[index]['urlToImage'] != null,
                  builder: (context)=>Image.network(
                    '${list[index]['urlToImage']}',
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                  fallback: (context)=>const Center(child: CircularProgressIndicator()),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  height: 120,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          '${list[index]['title']}',
                          maxLines: 2,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.white : Colors.black),
                        ),
                      ),
                      Text(
                        '${list[index]['publishedAt']}',
                        maxLines: 2,
                        style: Theme.of(context).textTheme.caption!.copyWith(
                            overflow: TextOverflow.ellipsis,
                            color: isDark ? Colors.white : Colors.black),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

Widget listItems({list, context, isDark, bool isSearch = false}) => ConditionalBuilder(
      condition: list.isNotEmpty,
      builder: (context) => ListView.separated(
          itemBuilder: (context, index) => item(context, list, index, isDark),
          separatorBuilder: (context, index) => myDivider(),
          itemCount: list.length),
      fallback: (context) =>isSearch?Center(child: Container()):const Center(child: CircularProgressIndicator()),
    );
