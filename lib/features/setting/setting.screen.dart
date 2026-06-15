part of setting_lib;

class SettingScreen extends GetView<SettingController> {
  const SettingScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppStyle.kWhite,
        appBar: const AppBarSetting(),
        body: ListView(children: const [ProfileCard(), Settings()]));
  }
}
