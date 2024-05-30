import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nyangstar/calendar/Calendar.dart';
import 'package:nyangstar/diary/Diary.dart';
import 'package:nyangstar/main.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      if(index == 3) { // 설정 메뉴 동작
          _selectedIndex = 0;
          Navigator.of(context).pushNamed("/settings");
      } else {
        _selectedIndex = index;
      }
    });
  }

  Widget _getSelectedPage(int index) {
    // index 3 값은 Setting 메뉴.
    switch (index) {
      case 0:
        return MainContents();
      case 1:
        return Diary();
      case 2:
        return Calendar();
      default:
        return MainContents();
    }
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
        backgroundColor: themeProvider.themeMode == ThemeMode.dark
            ? Colors.black12
            : Colors.white,
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
      body: _getSelectedPage(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Diary',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: themeProvider.themeMode == ThemeMode.dark ? Colors.white : Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}

class MainContents extends StatelessWidget {
  const MainContents({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // 상단 박스 안에 table.svg 배치
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: SvgPicture.asset(
                'svg/cat1.svg',
                width: 200,
                height: 200,
              ),
            ),
          ),
          SizedBox(height: 20), // 상자와 나머지 컨텐츠 간의 간격 조정
          // 입금 버튼과 금액 입력란
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 프로필 사진
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {},
                child: Text('입금'),
              ),
              SizedBox(width: 10),
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
