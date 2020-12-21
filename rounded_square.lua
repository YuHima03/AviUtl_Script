--[[
///////////////////////////////////
===================================
>>> 角丸四角形plus_v2(obj/anm)用 <<<
===================================
///////////////////////////////////
]]

--main_function
local function draw(w, h, linew, color, r1, r2, r3, r4, opt)
    local r = {r1, r2, r3, r4, math.max(r1, r2, r3, r4), math.min(r1, r2, r3, r4)} --それぞれ半径のサイズ
    local drawtf = {1, 1, 1, 1} --個別描画T/F
    local p = { --[[四つ角の円の中心寄りの頂点の座標{x, y}]]
        {w/-2 + r[1], h/-2 + r[1]},
        {w/2 - r[2], h/-2 + r[2]},
        {w/2 - r[3], h/2 - r[3]},
        {w/-2 + r[4], h/2 - r[4]}
    }

    if math.min(w, h) > 0.5 and linew > 0 then --仮想バッファサイズが0.5以下だとバグるからそれの対策
        obj.setoption('drawtarget', 'tempbuffer', w, h)
            --円描画
            if r[5] > 0 then
                if r[5] == r[6] then --同一サイズ
                    obj.load('figure', "円", color, r[5]*2, linew)
                    local R = r[5]*2
                    if w == h and r[1] + r[2] + r[3] + r[4] == w*2 then
                        --完全なる円
                        obj.draw()
                    else
                        --順に左上、右上、右下、左下
                        obj.drawpoly(w/-2, h/-2, 0, w/-2 + r[5], h/-2, 0, w/-2 + r[5], h/-2 + r[5], 0, w/-2, h/-2 + r[5], 0,--[[範囲->]] 0, 0, r[5], 0, r[5], r[5], 0, r[5])
                        obj.drawpoly(w/2 - r[5], h/-2, 0, w/2, h/-2, 0, w/2, h/-2 + r[5], 0, w/2 - r[5], h/-2 + r[5], 0,--[[範囲->]] r[5], 0, R, 0, R, r[5], r[5], r[5])
                        obj.drawpoly(w/2 - r[5], h/2 - r[5], 0, w/2, h/2 - r[5], 0, w/2, h/2, 0, w/2 - r[5], h/2, 0,--[[範囲->]] r[5], r[5], R, r[5], R, R, r[5], R)
                        obj.drawpoly(w/-2, h/2 - r[5], 0, w/-2 + r[5], h/2 - r[5], 0, w/-2 + r[5], h/2, 0, w/-2, h/2, 0,--[[範囲->]] 0, r[5], r[5], r[5], r[5], R, 0, R)
                    end
                else --個別に図形読み込み&描画
                    --順に左上、右上、右下、左下
                    local R = {}
                    if r[1] > 0 then
                        R[1] = r[1]*2
                        obj.load('figure', "円", color, R[1], linew)
                        obj.drawpoly(w/-2, h/-2, 0, w/-2 + r[1], h/-2, 0, w/-2 + r[1], h/-2 + r[1], 0, w/-2, h/-2 + r[1], 0,--[[範囲->]] 0, 0, r[1], 0, r[1], r[1], 0, r[1])
                    end
                    if r[2] > 0 then
                        R[2] = r[2]*2
                        obj.load('figure', "円", color, R[2], linew)
                        obj.drawpoly(w/2 - r[2], h/-2, 0, w/2, h/-2, 0, w/2, h/-2 + r[2], 0, w/2 - r[2], h/-2 + r[2], 0,--[[範囲->]] r[2], 0, R[2], 0, R[2], r[2], r[2], r[2])
                    end
                    if r[3] > 0 then
                        R[3] = r[3]*2
                        obj.load('figure', "円", color, R[3], linew)
                        obj.drawpoly(w/2 - r[3], h/2 - r[3], 0, w/2, h/2 - r[3], 0, w/2, h/2, 0, w/2 - r[3], h/2, 0,--[[範囲->]] r[3], r[3], R[3], r[3], R[3], R[3], r[3], R[3])
                    end
                    if r[4] > 0 then
                        R[4] = r[4]*2
                        obj.load('figure', "円", color, R[4], linew)
                        obj.drawpoly(w/-2, h/2 - r[4], 0, w/-2 + r[4], h/2 - r[4], 0, w/-2 + r[4], h/2, 0, w/-2, h/2, 0,--[[範囲->]] 0, r[4], r[4], r[4], r[4], R[4], 0, R[4])
                    end
                end
            end

            --四角形描画(ライン幅含めて一括で)
            if w ~= h or r[1] + r[2] + r[3] + r[4] ~= w*2 then
                obj.setoption('blend', 'alpha_add')
                    if r[5] == r[6] then --同一サイズ
                        --縦
                        if r[5]*2 < w then
                            obj.load("figure", "円", color, h, linew)
                            obj.drawpoly(w/-2 + r[5], h/-2, 0, w/2 - r[5], h/-2, 0, w/2 - r[5], h/2, 0, w/-2 + r[5], h/2, 0,--[[範囲->]] h/2, 0, h/2, 0, h/2, h, h/2, h)
                        end
                        --横
                        if r[5]*2 < h then
                            obj.load('figure', "円", color, w, linew)
                            obj.drawpoly(w/-2, h/-2 + r[5], 0, w/2, h/-2 + r[5], 0, w/2, h/2 - r[5], 0, w/-2, h/2 - r[5], 0,--[[範囲->]] 0, w/2, w, w/2, w, w/2, 0, w/2)
                        end
                    else --個別に描画
                        --上、下
                        obj.load('figure', "円", color, h, linew)
                        if r[1] + r[2] < w then obj.drawpoly(w/-2 + r[1], h/-2, 0, w/2 - r[2], h/-2, 0, w/2 - r[2], 0, 0, w/-2 + r[1], 0, 0,--[[範囲->]] h/2, 0, h/2, 0, h/2, h/2, h/2, h/2) end
                        if r[3] + r[4] < w then obj.drawpoly(w/-2 + r[4], 0, 0, w/2 - r[3], 0, 0, w/2 - r[3], h/2, 0, w/-2 + r[4], h/2, 0,--[[範囲->]] h/2, h/2, h/2, h/2, h/2, h, h/2, h) end
                        --右、左
                        obj.load('figure', "円", color, w, linew)
                        if r[2] + r[3] < h then obj.drawpoly(0, h/-2 + r[2], 0, w/2, h/-2 + r[2], 0, w/2, h/2 - r[3], 0, 0, h/2 - r[3], 0,--[[範囲->]] w/2, w/2, w, w/2, w, w/2, w/2, w/2) end
                        if r[1] + r[4] < h then obj.drawpoly(w/-2, h/-2 + r[1], 0, 0, h/-2 + r[1], 0, 0, h/2 - r[4], 0, w/-2, h/2 - r[4], 0,--[[範囲->]] 0, w/2, w/2, w/2, w/2, w/2, 0, w/2) end
                    end
                obj.setoption('blend', 0)
            end

        obj.setoption('drawtarget', 'framebuffer')
    else
        --仮想バッファサイズが0.5以下orライン幅0のとき
        obj.setoption('drawtarget', 'tempbuffer', 10, 10)
        obj.setoption('drawtarget', 'framebuffer')
    end

    obj.load('tempbuffer')

    return
end

--return
return {
    draw = draw,
}

--[[
P.S.
本家とは違って四つ角個別で調整できるようにしてるからその分若干計算量が増えてて、
その分処理が重たくならないよう(バグ防止の為でもある)に条件分岐書きまくって(?)なんちゃって軽量化してるんだけど、
分量が本家に比べて倍増してるし、これが本当に効果あるのかは分からない...(´・ω・`)
(あと一部きったねぇコードになってるのは内緒)
]]