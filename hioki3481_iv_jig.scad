// HIOKI 3481 用 IV線保持ジグ（着脱式） v17.1
// ※ 日置電機（HIOKI）の非公式品です。メーカーとは関係ありません。
// ※ 使用前後に必ず既知の活線で検電器の動作を確認してください。使用は自己責任でお願いします。
//
// ・先端ノーズ（センサー部）の「側面」に、IV線を軸と直交させて当てる
// ・IV線はノーズとジグのV溝で挟み込み、爪でパチッと保持（機器に接続したままの線でOK）
// ・IV 1.6mm（外径3.2）と IV 2.0mm（外径3.4）の両方に対応
// ・本体先端のリブ（透明部と黒い部分のつなぎ目）をスリーブ内の溝に収めて、前後方向をカチッと固定
// ・スリーブのボタン面側は窓で開放（楕円部とON/OFFボタンを覆わない）。窓の両側の爪は本体のボタン面に広く掛かる
// ・IV線がノーズを押す力で本体がボタン面側の爪に押し付けられ、その摩擦で検電器と線の両方を保持する（v7〜v13で実績）
// ・取り付けは後ろからの差し込みのみ。背中の矢印と、後端の面取りで差し込む向きを示す
//
// 座標：Z軸 = 検電器の軸方向（+Z が先端側）、IV線は Y方向、線とアームは +X側
// ★印はノギスで実測して置き換える値
//
// 使い方：
//  1. 検電器の先端を、スリーブの後ろ（面取りしてある口）から差し込み、ツバに当たるまで押し込む
//     ※ ボタン面側から横に押し込むと爪が割れるので不可
//  2. IV線を前方（+Z側）からノーズの横の溝へ押し込む（パチッと爪を越える）
//  3. 検電（手を離した状態でも検知できるよう、検電器の感度は各自で調整・確認すること）
//  4. 外すときは線を前方へ抜いてから、検電器を後ろへ抜く
//
// 補強材：結束バンド（ヘラマンタイトン AB300、幅4.9×厚1.5mm）を切ってアーム内のポケットに埋め込む
//         印刷中に一時停止して差し込む（高さはコンソールの ECHO に表示）
// 印刷の向き：スリーブを下にして立てる（寝かせるとPLAで爪が一発で割れた。アームの根元は要経過観察）

$fn = 72;

// ---- 線を当てる面 ----
// "label"  : ラベル面側（アームもラベル面側。ボタン面は開放のまま）
// "narrow" : 側面（幅の狭い面）側
// "button" : ボタン面側（アームが楕円部・ボタンの上を通るので非推奨）
wire_face = "label";   // 現行版は "label" のみ対応

// ---- 検電器本体（先端側の黒い部分の断面）----
body_w  = 17.0;  // 幅（ボタン面の横幅）実測
body_d  = 13.0;  // 厚み（ボタン面〜ラベル面）実測
body_r  = 2.0;   // 角の丸みの半径 実測
clr     = 0.3;   // 片側クリアランス
clr_d   = 0.3;   // 厚み方向（ボタン面〜ラベル面）の片側すき間。増やすとV溝も同じだけ自動で外へずれる
w_extra = 0.6;   // 幅方向だけ追加する余裕（合計）。試作4回目でスリーブが広がったため
rib_w   = 18.0;  // 先端リブの幅 実測
rib_d   = 14.0;  // ★ 先端リブの厚み（本体13mm + 0.5mm×2 と想定）
rib_len = 3.5;   // 先端リブの受け溝の前後方向の長さ（試作5回目の現物合わせで 2.0→3.5）
cap_w   = 13.4;  // 透明キャップ根元の幅（外形図）。ツバの穴＝これ+0.6 で、リブ前側の輪(幅16.3)に当たる
cap_d   = 10.2;  // ツバの穴・アーム内面の基準（キャップのラベル面側は中心から5.0mm：外形図）

// ---- 先端キャップ ----
tip_len   = 22.0; // リブ前面〜ノーズ頂点の距離（外形図）
nose_d    = 6.0;  // ノーズの幅（外形図：5.3〜6.0）
nose_t    = 1.9;  // ノーズの厚み（外形図。平たい板状）
nose_off  = 8.8;  // 本体ボタン面〜ノーズのラベル面側の面（外形図。参考表示にのみ使用）
nose_x    = 0.5;  // V溝の位置決めに使うノーズ面のX（v7〜v13の現物合わせで実績のある値）
nose_len  = 8.2;  // ノーズ（細い部分＋根元の丸み）の長さ（外形図：細い部分6.7＋丸み）
nose_tip_r = 2.0; // ★ ノーズ頂点の丸みの半径（目安。線はこれより根元側に当てる）
contact_h = 5.0;  // ノーズ頂点〜IV線の中心までの距離（v8〜v14 と同じ実位置。tip_len 補正分を移した）

// ---- IV線 ----
wire_min  = 3.2;  // 対応する最小の線径（IV 1.6mm 実測）
wire_max  = 3.4;  // 対応する最大の線径（IV 2.0mm 実測）
squeeze   = 0.15; // 細い線をノーズへ押し付ける量（太い線はこれ + 約0.25mm）。v7〜v13と同じ
open_gap  = 2.8;  // 爪の先端〜ノーズ面の入口幅（wire_min より小さく。小さいほど保持が強い）

// ---- スリーブ ----
sleeve_len = 14.0; // スリーブ長さ
wall       = 1.4;  // 側面・爪の肉厚（すき間 0.3〜0.6mm と合わせて、仕上がりで約2mm）
wall_back  = 2.0;  // 背中（ラベル面側）の肉厚。アームの根元になるので厚め
win_w      = 10.0; // ボタン面側の窓の幅（楕円部の幅9.3 + 余裕）。爪が本体ボタン面に広く掛かる
rear_ch    = 1.0;  // スリーブ後端の内側の面取り（差し込み口の目印＆入れやすく）
arrow_d    = 0.4;  // 背中に彫る矢印（差し込む向き）の深さ
flange_t   = 1.2;  // 先端ツバの厚み

// ---- 線受けブロック・アーム ----
bar_t    = 12.0; // ブロックの幅（線に沿った長さ）
arm_w    = 13.0; // アームの幅（背中の平らな部分いっぱい）

// ---- 補強材（結束バンド）----
use_rib    = true; // false にするとポケットなし（v16と同じ形）
tie_w      = 4.9;  // 結束バンドの幅（実測）
tie_t      = 1.5;  // 結束バンドの厚み（実測）
tie_clr    = 0.03; // ポケットの片側すき間（0.15ではスカスカだった。押し込んで入るくらいを狙う）
tie_floor  = 0.4;  // ポケットの底（ツバの上）の厚み
tie_roof   = 0.8;  // ポケットのフタの厚み（ブロック上面からの残り）
gap      = 0.4;  // ノーズとブロックのすき間
wall_t   = 2.5;  // V溝の奥の壁厚
ledge_t  = 0.8;  // 線の下（本体側）の受け厚
ledge_dz = 1.8;  // 線の中心〜受け面の高さ
lip_h    = 2.0;  // 爪の先端より上の厚み
lead     = 1.0;  // 入口の面取り
low_ch   = 1.2;  // ブロック下面・ノーズ側の角の面取り（テーパー部との干渉よけ）
arm_t    = 9.9;  // アーム厚みの上限（実際は透明キャップに当たらない厚みに自動で制限）

// ---- 導出値 ----
rot   = wire_face == "label" ? 90 : wire_face == "button" ? -90 : 0;
in_w  = body_w + 2*clr + w_extra;
in_d  = body_d + 2*clr_d;
hx    = in_d/2 + wall_back;                          // 背中（ラベル面側）の外面X
nose_r = nose_d/2;
z_bf   = sleeve_len;                                  // 本体先端面のZ（ツバの裏）
z_top  = z_bf + tip_len;                              // ノーズ頂点
z_sh   = z_top - nose_len;                            // ノーズの肩
z_c    = z_top - contact_h;                           // 線の中心高さ
// 本体は線の力でボタン面側の爪に押し付けられるので、厚み方向のすき間を増やすとノーズもその分ずれる。
// v16（clr_d=0.3）を基準に、V溝も同じだけずらして押し付け量を保つ
xn     = nose_x + (clr_d - 0.3);                       // 線を当てるノーズ面のX
// 90°のV溝：頂点 xa。直径dの線は中心が頂点から d/2*√2 の位置に来る
xa     = xn - squeeze + wire_min*(0.5 + sqrt(2)/2);   // V溝の頂点X
function wx(d) = xa - d/2*sqrt(2);                     // 直径dの線の中心X
x_in   = xn + gap;                                    // ブロックのノーズ側の面
x_l    = xn + open_gap;                               // 爪の先端X
z_lip  = z_c + (xa - x_l);                            // 爪の先端Z
blk_z0 = z_c - ledge_dz - ledge_t;
blk_z1 = z_lip + lip_h;
arm_x1 = hx;                                          // アーム外面＝スリーブ外面（面一）
arm_x0 = max(hx - arm_t, cap_d/2 + 0.3);                // キャップ根元 + 0.3mm まで
echo(str("IV1.6 の食い込み = ", xn - (wx(wire_min) - wire_min/2), " mm / IV2.0 の食い込み = ", xn - (wx(wire_max) - wire_max/2), " mm"));

assert(blk_z0 > z_sh - 0.5, "線の受けがノーズの肩（テーパー部）に当たる：contact_h を小さくするか ledge_t を薄く");
assert(xa + wall_t <= arm_x1, "V溝の奥の壁がスリーブ外面より外に出る：wall_t を薄く");
// 補強材ポケット（アーム厚みの中央、ツバの上〜線受けブロックの中まで）
pk_t   = tie_t + 2*tie_clr;
pk_w   = tie_w + 2*tie_clr;
pk_x0  = (arm_x0 + arm_x1)/2 - pk_t/2;
pk_z0  = sleeve_len + tie_floor;
pk_z1  = blk_z1 - tie_roof;
if (use_rib) {
    echo(str("補強材：結束バンドを ", floor((pk_z1 - pk_z0 - 0.2)*10)/10, " mm に切る / 一時停止の高さ = ", pk_z1, " mm（この高さを超える最初の層の前で止める）"));
    echo(str("ポケット両側の肉厚 = 内側 ", pk_x0 - arm_x0, " mm / 外側 ", arm_x1 - (pk_x0 + pk_t), " mm"));
}
echo(str("アーム厚み = ", arm_x1 - arm_x0, " mm / 爪がボタン面に掛かる幅(片側) = ", (in_w - win_w)/2, " mm"));
assert(wire_face == "label", "v14 は wire_face = \"label\" のみ対応");
assert(arm_w <= in_w - 2*(body_r + clr), "arm_w が背中の平らな部分より広い");
assert(open_gap < wire_min, "open_gap は wire_min より小さくすること");
assert(contact_h >= nose_tip_r, "線がノーズの丸い頂点にかかる：contact_h を大きく");

module body_frame() { rotate([0, 0, rot]) children(); }
module rrect(w, d, rr) { offset(r = rr) square([w - 2*rr, d - 2*rr], center = true); }

// 本体座標（幅がX、ボタン面が+Y、ラベル面が-Y）で作ってから治具座標へ回す
module sleeve() {
    zt = sleeve_len + flange_t;
    body_frame() difference() {
        // 外形：背中（-Y）だけ wall_back、ほかは wall
        translate([0, -(wall_back - wall)/2, 0])
            linear_extrude(zt) rrect(in_w + 2*wall, in_d + wall + wall_back, body_r + clr + wall);
        // 本体が入る空洞
        translate([0, 0, -1]) linear_extrude(sleeve_len + 1) rrect(in_w, in_d, body_r + clr);
        // 先端リブの受け溝（リブはラベル面側にも0.5mm出ているので背中側も逃がす。背中は wall_back で厚みを確保）
        translate([0, 0, sleeve_len - rib_len]) linear_extrude(rib_len + 0.01) intersection() {
            rrect(rib_w + 2*clr + w_extra, rib_d + 2*clr, body_r + 0.5 + clr);
            translate([-50, -50]) square([100, 100]);
        }
        // ツバの内側の穴（透明キャップ根元 + 0.3mm）
        translate([0, 0, sleeve_len - 1]) linear_extrude(flange_t + 2) rrect(cap_w + 0.6, cap_d + 0.6, 1.0);
        // ボタン面側の窓（スリーブ全長＋ツバ。楕円部・LED部が通る）
        translate([-win_w/2, 0, -1]) cube([win_w, 50, zt + 2]);
        // 後端の差し込み口の面取り
        translate([0, 0, -0.01]) hull() {
            linear_extrude(0.01) offset(delta = rear_ch) rrect(in_w, in_d, body_r + clr);
            translate([0, 0, rear_ch]) linear_extrude(0.01) rrect(in_w, in_d, body_r + clr);
        }
    }
}

// アームはツバの位置から立ち上げる（スリーブ部分はスリーブの壁がそのまま背骨になる）
module arm() { translate([arm_x0, -arm_w/2, sleeve_len]) cube([arm_x1 - arm_x0, arm_w, blk_z1 - sleeve_len]); }

module block() {
    difference() {
        translate([x_in, -bar_t/2, blk_z0]) cube([arm_x1 - x_in, bar_t, blk_z1 - blk_z0]);
        // V溝＋受け面＋入口（XZ断面をY方向に押し出して抜く）
        translate([0, bar_t/2 + 1, 0]) rotate([90, 0, 0]) linear_extrude(bar_t + 2)
            polygon([
                [x_in - 1,          z_c - ledge_dz],   // 受け面（ノーズ側）
                [xa - ledge_dz,     z_c - ledge_dz],   // 受け面 → V溝の下面
                [xa,                z_c],              // V溝の頂点
                [x_l,               z_lip],            // V溝の上面 → 爪の先端
                [x_l,               blk_z1 - lead],    // 爪の前面
                [x_l + lead,        blk_z1 + 0.01],    // 入口の面取り
                [x_in - 1,          blk_z1 + 0.01]
            ]);
        // 下面のノーズ側の角を面取り
        translate([0, bar_t/2 + 1, 0]) rotate([90, 0, 0]) linear_extrude(bar_t + 2)
            polygon([[x_in - 1, blk_z0 - 1], [x_in + low_ch + 1, blk_z0 - 1], [x_in - 1, blk_z0 + low_ch + 1]]);
    }
}

// 背中（ラベル面側の外面）に、差し込む向き（後ろ→先端）の矢印を彫る
module arrow2d() { polygon([[-1.2, 1], [1.2, 1], [1.2, 7], [3.5, 7], [0, 12], [-3.5, 7], [-1.2, 7]]); }
difference() {
    union() { sleeve(); arm(); block(); }
    if (use_rib) translate([pk_x0, -pk_w/2, pk_z0]) cube([pk_t, pk_w, pk_z1 - pk_z0]);
    translate([hx - arrow_d, 0, 0]) rotate([90, 0, 90]) linear_extrude(arrow_d + 1) arrow2d();
}

// ---- 参考表示（% 付き：プレビューのみ、STLには含まれない）----
%translate([wx(wire_max), -30, z_c]) rotate([-90, 0, 0]) cylinder(d = wire_max, h = 60);   // IV線（2.0mm）
// 検電器（外形図からの概形）。本体座標：ボタン面+Y、ラベル面-Y
%body_frame() {
    translate([0, 0, z_bf - 60]) linear_extrude(60) rrect(body_w, body_d, body_r);
    translate([0, 0, z_bf]) linear_extrude(3.3) rrect(rib_w, rib_d, body_r + 0.5);
    // テーパー部（ラベル面側は中心から5.0→4.5、ボタン面側は4.4→2.2、幅13.4→10.5）
    hull() {
        translate([0, -0.3, z_bf]) linear_extrude(0.1) translate([-6.7, -5.0]) square([13.4, 9.4]);
        translate([0, 0, z_top - 8.2]) linear_extrude(0.1) translate([-5.25, -4.4]) square([10.5, 6.6]);
    }
    // ノーズ（幅 nose_d × 厚み nose_t、ラベル面側へ寄っている）
    translate([0, body_d/2 - nose_off + nose_t/2, z_top - nose_len])
        hull() {
            translate([0, 0, 0]) linear_extrude(nose_len - nose_d/2) square([nose_d, nose_t], center = true);
            translate([0, 0, nose_len - nose_d/2]) scale([1, nose_t/nose_d, 1]) sphere(d = nose_d);
        }
}
