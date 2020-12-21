--[[
����͎����p�ɍ�����֐��Q
���������l����̂��ʓ|�������...

memo�F���̃X�N���v�g�Ŏg���������؂����ēK����lua�t�@�C��or�X�N���v�g���̂ɂԂ����߂΂���

]]

local obj = {}  --�G���[�͂��Ȃ��悤�ɂ��Ƃ�

--[[
////////////
/// Math ///
////////////
]]
local function SimplifiedNum(num, radix)    --num��0~radix�Ɏ��߂�(��F540��0~360�Ɏ��߂��180��Ԃ��A�p�x�v�Z���Ɏg����)
    if radix == 0 then return -1 end
    local result = math.abs(num % radix);
    if radix < 0 then result = result * -1 end
    return result;
end

--[[
////////////////
/// Position ///
////////////////
���O�p��֌W����
]]
local function GetLenBet2P(pos1x, pos1y, pos2x, pos2y) --2�_�Ԃ̋���(2D)
    return math.pow(math.pow(math.abs(pos1x - pos2x),2) + math.pow(math.abs(pos1y - pos2y),2),1/2);
end

local function GetLenBet2P3D(pos1x, pos1y, pos1z, pos2x, pos2y, pos2z) --2�_�Ԃ̋���(3D)
    return math.pow(math.pow(math.abs(pos1x - pos2x),2) + math.pow(math.abs(pos1y - pos2y),2) + math.pow(math.abs(pos1z - pos2z),2),1/2);
end

local function GetTanfrom2P(pos1x, pos1y, pos2x, pos2y) --2�_�̍��W����^���W�F���g�𓾂�
    return (pos2y - pos1y) / (pos2x - pos1x);
end

local function PostoAngle(pos1x, pos1y, pos2x, pos2y, criterion--[[��ɂ���_(1or2)]]) --2�_�Ԃɒ�����`�������̊�_���猩�������̊p�x
    local len = GetLenBet2P(pos1x, pos1y, pos2x, pos2y);
    if criterion == nil then criterion = 0 end
    local result = math.deg(math.atan(GetTanfrom2P(pos1x, pos1y, pos2x, pos2y)))
    return result;
end

local function LenandAngleto2Pos(len, angle) --(x,y)=(0,0)����Ƃ����Ƃ��ɒ����Ɗp�x���璼����2�_
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
local function GetRatio(w, h) --�c����
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
local function loadline(w,h,col)    --�����`��
    obj.load('figure',"�l�p�`",col,math.max(w,h))
    obj.effect("�}�X�N",'type',2,"�T�C�Y",math.max(w,h),"�c����",GetRatio(w,h));
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