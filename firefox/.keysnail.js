// ========================== KeySnail Init File =========================== //

// この領域は, GUI により設定ファイルを生成した際にも引き継がれます
// 特殊キー, キーバインド定義, フック, ブラックリスト以外のコードは, この中に書くようにして下さい
// ========================================================================= //
//{{%PRESERVE%

// ここにコードを入力して下さい

//}}%PRESERVE%
// ========================================================================= //

// ========================= Special key settings ========================== //

key.quitKey              = "undefined";
key.helpKey              = "undefined";
key.escapeKey            = "undefined";
key.macroStartKey        = "undefined";
key.macroEndKey          = "undefined";
key.universalArgumentKey = "undefined";
key.negativeArgument1Key = "undefined";
key.negativeArgument2Key = "undefined";
key.negativeArgument3Key = "undefined";
key.suspendKey           = "undefined";

// ================================= Hooks ================================= //



// ============================= Key bindings ============================== //

key.setViewKey('1', function (ev) {
    getBrowser().mTabContainer.advanceSelectedTab(-1, true);
}, 'ひとつ左のタブへ');

key.setViewKey('2', function (ev) {
    getBrowser().mTabContainer.advanceSelectedTab(1, true);
}, 'ひとつ右のタブへ');

key.setViewKey('z', function (ev) {
    BrowserBack();
}, '戻る');

key.setViewKey('x', function (ev) {
    BrowserForward();
}, '進む');

key.setViewKey('j', function (ev) {
    key.generateKey(ev.originalTarget, KeyEvent.DOM_VK_DOWN, true);
}, '一行スクロールダウン');

key.setViewKey('k', function (ev) {
    key.generateKey(ev.originalTarget, KeyEvent.DOM_VK_UP, true);
}, '一行スクロールアップ');
