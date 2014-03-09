// ========================== KeySnail Init File =========================== //

// この領域は, GUI により設定ファイルを生成した際にも引き継がれます
// 特殊キー, キーバインド定義, フック, ブラックリスト以外のコードは, この中に書くようにして下さい
// ========================================================================= //
//{{%PRESERVE%
//}}%PRESERVE%
// ========================================================================= //

// ========================= Special key settings ========================== //

key.quitKey              = "Not defined";
key.helpKey              = "Not defined";
key.escapeKey            = "Not defined";
key.macroStartKey        = "Not defined";
key.macroEndKey          = "Not defined";
key.universalArgumentKey = "Not defined";
key.negativeArgument1Key = "Not defined";
key.negativeArgument2Key = "Not defined";
key.negativeArgument3Key = "Not defined";
key.suspendKey           = "Not defined";

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

key.setViewKey('W', function (ev, arg) {
    TreeStyleTabService.removeTabSubTree(gBrowser.selectedTab);
}, 'このツリーを閉じる');

key.setViewKey('a', function (ev) {
    command.focusElement(command.elementsRetrieverTextarea, 0);
}, '最初のインプットエリアへフォーカス', true);

key.setViewKey('b', function (ev, arg) {
    loadURI("javascript:if(document.getSelection){s=document.getSelection();}else{s='';};document.location='https://pinboard.in/add?next=same&url='+encodeURIComponent(location.href)+'&description='+encodeURIComponent(s)+'&title='+encodeURIComponent(document.title)");
}, 'ブックマーク', true);
