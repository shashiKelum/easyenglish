// class DrawerHeaderGuestView extends ViewModelWidget<DrawerViewModel> {
//   @override
//   Widget build(BuildContext context, DrawerViewModel model) {
//     return Container(
//       key: ValueKey(2),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Row(
//             children: [
//               AccountAvatar(),
//               SizedBox(width: 16.0),
//               Expanded(
//                 child: Text('Guest User'),
//               ),
//             ],
//           ),
//           SizedBox(height: 16.0),
//           Row(
//             children: [
//               Expanded(
//                 child: FlatButton(
//                   onPressed: model.onClickRegister,
//                   child: Text('Sign Up'),
//                   color: Colors.red,
//                 ),
//               ),
//               SizedBox(width: 16.0),
//               Expanded(
//                 child: FlatButton(
//                   onPressed: model.onClickLogin,
//                   child: Text('Log In'),
//                   color: Colors.blue[900],
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
