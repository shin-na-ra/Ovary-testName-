import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ovary_app/vm/database_handler.dart';

class SimplePasswordWidget extends StatefulWidget {
  const SimplePasswordWidget({super.key});

  @override
  _SimplePasswordWidget createState() => _SimplePasswordWidget();
}

class _SimplePasswordWidget extends State<SimplePasswordWidget> {
  List<String> _password = List.filled(6, '');
  int _currentIndex = 0;
  String _passwordString = '';
  final box = GetStorage();
  
  //키보드 입력시 배열에 저장
  void _handleNumberInput(String number) {
    if (_currentIndex < 6) {
      setState(() {
        _password[_currentIndex] = number;
        _currentIndex++;
      });
    }
  }
//백스페이스 입력시 배열 삭제
  void _handleBackspace() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
        _password[_currentIndex] = '';
      });
    }
  }
  //입력한 리스트값을 box에 담고 이메일을 기준으로 비밀번호를 인서트 시키기 위해 이메일이랑 패스워드값을 보냄
  void _handleSubmit() async{
    _passwordString = _password.join(); // 리스트를 문자열로 변환
    box.write('simplepassword', _passwordString);
    // _passwordString= _passwordString.toString;
    print('입력한 비밀번호: $_passwordString'); // 콘솔에 출력
    final databaseHandler = DatabaseHandler();
    
    await databaseHandler.updateUserPassword(box.read("email"), _passwordString.toString());

    Get.back();
    Get.back();
    Get.back();
    
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 30, 0, 200),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                6,
                (index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        _password[index],
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // 숫자 버튼 행
         Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  _handleNumberInput('1');
                },
                child: const Text('1',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
                ),
                style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff8b7ff5),
                foregroundColor: Colors.white,
                fixedSize: Size(120, 60)
              ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  _handleNumberInput('2');
                },
                child: const Text('2',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),),
                style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff8b7ff5) ,
                foregroundColor: Colors.white,
                fixedSize: Size(120, 60)
              ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  _handleNumberInput('3');
                },
                child: const Text('3',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),),
                style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff8b7ff5) ,
                foregroundColor: Colors.white,
                fixedSize: Size(120, 60)
              ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  _handleNumberInput('4');
                },
                child: const Text('4',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),),
                  style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff8b7ff5) ,
                foregroundColor: Colors.white,
                fixedSize: Size(120, 60)
              ),

              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  _handleNumberInput('5');
                },
                child: const Text('5',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),),
                style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff8b7ff5) ,
                foregroundColor: Colors.white,
                fixedSize: Size(120, 60)
              ),

              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  _handleNumberInput('6');
                },
                child: const Text('6',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),),
                style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff8b7ff5) ,
                foregroundColor: Colors.white,
                fixedSize: Size(120, 60)
              ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  _handleNumberInput('7');
                },
                child: const Text('7',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),),
                style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff8b7ff5) ,
                foregroundColor: Colors.white,
                fixedSize: Size(120, 60)
              ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  _handleNumberInput('8');
                },
                child: const Text('8',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),),
                style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff8b7ff5) ,
                foregroundColor: Colors.white,
                fixedSize: Size(120, 60)
              ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  _handleNumberInput('9');
                },
                child: const Text('9',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),),
                style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff8b7ff5) ,
                foregroundColor: Colors.white,
                fixedSize: Size(120, 60)
              ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             
              
              Padding(
                padding: const EdgeInsets.fromLTRB(130, 0, 0, 0),
                child: ElevatedButton(
                  onPressed: () {
                    _handleNumberInput('0');
                  },
                  child: const Text('0',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),),
                  style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff8b7ff5) ,
                  foregroundColor: Colors.white,
                  fixedSize: Size(120, 60)
                ),
                ),
              ),
              
              const SizedBox(width: 8),
               ElevatedButton(
                onPressed: _handleBackspace,
                child: const Icon(Icons.backspace),
                style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff8b7ff5) ,
                foregroundColor: Colors.white,
                fixedSize: Size(120, 60)
              ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(70.0),
            child: ElevatedButton(
                  onPressed: _currentIndex == 6 ? _handleSubmit : null,
                  child: const Text('입력 완료',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff8b7ff5) ,
                  foregroundColor: Colors.white,
                  fixedSize: Size(120, 60)
                ),
                ),
          ),
        ],
      ),
    );
  }
}