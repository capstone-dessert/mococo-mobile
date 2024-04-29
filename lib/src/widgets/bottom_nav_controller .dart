
class SearchBottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              IconPath.closetOff,
              width: 55,
              height: 55,
            ),
            activeIcon: Image.asset(IconPath.closetOn, width: 55, height: 55),
            label: 'closet',
          ),
        ]);
  }
}
