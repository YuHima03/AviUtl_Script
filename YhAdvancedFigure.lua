--[[

AviUtl�X�N���v�g�uYh�g���}�`�v��uYh�g���}�X�N�v�Ŏg���֐��Q�ł�
(�����̂�[�Ђ܍�̃X�N���v�g�ł��K�v�ƂȂ�ꍇ������܂�)

���̃X�N���v�g������Ăяo���܂�
�F�X�ȏڍׂȐݒ���p�ӂ��Ă܂�(���̏��ׂł����ԕ�����h���ł���...)

==< �������̓ǂݕ� >==
�ϐ��� -> �ϐ��̌^ (����) (�����l) ��
    ���F��̂�Ɋւ��钍�߂���������Ȃ�������

]]

local function Draw(...) -- �}�`�̕`�� Draw( {�`��I�v�V����...}, �}�`�̎��, �F, ��, ����, ���C����, {�}�`���Ƃ̃I�v�V����...} )
    --[[
    ===< �`��I�v�V�����̐ݒ� >===
    >> �e�[�u���𗘗p���Ĉȉ��̂悤�ɋL�q���Ă�������(�����l���p�ӂ���Ă���̂őS�ĕK�{�ł͂���܂���)
        { �v�f��1 = �l, �v�f��2 = �l, ...}

    >> �e�v�f�̐����͈ȉ��̒ʂ�ł� (boolean�̏ꍇ�A��{�I�ɂ� �utrue�ŗL���Afalse�Ŗ����v �ł�)
        << �`��I�v�V���� >>
            --��{�ݒ�---------------
            intempbuffer -> boolean (false) (���z�o�b�t�@�̒��ł��̊֐������s����ۂ͒l��true��) ���d�v���ڂł�
            loadonly -> boolean (true) (obj.draw�͎��s�����Aobj.load�̂ݎ��s���܂�) ���d�v���ڂł�
            defaultblend -> number/string (0) (���̊֐��̎��s��ɃZ�b�g����鍇�����[�h) ���d�v���ڂł�
            antialias -> boolean (false) (�A���`�G�C���A�X�̗L��) ���g�p����Ɠ�̃��C���������P�����ꍇ����
            --�`��Ɋւ��ݒ�---------------

        << �}�`���Ƃ̃I�v�V���� >>
            --�~---------------
            around -> number (1) (���ӂ̕`��̐i���) ��0~1�Őݒ�(����)
            --�l�p�`---------------
            around -> number (1) (���ӂ̕`��̐i���) ��0~1�Őݒ�(����)

    ]]

    local arg = {...} or {}

    if #arg >= 5  and type(arg[1]) == 'table' then
        --�f�[�^�ۑ�
        local GDATA = YhAFig_OPT or {}
        local rounded = GDATA.rounded or { 0, 0, 0, 0 } --�p�ۃI�v�V����
        local DOPT = { --�`��I�v�V����
            --��{�ݒ�
            intempbuffer = arg[1].tempbuffer or false,
            loadonly = arg[1].loadonly or true,
            defaultblend = tonumber(arg[1].defaultblend) or 0,
            antialias = arg[1].antialias or false,
            --�`��Ɋւ��ݒ�
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
            zoom = arg[1].zoom or 1,
        }
        local FIG = tostring(arg[2]) -- �}�`��
        local COL = tonumber(arg[3]) -- �F
        local SIZE = { --�T�C�Y
            tonumber(arg[4]), --��
            tonumber(arg[5]), --����
            w = tonumber(arg[4]), --��
            h = tonumber(arg[5]), --����
            max = tonumber(math.max(arg[4], arg[5])), --������
            min = tonumber(math.min(arg[4], arg[5])) --�Z����
        }
        local LINEW = tonumber(arg[6]) -- ���C����
        local FOPT --�}�`���Ƃ̃I�v�V����
        arg[7] = arg[7] or {}

        --�O���[�o���ϐ�������
        YhAFig_OPT = nil

        --�S���Ŏg�������ȕϐ���
        local p = {
            SIZE.w/2, SIZE.w/-2,
            SIZE.h/2, SIZE.h/-2
        }

        --[[
        ////////////////
        ///// MAIN /////
        ////////////////
        ]]

        --[[
        ==================================================
        /// ���z�o�b�t�@�������� ///
        ]]
        if DOPT.intempbuffer == false then
            obj.setoption('drawtarget', 'tempbuffer', math.max(SIZE[1], 0.6), math.max(SIZE[2], 0.6))
        end

        if FIG == '�~' then
            FOPT = {
                --���ӂ̐ݒ�
                around = arg[7].around or 1,
            }

            --[[/// �`�揈���������� ///]]
            if SIZE.min > 0.5 then
                --��{�̉~
                obj.load('figure', "�~", COL, SIZE.max)
                obj.drawpoly(p[2], p[4], 0, p[1], p[4], 0, p[1], p[3], 0, p[2], p[3], 0)
                --���C����
                if LINEW < SIZE.min / 2 then
                    obj.setoption('blend', 'alpha_sub', 'force')
                        obj.drawpoly(p[2] + LINEW, p[4] + LINEW, 0, p[1] - LINEW, p[4] + LINEW, 0, p[1] - LINEW, p[3] - LINEW, 0, p[2] + LINEW, p[3] - LINEW, 0)
                    obj.setoption('blend', DOPT.defaultblend, 'force')
                end
            end
            --[[/// �`�揈�������܂� ///]]
        elseif FIG == '�g���~' then
        elseif FIG == '����' then
            FOPT = {
                length = arg[7].length or 100, --����(%)
                criteria = arg[7].criteria or 0 --�
            }

            --[[/// �`�揈���������� ///]]
            if SIZE.min > 0.5 then
                obj.load('figure', "�l�p�`", COL, 10)
                obj.drawpoly(p[2], p[4], 0, p[1], p[4], 0, p[1], p[3], 0, p[2], p[3], 0)
            end
            --[[/// �`�揈�������܂� ///]]
        elseif FIG == '�l�p�`' then
            FOPT = {
                --���ӂ̐ݒ�
                around = arg[7].around or 1,
                around_startp = arg[7].around_startp or 0,
                around_epcircle = arg[7].around_epcircle or 0
            }

            --[[/// �`�揈���������� ///]]
            if SIZE.min > 0.5 then
                --��{�̎l�p�`
                obj.load('figure', '�l�p�`', COL, 10)
                obj.drawpoly(p[2], p[4], 0, p[1], p[4], 0, p[1], p[3], 0, p[2], p[3], 0)
                --���C����
                if LINEW < SIZE.min / 2 then
                    obj.setoption('blend', 'alpha_sub', 'force')
                        obj.drawpoly(p[2] + LINEW, p[4] + LINEW, 0, p[1] - LINEW, p[4] + LINEW, 0, p[1] - LINEW, p[3] - LINEW, 0, p[2] + LINEW, p[3] - LINEW, 0)
                    obj.setoption('blend', DOPT.defaultblend, 'force')
                end
                --����
                if FOPT.around < 1 then
                end
            end
            --[[/// �`�揈�������܂� ///]]
        end

        --[[
        /// ���z�o�b�t�@�����܂� ///
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