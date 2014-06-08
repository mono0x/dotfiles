// ========================== KeySnail Init File =========================== //

// この領域は, GUI により設定ファイルを生成した際にも引き継がれます
// 特殊キー, キーバインド定義, フック, ブラックリスト以外のコードは, この中に書くようにして下さい
// ========================================================================= //
//{{%PRESERVE%
var local = {};
plugins.options["site_local_keymap.local_keymap"] = local;

function fake(k, i) function () { key.feed(k, i); };
function pass(k, i) [k, fake(k, i)];
function ignore(k, i) [k, null];

local["^http://reader.livedoor.com/reader/"] = [
    pass('a'),
    pass('s'),
    pass('j'),
    pass('k'),
    pass('o'),
    pass('p'),
    pass('v'),
    pass('z')
];
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
    loadURI("javascript:q=location.href;if(document.getSelection){d=document.getSelection();}else{d='';};p=document.title;void(open('https://pinboard.in/add?url='+encodeURIComponent(q)+'&description='+encodeURIComponent(d)+'&title='+encodeURIComponent(p),'Pinboard','toolbar=no,width=700,height=350'));");
}, 'ブックマーク', true);

key.setViewKey('B', function (ev, arg) {
    loadURI("javascript:q=location.href;p=document.title;void(t=open('https://pinboard.in/add?later=yes&noui=yes&jump=close&url='+encodeURIComponent(q)+'&title='+encodeURIComponent(p),'Pinboard','toolbar=no,width=100,height=100'));t.blur();");
}, 'Read Later');

key.setViewKey('e', function (ev, arg) {
    ext.exec('hok-start-foreground-mode', arg, ev);
}, 'HoK - リンクをフォアグラウンドで開く', true);

key.setViewKey('E', function (ev, arg) {
    ext.exec('hok-start-background-mode', arg, ev);
}, 'HoK - リンクをバックグラウンドで開く', true);

key.setViewKey('/', function (ev) {
    command.iSearchForward();
}, 'インクリメンタル検索', true);
