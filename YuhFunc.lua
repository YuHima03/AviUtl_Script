--[[
これは自分用に作った関数群
いちいち考えるのも面倒だからね...

memo：そのスクリプトで使う分だけ切り取って適当にluaファイルorスクリプト自体にぶち込めばおｋ

]]

local obj = {}  --エラーはかないようにしとく

--[[
////////////
/// Math ///
////////////
]]
local function SimplifiedNum(num, radix)    --numを0~radixに収める(例：540を0~360に収めると180を返す、角度計算等に使える)
    if radix == 0 then return -1 end
    local result = math.abs(num % radix);
    if radix < 0 then result = result * -1 end
    return result;
end

--[[
////////////////
/// Position ///
////////////////
※三角比関係多め
]]
local function GetLenBet2P(pos1x, pos1y, pos2x, pos2y) --2点間の距離(2D)
    return math.pow(math.pow(math.abs(pos1x - pos2x),2) + math.pow(math.abs(pos1y - pos2y),2),1/2);
end

local function GetLenBet2P3D(pos1x, pos1y, pos1z, pos2x, pos2y, pos2z) --2点間の距離(3D)
    return math.pow(math.pow(math.abs(pos1x - pos2x),2) + math.pow(math.abs(pos1y - pos2y),2) + math.pow(math.abs(pos1z - pos2z),2),1/2);
end

local function GetTanfrom2P(pos1x, pos1y, pos2x, pos2y) --2点の座標からタンジェントを得る
    return (pos2y - pos1y) / (pos2x - pos1x);
end

local function PostoAngle(pos1x, pos1y, pos2x, pos2y, criterion--[[基準にする点(1or2)]]) --2点間に直線を描いた時の基準点から見た直線の角度
    local len = GetLenBet2P(pos1x, pos1y, pos2x, pos2y);
    if criterion == nil then criterion = 0 end
    local result = math.deg(math.atan(GetTanfrom2P(pos1x, pos1y, pos2x, pos2y)))
    return result;
end

local function LenandAngleto2Pos(len, angle) --(x,y)=(0,0)を基準としたときに長さと角度から直線の2点
    local r = math.rad(angle);
    local x1 = math.cos(r) * len;
    local y1 = math.sin(r) * len;
    return x1, y1, -x1, -y1;
end

--[[
//////////////
/// Figure ///
//////////////
]]
local function GetRatio(w, h) --縦横比
    local ratio = 0;
    if w == h then
        ratio = 0;
    elseif w > h then
        ratio = 100 * ((h / w) - 1);
    else
        ratio = 100 * (1 - (w / h));
    end
    return ratio;
end

--[[
//////////////////////////////
/// Using AviUtl Functions ///
//////////////////////////////    
]]
local function loadline(w,h,col)    --直線描画
    obj.load('figure',"四角形",col,math.max(w,h))
    obj.effect("マスク",'type',2,"サイズ",math.max(w,h),"縦横比",GetRatio(w,h));
end

--[[
//////////////
/// Return ///
//////////////
]]
return {
    SimplifiedNum = SimplifiedNum,
    GetLenBet2P = GetLenBet2P,
    GetLenBet2P3D = GetLenBet2P3D,
    LenandAngleto2Pos = LenandAngleto2Pos,
    GetTanfrom2P = GetTanfrom2P,
    GetRatio = GetRatio,
    PostoAngle = PostoAngle,
    loadline = loadline,
}