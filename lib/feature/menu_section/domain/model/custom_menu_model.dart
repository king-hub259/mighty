class CustomMenuModel{
  final String title;
  final String icon;
  final List<SubMenu>? subMenus;

  CustomMenuModel({required this.title, required this.icon, this.subMenus});
}
class SubMenu{
  final String title;
  final String icon;

  SubMenu({required this.title, required this.icon});
}