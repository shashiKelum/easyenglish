// class DrawerHeaderUserView extends ViewModelWidget<DrawerViewModel> {
//   final User user;
//
//   DrawerHeaderUserView(this.user);
//
//   @override
//   Widget build(BuildContext context, DrawerViewModel model) {
//     return Container(
//       key: ValueKey(1),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           InkWell(
//             onTap: model.onClickAccount,
//             child: Row(
//               children: [
//                 AccountAvatar(url: user.photoUrl),
//                 SizedBox(width: 16.0),
//                 Expanded(
//                   child: Text('Hi ${user.name}'),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
