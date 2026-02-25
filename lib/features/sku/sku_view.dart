import 'package:flutter/material.dart';

import '../../layout/responsive_wrapper.dart';
import '../../ui/custom_colors.dart';
import 'sku_constants.dart';

// ============================================================================
// ЭКРАН СПИСКА SKU (номенклатура)
// ============================================================================

class SkusView extends StatefulWidget {
  const SkusView({super.key});

  @override
  State<SkusView> createState() => _SkusViewState();
}

class _SkusViewState extends State<SkusView> {
  final List<Map<String, dynamic>> _skus = [
    {
      'id': 'sku_1',
      'name': 'Chanel N°5 EDP 50 ml',
      'brand': 'Chanel',
      'category': 'Парфюмерия > Женская > EDP',
      'vendorSku': 'CH-N5-50',
      'internalSku': 'SKU-001',
      'barcodes': [
        {'code': '3337871234567', 'type': 'EAN-13', 'description': 'Основной'},
      ],
      'length': '8',
      'width': '4',
      'height': '12',
      'weightNet': '0.35',
      'weightGross': '0.42',
      'qtyPerBox': '12',
      'boxesPerPallet': '48',
      'packageType': 'Флакон',
      'storageZone': 'Сейфовая (ценное)',
      'handling': 'Стандарт',
      'pickingStrategy': 'FEFO',
      'abcClass': 'A',
      'accountingType': 'Партионный',
      'shelfLifeMonths': '36',
      'receptionLimitPct': '10',
      'lifeStatus': 'Активен',
      'minStock': '20',
      'currency': 'USD',
      'vatRate': '12',
      'concentration': 'EDP',
      'gender': 'Female',
      'collection': 'N°5',
    },
    {
      'id': 'sku_2',
      'name': 'Dior Sauvage EDT 100 ml',
      'brand': 'Dior',
      'category': 'Парфюмерия > Мужская > EDP',
      'vendorSku': 'DIOR-SAV-100',
      'internalSku': 'SKU-002',
      'barcodes': [
        {'code': '3337872345678', 'type': 'EAN-13', 'description': 'Основной'},
        {'code': '3337872345679', 'type': 'EAN-13', 'description': 'Тестер'},
      ],
      'length': '9',
      'width': '5',
      'height': '14',
      'weightNet': '0.28',
      'weightGross': '0.35',
      'qtyPerBox': '6',
      'boxesPerPallet': '36',
      'packageType': 'Флакон',
      'storageZone': 'Основная',
      'handling': 'Стандарт',
      'pickingStrategy': 'FIFO',
      'abcClass': 'A',
      'accountingType': 'Партионный',
      'shelfLifeMonths': '36',
      'receptionLimitPct': '15',
      'lifeStatus': 'Активен',
      'minStock': '30',
      'currency': 'EUR',
      'vatRate': '20',
      'concentration': 'EDT',
      'gender': 'Male',
      'collection': 'Sauvage',
    },
    {
      'id': 'sku_3',
      'name': 'L\'Oréal Revitalift крем 50 ml',
      'brand': 'L\'Oréal',
      'category': 'Косметика > Уход > Крем',
      'vendorSku': 'LO-REV-50',
      'internalSku': 'SKU-003',
      'barcodes': [
        {'code': '3600530123456', 'type': 'EAN-13', 'description': 'Основной'},
      ],
      'length': '5',
      'width': '5',
      'height': '8',
      'weightNet': '0.06',
      'weightGross': '0.08',
      'qtyPerBox': '24',
      'boxesPerPallet': '72',
      'packageType': 'Флакон',
      'storageZone': 'Основная',
      'handling': 'Стандарт',
      'pickingStrategy': 'FEFO',
      'abcClass': 'B',
      'accountingType': 'Партионный',
      'shelfLifeMonths': '24',
      'receptionLimitPct': '20',
      'lifeStatus': 'Активен',
      'minStock': '50',
      'currency': 'KZT',
      'vatRate': '12',
      'concentration': 'EDP',
      'gender': 'Female',
      'collection': 'Revitalift',
    },
    {
      'id': 'sku_4',
      'name': 'Chanel Coco Mademoiselle тестер 1.5 ml',
      'brand': 'Chanel',
      'category': 'Парфюмерия > Женская > EDT',
      'vendorSku': 'CH-COCO-T15',
      'internalSku': 'SKU-004',
      'barcodes': [],
      'length': '4',
      'width': '2',
      'height': '6',
      'weightNet': '0.02',
      'weightGross': '0.03',
      'qtyPerBox': '100',
      'boxesPerPallet': '200',
      'packageType': 'Тестер',
      'storageZone': 'Основная',
      'handling': 'Хрупкое',
      'pickingStrategy': 'FIFO',
      'abcClass': 'B',
      'accountingType': 'Серийный номер',
      'shelfLifeMonths': '24',
      'receptionLimitPct': '5',
      'lifeStatus': 'Новинка',
      'minStock': '200',
      'currency': 'USD',
      'vatRate': '12',
      'concentration': 'EDT',
      'gender': 'Female',
      'collection': 'Coco Mademoiselle',
    },
    {
      'id': 'sku_5',
      'name': 'Унисекс EDC 30 ml собственный бренд',
      'brand': 'Собственный бренд',
      'category': 'Парфюмерия > Унисекс > EDC',
      'vendorSku': 'SB-EDC-30',
      'internalSku': 'SKU-005',
      'barcodes': [
        {'code': '4627123456789', 'type': 'EAN-13', 'description': 'Основной'},
      ],
      'length': '6',
      'width': '3',
      'height': '10',
      'weightNet': '0.12',
      'weightGross': '0.15',
      'qtyPerBox': '18',
      'boxesPerPallet': '60',
      'packageType': 'Флакон',
      'storageZone': 'Основная',
      'handling': 'Стандарт',
      'pickingStrategy': 'По зоне',
      'abcClass': 'C',
      'accountingType': 'Партионный',
      'shelfLifeMonths': '18',
      'receptionLimitPct': '25',
      'lifeStatus': 'Активен',
      'minStock': '15',
      'currency': 'KZT',
      'vatRate': '12',
      'concentration': 'EDC',
      'gender': 'Unisex',
      'collection': 'Линейка EDC',
    },
  ];

  void _openSkuForm([Map<String, dynamic>? skuToEdit]) {
    showDialog<void>(
      context: context,
      builder: (context) => SkuFormDialog(
        skuToEdit: skuToEdit,
        onSave: (sku) {
          setState(() {
            if (skuToEdit != null) {
              final i = _skus.indexOf(skuToEdit);
              if (i >= 0) _skus[i] = sku;
            } else {
              _skus.add(sku);
            }
          });
        },
      ),
    );
  }

  static const List<({String key, String title, double width})> _skuColumns = [
    (key: 'name', title: 'НАЗВАНИЕ', width: 260),
    (key: 'brand', title: 'БРЕНД', width: 110),
    (key: 'vendorSku', title: 'КОД ВЕНДОРА', width: 120),
    (key: 'internalSku', title: 'ВНУТР. SKU', width: 100),
    (key: 'category', title: 'КАТЕГОРИЯ', width: 200),
    (key: 'lifeStatus', title: 'СТАТУС', width: 100),
  ];

  Widget _buildSkuTable(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final totalWidth = _skuColumns.fold<double>(
          0.0,
          (sum, c) => sum + c.width,
        ) + 56;
        final tableWidth = totalWidth > constraints.maxWidth
            ? totalWidth
            : constraints.maxWidth;
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: constraints.maxWidth),
            child: SizedBox(
              width: tableWidth,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: context.card,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    child: Row(
                      children: [
                        ..._skuColumns.map(
                          (c) => SizedBox(
                            width: c.width,
                            child: Text(
                              c.title,
                              style: TextStyle(
                                color: context.textMuted,
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        const SizedBox(width: 32),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: context.surface,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                        ),
                      ),
                      child: ListView.separated(
                        itemCount: _skus.length,
                        separatorBuilder: (_, _) => Divider(
                          color: context.border,
                          height: 1,
                        ),
                        itemBuilder: (context, index) {
                          final sku = _skus[index];
                          return InkWell(
                            onTap: () => _openSkuForm(sku),
                            hoverColor: context.hover,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 8,
                              ),
                              child: Row(
                                children: [
                                  ..._skuColumns.map(
                                    (c) => SizedBox(
                                      width: c.width,
                                      child: _skuCell(c.key, sku),
                                    ),
                                  ),
                                  const Spacer(),
                                  PopupMenuButton<String>(
                                    icon: Icon(
                                      Icons.more_vert,
                                      color: context.textMuted,
                                      size: 20,
                                    ),
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(
                                      minWidth: 32,
                                      minHeight: 32,
                                    ),
                                    color: context.hover,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    onSelected: (_) => _openSkuForm(sku),
                                    itemBuilder: (context) => [
                                      PopupMenuItem(
                                        value: 'edit',
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.edit,
                                              color: context.textMain,
                                              size: 20,
                                            ),
                                            const SizedBox(width: 12),
                                            Text(
                                              'Редактировать',
                                              style: TextStyle(
                                                color: context.textMain,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _skuCell(String key, Map<String, dynamic> sku) {
    final value = sku[key]?.toString() ?? '—';
    final isName = key == 'name';
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        value,
        style: TextStyle(
          color: context.textMain,
          fontSize: isName ? 14 : 13,
          fontWeight: isName ? FontWeight.w600 : FontWeight.normal,
        ),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      color: context.bg,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: context.primary.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.inventory_2_outlined,
                      color: context.primary,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    'Товары (SKU)',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: context.textMain,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 44,
                child: ElevatedButton.icon(
                  onPressed: () => _openSkuForm(),
                  icon: const Icon(Icons.add),
                  label: const Text('Добавить SKU'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: _skus.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.inventory_2_outlined,
                          size: 64,
                          color: context.textMuted,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Нет добавленных SKU',
                          style: TextStyle(
                            color: context.textMuted,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextButton.icon(
                          onPressed: () => _openSkuForm(),
                          icon: const Icon(Icons.add),
                          label: const Text('Добавить первый SKU'),
                        ),
                      ],
                    ),
                  )
                : _buildSkuTable(context),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// ФОРМА SKU (6 СЕКЦИЙ)
// ============================================================================

class SkuFormDialog extends StatefulWidget {
  final Map<String, dynamic>? skuToEdit;
  final void Function(Map<String, dynamic> sku) onSave;

  const SkuFormDialog({
    super.key,
    this.skuToEdit,
    required this.onSave,
  });

  @override
  State<SkuFormDialog> createState() => _SkuFormDialogState();
}

class _SkuFormDialogState extends State<SkuFormDialog> {
  static String _str(dynamic v) => v?.toString() ?? '';

  late TextEditingController _nameCtrl;
  late TextEditingController _vendorSkuCtrl;
  late TextEditingController _internalSkuCtrl;
  late TextEditingController _lengthCtrl;
  late TextEditingController _widthCtrl;
  late TextEditingController _heightCtrl;
  late TextEditingController _weightNetCtrl;
  late TextEditingController _weightGrossCtrl;
  late TextEditingController _qtyPerBoxCtrl;
  late TextEditingController _boxesPerPalletCtrl;
  late TextEditingController _shelfLifeMonthsCtrl;
  late TextEditingController _receptionLimitPctCtrl;
  late TextEditingController _minStockCtrl;
  late TextEditingController _collectionCtrl;
  late TextEditingController _vatRateCtrl;
  late TextEditingController _brandCtrl;

  late String _categoryLevel1;
  late String _categoryLevel2;
  late String _categoryLevel3;
  late String _packageType;
  late String _storageZone;
  late String _handling;
  late String _pickingStrategy;
  late String _abcClass;
  late String _accountingType;
  late String _lifeStatus;
  late String _concentration;
  late String _gender;
  late String _currency;
  late List<Map<String, String>> _barcodes;

  @override
  void initState() {
    super.initState();
    final s = widget.skuToEdit;
    _nameCtrl = TextEditingController(text: _str(s?['name']));
    _vendorSkuCtrl = TextEditingController(text: _str(s?['vendorSku']));
    _internalSkuCtrl = TextEditingController(text: _str(s?['internalSku']));
    _brandCtrl = TextEditingController(text: _str(s?['brand']));
    _lengthCtrl = TextEditingController(text: _str(s?['length']));
    _widthCtrl = TextEditingController(text: _str(s?['width']));
    _heightCtrl = TextEditingController(text: _str(s?['height']));
    _weightNetCtrl = TextEditingController(text: _str(s?['weightNet']));
    _weightGrossCtrl = TextEditingController(text: _str(s?['weightGross']));
    _qtyPerBoxCtrl = TextEditingController(text: _str(s?['qtyPerBox']));
    _boxesPerPalletCtrl = TextEditingController(text: _str(s?['boxesPerPallet']));
    _shelfLifeMonthsCtrl = TextEditingController(text: _str(s?['shelfLifeMonths']));
    _receptionLimitPctCtrl = TextEditingController(text: _str(s?['receptionLimitPct']));
    _minStockCtrl = TextEditingController(text: _str(s?['minStock']));
    _collectionCtrl = TextEditingController(text: _str(s?['collection']));
    _vatRateCtrl = TextEditingController(text: _str(s?['vatRate']));

    _initCategoryLevels(s?['category']?.toString() ?? '');
    _packageType = skuPackageTypes.contains(s?['packageType']) ? s!['packageType'] as String : skuPackageTypes.first;
    _storageZone = skuStorageZones.contains(s?['storageZone']) ? s!['storageZone'] as String : skuStorageZones.first;
    _handling = skuHandlingConditions.contains(s?['handling']) ? s!['handling'] as String : skuHandlingConditions.first;
    _pickingStrategy = skuPickingStrategy.contains(s?['pickingStrategy']) ? s!['pickingStrategy'] as String : skuPickingStrategy.first;
    _abcClass = skuAbcClass.contains(s?['abcClass']) ? s!['abcClass'] as String : skuAbcClass.first;
    _accountingType = skuAccountingType.contains(s?['accountingType']) ? s!['accountingType'] as String : skuAccountingType.first;
    _lifeStatus = skuLifeStatus.contains(s?['lifeStatus']) ? s!['lifeStatus'] as String : skuLifeStatus.first;
    _concentration = skuConcentration.contains(s?['concentration']) ? s!['concentration'] as String : skuConcentration.first;
    _gender = skuGender.contains(s?['gender']) ? s!['gender'] as String : skuGender.first;
    _currency = skuCurrencies.contains(s?['currency']) ? s!['currency'] as String : skuCurrencies.first;
    _barcodes = _barcodeList(s?['barcodes']);
  }

  void _initCategoryLevels(String categoryStr) {
    final parts = categoryStr.split(' > ').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
    _categoryLevel1 = (parts.isNotEmpty && skuCategoryLevel1.contains(parts[0])) ? parts[0] : skuCategoryLevel1.first;
    final l2Options = skuCategoryLevel2[_categoryLevel1] ?? [];
    _categoryLevel2 = (parts.length > 1 && l2Options.contains(parts[1])) ? parts[1] : (l2Options.isNotEmpty ? l2Options.first : '');
    final l3Options = skuCategoryLevel3[_categoryLevel2] ?? [];
    _categoryLevel3 = (parts.length > 2 && l3Options.contains(parts[2])) ? parts[2] : (l3Options.isNotEmpty ? l3Options.first : '');
  }

  static List<Map<String, String>> _barcodeList(dynamic v) {
    if (v is! List || v.isEmpty) return [];
    final list = <Map<String, String>>[];
    for (final e in v) {
      if (e is Map && e['code'] != null) {
        list.add({
          'code': e['code'].toString(),
          'type': e['type']?.toString() ?? skuBarcodeTypes.first,
          'description': e['description']?.toString() ?? skuBarcodeDescriptions.first,
        });
      } else if (e is String) {
        list.add({'code': e, 'type': skuBarcodeTypes.first, 'description': skuBarcodeDescriptions.first});
      }
    }
    return list;
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _vendorSkuCtrl.dispose();
    _internalSkuCtrl.dispose();
    _brandCtrl.dispose();
    _lengthCtrl.dispose();
    _widthCtrl.dispose();
    _heightCtrl.dispose();
    _weightNetCtrl.dispose();
    _weightGrossCtrl.dispose();
    _qtyPerBoxCtrl.dispose();
    _boxesPerPalletCtrl.dispose();
    _shelfLifeMonthsCtrl.dispose();
    _receptionLimitPctCtrl.dispose();
    _minStockCtrl.dispose();
    _collectionCtrl.dispose();
    _vatRateCtrl.dispose();
    super.dispose();
  }

  Map<String, dynamic> _collectData() {
    return {
      'id': widget.skuToEdit?['id'] ?? DateTime.now().millisecondsSinceEpoch.toString(),
      'name': _nameCtrl.text.trim(),
      'brand': _brandCtrl.text.trim(),
      'category': '$_categoryLevel1 > $_categoryLevel2 > $_categoryLevel3',
      'vendorSku': _vendorSkuCtrl.text.trim(),
      'internalSku': _internalSkuCtrl.text.trim(),
      'barcodes': _barcodes.map((e) => {
        'code': e['code']!,
        'type': e['type'] ?? skuBarcodeTypes.first,
        'description': e['description'] ?? skuBarcodeDescriptions.first,
      }).toList(),
      'length': _lengthCtrl.text.trim(),
      'width': _widthCtrl.text.trim(),
      'height': _heightCtrl.text.trim(),
      'weightNet': _weightNetCtrl.text.trim(),
      'weightGross': _weightGrossCtrl.text.trim(),
      'qtyPerBox': _qtyPerBoxCtrl.text.trim(),
      'boxesPerPallet': _boxesPerPalletCtrl.text.trim(),
      'packageType': _packageType,
      'storageZone': _storageZone,
      'handling': _handling,
      'pickingStrategy': _pickingStrategy,
      'abcClass': _abcClass,
      'accountingType': _accountingType,
      'shelfLifeMonths': _shelfLifeMonthsCtrl.text.trim(),
      'receptionLimitPct': _receptionLimitPctCtrl.text.trim(),
      'lifeStatus': _lifeStatus,
      'minStock': _minStockCtrl.text.trim(),
      'currency': _currency,
      'vatRate': _vatRateCtrl.text.trim(),
      'concentration': _concentration,
      'gender': _gender,
      'collection': _collectionCtrl.text.trim(),
    };
  }

  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        text,
        style: TextStyle(
          color: context.primary,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _dropdown(String value, List<String> items, ValueChanged<String> onChanged) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: context.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.border),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: items.contains(value) ? value : items.first,
          isExpanded: true,
          dropdownColor: context.card,
          borderRadius: BorderRadius.circular(12),
          style: TextStyle(color: context.textMain, fontSize: 14),
          icon: Icon(Icons.keyboard_arrow_down, color: context.textMuted),
          items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: (v) => v != null ? onChanged(v) : null,
        ),
      ),
    );
  }

  Widget _field(String label, TextEditingController ctrl, {String hint = ''}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(color: context.textMuted, fontSize: 12)),
          const SizedBox(height: 6),
          TextField(
            controller: ctrl,
            style: TextStyle(color: context.textMain),
            decoration: InputDecoration(
              hintText: hint,
              filled: true,
              fillColor: context.card,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: context.bg,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      clipBehavior: Clip.antiAlias,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 950,
          maxHeight: MediaQuery.of(context).size.height * 0.9,
        ),
        child: DialogScrollWrapper(
          minWidth: 850,
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.skuToEdit == null ? 'Новый SKU' : 'Редактировать SKU',
                      style: TextStyle(
                        color: context.textMain,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close, color: context.textMuted),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Flexible(
                  child: DefaultTabController(
                    length: 6,
                    child: Column(
                      children: [
                        TabBar(
                          isScrollable: true,
                          tabAlignment: TabAlignment.start,
                          dividerColor: context.border,
                          indicatorColor: context.primary,
                          labelColor: context.primary,
                          unselectedLabelColor: context.textMuted,
                          tabs: const [
                            Tab(text: 'Мастер-данные'),
                            Tab(text: 'Логистика'),
                            Tab(text: 'WMS'),
                            Tab(text: 'Качество'),
                            Tab(text: 'Коммерция'),
                            Tab(text: 'Атрибуты'),
                          ],
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              _buildMasterDataTab(),
                              _buildLogisticsTab(),
                              _buildWmsTab(),
                              _buildComplianceTab(),
                              _buildFinanceTab(),
                              _buildAttributesTab(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Отмена', style: TextStyle(color: context.textMuted)),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () {
                        widget.onSave(_collectData());
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: context.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(widget.skuToEdit == null ? 'Создать' : 'Сохранить'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabScroll(Widget child) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          height: constraints.maxHeight,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: child,
          ),
        );
      },
    );
  }

  Widget _buildMasterDataTab() {
    return _buildTabScroll(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('БАЗОВАЯ ИДЕНТИФИКАЦИЯ (MASTER DATA)'),
          _field('Наименование (маска: [Бренд] [Линейка] [Тип] [Объем])', _nameCtrl, hint: 'Например: Chanel Chance EDP 50 ml'),
          Row(
            children: [
              Expanded(
                child: _field('Бренд', _brandCtrl, hint: 'Например: Chanel'),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Категория: уровень 1', style: TextStyle(color: context.textMuted, fontSize: 12)),
                    const SizedBox(height: 6),
                    _dropdown(_categoryLevel1, skuCategoryLevel1, (v) {
                      setState(() {
                        _categoryLevel1 = v;
                        final l2 = skuCategoryLevel2[v] ?? [];
                        _categoryLevel2 = l2.isNotEmpty ? l2.first : '';
                        final l3 = skuCategoryLevel3[_categoryLevel2] ?? [];
                        _categoryLevel3 = l3.isNotEmpty ? l3.first : '';
                      });
                    }),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Уровень 2', style: TextStyle(color: context.textMuted, fontSize: 12)),
                    const SizedBox(height: 6),
                    _dropdown(_categoryLevel2, skuCategoryLevel2[_categoryLevel1] ?? [], (v) {
                      setState(() {
                        _categoryLevel2 = v;
                        final l3 = skuCategoryLevel3[v] ?? [];
                        _categoryLevel3 = l3.isNotEmpty ? l3.first : '';
                      });
                    }),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Уровень 3', style: TextStyle(color: context.textMuted, fontSize: 12)),
                    const SizedBox(height: 6),
                    _dropdown(_categoryLevel3, skuCategoryLevel3[_categoryLevel2] ?? [], (v) => setState(() => _categoryLevel3 = v)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _field('Артикул (Vendor SKU)', _vendorSkuCtrl, hint: 'Код производителя'),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _field('Внутренний SKU компании', _internalSkuCtrl, hint: 'Учётный код компании'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text('Штрих-коды (тип, назначение, код)', style: TextStyle(color: context.textMuted, fontSize: 12)),
          const SizedBox(height: 6),
          ..._barcodes.asMap().entries.map((e) {
            final code = e.value['code'] ?? '';
            final type = e.value['type'] ?? skuBarcodeTypes.first;
            final desc = e.value['description'] ?? skuBarcodeDescriptions.first;
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  SizedBox(
                    width: 90,
                    child: Container(
                      height: 44,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: context.card,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.centerLeft,
                      child: Text(type, style: TextStyle(color: context.textMuted, fontSize: 12), overflow: TextOverflow.ellipsis),
                    ),
                  ),
                  const SizedBox(width: 6),
                  SizedBox(
                    width: 140,
                    child: Container(
                      height: 44,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: context.card,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.centerLeft,
                      child: Text(desc, style: TextStyle(color: context.textMuted, fontSize: 12), overflow: TextOverflow.ellipsis),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Container(
                      height: 44,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: context.card,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.centerLeft,
                      child: Text(code, style: TextStyle(color: context.textMain)),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: Icon(Icons.close, color: Colors.redAccent, size: 20),
                    onPressed: () => setState(() => _barcodes.removeAt(e.key)),
                  ),
                ],
              ),
            );
          }),
          TextButton.icon(
            onPressed: () {
              final codeCtrl = TextEditingController();
              var selectedType = skuBarcodeTypes.first;
              var selectedDesc = skuBarcodeDescriptions.first;
              showDialog<void>(
                context: context,
                builder: (ctx) => StatefulBuilder(
                  builder: (ctx, setDialogState) => AlertDialog(
                    backgroundColor: context.bg,
                    title: Text('Добавить штрих-код', style: TextStyle(color: context.textMain)),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Тип кода', style: TextStyle(color: context.textMuted, fontSize: 12)),
                                  const SizedBox(height: 6),
                                  Container(
                                    height: 44,
                                    padding: const EdgeInsets.symmetric(horizontal: 12),
                                    decoration: BoxDecoration(
                                      color: context.card,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(color: context.border),
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        value: selectedType,
                                        isExpanded: true,
                                        dropdownColor: context.card,
                                        style: TextStyle(color: context.textMain, fontSize: 14),
                                        items: skuBarcodeTypes.map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
                                        onChanged: (v) => v != null ? setDialogState(() => selectedType = v) : null,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Назначение (описание)', style: TextStyle(color: context.textMuted, fontSize: 12)),
                                  const SizedBox(height: 6),
                                  Container(
                                    height: 44,
                                    padding: const EdgeInsets.symmetric(horizontal: 12),
                                    decoration: BoxDecoration(
                                      color: context.card,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(color: context.border),
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        value: selectedDesc,
                                        isExpanded: true,
                                        dropdownColor: context.card,
                                        style: TextStyle(color: context.textMain, fontSize: 14),
                                        items: skuBarcodeDescriptions.map((d) => DropdownMenuItem(value: d, child: Text(d))).toList(),
                                        onChanged: (v) => v != null ? setDialogState(() => selectedDesc = v) : null,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text('Код', style: TextStyle(color: context.textMuted, fontSize: 12)),
                        const SizedBox(height: 6),
                        TextField(
                          controller: codeCtrl,
                          autofocus: true,
                          style: TextStyle(color: context.textMain),
                          decoration: InputDecoration(
                            hintText: 'EAN-13, UPC или другой код',
                            filled: true,
                            fillColor: context.card,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                          ),
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(ctx), child: Text('Отмена', style: TextStyle(color: context.textMuted))),
                      ElevatedButton(
                        onPressed: () {
                          if (codeCtrl.text.trim().isNotEmpty) {
                            setState(() => _barcodes.add({
                              'code': codeCtrl.text.trim(),
                              'type': selectedType,
                              'description': selectedDesc,
                            }));
                            Navigator.pop(ctx);
                          }
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: context.primary),
                        child: const Text('Добавить'),
                      ),
                    ],
                  ),
                ),
              );
            },
            icon: const Icon(Icons.add, size: 18),
            label: const Text('Добавить штрих-код'),
          ),
        ],
      ),
    );
  }

  Widget _buildLogisticsTab() {
    return _buildTabScroll(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('ФИЗИЧЕСКИЕ ПАРАМЕТРЫ (ЛОГИСТИКА)'),
          Text('ВГХ (габариты), см', style: TextStyle(color: context.textMuted, fontSize: 12)),
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(child: _field('Длина', _lengthCtrl)),
              const SizedBox(width: 12),
              Expanded(child: _field('Ширина', _widthCtrl)),
              const SizedBox(width: 12),
              Expanded(child: _field('Высота', _heightCtrl)),
            ],
          ),
          Row(
            children: [
              Expanded(child: _field('Вес нетто, кг', _weightNetCtrl)),
              const SizedBox(width: 12),
              Expanded(child: _field('Вес брутто, кг', _weightGrossCtrl)),
            ],
          ),
          Row(
            children: [
              Expanded(child: _field('Штук в коробе', _qtyPerBoxCtrl)),
              const SizedBox(width: 12),
              Expanded(child: _field('Коробов на паллете', _boxesPerPalletCtrl)),
            ],
          ),
          const SizedBox(height: 8),
          Text('Тип упаковки', style: TextStyle(color: context.textMuted, fontSize: 12)),
          const SizedBox(height: 6),
          _dropdown(_packageType, skuPackageTypes, (v) => setState(() => _packageType = v)),
        ],
      ),
    );
  }

  Widget _buildWmsTab() {
    return _buildTabScroll(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('СКЛАДСКИЕ ПРАВИЛА (WMS)'),
          Text('Зона хранения', style: TextStyle(color: context.textMuted, fontSize: 12)),
          const SizedBox(height: 6),
          _dropdown(_storageZone, skuStorageZones, (v) => setState(() => _storageZone = v)),
          const SizedBox(height: 16),
          Text('Условия обработки', style: TextStyle(color: context.textMuted, fontSize: 12)),
          const SizedBox(height: 6),
          _dropdown(_handling, skuHandlingConditions, (v) => setState(() => _handling = v)),
          const SizedBox(height: 16),
          Text('Стратегия отбора', style: TextStyle(color: context.textMuted, fontSize: 12)),
          const SizedBox(height: 6),
          _dropdown(_pickingStrategy, skuPickingStrategy, (v) => setState(() => _pickingStrategy = v)),
          const SizedBox(height: 16),
          Text('ABC-класс', style: TextStyle(color: context.textMuted, fontSize: 12)),
          const SizedBox(height: 6),
          _dropdown(_abcClass, skuAbcClass, (v) => setState(() => _abcClass = v)),
        ],
      ),
    );
  }

  Widget _buildComplianceTab() {
    return _buildTabScroll(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('КАЧЕСТВО И СРОКИ (COMPLIANCE)'),
          Text('Тип учета', style: TextStyle(color: context.textMuted, fontSize: 12)),
          const SizedBox(height: 6),
          _dropdown(_accountingType, skuAccountingType, (v) => setState(() => _accountingType = v)),
          const SizedBox(height: 16),
          _field('Срок годности (Shelf Life), мес.', _shelfLifeMonthsCtrl, hint: 'Например: 36'),
          _field('Лимит приемки, % остаточного срока', _receptionLimitPctCtrl, hint: 'Ниже этого % прием блокируется'),
        ],
      ),
    );
  }

  Widget _buildFinanceTab() {
    return _buildTabScroll(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('КОММЕРЧЕСКИЙ БЛОК (FINANCE)'),
          _financeRow(
            'Валюта базовой цены',
            _dropdown(_currency, skuCurrencies, (v) => setState(() => _currency = v)),
            'Ставка НДС, %',
            _financeField(_vatRateCtrl, 'Например: 12'),
          ),
          _financeRow(
            'Статус жизни',
            _dropdown(_lifeStatus, skuLifeStatus, (v) => setState(() => _lifeStatus = v)),
            'Минимальный остаток (точка перезаказа)',
            _financeField(_minStockCtrl, 'Для автозакупок'),
          ),
        ],
      ),
    );
  }

  Widget _financeField(TextEditingController ctrl, String hint) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: context.card,
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.centerLeft,
      child: TextField(
        controller: ctrl,
        style: TextStyle(color: context.textMain, fontSize: 14),
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
          isDense: true,
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }

  Widget _financeRow(String label1, Widget control1, String label2, Widget control2) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label1, style: TextStyle(color: context.textMuted, fontSize: 12)),
                const SizedBox(height: 6),
                control1,
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label2, style: TextStyle(color: context.textMuted, fontSize: 12)),
                const SizedBox(height: 6),
                control2,
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttributesTab() {
    return _buildTabScroll(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('СПЕЦИФИКА (ATTRIBUTES)'),
          Text('Концентрация', style: TextStyle(color: context.textMuted, fontSize: 12)),
          const SizedBox(height: 6),
          _dropdown(_concentration, skuConcentration, (v) => setState(() => _concentration = v)),
          const SizedBox(height: 16),
          Text('Пол', style: TextStyle(color: context.textMuted, fontSize: 12)),
          const SizedBox(height: 6),
          _dropdown(_gender, skuGender, (v) => setState(() => _gender = v)),
          const SizedBox(height: 16),
          _field('Коллекция / Сезон', _collectionCtrl, hint: 'Маркетинговый запуск'),
        ],
      ),
    );
  }
}
