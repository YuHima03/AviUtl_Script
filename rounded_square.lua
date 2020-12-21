--[[
///////////////////////////////////
===================================
>>> �p�ێl�p�`plus_v2(obj/anm)�p <<<
===================================
///////////////////////////////////
]]

--main_function
local function draw(w, h, linew, color, r1, r2, r3, r4, opt)
    local r = {r1, r2, r3, r4, math.max(r1, r2, r3, r4), math.min(r1, r2, r3, r4)} --���ꂼ�ꔼ�a�̃T�C�Y
    local drawtf = {1, 1, 1, 1} --�ʕ`��T/F
    local p = { --[[�l�p�̉~�̒��S���̒��_�̍��W{x, y}]]
        {w/-2 + r[1], h/-2 + r[1]},
        {w/2 - r[2], h/-2 + r[2]},
        {w/2 - r[3], h/2 - r[3]},
        {w/-2 + r[4], h/2 - r[4]}
    }

    if math.min(w, h) > 0.5 and linew > 0 then --���z�o�b�t�@�T�C�Y��0.5�ȉ����ƃo�O�邩�炻��̑΍�
        obj.setoption('drawtarget', 'tempbuffer', w, h)
            --�~�`��
            if r[5] > 0 then
                if r[5] == r[6] then --����T�C�Y
                    obj.load('figure', "�~", color, r[5]*2, linew)
                    local R = r[5]*2
                    if w == h and r[1] + r[2] + r[3] + r[4] == w*2 then
                        --���S�Ȃ�~
                        obj.draw()
                    else
                        --���ɍ���A�E��A�E���A����
                        obj.drawpoly(w/-2, h/-2, 0, w/-2 + r[5], h/-2, 0, w/-2 + r[5], h/-2 + r[5], 0, w/-2, h/-2 + r[5], 0,--[[�͈�->]] 0, 0, r[5], 0, r[5], r[5], 0, r[5])
                        obj.drawpoly(w/2 - r[5], h/-2, 0, w/2, h/-2, 0, w/2, h/-2 + r[5], 0, w/2 - r[5], h/-2 + r[5], 0,--[[�͈�->]] r[5], 0, R, 0, R, r[5], r[5], r[5])
                        obj.drawpoly(w/2 - r[5], h/2 - r[5], 0, w/2, h/2 - r[5], 0, w/2, h/2, 0, w/2 - r[5], h/2, 0,--[[�͈�->]] r[5], r[5], R, r[5], R, R, r[5], R)
                        obj.drawpoly(w/-2, h/2 - r[5], 0, w/-2 + r[5], h/2 - r[5], 0, w/-2 + r[5], h/2, 0, w/-2, h/2, 0,--[[�͈�->]] 0, r[5], r[5], r[5], r[5], R, 0, R)
                    end
                else --�ʂɐ}�`�ǂݍ���&�`��
                    --���ɍ���A�E��A�E���A����
                    local R = {}
                    if r[1] > 0 then
                        R[1] = r[1]*2
                        obj.load('figure', "�~", color, R[1], linew)
                        obj.drawpoly(w/-2, h/-2, 0, w/-2 + r[1], h/-2, 0, w/-2 + r[1], h/-2 + r[1], 0, w/-2, h/-2 + r[1], 0,--[[�͈�->]] 0, 0, r[1], 0, r[1], r[1], 0, r[1])
                    end
                    if r[2] > 0 then
                        R[2] = r[2]*2
                        obj.load('figure', "�~", color, R[2], linew)
                        obj.drawpoly(w/2 - r[2], h/-2, 0, w/2, h/-2, 0, w/2, h/-2 + r[2], 0, w/2 - r[2], h/-2 + r[2], 0,--[[�͈�->]] r[2], 0, R[2], 0, R[2], r[2], r[2], r[2])
                    end
                    if r[3] > 0 then
                        R[3] = r[3]*2
                        obj.load('figure', "�~", color, R[3], linew)
                        obj.drawpoly(w/2 - r[3], h/2 - r[3], 0, w/2, h/2 - r[3], 0, w/2, h/2, 0, w/2 - r[3], h/2, 0,--[[�͈�->]] r[3], r[3], R[3], r[3], R[3], R[3], r[3], R[3])
                    end
                    if r[4] > 0 then
                        R[4] = r[4]*2
                        obj.load('figure', "�~", color, R[4], linew)
                        obj.drawpoly(w/-2, h/2 - r[4], 0, w/-2 + r[4], h/2 - r[4], 0, w/-2 + r[4], h/2, 0, w/-2, h/2, 0,--[[�͈�->]] 0, r[4], r[4], r[4], r[4], R[4], 0, R[4])
                    end
                end
            end

            --�l�p�`�`��(���C�����܂߂Ĉꊇ��)
            if w ~= h or r[1] + r[2] + r[3] + r[4] ~= w*2 then
                obj.setoption('blend', 'alpha_add')
                    if r[5] == r[6] then --����T�C�Y
                        --�c
                        if r[5]*2 < w then
                            obj.load("figure", "�~", color, h, linew)
                            obj.drawpoly(w/-2 + r[5], h/-2, 0, w/2 - r[5], h/-2, 0, w/2 - r[5], h/2, 0, w/-2 + r[5], h/2, 0,--[[�͈�->]] h/2, 0, h/2, 0, h/2, h, h/2, h)
                        end
                        --��
                        if r[5]*2 < h then
                            obj.load('figure', "�~", color, w, linew)
                            obj.drawpoly(w/-2, h/-2 + r[5], 0, w/2, h/-2 + r[5], 0, w/2, h/2 - r[5], 0, w/-2, h/2 - r[5], 0,--[[�͈�->]] 0, w/2, w, w/2, w, w/2, 0, w/2)
                        end
                    else --�ʂɕ`��
                        --��A��
                        obj.load('figure', "�~", color, h, linew)
                        if r[1] + r[2] < w then obj.drawpoly(w/-2 + r[1], h/-2, 0, w/2 - r[2], h/-2, 0, w/2 - r[2], 0, 0, w/-2 + r[1], 0, 0,--[[�͈�->]] h/2, 0, h/2, 0, h/2, h/2, h/2, h/2) end
                        if r[3] + r[4] < w then obj.drawpoly(w/-2 + r[4], 0, 0, w/2 - r[3], 0, 0, w/2 - r[3], h/2, 0, w/-2 + r[4], h/2, 0,--[[�͈�->]] h/2, h/2, h/2, h/2, h/2, h, h/2, h) end
                        --�E�A��
                        obj.load('figure', "�~", color, w, linew)
                        if r[2] + r[3] < h then obj.drawpoly(0, h/-2 + r[2], 0, w/2, h/-2 + r[2], 0, w/2, h/2 - r[3], 0, 0, h/2 - r[3], 0,--[[�͈�->]] w/2, w/2, w, w/2, w, w/2, w/2, w/2) end
                        if r[1] + r[4] < h then obj.drawpoly(w/-2, h/-2 + r[1], 0, 0, h/-2 + r[1], 0, 0, h/2 - r[4], 0, w/-2, h/2 - r[4], 0,--[[�͈�->]] 0, w/2, w/2, w/2, w/2, w/2, 0, w/2) end
                    end
                obj.setoption('blend', 0)
            end

        obj.setoption('drawtarget', 'framebuffer')
    else
        --���z�o�b�t�@�T�C�Y��0.5�ȉ�or���C����0�̂Ƃ�
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
�{�ƂƂ͈���Ďl�p�ʂŒ����ł���悤�ɂ��Ă邩�炻�̕��኱�v�Z�ʂ������ĂāA
���̕��������d�����Ȃ�Ȃ��悤(�o�O�h�~�ׂ̈ł�����)�ɏ������򏑂��܂�����(?)�Ȃ񂿂���Čy�ʉ����Ă�񂾂��ǁA
���ʂ��{�Ƃɔ�ׂĔ{�����Ă邵�A���ꂪ�{���Ɍ��ʂ���̂��͕�����Ȃ�...(�L�E�ցE`)
(���ƈꕔ�������˂��R�[�h�ɂȂ��Ă�͓̂���)
]]