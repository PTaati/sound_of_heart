import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

class ManualPlayPage extends StatefulWidget {
  const ManualPlayPage({Key? key}) : super(key: key);

  @override
  State<ManualPlayPage> createState() => _ManualPlayPageState();
}

class _ManualPlayPageState extends State<ManualPlayPage> {
  final _soundAssetList = [
    'assets/sounds/action/Alex Figueira - Longe.mp3',
    'assets/sounds/action/Alex Figueira - Serious.mp3',
    'assets/sounds/action/heros-time-paulo-kalazzi-main-version-01-51-2639.mp3',
    'assets/sounds/action/Hogan Grip - Stance Gives You Balance.mp3',
    'assets/sounds/action/Scott Holmes Music - Smart Tech.mp3',
    'assets/sounds/action/Sergey Cheremisinov - Chernobyl.mp3',
    'assets/sounds/action/Sergey Cheremisinov - Norilsk.mp3',
  ];

  String? _currentSoundAsset;
  late AssetsAudioPlayer _assetsAudioPlayer;

  @override
  void initState() {
    super.initState();
    _assetsAudioPlayer = AssetsAudioPlayer.newPlayer();
  }

  @override
  void dispose() {
    _assetsAudioPlayer.dispose();
    super.dispose();
  }

  Widget _buildTitle() {
    return Text(
      '1 th room',
      style: TextStyle(fontSize: 50),
    );
  }

  Widget _buildSoundTypeList() {
    return Container();
  }

  Widget _buildCurrentSound() {
    if (_currentSoundAsset != null) {
      return Container(
        child: Center(
          child: Text(
            _currentSoundAsset!,
            style: TextStyle(fontSize: 20),
            overflow: TextOverflow.clip,
          ),
        ),
      );
    }

    return Container();
  }

  Future<void> _openPlayer(String assetPath) async {
    await _assetsAudioPlayer.open(
      Playlist(audios: [Audio(assetPath)], startIndex: 0),
      showNotification: true,
      autoStart: true,
    );
  }

  Widget _buildSoundTile(String assetPath) {
    const size = 200.0;
    final soundName = assetPath.split('/').last;
    final isSelecting = _currentSoundAsset == assetPath;
    return GestureDetector(
      onTap: () async {
        await _assetsAudioPlayer.pause();
        await _openPlayer(assetPath);
        setState(() {
          _currentSoundAsset = assetPath;
        });
      },
      child: Container(
        margin: EdgeInsets.all(10),
        height: size,
        width: size,
        decoration: BoxDecoration(
          color: isSelecting ? Colors.redAccent : Colors.pinkAccent,
          shape: BoxShape.circle,
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Text(
              soundName,
              style: TextStyle(fontSize: 20, color: Colors.white),
              overflow: TextOverflow.clip,
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildSoundWidgets() {
    return _soundAssetList
        .map(
          (assetFile) => _buildSoundTile(assetFile),
        )
        .toList();
  }

  Widget _buildSelectingSoundList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _buildSoundWidgets(),
      ),
    );
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
