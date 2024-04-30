import 'package:flutter/material.dart';
import '../components/image_data.dart';

class LeftLogoAppBar extends StatelessWidget implements PreferredSizeWidget {
  const LeftLogoAppBar({super.key, this.onAddButtonPressed});

  final VoidCallback? onAddButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 37),
      child: AppBar(
        toolbarHeight: 97,
        automaticallyImplyLeading: false,
        title: Image.asset(IconPath.logo, width: 140,),
        actions: [
          TextButton(
            onPressed: onAddButtonPressed,
            child: SizedBox(height: 30, child: Image.asset(IconPath.add,),)
          )
        ],
      )
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(97);
}


class CenterLogoAppBar extends StatelessWidget implements PreferredSizeWidget{
  const CenterLogoAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 97,
      centerTitle: true,
      automaticallyImplyLeading: false,
      title: Padding(
        padding: const EdgeInsets.only(top: 35),
        child: SizedBox(width: 140, child: Image.asset(IconPath.logo)),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(97);
}



class TextTitleAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TextTitleAppBar({
    super.key,
    required this.title,
    required this.buttonNum,
    this.onDeleteButtonPressed,
    this.onEditButtonPressed,
    this.onSaveButtonPressed
  });

  final String title;
  final int buttonNum;
  final VoidCallback? onDeleteButtonPressed;
  final VoidCallback? onEditButtonPressed;
  final VoidCallback? onSaveButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 37),
      child: AppBar(
        toolbarHeight: 97,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SizedBox(height:24, child: Image.asset(IconPath.goBack))
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        actions: [drawButton()],
      ),
    );
  }

  Widget drawButton() {
    if (buttonNum == 1) {
      return TextButton(
        onPressed: onDeleteButtonPressed,
        style: TextButton.styleFrom(
          minimumSize: Size.zero,
          padding: EdgeInsets.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: SizedBox(height: 24, child: Image.asset(IconPath.delete)),
      );
    } else if (buttonNum == 2) {
      return Row(
        children: [
          TextButton(
            onPressed: onEditButtonPressed,
            style: TextButton.styleFrom(
              minimumSize: Size.zero,
              padding: EdgeInsets.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: SizedBox(height:24, child: Image.asset(IconPath.edit)),
          ),
          const SizedBox(width: 8),
          TextButton(
            onPressed: onDeleteButtonPressed,
            style: TextButton.styleFrom(
              minimumSize: Size.zero,
              padding: EdgeInsets.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: SizedBox(height: 24, child: Image.asset(IconPath.delete)),
          ),
        ],
      );
    } else if (buttonNum == 3) {
      return SizedBox(
        width: 51,
        height: 34,
        child: FilledButton(
          onPressed: onSaveButtonPressed,
          style: TextButton.styleFrom(
              minimumSize: Size.zero,
              padding: EdgeInsets.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              backgroundColor: const Color(0xffF6747E)
          ),
          child: const Text(
            "저장",
            style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500,),
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(97);
}
