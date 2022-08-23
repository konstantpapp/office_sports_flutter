import 'dart:math';

class Emojis {
  final List<String> emojis = [
    '😄',
    '😃',
    '😀',
    '😊',
    '☺',
    '😉',
    '😍',
    '😘',
    '😚',
    '😗',
    '😙',
    '😜',
    '😝',
    '😛',
    '😳',
    '😁',
    '😔',
    '😌',
    '😒',
    '😞',
    '😣',
    '😢',
    '😂',
    '😭',
    '😪',
    '😥',
    '😰',
    '😅',
    '😓',
    '😩',
    '😫',
    '😨',
    '😱',
    '😠',
    '😡',
    '😤',
    '😖',
    '😆',
    '😋',
    '😷',
    '😎',
    '😴',
    '😵',
    '😲',
    '😟',
    '😦',
    '😧',
    '😈',
    '👿',
    '😮',
    '😬',
    '😐',
    '😕',
    '😯',
    '😶',
    '😇',
    '😏',
    '😑',
    '👲',
    '👳',
    '👮',
    '👷',
    '💂',
    '👶',
    '👦',
    '👧',
    '👨',
    '👩',
    '👴',
    '👵',
    '👱',
    '👼',
    '👸',
    '😺',
    '😸',
    '😻',
    '😽',
    '😼',
    '🙀',
    '😿',
    '😹',
    '😾',
    '👹',
    '👺',
    '🙈',
    '🙉',
    '🙊',
    '💀',
    '👽',
    '💩',
    '🔥',
    '✨',
    '🌟',
    '💫',
    '💥',
    '💢',
    '💦',
    '💧',
    '💤',
    '💨',
    '👂',
    '👀',
    '👃',
    '👅',
    '👄',
    '👍',
    '👎',
    '👌',
    '👊',
    '✊',
    '✌',
    '👋',
    '✋',
    '👐',
    '👆',
    '👇',
    '👉',
    '👈',
    '🙌',
    '🙏',
    '☝',
    '👏',
    '💪',
    '🚶',
    '🏃',
    '💃',
    '👫',
    '👪',
    '👬',
    '👭',
    '💏',
    '💑',
    '👯',
    '🙆',
    '🙅',
    '💁',
    '🙋',
    '💆',
    '💇',
    '💅',
    '👰',
    '🙎',
    '🙍',
    '🙇',
    '🎩',
    '👑',
    '👒',
    '👟',
    '👞',
    '👡',
    '👠',
    '👢',
    '👕',
    '👔',
    '👚',
    '👗',
    '🎽',
    '👖',
    '👘',
    '👙',
    '💼',
    '👜',
    '👝',
    '👛',
    '👓',
    '🎀',
    '🌂',
    '💄',
    '💛',
    '💙',
    '💜',
    '💚',
    '❤',
    '💔',
    '💗',
    '💓',
    '💕',
    '💖',
    '💞',
    '💘',
    '💌',
    '💋',
    '💍',
    '💎',
    '👤',
    '👥',
    '💬',
    '👣',
    '💭',
    '🐶',
    '🐺',
    '🐱',
    '🐭',
    '🐹',
    '🐰',
    '🐸',
    '🐯',
    '🐨',
    '🐻',
    '🐷',
    '🐽',
    '🐮',
    '🐗',
    '🐵',
    '🐒',
    '🐴',
    '🐑',
    '🐘',
    '🐼',
    '🐧',
    '🐦',
    '🐤',
    '🐥',
    '🐣',
    '🐔',
    '🐍',
    '🐢',
    '🐛',
    '🐝',
    '🐜',
    '🐞',
    '🐌',
    '🐙',
    '🐚',
    '🐠',
    '🐟',
    '🐬',
    '🐳',
    '🐋',
    '🐄',
    '🐏',
    '🐀',
    '🐃',
    '🐅',
    '🐇',
    '🐉',
    '🐎',
    '🐐',
    '🐓',
    '🐕',
    '🐖',
    '🐁',
    '🐂',
    '🐲',
    '🐡',
    '🐊',
    '🐫',
    '🐪',
    '🐆',
    '🐈',
    '🐩',
    '🐾',
    '💐',
    '🌸',
    '🌷',
    '🍀',
    '🌹',
    '🌻',
    '🌺',
    '🍁',
    '🍃',
    '🍂',
    '🌿',
    '🌾',
    '🍄',
    '🌵',
    '🌴',
    '🌲',
    '🌳',
    '🌰',
    '🌱',
    '🌼',
    '🌐',
    '🌞',
    '🌝',
    '🌚',
    '🌑',
    '🌒',
    '🌓',
    '🌔',
    '🌕',
    '🌖',
    '🌗',
    '🌘',
    '🌜',
    '🌛',
    '🌙',
    '🌍',
    '🌎',
    '🌏',
    '🌋',
    '🌌',
    '🌠',
    '⭐',
    '☀',
    '⛅',
    '☁',
    '⚡',
    '☔',
    '❄',
    '⛄',
    '🌀',
    '🌁',
    '🌈',
    '🌊',
    '🎍',
    '💝',
    '🎎',
    '🎒',
    '🎓',
    '🎏',
    '🎆',
    '🎇',
    '🎐',
    '🎑',
    '🎃',
    '👻',
    '🎅',
    '🎄',
    '🎁',
    '🎋',
    '🎉',
    '🎊',
    '🎈',
    '🎌',
    '🔮',
    '🎥',
    '📷',
    '📹',
    '📼',
    '💿',
    '📀',
    '💽',
    '💾',
    '💻',
    '📱',
    '☎',
    '📞',
    '📟',
    '📠',
    '📡',
    '📺',
    '📻',
    '🔊',
    '🔉',
    '🔈',
    '🔇',
    '🔔',
    '🔕',
    '📢',
    '📣',
    '⏳',
    '⌛',
    '⏰',
    '⌚',
    '🔓',
    '🔒',
    '🔏',
    '🔐',
    '🔑',
    '🔎',
    '💡',
    '🔦',
    '🔆',
    '🔅',
    '🔌',
    '🔋',
    '🔍',
    '🛁',
    '🛀',
    '🚿',
    '🚽',
    '🔧',
    '🔩',
    '🔨',
    '🚪',
    '🚬',
    '💣',
    '🔫',
    '🔪',
    '💊',
    '💉',
    '💰',
    '💴',
    '💵',
    '💷',
    '💶',
    '💳',
    '💸',
    '📲',
    '📧',
    '📥',
    '📤',
    '✉',
    '📩',
    '📨',
    '📯',
    '📫',
    '📪',
    '📬',
    '📭',
    '📮',
    '📦',
    '📝',
    '📄',
    '📃',
    '📑',
    '📊',
    '📈',
    '📉',
    '📜',
    '📋',
    '📅',
    '📆',
    '📇',
    '📁',
    '📂',
    '✂',
    '📌',
    '📎',
    '✒',
    '✏',
    '📏',
    '📐',
    '📕',
    '📗',
    '📘',
    '📙',
    '📓',
    '📔',
    '📒',
    '📚',
    '📖',
    '🔖',
    '📛',
    '🔬',
    '🔭',
    '📰',
    '🎨',
    '🎬',
    '🎤',
    '🎧',
    '🎼',
    '🎵',
    '🎶',
    '🎹',
    '🎻',
    '🎺',
    '🎷',
    '🎸',
    '👾',
    '🎮',
    '🃏',
    '🎴',
    '🀄',
    '🎲',
    '🎯',
    '🏈',
    '🏀',
    '⚽',
    '⚾',
    '🎾',
    '🎱',
    '🏉',
    '🎳',
    '⛳',
    '🚵',
    '🚴',
    '🏁',
    '🏇',
    '🏆',
    '🎿',
    '🏂',
    '🏊',
    '🏄',
    '🎣',
    '☕',
    '🍵',
    '🍶',
    '🍼',
    '🍺',
    '🍻',
    '🍸',
    '🍹',
    '🍷',
    '🍴',
    '🍕',
    '🍔',
    '🍟',
    '🍗',
    '🍖',
    '🍝',
    '🍛',
    '🍤',
    '🍱',
    '🍣',
    '🍥',
    '🍙',
    '🍘',
    '🍚',
    '🍜',
    '🍲',
    '🍢',
    '🍡',
    '🍳',
    '🍞',
    '🍩',
    '🍮',
    '🍦',
    '🍨',
    '🍧',
    '🎂',
    '🍰',
    '🍪',
    '🍫',
    '🍬',
    '🍭',
    '🍯',
    '🍎',
    '🍏',
    '🍊',
    '🍋',
    '🍒',
    '🍇',
    '🍉',
    '🍓',
    '🍑',
    '🍈',
    '🍌',
    '🍐',
    '🍍',
    '🍠',
    '🍆',
    '🍅',
    '🌽',
    '🏠',
    '🏡',
    '🏫',
    '🏢',
    '🏣',
    '🏥',
    '🏦',
    '🏪',
    '🏩',
    '🏨',
    '💒',
    '⛪',
    '🏬',
    '🏤',
    '🌇',
    '🌆',
    '🏯',
    '🏰',
    '⛺',
    '🏭',
    '🗼',
    '🗾',
    '🗻',
    '🌄',
    '🌅',
    '🌃',
    '🗽',
    '🌉',
    '🎠',
    '🎡',
    '⛲',
    '🎢',
    '🚢',
    '⛵',
    '🚤',
    '🚣',
    '⚓',
    '🚀',
    '✈',
    '💺',
    '🚁',
    '🚂',
    '🚊',
    '🚉',
    '🚞',
    '🚆',
    '🚄',
    '🚅',
    '🚈',
    '🚇',
    '🚝',
    '🚋',
    '🚃',
    '🚎',
    '🚌',
    '🚍',
    '🚙',
    '🚘',
    '🚗',
    '🚕',
    '🚖',
    '🚛',
    '🚚',
    '🚨',
    '🚓',
    '🚔',
    '🚒',
    '🚑',
    '🚐',
    '🚲',
    '🚡',
    '🚟',
    '🚠',
    '🚜',
    '💈',
    '🚏',
    '🎫',
    '🚦',
    '🚥',
    '⚠',
    '🚧',
    '🔰',
    '⛽',
    '🏮',
    '🎰',
    '♨',
    '🗿',
    '🎪',
    '🎭',
    '📍',
    '🚩',
    '⬆',
    '⬇',
    '⬅',
    '➡',
    '🔠',
    '🔡',
    '🔤',
    '↗',
    '↖',
    '↘',
    '↙',
    '↔',
    '↕',
    '🔄',
    '◀',
    '▶',
    '🔼',
    '🔽',
    '↩',
    '↪',
    'ℹ',
    '⏪',
    '⏩',
    '⏫',
    '⏬',
    '⤵',
    '⤴',
    '🆗',
    '🔀',
    '🔁',
    '🔂',
    '🆕',
    '🆙',
    '🆒',
    '🆓',
    '🆖',
    '📶',
    '🎦',
    '🈁',
    '🈯',
    '🈳',
    '🈵',
    '🈴',
    '🈲',
    '🉐',
    '🈹',
    '🈺',
    '🈶',
    '🈚',
    '🚻',
    '🚹',
    '🚺',
    '🚼',
    '🚾',
    '🚰',
    '🚮',
    '🅿',
    '♿',
    '🚭',
    '🈷',
    '🈸',
    '🈂',
    'Ⓜ',
    '🛂',
    '🛄',
    '🛅',
    '🛃',
    '🉑',
    '㊙',
    '㊗',
    '🆑',
    '🆘',
    '🆔',
    '🚫',
    '🔞',
    '📵',
    '🚯',
    '🚱',
    '🚳',
    '🚷',
    '🚸',
    '⛔',
    '✳',
    '❇',
    '❎',
    '✅',
    '✴',
    '💟',
    '🆚',
    '📳',
    '📴',
    '🅰',
    '🅱',
    '🆎',
    '🅾',
    '💠',
    '➿',
    '♻',
    '♈',
    '♉',
    '♊',
    '♋',
    '♌',
    '♍',
    '♎',
    '♏',
    '♐',
    '♑',
    '♒',
    '♓',
    '⛎',
    '🔯',
    '🏧',
    '💹',
    '💲',
    '💱',
    '©',
    '®',
    '™',
    '〽',
    '〰',
    '🔝',
    '🔚',
    '🔙',
    '🔛',
    '🔜',
    '❌',
    '⭕',
    '❗',
    '❓',
    '❕',
    '❔',
    '🔃',
    '🕛',
    '🕧',
    '🕐',
    '🕜',
    '🕑',
    '🕝',
    '🕒',
    '🕞',
    '🕓',
    '🕟',
    '🕔',
    '🕠',
    '🕕',
    '🕖',
    '🕗',
    '🕘',
    '🕙',
    '🕚',
    '🕡',
    '🕢',
    '🕣',
    '🕤',
    '🕥',
    '🕦',
    '✖',
    '➕',
    '➖',
    '➗',
    '♠',
    '♥',
    '♣',
    '♦',
    '💮',
    '💯',
    '✔',
    '☑',
    '🔘',
    '🔗',
    '➰',
    '🔱',
    '🔲',
    '🔳',
    '◼',
    '◻',
    '◾',
    '◽',
    '▪',
    '▫',
    '🔺',
    '⬜',
    '⬛',
    '⚫',
    '⚪',
    '🔴',
    '🔵',
    '🔻',
    '🔶',
    '🔷',
    '🔸',
    '🔹'
  ];

  String getRandom() {
    return emojis[Random().nextInt(emojis.length)];
  }
}