import 'package:flutter/material.dart';

class VideoEditorScreen extends StatefulWidget {
  final String? videoPath;

  const VideoEditorScreen({super.key, this.videoPath});

  @override
  State<VideoEditorScreen> createState() => _VideoEditorScreenState();
}

class _VideoEditorScreenState extends State<VideoEditorScreen> {
  int _selectedTool = 0;
  double _playbackSpeed = 1.0;
  
  final List<_ToolItem> _tools = [
    _ToolItem(icon: Icons.content_cut, label: '裁剪'),
    _ToolItem(icon: Icons.music_note, label: '音乐'),
    _ToolItem(icon: Icons.text_fields, label: '文字'),
    _ToolItem(icon: Icons.swap_horiz, label: '转场'),
    _ToolItem(icon: Icons.speed, label: '变速'),
    _ToolItem(icon: Icons.auto_awesome, label: 'AI'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: _exportVideo,
            child: const Text(
              '导出',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 400),
                child: AspectRatio(
                  aspectRatio: 9 / 16,
                  child: Container(
                    color: Colors.grey.shade800,
                    child: const Center(
                      child: Icon(Icons.play_circle_outline, size: 64, color: Colors.white54),
                    ),
                  ),
                ),
              ),
            ),
          ),
          _buildTimeline(),
          _buildToolSelector(),
          _buildToolPanel(),
        ],
      ),
    );
  }

  Widget _buildTimeline() {
    return Container(
      height: 80,
      color: Colors.black87,
      child: Column(
        children: [
          Container(
            height: 24,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const Icon(Icons.play_arrow, color: Colors.white, size: 16),
                const SizedBox(width: 8),
                const Text('00:00', style: TextStyle(color: Colors.white, fontSize: 12)),
                const Spacer(),
                const Text('00:30', style: TextStyle(color: Colors.white, fontSize: 12)),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: 10,
              itemBuilder: (context, index) {
                return Container(
                  width: 60,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade700,
                    borderRadius: BorderRadius.circular(4),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToolSelector() {
    return Container(
      height: 70,
      color: Colors.black87,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _tools.length,
        itemBuilder: (context, index) {
          final tool = _tools[index];
          final isSelected = _selectedTool == index;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedTool = index;
              });
            },
            child: Container(
              width: 60,
              margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? Colors.white.withOpacity(0.2) : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    tool.icon,
                    color: isSelected ? Colors.white : Colors.white54,
                    size: 22,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    tool.label,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.white54,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildToolPanel() {
    return Container(
      height: 120,
      color: Colors.black87,
      child: IndexedStack(
        index: _selectedTool,
        children: [
          _buildTrimPanel(),
          _buildMusicPanel(),
          _buildTextPanel(),
          _buildTransitionPanel(),
          _buildSpeedPanel(),
          _buildAIPanel(),
        ],
      ),
    );
  }

  Widget _buildTrimPanel() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildToolButton('分割', Icons.content_cut),
          _buildToolButton('删除', Icons.delete_outline),
          _buildToolButton('复制', Icons.content_copy),
          _buildToolButton('反转', Icons.swap_horiz),
        ],
      ),
    );
  }

  Widget _buildMusicPanel() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildToolButton('本地音乐', Icons.library_music),
          _buildToolButton('在线音乐', Icons.cloud),
          _buildToolButton('录音', Icons.mic),
          _buildToolButton('音效', Icons.music_note),
        ],
      ),
    );
  }

  Widget _buildTextPanel() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildToolButton('添加文字', Icons.text_fields),
          _buildToolButton('字幕', Icons.subtitles),
          _buildToolButton('贴纸', Icons.emoji_emotions_outlined),
          _buildToolButton('水印', Icons.branding_watermark),
        ],
      ),
    );
  }

  Widget _buildTransitionPanel() {
    final transitions = ['淡入淡出', '滑动', '缩放', '旋转', '翻转'];
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: transitions.length,
        itemBuilder: (context, index) {
          return Container(
            width: 80,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey.shade700,
                  ),
                  child: const Icon(Icons.swap_horiz, color: Colors.white54),
                ),
                const SizedBox(height: 6),
                Text(
                  transitions[index],
                  style: const TextStyle(color: Colors.white, fontSize: 11),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSpeedPanel() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              const Text('播放速度', style: TextStyle(color: Colors.white, fontSize: 12)),
              const Spacer(),
              Text('${_playbackSpeed}x', style: const TextStyle(color: Colors.white, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 12),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 3,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
            ),
            child: Slider(
              value: _playbackSpeed,
              min: 0.25,
              max: 4.0,
              divisions: 15,
              onChanged: (value) {
                setState(() {
                  _playbackSpeed = value;
                });
              },
              activeColor: Colors.white,
              inactiveColor: Colors.white24,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildSpeedButton('0.25x', 0.25),
              _buildSpeedButton('0.5x', 0.5),
              _buildSpeedButton('1x', 1.0),
              _buildSpeedButton('2x', 2.0),
              _buildSpeedButton('4x', 4.0),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSpeedButton(String label, double speed) {
    final isSelected = _playbackSpeed == speed;
    return GestureDetector(
      onTap: () {
        setState(() {
          _playbackSpeed = speed;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white.withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.white54,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildAIPanel() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildAIButton('智能字幕', Icons.subtitles),
          _buildAIButton('智能抠像', Icons.content_cut),
          _buildAIButton('一键成片', Icons.auto_awesome),
          _buildAIButton('画质增强', Icons.hd),
        ],
      ),
    );
  }

  Widget _buildToolButton(String label, IconData icon) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.white, size: 22),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 11),
          ),
        ],
      ),
    );
  }

  Widget _buildAIButton(String label, IconData icon) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF6366F1).withOpacity(0.3),
                  const Color(0xFFEC4899).withOpacity(0.3),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.white, size: 22),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 11),
          ),
        ],
      ),
    );
  }

  void _exportVideo() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              '导出视频',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildExportOption('720P', '高清', false),
            _buildExportOption('1080P', '全高清', true),
            _buildExportOption('4K', '超高清', false),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('视频正在导出中...')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6366F1),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('开始导出'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExportOption(String quality, String label, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF6366F1).withOpacity(0.1) : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? const Color(0xFF6366F1) : Colors.transparent,
        ),
      ),
      child: Row(
        children: [
          Icon(
            isSelected ? Icons.check_circle : Icons.circle_outlined,
            color: isSelected ? const Color(0xFF6366F1) : Colors.grey,
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                quality,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                label,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ToolItem {
  final IconData icon;
  final String label;

  _ToolItem({required this.icon, required this.label});
}
