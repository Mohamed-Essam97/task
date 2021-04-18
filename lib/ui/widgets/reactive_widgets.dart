// import 'package:flutter/material.dart';
// import 'package:reactive_forms/reactive_forms.dart';
// import 'package:testapp/core/services/localization/localization.dart';

// enum ReactiveFields {
//   TEXT,
//   DROP_DOWN,
//   PASSWORD,
//   DATE_PICKER,
//   DATE_PICKER_FIELD,
//   CHECKBOX_LISTTILE,
//   RADIO_LISTTILE
// }

// class ReactiveField extends StatelessWidget {
//   @required
//   final ReactiveFields type;
//   @required
//   final String controllerName;
//   final int maxLines;
//   final double width;
//   final Map<String, String> validationMesseges;
//   final TextInputType keyboardType;
//   final InputDecoration decoration;
//   final String hint, radioTitle, radioVal;
//   final Color borderColor, hintColor, textColor, fillColor, enabledBorderColor;
//   final bool secure, autoFocus, readOnly, filled;
//   final List<dynamic> items;
//   final BuildContext context;
//   final String label;
//   const ReactiveField(
//       {this.type,
//       this.controllerName,
//       this.validationMesseges,
//       this.hint,
//       this.width = double.infinity,
//       this.keyboardType = TextInputType.emailAddress,
//       this.secure = false,
//       this.autoFocus = false,
//       this.readOnly = false,
//       this.label,
//       this.radioTitle = '',
//       this.borderColor = Colors.grey,
//       this.hintColor = Colors.black,
//       this.textColor = Colors.black,
//       this.fillColor = Colors.transparent,
//       this.enabledBorderColor = Colors.white,
//       this.maxLines = 1,
//       this.filled = false,
//       this.radioVal = '',
//       this.items,
//       this.context,
//       this.decoration});

//   @override
//   Widget build(BuildContext context) {
//     final locale = AppLocalizations.of(context);
//     return Container(
//       width: width,
//       child: buildReactiveField(locale),
//     );
//   }

//   buildReactiveField(locale) {
//     var validationM = validationMesseges ??
//         {
//           'required': locale.get("Required") ?? "Required",
//           'minLength': locale.get("Password must exceed 8 characters") ??
//               "Password must exceed 8 characters",
//           'mustMatch': locale.get("Passwords doesn't match") ??
//               "Passwords doesn't match",
//           'email': locale.get("Please enter valid email") ??
//               "Please enter valid email"
//         };

//     switch (type) {
//       case ReactiveFields.TEXT:
//         return ReactiveTextField(
//           formControlName: controllerName,
//           validationMessages: (controller) => validationM,
//           keyboardType: keyboardType,
//           style: TextStyle(color: textColor),
//           maxLines: maxLines,
//           decoration: decoration != null
//               ? decoration
//               : InputDecoration(
//                   // labelStyle: TextStyle(color: Colors.blue),
//                   filled: filled,
//                   fillColor: fillColor,
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10.0),
//                     borderSide: BorderSide(
//                       color: borderColor,
//                     ),
//                   ),

//                   enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10.0),
//                     borderSide: BorderSide(
//                       color: enabledBorderColor,
//                       width: 2.0,
//                     ),
//                   ),
//                   labelText: label,
//                   hintText: hint,
//                   // fillColor: Colors.grey,

//                   labelStyle: TextStyle(color: textColor),
//                   hintStyle: TextStyle(color: hintColor),

//                   // fillColor: Colors.white,
//                 ),
//           autofocus: autoFocus,
//           readOnly: readOnly,
//           obscureText: secure,
//         );
//         break;
//       case ReactiveFields.PASSWORD:
//         return ReactiveTextField(
//           formControlName: controllerName,
//           validationMessages: (controller) => validationM,
//           keyboardType: TextInputType.visiblePassword,
//           style: TextStyle(color: textColor),
//           decoration: decoration != null
//               ? decoration
//               : InputDecoration(
//                   // labelStyle: TextStyle(color: Colors.blue),
//                   filled: filled,
//                   fillColor: fillColor,
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10.0),
//                     borderSide: BorderSide(
//                       color: Colors.red,
//                     ),
//                   ),
//                   enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10.0),
//                     borderSide: BorderSide(
//                       color: borderColor,
//                       width: 2.0,
//                     ),
//                   ),
//                   labelText: label,
//                   hintText: hint,

//                   labelStyle: TextStyle(color: textColor),
//                   hintStyle: TextStyle(color: hintColor),
//                   // fillColor: Colors.grey,

//                   // fillColor: Colors.white,
//                 ),
//           autofocus: autoFocus,
//           readOnly: readOnly,
//           obscureText: secure,
//         );
//         break;
//       case ReactiveFields.DROP_DOWN:
//         return ReactiveDropdownField(
//           hint: Text(hint ?? ""),
//           items: items
//               .map((item) => DropdownMenuItem<dynamic>(
//                     value: item.id,
//                     child: new Text(
//                       item.name.localized(context),
//                       style: TextStyle(color: Colors.black, fontSize: 16),
//                     ),
//                   ))
//               .toList(),
//           style: TextStyle(color: Colors.black),
//           decoration: decoration != null
//               ? decoration
//               : InputDecoration(
//                   // labelStyle: TextStyle(color: Colors.blue),
//                   filled: filled,
//                   fillColor: fillColor,
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10.0),
//                     borderSide: BorderSide(
//                       color: Colors.red,
//                     ),
//                   ),

//                   enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10.0),
//                     borderSide: BorderSide(
//                       color: borderColor,
//                       width: 2.0,
//                     ),
//                   ),

//                   labelText: label,
//                   hintText: hint,

//                   labelStyle: TextStyle(color: textColor),
//                   hintStyle: TextStyle(color: hintColor),

//                   // fillColor: Colors.white,
//                 ),
//           readOnly: readOnly,
//           formControlName: controllerName,

//           // style: TextStyle(color: textColor),
//         );
//         break;
//       case ReactiveFields.DATE_PICKER:
//         return ReactiveDatePicker(
//           formControlName: controllerName,
//           builder: (context, picker, child) {
//             return IconButton(
//               onPressed: picker.showPicker,
//               icon: Icon(Icons.date_range),
//             );
//           },
//           firstDate: DateTime(1985),
//           lastDate: DateTime(2030),
//         );
//         break;

//       case ReactiveFields.DATE_PICKER_FIELD:
//         return ReactiveTextField(
//           formControlName: controllerName,
//           readOnly: true,
//           decoration: InputDecoration(
//             labelText: 'Birthday',
//             suffixIcon: ReactiveDatePicker(
//               formControlName: controllerName,
//               firstDate: DateTime(1985),
//               lastDate: DateTime(2030),
//               builder: (context, picker, child) {
//                 return IconButton(
//                   onPressed: picker.showPicker,
//                   icon: Icon(Icons.date_range),
//                 );
//               },
//             ),
//           ),
//         );
//         break;

//       case ReactiveFields.CHECKBOX_LISTTILE:
//         return ReactiveCheckboxListTile();
//         break;
//       case ReactiveFields.RADIO_LISTTILE:
//         return ReactiveRadioListTile(
//             formControlName: controllerName,
//             title: Text(radioTitle),
//             value: radioVal);
//         break;
//     }
//   }
// }
