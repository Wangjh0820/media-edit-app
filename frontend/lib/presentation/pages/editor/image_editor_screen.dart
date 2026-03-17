import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ImageEditorScreen extends StatefulWidget {
  final String? imagePath;

  const ImageEditorScreen({super.key, this.imagePath});

  @override
  State<ImageEditorScreen> createState() => _ImageEditorScreenState();
}

class _ImageEditorScreenState extends State<ImageEditorScreen> {
  double _brightness = 0;
  double _contrast = 0;
  double _saturation = 0;
  double _hue = 0;
  int _selectedTool = 0;

  final List<_ToolItem> _tools = [
    _ToolItem(icon: Icons.tune, label: '调整'),
    _ToolItem(icon: Icons.palette_outlined, label: '滤镜'),
    _ToolItem(icon: Icons.crop, label: '裁剪'),
    _ToolItem(icon: Icons.text_fields, label: '文字'),
    _ToolItem(icon: Icons.face_retouching_natural, label: '美颜'),
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
            onPressed: _saveImage,
            child: const Text(
              '保存',
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
                  aspectRatio: 3 / 4,
                  child: Container(
                    color: Colors.grey.shade800,
                    child: widget.imagePath != null
                        ? Image.network(
                            widget.imagePath!,
                            fit: BoxFit.contain,
                          )
                        : const Center(
                            child: Icon(Icons.image, size: 64, color: Colors.white54),
                          ),
                  ),
                ),
              ),
            ),
          ),
          _buildToolSelector(),
          _buildToolPanel(),
        ],
      ),
    );
  }

  Widget _buildToolSelector() {
    return Container(
      height: 80,
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
              width: 70,
              margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
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
                    size: 24,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    tool.label,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.white54,
                      fontSize: 11,
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
      height: 150,
      color: Colors.black87,
      child: IndexedStack(
        index: _selectedTool,
        children: [
          _buildAdjustPanel(),
          _buildFilterPanel(),
          _buildCropPanel(),
          _buildTextPanel(),
          _buildBeautyPanel(),
          _buildAIPanel(),
        ],
      ),
    );
  }

  Widget _buildAdjustPanel() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildSlider('亮度', _brightness, (value) {
            setState(() => _brightness = value);
          }),
          const SizedBox(height: 12),
          _buildSlider('对比度', _contrast, (value) {
            setState(() => _contrast = value);
          }),
          const SizedBox(height: 12),
          _buildSlider('饱和度', _saturation, (value) {
            setState(() => _saturation = value);
          }),
        ],
      ),
    );
  }

  Widget _buildSlider(String label, double value, Function(double) onChanged) {
    return Row(
      children: [
        SizedBox(
          width: 50,
          child: Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
        Expanded(
          child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 3,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
            ),
            child: Slider(
              value: value,
              min: -100,
              max: 100,
              onChanged: onChanged,
              activeColor: Colors.white,
              inactiveColor: Colors.white24,
            ),
          ),
        ),
        SizedBox(
          width: 40,
          child: Text(
            value.round().toString(),
            style: const TextStyle(color: Colors.white, fontSize: 12),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  Widget _buildFilterPanel() {
    final filters = [
      '原图', '鲜艳', '暖色', '冷色', '复古', '黑白', '怀旧', '戏剧'
    ];
    
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: filters.length,
        itemBuilder: (context, index) {
          return Container(
            width: 70,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey.shade700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  filters[index],
                  style: const TextStyle(color: Colors.white, fontSize: 11),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCropPanel() {
    final ratios = ['自由', '1:1', '4:3', '16:9', '9:16', '3:4'];
    
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: ratios.map((ratio) {
          return GestureDetector(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                ratio,
                style: const TextStyle(color: Colors.white, fontSize: 13),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTextPanel() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildTextButton('添加文字'),
          _buildTextButton('添加贴纸'),
          _buildTextButton('添加水印'),
        ],
      ),
    );
  }

  Widget _buildTextButton(String label) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 13),
        ),
      ),
    );
  }

  Widget _buildBeautyPanel() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildSlider('磨皮', 0, (value) {}),
          const SizedBox(height: 12),
          _buildSlider('美白', 0, (value) {}),
          const SizedBox(height: 12),
          _buildSlider('瘦脸', 0, (value) {}),
        ],
      ),
    );
  }

  Widget _buildAIPanel() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildAIButton('一键美颜', Icons.face_retouching_natural),
          _buildAIButton('智能抠图', Icons.content_cut),
          _buildAIButton('风格迁移', Icons.palette),
          _buildAIButton('智能修复', Icons.healing),
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
            child: Icon(icon, color: Colors.white, size: 24),
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

  void _saveImage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('图片已保存')),
    );
    Navigator.pop(context);
  }
}

class _ToolItem {
  final IconData icon;
  final String label;

  _ToolItem({required this.icon, required this.label});
}
