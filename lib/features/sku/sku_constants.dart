// ============================================================================
// СПРАВОЧНИКИ ДЛЯ SKU (номенклатура)
// ============================================================================

final List<String> skuBrands = [
  'Chanel',
  'Dior',
  'L\'Oréal',
  'LVMH',
  'Собственный бренд',
];

final List<String> skuCategories = [
  'Парфюмерия > Женская > EDP',
  'Парфюмерия > Женская > EDT',
  'Парфюмерия > Мужская > EDP',
  'Парфюмерия > Унисекс > EDC',
  'Косметика > Уход > Крем',
  'Косметика > Макияж > Помада',
];

final List<String> skuPackageTypes = [
  'Флакон',
  'Тестер',
  'Набор',
  'Короб',
  'Палета',
];

final List<String> skuStorageZones = [
  'Основная',
  'Сейфовая (ценное)',
  'Температурная',
];

final List<String> skuHandlingConditions = [
  'Стандарт',
  'Хрупкое',
  'Опасный груз (ADR)',
  'Требует маркировки',
];

final List<String> skuPickingStrategy = [
  'FEFO',
  'FIFO',
  'По зоне',
];

final List<String> skuAbcClass = ['A', 'B', 'C'];

final List<String> skuAccountingType = [
  'Партионный',
  'Серийный номер',
];

final List<String> skuLifeStatus = [
  'Новинка',
  'Активен',
  'Вывод из ассортимента',
  'Архив',
];

final List<String> skuConcentration = [
  'EDP',
  'EDT',
  'EDC',
  'Parfum',
];

final List<String> skuGender = [
  'Male',
  'Female',
  'Unisex',
];

final List<String> skuCurrencies = ['KZT', 'USD', 'EUR', 'RUB'];

final List<String> skuBarcodeTypes = [
  'EAN-13',
  'EAN-8',
  'UPC-A',
  'Внутренний',
  'QR',
  'Другой',
];

/// Описание по назначению: основной, тестер и т.д.
final List<String> skuBarcodeDescriptions = [
  'Основной',
  'Тестер',
  'Подарочная упаковка',
  'Промо',
  'Другой',
];

/// Дерево категорий: уровень 1 → уровень 2 → уровень 3
final List<String> skuCategoryLevel1 = ['Парфюмерия', 'Косметика'];
final Map<String, List<String>> skuCategoryLevel2 = {
  'Парфюмерия': ['Женская', 'Мужская', 'Унисекс'],
  'Косметика': ['Уход', 'Макияж'],
};
final Map<String, List<String>> skuCategoryLevel3 = {
  'Женская': ['EDP', 'EDT'],
  'Мужская': ['EDP'],
  'Унисекс': ['EDC'],
  'Уход': ['Крем'],
  'Макияж': ['Помада'],
};
