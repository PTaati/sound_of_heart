import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ManualPlayPage extends StatefulWidget {
  const ManualPlayPage({Key? key}) : super(key: key);

  @override
  State<ManualPlayPage> createState() => _ManualPlayPageState();
}

class _ManualPlayPageState extends State<ManualPlayPage> {
  Widget _buildTitle(){
    return Text('1 th room', style: TextStyle(fontSize: 50),);
  }

  Widget _buildSoundTypeList(){
    return Container();
  }
  
  Widget _buildCurrentSound(){
    return Container();
  }

  Widget _buildSelectingSoundList(){
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitle(),
            _buildSoundTypeList(),
            _buildCurrentSound(),
            _buildSelectingSoundList(),
          ],
        ),
      ),
    );
  }
}
