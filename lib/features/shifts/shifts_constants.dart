import '../../core/grid_models.dart';

// Заводские колонки для экрана Команда (разделены Телефон и Тип найма)
final List<ColumnConfig> defaultColumns = [
  ColumnConfig(key: 'name', title: 'Сотрудник', width: 240),
  ColumnConfig(key: 'phone', title: 'Телефон', width: 160),
  ColumnConfig(key: 'role', title: 'Должность', width: 180),
  ColumnConfig(key: 'employment', title: 'Тип найма', width: 140),
  ColumnConfig(key: 'zone', title: 'Текущая зона', width: 160),
  ColumnConfig(key: 'status', title: 'Статус', width: 160),
  ColumnConfig(key: 'login', title: 'Логин', isVisible: false, width: 140),
  ColumnConfig(key: 'email', title: 'Email', isVisible: false, width: 220),
  ColumnConfig(
    key: 'telegram',
    title: 'Telegram',
    isVisible: false,
    width: 140,
  ),
  ColumnConfig(key: 'iin', title: 'ИИН', isVisible: false, width: 150),
  ColumnConfig(key: 'contract', title: 'Договор', isVisible: false, width: 130),
  ColumnConfig(
    key: 'hireDate',
    title: 'Дата приема',
    isVisible: false,
    width: 130,
  ),
  ColumnConfig(
    key: 'clothes',
    title: 'Размер одежды',
    isVisible: false,
    width: 140,
  ),
  ColumnConfig(
    key: 'shoes',
    title: 'Размер обуви',
    isVisible: false,
    width: 120,
  ),
  ColumnConfig(key: 'locker', title: 'Шкафчик', isVisible: false, width: 100),
  ColumnConfig(key: 'tsdPin', title: 'ПИН ТСД', isVisible: false, width: 100),
];

final List<String> globalRoles = [
  'Старший смены',
  'Комплектовщик',
  'Водитель погрузчика',
  'Приемщик',
];

final List<String> globalZones = [
  'Зона А (Сборка)',
  'Зона Б (Паллеты)',
  'Пандус 1',
  'Холодильник',
  'Все зоны',
];

final List<String> globalStatuses = [
  'Активен',
  'В отпуске',
  'Больничный',
  'Отсутствует',
  'В архиве',
];

final List<String> clothesSizes = [
  'S (44-46)',
  'M (46-48)',
  'L (48-50)',
  'XL (50-52)',
  'XXL (52-54)',
];

final List<String> shoeSizes = [
  '35', '36', '37', '38', '39', '40', '41', '42', '43', '44', '45', '46', '47',
];

final List<String> globalEmploymentTypes = ['Штат', 'Аутстаффинг', 'ГПХ'];

final List<String> globalRights = [
  '1C Предприятие',
  'ТСД Сканер (Сборка)',
  'ТСД Сканер (Приемка)',
  'Редактирование смен',
  'Допуск в Холодильник',
  'Вождение погрузчика',
];

final List<String> globalInventoryTypes = [
  'Ноутбук / ПК',
  'ТСД Сканер',
  'Рация',
  'Спецодежда',
  'Ключи',
  'Прочее',
];
