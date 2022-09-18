import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

class ManualPlayPage extends StatefulWidget {
  const ManualPlayPage({Key? key}) : super(key: key);

  @override
  State<ManualPlayPage> createState() => _ManualPlayPageState();
}

class _ManualPlayPageState extends State<ManualPlayPage> {
  final _category = [
    'action',
    'adventure',
    'comedy',
    'drama',
    'horror',
    'romantic',
  ];

  final _assetSoundAction = [
    'assets/sounds/action/Alex Figueira - Longe.mp3',
    'assets/sounds/action/Alex Figueira - Serious.mp3',
    'assets/sounds/action/heros-time-paulo-kalazzi-main-version-01-51-2639.mp3',
    'assets/sounds/action/Hogan Grip - Stance Gives You Balance.mp3',
    'assets/sounds/action/Scott Holmes Music - Smart Tech.mp3',
    'assets/sounds/action/Sergey Cheremisinov - Chernobyl.mp3',
    'assets/sounds/action/Sergey Cheremisinov - Norilsk.mp3',
  ];

  final _assetSoundAdventure = [
    'assets/sounds/adventure/achievement-philip-anderson-main-version-01-31-13804.mp3',
    'assets/sounds/adventure/HoliznaCC0 - NPC Theme.mp3',
    'assets/sounds/adventure/Ketsa - Days-of-Life.mp3',
    'assets/sounds/adventure/Ketsa - Never Turn Back.mp3',
    'assets/sounds/adventure/Maarten Schellekens - Jazzy Lounge.mp3',
    'assets/sounds/adventure/Maarten Schellekens - Will they find us_.mp3',
    'assets/sounds/adventure/Milkshake Daddy - Super Sloppy Space Junk.mp3',
    'assets/sounds/adventure/Nul Tiel Records - Discord.mp3',
    'assets/sounds/adventure/Sergey Cheremisinov - Bhopal.mp3',
  ];

  final _assetSoundComedy = [
    'assets/sounds/comedy/aw-cute-cutesy-chamber-ensemble-main-version-02-00-2352.mp3',
    'assets/sounds/comedy/HoliznaPATREON - Dancing Ghosts.mp3',
    'assets/sounds/comedy/monkeys-spinning-monkeys-kevin-macleod-main-version-02-05-8413.mp3',
    'assets/sounds/comedy/Plushgoolash - Big Gay Water Fight.mp3',
  ];

  final _assetSoundDrama = [
    'assets/sounds/drama/call-ended-bpmoore-main-version-03-22-10944.mp3',
    'assets/sounds/drama/Crowander - Peaceful.mp3',
    'assets/sounds/drama/Kosta T - Red in Black.mp3',
    'assets/sounds/drama/Maarten Schellekens - Ode to Pachelbel.mp3',
    'assets/sounds/drama/praise-ill-kitchen-main-version-02-58-6407.mp3',
  ];

  final _assetSoundHorror = [
    'assets/sounds/horror/blank-light-adi-goldstein-main-version-06-26-7796.mp3',
    'assets/sounds/horror/Crowander - Dreaming in a Dream.mp3',
    'assets/sounds/horror/Hogan Grip - Interlude - _Reading The Greens_.mp3',
    'assets/sounds/horror/Maarten Schellekens - A bit of discomfort.mp3',
    'assets/sounds/horror/Maarten Schellekens - Hesitation.mp3',
    'assets/sounds/horror/Sergey Cheremisinov - Garbadge Patch.mp3',
    'assets/sounds/horror/Sergey Cheremisinov - Kamchatka.mp3',
  ];

  final _assetSoundRomantic = [
    'assets/sounds/romantic/Cali Love (Instrumental Version).mp3',
    'assets/sounds/romantic/cruising-altitude-lake-isabel-sonder-house-main-version-02-31-9206.mp3',
    'assets/sounds/romantic/HoliznaCC0 - Lost In Your Eyes.mp3',
    'assets/sounds/romantic/note-rick-gallagher-main-version-15661-03-33.mp3',
    'assets/sounds/romantic/Possimiste - Behind The Seas.mp3',
    'assets/sounds/romantic/requiem-sarah-spring-sonder-house-main-version-02-59-9991.mp3',
  ];

  String _soundCategory = 'action';
  late List<String> _soundAssetList;
  String? _currentSoundAsset;
  late AssetsAudioPlayer _assetsAudioPlayer;

  List<String> _getSoundAssetListFromCategory(String category) {
    switch (category) {
      case 'action':
        return _assetSoundAction;
      case 'adventure':
        return _assetSoundAdventure;
      case 'comedy':
        return _assetSoundComedy;
      case 'drama':
        return _assetSoundDrama;
      case 'horror':
        return _assetSoundHorror;
      case 'romantic':
        return _assetSoundRomantic;
      default:
        return [];
    }
  }

  void _selectCategory(String category) {
    setState(() {
      _soundCategory = category;
      _soundAssetList = _getSoundAssetListFromCategory(category);
    });
  }

  @override
  void initState() {
    super.initState();
    _soundAssetList = _getSoundAssetListFromCategory(_soundCategory);
    _assetsAudioPlayer = AssetsAudioPlayer.newPlayer();
  }

  @override
  Future<void> dispose() async {
    _assetsAudioPlayer.dispose();
    super.dispose();
  }

  Widget _buildCategoryDefaultIcon(double size, {bool isSelecting = false}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.black12,
        shape: BoxShape.circle,
      ),
      child: Image.asset(
        'assets/images/face_icon.png',
        color: isSelecting ? null : Colors.blueGrey,
      ),
    );
  }

  Widget _buildCategoryTile(String category) {
    const size = 180.0;
    final isSelecting = _soundCategory == category;
    return GestureDetector(
      onTap: () async {
        await _assetsAudioPlayer.pause();
        _getSoundAssetListFromCategory(category);
        setState(() {
          if (_soundCategory != category) {
            _currentSoundAsset = null;
          }
          _selectCategory(category);
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SizedBox(
          width: size,
          child: Column(
            children: [
              _buildCategoryDefaultIcon(size, isSelecting: isSelecting),
              Text(
                category,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.clip,
                maxLines: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildCategoryWidgets() {
    return _category
        .map(
          (e) => _buildCategoryTile(e),
        )
        .toList();
  }

  Widget _buildSoundTypeList() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: _buildCategoryWidgets(),
        ),
      ),
    );
  }

  Widget _buildCurrentSound() {
    final soundName = _currentSoundAsset!.split('/').last.split('.').first;
    return Container(
      child: Column(
        children: [
          _buildDefaultIcon(400),
          SizedBox(height: 25),
          Center(
            child: Text(
              _soundCategory,
              style: TextStyle(fontSize: 40),
              overflow: TextOverflow.clip,
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: Text(
              soundName,
              style: TextStyle(fontSize: 20),
              overflow: TextOverflow.clip,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _openPlayer(String assetPath) async {
    await _assetsAudioPlayer.open(
      Playlist(audios: [Audio(assetPath)], startIndex: 0),
      showNotification: true,
      autoStart: true,
    );
  }

  Widget _buildDefaultIcon(double size, {bool isSelecting = false}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.black12,
        shape: BoxShape.circle,
      ),
      child: Image.asset(
        'assets/images/default_sound_icon.png',
        color: isSelecting ? null : Colors.blueGrey,
      ),
    );
  }

  Widget _buildSoundTile(String assetPath) {
    const size = 180.0;
    final soundName = assetPath.split('/').last.split('.').first;
    final isSelecting = _currentSoundAsset == assetPath;
    return GestureDetector(
      onTap: () async {
        await _assetsAudioPlayer.pause();
        setState(() {
          if (isSelecting) {
            _currentSoundAsset = null;
          } else {
            _currentSoundAsset = assetPath;
          }
        });
        if (_currentSoundAsset != null) {
          await _openPlayer(assetPath);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SizedBox(
          width: size,
          child: Column(
            children: [
              _buildDefaultIcon(size, isSelecting: isSelecting),
              Text(
                soundName,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.clip,
                maxLines: 1,
              ),
            ],
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: _buildSoundWidgets(),
        ),
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
            _buildSoundTypeList(),
            if (_currentSoundAsset != null) _buildCurrentSound(),
            _buildSelectingSoundList(),
          ],
        ),
      ),
    );
  }
}
