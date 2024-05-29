import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nyangstar/main.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  void _signOut() async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text('로그아웃 처리가 정상적으로 되었습니다.'),
          duration: Duration(seconds: 1)),
    );
    Navigator.of(context).pushNamedAndRemoveUntil("/login", (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'NyangStar',
          style: TextStyle(
              fontFamily: 'HiMelody',
              fontSize: 34,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor:
        themeProvider.themeMode == ThemeMode.dark ? Colors.black12 : Colors
            .white,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: AssetImage(
                  'images/profile_picture.png'), // replace with your profile image asset
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              child: Text(
                'Menu',
                style: TextStyle(
                    fontFamily: 'HiMelody',
                    fontSize: 28,
                    fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.of(context).pop(); // close the drawer
                Navigator.of(context).pushNamed("/home");
              },
            ),
            ListTile(
              leading: Icon(Icons.book),
              title: Text('Diary'),
              onTap: () {
                Navigator.of(context).pop(); // close the drawer
                Navigator.of(context).pushNamed("/diary");
              },
            ),
            ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text('Calendar'),
              onTap: () {
                Navigator.of(context).pop(); // close the drawer
                Navigator.of(context).pushNamed("/calendar");
              },
            ),
            Spacer(),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.of(context).pop(); // close the drawer
                Navigator.of(context).pushNamed("/settings");
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: _signOut,
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // 상단 박스 안에 table.svg 배치
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: SvgPicture.asset('svg/cat1.svg', width: 200, height: 200,),
            ),
          ),
          SizedBox(height: 20), // 상자와 나머지 컨텐츠 간의 간격 조정
          // 프로필 사진
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage('images/profile_picture.png'),
          ),
          SizedBox(height: 10), // 프로필 사진과 입금 버튼 간의 간격 조정
          // 입금 버튼과 금액 입력란
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: Text('입금'),
              ),
              SizedBox(width: 10), // 버튼과 텍스트 필드 사이의 간격 조정
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '금액',
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20), // 입력창과 입금 내역 사이의 간격 조정
          // 입금 내역 제목
          Text(
            'History',
            style: TextStyle(
              fontFamily: 'HiMelody',
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          // 입금 내역 리스트뷰
          Expanded(
            child: ListView.builder(
              itemCount: 10, // 입금 내역 아이템 개수
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.money),
                  title: Text('입금 내역 ${index + 1}'),
                  subtitle: Text('금액: \$100'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
