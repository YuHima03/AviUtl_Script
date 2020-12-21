--[[

AviUtlスクリプト「Yh拡張図形」で使う関数群だゾ

他のスクリプトからも呼び出せます
色々な詳細な設定も用意してます

==< 説明欄の読み方 >==
変数名 -> 変数の型 (説明) (初期値) ※
    注：上のやつに関する注釈があったりなかったり

]]

local function Draw(...) -- 図形の描画 Draw( {描画オプション...}, 図形の種類, 色, 幅, 高さ, ライン幅, {図形ごとのオプション...} )

    --[[
    ===< 描画オプションの設定 >===
    >> テーブルを利用して以下のように記述してください(初期値が用意されているので全て必須ではありません)
        { 要素名1 = 値, 要素名2 = 値, ...}

    >> 各要素の説明は以下の通りです (booleanの場合、基本的には 「trueで有効、falseで無効」 です)
        << 描画オプション >>
            --基本設定---------------
            intempbuffer -> boolean (false) (仮想バッファの中でこの関数を実行する際は値をtrueに) ※重要項目です
            loadonly -> boolean (true) (obj.drawは実行せず、obj.loadのみ実行します) ※重要項目です
            defaultblend -> number/string (0) (この関数の実行後にセットされる合成モード) ※重要項目です
            antialias -> boolean (false) (アンチエイリアスの有無) ※使用すると謎のライン等が改善される場合あり
            --描画に関わる設定---------------

        << 図形ごとのオプション >>
            --円---------------
            around -> number (1) (周辺の描画の進捗具合) ※0~1で設定(割合)
            --四角形---------------
            around -> number (1) (周辺の描画の進捗具合) ※0~1で設定(割合)

    ]]

    --[[
    MEMO：ひな形

    if DOPT.intempbuffer == false then
        obj.setoption('drawtarget', 'tempbuffer', math.max(SIZE[1], 0.6), math.max(SIZE[2], 0.6))
    end

    --[[
    ==================================================
    /// 描画処理ここから //
    \]\]
    if SIZE.min > 0.5 then
        --基本の円
        obj.load('figure', "円", COL, SIZE.max)
        obj.drawpoly(p[2], p[4], 0, p[1], p[4], 0, p[1], p[3], 0, p[2], p[3], 0)
        --ライン幅
        if LINEW < SIZE.min / 2 then
            obj.setoption('blend', 'alpha_sub', 'force')
                obj.drawpoly(p[2] + LINEW, p[4] + LINEW, 0, p[1] - LINEW, p[4] + LINEW, 0, p[1] - LINEW, p[3] - LINEW, 0, p[2] + LINEW, p[3] - LINEW, 0)
            obj.setoption('blend', DOPT.defaultblend, 'force')
        end
    end
    --[[
    /// 描画処理ここまで ///
    ==================================================
    \]\]

    if DOPT.intempbuffer == false then
        obj.setoption('drawtarget', 'framebuffer')
        obj.load('tempbuffer')
    end

    ]]

    local arg = {...} or {}

    if #arg >= 5  and type(arg[1]) == 'table' then
        --データ保存
        local DOPT = { --描画オプション
            --基本設定
            intempbuffer = arg[1].tempbuffer or false,
            loadonly = arg[1].loadonly or true,
            defaultblend = tonumber(arg[1].defaultblend) or 0,
            antialias = arg[1].antialias or false,
            --描画に関わる設定
            x = arg[1].x or 0,
            y = arg[1].y or 0,
            z = arg[1].z or 0,
            ox = arg[1].ox or 0,
            oy = arg[1].oy or 0,
            oz = arg[1].oz or 0,
            rx = arg[1].rx or 0,
            ry = arg[1].ry or 0,
            rz = arg[1].rz or 0,
            cx = arg[1].cx or 0,
            cy = arg[1].cy or 0,
            cz = arg[1].cz or 0,
            alpha = arg[1].alpha or 0,
            zoom = arg[1].zoom or 1
        }
        local FIG = tostring(arg[2]) -- 図形名
        local COL = tonumber(arg[3]) -- 色
        local SIZE = { --サイズ
            tonumber(arg[4]), --幅
            tonumber(arg[5]), --高さ
            max = tonumber(math.max(arg[4], arg[5])), --長い方
            min = tonumber(math.min(arg[4], arg[5])) --短い方
        }
        local LINEW = tonumber(arg[6]) -- ライン幅
        local FOPT --図形ごとのオプション
        arg[7] = arg[7] or {}

        --[[
        ////////////////
        ///// MAIN /////
        ////////////////
        ]]

        --[[
        ==================================================
        /// 仮想バッファここから ///
        ]]
        if DOPT.intempbuffer == false then
            obj.setoption('drawtarget', 'tempbuffer', math.max(SIZE[1], 0.6), math.max(SIZE[2], 0.6))
        end

        if FIG == '円' then
            FOPT = {
                --周辺の設定
                around = arg[7].around or 1,
            }

            local p = {
                SIZE[1]/2, SIZE[1]/-2,
                SIZE[2]/2, SIZE[2]/-2
            }

            --[[
            /// 描画処理ここから //
            ]]
            if SIZE.min > 0.5 then
                --基本の円
                obj.load('figure', "円", COL, SIZE.max)
                obj.drawpoly(p[2], p[4], 0, p[1], p[4], 0, p[1], p[3], 0, p[2], p[3], 0)
                --ライン幅
                if LINEW < SIZE.min / 2 then
                    obj.setoption('blend', 'alpha_sub', 'force')
                        obj.drawpoly(p[2] + LINEW, p[4] + LINEW, 0, p[1] - LINEW, p[4] + LINEW, 0, p[1] - LINEW, p[3] - LINEW, 0, p[2] + LINEW, p[3] - LINEW, 0)
                    obj.setoption('blend', DOPT.defaultblend, 'force')
                end
            end
            --[[
            /// 描画処理ここまで ///
            ]]
        elseif FIG == '拡張円' then
        elseif FIG == '四角形' then
            FOPT = {
                --周辺の設定
                around = arg[7].around or 1,
                around_startp = arg[7].around_startp or 0,
                around_epcircle = arg[7].around_epcircle or 0
            }

            local p = {
                SIZE[1]/2, SIZE[1]/-2,
                SIZE[2]/2, SIZE[2]/-2
            }

            --[[
            /// 描画処理ここから //
            ]]
            if SIZE.min > 0.5 then
                --基本の四角形
                obj.load('figure', '四角形', COL, 10)
                obj.drawpoly(p[2], p[4], 0, p[1], p[4], 0, p[1], p[3], 0, p[2], p[3], 0)
                --ライン幅
                if LINEW < SIZE.min / 2 then
                    obj.setoption('blend', 'alpha_sub', 'force')
                        obj.drawpoly(p[2] + LINEW, p[4] + LINEW, 0, p[1] - LINEW, p[4] + LINEW, 0, p[1] - LINEW, p[3] - LINEW, 0, p[2] + LINEW, p[3] - LINEW, 0)
                    obj.setoption('blend', DOPT.defaultblend, 'force')
                end
                --周辺
                if FOPT.around < 1 then
                end
            end
            --[[
            /// 描画処理ここまで ///
            ]]
        end

        --[[
        /// 仮想バッファここまで ///
        ==================================================
        ]]
        if DOPT.intempbuffer == false then
            obj.setoption('drawtarget', 'framebuffer')
            obj.load('tempbuffer')
        end
    else
        return 0
    end

    return 1
end

return {
    Draw = Draw
}