import 'package:flutter/material.dart';
import 'package:project1/Module/room_item.dart';
import 'package:project1/Module/user_item.dart';
import 'package:project1/View/guest_navigation_screen.dart';
import 'package:project1/View/login_screen.dart';
import 'package:project1/View/owner_navigation_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  bool isLogin = false;

  Future<String?> getstoreData() async {
    // khai báo biến store lưu trữ toàn bộ thông tin đã lưu lại của app trong bộ nhớ của đện thoại
    SharedPreferences store = await _prefs;
    // khai báo biến lấy ra thời gian đăng nhập gần nhất
    DateTime? lastLogin = DateTime.tryParse(store.getString('timer') ?? '');
    // nếu biến lastLogin ko null (có nghĩa là dữ liệu) thì người dùng đã từng login và chọn lưu đăng nhập
    if (lastLogin != null) {
      // nếu thời gian đăng nhập gần nhất là trong khoảng 24h trước thì sẽ tự động login và navigate tới màn hình home tương ứng vs tài khoản đã lưu trước đó
      if (DateTime.now().difference(lastLogin).inHours <= 24) {
        // lấy ra id của người dùng ở lần đang nhập gần nhất
        String userId = store.getString('userID')!;
        return userId;
      }
    }
    return null;
  }

  @override
  void initState() {
    getstoreData().then((value) async {
      // value là return của function gestoreData (là id của người dùng ở lần đăng nhập gần nhất)
      if (value == null) {
        // trong bộ nhó của đt ko luu id của ng dùng hoạc thòi gian đang nhập đã quá 24h trước thì navigate tói màn hình login
        return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
      } else if (value == 'Admin') {
        // nếu id ng dùng là admin thì navigate tói role admin
        await RoomDA.getListRoom(); // lấy danh sách phòng cho thuê trên firebase
        await UserDA.getListAccount().then((_) {
          // lấy danh sách các tài khoản tồn tại trên firebase và lấy ra tk có id là admin
          UserDA.user = UserDA.listAccount.firstWhere(
            (e) => e.roomId == 'Admin',
            orElse: () => UserItem(),
          );
        });
        // ignore: use_build_context_synchronously
        return Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const OwnerNavigationScreen()));
      } else {
        // nếu id ng dùng ko phải admin thì navigate tói role guest
        await UserDA.getListAccount().then((_) {
          // lấy danh sách các tài khoản tồn tại trên firebase và lấy ra tk có id là value
          UserDA.user = UserDA.listAccount.firstWhere(
            (e) => e.roomId == value,
            orElse: () => UserItem(),
          );
        });
        var roomItem = await RoomDA.getRoomInfor(value);
        // ignore: use_build_context_synchronously
        return Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => GuestNavigationScreen(
                      roomItem: roomItem,
                    )));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'lib/Assets/Splash screen.png',
          fit: BoxFit.fill,
          width: double.infinity,
        ),
      ),
    );
  }
}
