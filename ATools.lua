--�������
goto hidden
goto visible
function _()
    (""):�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()
    (""):�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()
    (""):�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()
    (""):�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()
    (""):�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()():�()
end
::visible::
--����� � ������
script_author("Coder,Alex")
script_version('0.1.2')
::hidden::
--����������
require "lib.moonloader"
require 'lib.sampfuncs'
local requests = require 'requests' -- ��� �������� �����
local memory = require 'memory' -- ��� �����
local imgui = require 'imgui' -- GUI
local bNotf, notf = pcall(import, "imgui_notf.lua") -- ��� �����������
local flags = require 'moonloader'.font_flag -- �����
local key = require 'vkeys' -- �������
local encoding = require 'encoding' -- ��� ����
local inicfg = require 'inicfg' -- ��� ��������
local imadd = require 'imgui_addons'
imgui.HotKey = require 'imgui_addons'.HotKey -- ��� ������)
local sampev = require 'lib.samp.events' -- samp event
local v = require 'semver' -- ��� ������
local ffi = require 'ffi'
local dlstatus = require('moonloader').download_status -- ����� ������ ��������
local wm = require('lib.windows.message')
encoding.default = 'CP1251' -- ������ ���������
u8 = encoding.UTF8 -- ������� ��������� � UTF8 ��� ����
--�������� ����� � ���������� �����
if not doesDirectoryExist('moonloader/config/AdminTools') then createDirectory('moonloader/config/AdminTools') end
if doesFileExist("moonloader/config/AdminTools/c7iko6k.png") then
    png = imgui.CreateTextureFromFile(getGameDirectory().. "/moonloader/config/AdminTools/c7iko6k.png")
else
    downloadUrlToFile("https://i.imgur.com/c7iko6k.png", "moonloader/config/AdminTools/c7iko6k.png", function(id, status, p1, p2)
        if status == dlstatus.STATUS_ENDDOWNLOADDATA then
            png = imgui.CreateTextureFromFile(getGameDirectory().. "/moonloader/config/AdminTools/c7iko6k.png")
        end
    end)
end
--������
local mainini = inicfg.load({
	data =
	{
		key = false
	},
    config =
    {
        jail = false,
        sban = false,
        ban = false,
        skick = false,
		kick = false,
        warn = false,
        mute = false,
        report = false,
        esc = false,
        chat = false,
        secondaryKey = "VK_N",
        messagesMax = "150",
        pagesize = "13",
        adminpassACT = false,
        adminpass = "123",
        adminzonea = false,
        adminzone = "az",
        JailText = u8"",
        sBanText = u8"",
        BanText = u8"",
        sKickText = u8"",
		KickText = u8"",
        WarnText = u8"",
        MuteText = u8"",
        wh = false,
        clickwarp = false,
        godmode = false,
        did = 0,
        debug = false,
        blacklist = {
            '�� ����� %d+:%d+',
            '�� ����� %d+ ���.',
            '+%d hp'
        }
    },
    status = 
    {
        sban = 0,
        ban = 0,
        skick = 0,
        kick = 0,
        report = 0,
        warn = 0,
        jail = 0,
        mute = 0,
    },
    statTimers = 
    {
        report= true,
        ban = true,
        sban = true,
        kick = true,
        skick = true,
        jail = true,
        mute = true,
    	state = true,
    	clock = true,
    	sesOnline = true,
    	sesAfk = true,
    	sesFull = true,
  		dayOnline = true,
  		dayAfk = true,
  		dayFull = true,
  		weekOnline = true,
  		weekAfk = true,
  		weekFull = true,
        server = nil
    },
    onDay = 
    {
		today = os.date("%a"),
		online = 0,
		afk = 0,
		full = 0
	},
    onWeek = 
    {
		week = 1,
		online = 0,
		afk = 0,
		full = 0
	},
    myWeekOnline = 
    {
        [0] = 0,
        [1] = 0,
        [2] = 0,
        [3] = 0,
        [4] = 0,
        [5] = 0,
        [6] = 0
    },
    pos = 
    {
        x = 0,
        y = 0
    },
    cpos = 
    {
        x = 20,
        y = 20
    },
    style = 
    {
    	round = 10.0,
    	colorW = 4279834905,
    	colorT = 4286677377
    },
    settings = 
    {
        alwaysAutoCheckUpdates          = true,
        notificationsAboutJoinsAndQuits = true,
        hideOnScreenshot                = false,
        hideOnOpenChat                  = false,
        listFontName                    = 'Arial',
        listFontSize                    = 9,
        listFontFlags                   = 5,
        headerFontName                  = 'Arial',
        headerFontSize                  = 9,
        headerFontColor                 = 0xFFFFFFFF,
        headerFontFlags                 = 5,
        headerText                      = 'Users online',
        headerPosX                      = 450,
        headerPosY                      = 450,
        renderHotKey                    = {v={0x71}},
        renderHotKeyType                = 0,
        isRenderEnabledByDefault        = false,
        renderTime                      = 3000,
        renderID                        = true,
        renderLevel                     = true,
    },
    lists = 
    {
        {
            isbuiltin = true,
            title     = 'Common',
            ip        = '127.0.0.1',
            port      = 7777,
            color     = 0xFFFFFFFF,
            users     = {'West_Side', 'Drop_Table'},
        },
    },
}, "AdminTools/AdminTools")
--�������� �� ������ ���� ���� �� ������
local status = inicfg.load(mainini, 'AdminTools/AdminTools.ini')
if not doesFileExist('moonloader/config/AdminTools/AdminTools.ini') then inicfg.save(mainini, 'AdminTools/AdminTools.ini') end
--�������
key = imgui.ImBool(false)
secondaryKey = imgui.ImBuffer('' .. mainini.config.secondaryKey,4)
chat = imgui.ImBool(mainini.config.chat)
messagesMax = imgui.ImBuffer('' .. mainini.config.messagesMax, 256)
pagesize = imgui.ImBuffer('' .. mainini.config.pagesize, 256)
jail = imgui.ImBool(mainini.config.jail)
sban = imgui.ImBool(mainini.config.sban)
ban = imgui.ImBool(mainini.config.ban)
skick = imgui.ImBool(mainini.config.skick)
kick = imgui.ImBool(mainini.config.kick)
warn = imgui.ImBool(mainini.config.warn)
mute = imgui.ImBool(mainini.config.mute)
report = imgui.ImBool(mainini.config.report)
wh = imgui.ImBool(mainini.config.wh)
esc = imgui.ImBool(mainini.config.esc)
godmode = imgui.ImBool(mainini.config.godmode)
clickwarp = imgui.ImBool(mainini.config.clickwarp)
adminpassACT = imgui.ImBool(mainini.config.adminpassACT)
adminzonea = imgui.ImBool(mainini.config.adminzonea)
debug = imgui.ImBool(mainini.config.debug)
did = imgui.ImBuffer(mainini.config.did)
adminpass = imgui.ImBuffer(''.. mainini.config.adminpass, 20)
adminzone = imgui.ImBuffer(''.. mainini.config.adminzone, 20)
JailText = imgui.ImBuffer(u8''.. mainini.config.JailText, 256)
jstat = imgui.ImBuffer(''..mainini.status.jail, 999)
sBanText = imgui.ImBuffer(u8''.. mainini.config.BanText, 256)
sbstat = imgui.ImBuffer(''..mainini.status.sban, 999)
BanText = imgui.ImBuffer(u8''.. mainini.config.BanText, 256)
bstat = imgui.ImBuffer(''.. mainini.status.ban, 999)
sKickText = imgui.ImBuffer(u8''.. mainini.config.sKickText, 256)
skstat = imgui.ImBuffer(''..mainini.status.skick, 999)
KickText = imgui.ImBuffer(u8''.. mainini.config.KickText, 256)
kstat = imgui.ImBuffer(''..mainini.status.kick, 999)
WarnText = imgui.ImBuffer(u8''.. mainini.config.WarnText, 256)
wstat = imgui.ImBuffer(''..mainini.status.warn, 999)
MuteText = imgui.ImBuffer(u8''.. mainini.config.MuteText, 256)
mstat = imgui.ImBuffer(''..mainini.status.mute, 999)
ReportText = imgui.ImBuffer(2560)
rstat = imgui.ImBuffer(''..mainini.status.report, 999)
ReportTextOtvet = imgui.ImBuffer(2560)
active_menu = imgui.ImBool(false)
--���
local logText = {} -- ����� ��� �����
local logFilter = imgui.ImBuffer(128) -- ������������ �����
local clearlog = false -- ������� ������
local copylog = false -- ���������� �����
local testlog = false -- ���� ����
local savee = "AdminTools/AdminTools.ini" -- ���������� �����
-- ����������
mcx = 0x0087FF
local sX, sY = getScreenResolution() -- ����� ���������� ������ � ����
local tag = '* {0087FF}ATools: {FFFFFF}' --�������� � ����
local bindID = 0
local loadedUsers = {}
local onlineUsers = {}
local tempBuffers = {}
local to = imgui.ImBool(mainini.statTimers.state) -- ������ ����� � ������
local nowTime = os.date("%H:%M:%S", os.time()) -- ����� ����
local pos = false -- ��� ��������� ����� �������
local restart = false -- ������� �������
local recon = false -- �������� ���� � recon
local sesOnline = imgui.ImInt(0) -- ������ � �������
local sesAfk = imgui.ImInt(0) -- ������ � ����
local sesFull = imgui.ImInt(0) -- ������ ������
local dayFull = imgui.ImInt(mainini.onDay.full) -- ������ ������� �� ����
local weekFull = imgui.ImInt(mainini.onWeek.full) -- ������ ������� �� ������
local sRound = imgui.ImFloat(mainini.style.round) --
local argbW = mainini.style.colorW -- ���� ��� �������
local argbT = mainini.style.colorT -- ���� ��� �������
local colorW = imgui.ImFloat4(imgui.ImColor(argbW):GetFloat4()) -- �������� ���� �������
local colorT = imgui.ImFloat4(imgui.ImColor(argbT):GetFloat4()) -- �������� ���� �������
local posX, posY = mainini.pos.x, mainini.pos.y -- Pos x, Pos y ��� �������
local cposX, �posY = mainini.cpos.x, mainini.cpos.y -- Pos x, Pos y ��� ���������� ���� 
local listFontNameBuffer = imgui.ImBuffer('Arial', 256)
local listFontSizeBuffer = imgui.ImInt(9)
local listFontFlags = 5
local headerFontNameBuffer = imgui.ImBuffer('Arial', 256)
local headerFontSizeBuffer = imgui.ImInt(9)
local headerFontFlags = 5
local headerFontColorBuffer = imgui.ImFloat3(1, 1, 1)
local headerTextBuffer = imgui.ImBuffer('Users online', 32)
local headerPosXBuffer = imgui.ImInt(450)
local headerPosYBuffer = imgui.ImInt(450)
local headerFont = renderCreateFont('Arial', 9, 5)
local listFont = renderCreateFont('Arial', 9, 5)
local renderTimeBuffer = imgui.ImInt(3000)
local selectedTab           = 0
local selectedList          = 0
local movingInProgress      = false
local hasToggled            = false
-- ����� ��� �������
local Radio = {
	['clock'] = mainini.statTimers.clock,
	['sesOnline'] = mainini.statTimers.sesOnline,
	['sesAfk'] = mainini.statTimers.sesAfk,
	['sesFull'] = mainini.statTimers.sesFull,
	['dayOnline'] = mainini.statTimers.dayOnline,
	['dayAfk'] = mainini.statTimers.dayAfk,
	['dayFull'] = mainini.statTimers.dayFull,
	['weekOnline'] = mainini.statTimers.weekOnline,
	['weekAfk'] = mainini.statTimers.weekAfk,
    ['weekFull'] = mainini.statTimers.weekFull,
    ['report'] = mainini.statTimers.report,
    ['ban'] = mainini.statTimers.ban,
    ['sban'] = mainini.statTimers.sban,
    ['kick'] = mainini.statTimers.kick,
    ['skick'] = mainini.statTimers.skick,
    ['jail'] = mainini.statTimers.jail,
    ['mute'] = mainini.statTimers.mute
}
-- ��� ������
local tWeekdays = {
    [0] = '�����������',
    [1] = '�����������',
    [2] = '�������',
    [3] = '�����',
    [4] = '�������',
    [5] = '�������',
    [6] = '�������'
}
--api
function getserial()
    local ffi = require("ffi")
    ffi.cdef[[
    int __stdcall GetVolumeInformationA(
    const char* lpRootPathName,
    char* lpVolumeNameBuffer,
    uint32_t nVolumeNameSize,
    uint32_t* lpVolumeSerialNumber,
    uint32_t* lpMaximumComponentLength,
    uint32_t* lpFileSystemFlags,
    char* lpFileSystemNameBuffer,
    uint32_t nFileSystemNameSize
    );
    ]]
    local serial = ffi.new("unsigned long[1]", 0)
    ffi.C.GetVolumeInformationA(nil, nil, 0, serial, nil, nil, nil, 0)
    return serial[0]
end
-- ������� debug
function developer()
    local _, id = sampGetPlayerIdByCharHandle(playerPed)
    if sampGetPlayerNickname(id) == 'Nikita_Dobrov' or 'Hola_Bola' then
        mainini.config.debug = true
    else
        mainini.config.debug = false
        inicfg.save(mainini, savee)
    end
end
-- ������� �����
function addLog(string)
	logText[#logText+1] = string.format("[%s] %s", os.date("%H:%M:%S"), string)
end
function sampev.onTogglePlayerSpectating(state) recon = state end -- ���� �� �����, �� � ������ ������ ����� ��������� ��������, ������ ����� ��� ����, ���� ���� - �������
-- ������� �������
function time()
	startTime = os.time()                                               -- "����� �������"
    connectingTime = 0
    while true do
        wait(1000)
        nowTime = os.date("%H:%M:%S", os.time())
        if sampGetGamestate() == 3 then 								-- ������� ������ ����� "��������� � �������" (��� �� ������ ������� ������, �����, �� ���������� � �������)
	        sesOnline.v = sesOnline.v + 1 								-- ������ �� ������ ��� ����� ���
	        sesFull.v = os.time() - startTime 							-- ����� ������ �� ������
	        sesAfk.v = sesFull.v - sesOnline.v							-- ��� �� ������

	        mainini.onDay.online = mainini.onDay.online + 1 					-- ������ �� ���� ��� ����� ���
	        mainini.onDay.full = dayFull.v + sesFull.v 						-- ����� ������ �� ����
	        mainini.onDay.afk = mainini.onDay.full - mainini.onDay.online			-- ��� �� ����

	        mainini.onWeek.online = mainini.onWeek.online + 1 					-- ������ �� ������ ��� ����� ���
	        mainini.onWeek.full = weekFull.v + sesFull.v 					-- ����� ������ �� ������
	        mainini.onWeek.afk = mainini.onWeek.full - mainini.onWeek.online		-- ��� �� ������

            local today = tonumber(os.date('%w', os.time()))
            mainini.myWeekOnline[today] = mainini.onDay.full

            connectingTime = 0
	    else
            connectingTime = connectingTime + 1                         -- ����� ����������� � �������
	    	startTime = startTime + 1									-- �������� ������ ������� ��������
	    end
    end
end
-- ���� ���������� �������
function autoSave()
	while true do
		wait(60000) -- ���������� ������ 60 ������
		inicfg.save(mainini, "AdminTools/AdminTools")
	end
end
-- ���������� ������� ��� ������ �� ����
function onScriptTerminate(script, quitGame)
	if script == thisScript() and not restart then
		if inicfg.save(mainini, 'AdminTools/AdminTools.ini') then sampfuncsLog(tag..' {FFFFFF}��� ������ �������!') end
	end
end
-- ��������� ������ ������ � ����
function number_week()
    local current_time = os.date'*t'
    local start_year = os.time{ year = current_time.year, day = 1, month = 1 }
    local week_day = ( os.date('%w', start_year) - 1 ) % 7
    return math.ceil((current_time.yday + week_day) / 7)
end
-- ������� ��������� ������
function getStrDate(unixTime)
    local tMonths = {'������', '�������', '�����', '������', '���', '����', '����', '�������', '��������', '�������', '������', '�������'}
    local day = tonumber(os.date('%d', unixTime))
    local month = tMonths[tonumber(os.date('%m', unixTime))]
    local weekday = tWeekdays[tonumber(os.date('%w', unixTime))]
    return string.format('%s, %s %s', weekday, day, month)
end
-- ����� �������
function get_clock(time)
    local timezone_offset = 86400 - os.date('%H', 0) * 3600
    if tonumber(time) >= 86400 then onDay = true else onDay = false end
    return os.date((onDay and math.floor(time / 86400)..'� ' or '')..'%H:%M:%S', time + timezone_offset)
end
-- ������� ����� �� ������
function imgui.CenterTextColoredRGB(text)
    local width = imgui.GetWindowWidth()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local ImVec4 = imgui.ImVec4

    local explode_argb = function(argb)
        local a = bit.band(bit.rshift(argb, 24), 0xFF)
        local r = bit.band(bit.rshift(argb, 16), 0xFF)
        local g = bit.band(bit.rshift(argb, 8), 0xFF)
        local b = bit.band(argb, 0xFF)
        return a, r, g, b
    end

    local getcolor = function(color)
        if color:sub(1, 6):upper() == 'SSSSSS' then
            local r, g, b = colors[1].x, colors[1].y, colors[1].z
            local a = tonumber(color:sub(7, 8), 16) or colors[1].w * 255
            return ImVec4(r, g, b, a / 255)
        end
        local color = type(color) == 'string' and tonumber(color, 16) or color
        if type(color) ~= 'number' then return end
        local r, g, b, a = explode_argb(color)
        return imgui.ImColor(r, g, b, a):GetVec4()
    end

    local render_text = function(text_)
        for w in text_:gmatch('[^\r\n]+') do
            local textsize = w:gsub('{.-}', '')
            local text_width = imgui.CalcTextSize(u8(textsize))
            imgui.SetCursorPosX( width / 2 - text_width .x / 2 )
            local text, colors_, m = {}, {}, 1
            w = w:gsub('{(......)}', '{%1FF}')
            while w:find('{........}') do
                local n, k = w:find('{........}')
                local color = getcolor(w:sub(n + 1, k - 1))
                if color then
                    text[#text], text[#text + 1] = w:sub(m, n - 1), w:sub(k + 1, #w)
                    colors_[#colors_ + 1] = color
                    m = n
                end
                w = w:sub(1, n - 1) .. w:sub(k + 1, #w)
            end
            if text[0] then
                for i = 0, #text do
                    imgui.TextColored(colors_[i] or colors[1], u8(text[i]))
                    imgui.SameLine(nil, 0)
                end
                imgui.NewLine()
            else
                imgui.Text(u8(w))
            end
        end
    end
    render_text(text)
end
-- ��� �������
function imgui.Hint(text, delay)
    if imgui.IsItemHovered() then
        if go_hint == nil then go_hint = os.clock() + (delay and delay or 0.0) end
        local alpha = (os.clock() - go_hint) * 5 -- �������� ���������
        if os.clock() >= go_hint then
            imgui.PushStyleVar(imgui.StyleVar.Alpha, (alpha <= 1.0 and alpha or 1.0))
                imgui.PushStyleColor(imgui.Col.PopupBg, imgui.GetStyle().Colors[imgui.Col.ButtonHovered])
                    imgui.BeginTooltip()
                    imgui.PushTextWrapPos(450)
                    imgui.TextUnformatted(text)
                    if not imgui.IsItemVisible() and imgui.GetStyle().Alpha == 1.0 then go_hint = nil end
                    imgui.PopTextWrapPos()
                    imgui.EndTooltip()
                imgui.PopStyleColor()
            imgui.PopStyleVar()
        end
    end
end
--AutoUpdate
function autoupdate(json_url, prefix, url)
    local dlstatus = require('moonloader').download_status
    local json = getWorkingDirectory() .. '\\'..thisScript().name..'-version.json'
    if doesFileExist(json) then os.remove(json) end
    downloadUrlToFile(json_url, json,
      	function(id, status, p1, p2)
        	if status == dlstatus.STATUSEX_ENDDOWNLOAD then
          	if doesFileExist(json) then
            	local f = io.open(json, 'r')
            	if f then
              		local info = decodeJson(f:read('*a'))
              		updatelink = info.updateurl
		            updateversion = info.latest
		            f:close()
		            os.remove(json)
		            if updateversion ~= thisScript().version then
	                lua_thread.create(function(prefix)
	                  	local dlstatus = require('moonloader').download_status
	                  	local color = -1
						if bNotf then
							notf.addNotification((prefix..'���������� ����������. \n������� ���������� \nc '..thisScript().version..' �� '..updateversion), 4, 2)
						end
	                  	--sampAddChatMessage((prefix..'���������� ����������. ������� ���������� c '..thisScript().version..' �� '..updateversion), color)
	                  	wait(250)
	                  	downloadUrlToFile(updatelink, thisScript().path,
	                    	function(id3, status1, p13, p23)
	                      		if status1 == dlstatus.STATUS_DOWNLOADINGDATA then
							  		if bNotf then
						          		notf.addNotification(string.format('��������� %d �� %d.', p13, p23), 4, 2)
						      		end
	                    			print(string.format('��������� %d �� %d.', p13, p23))
	                      		elseif status1 == dlstatus.STATUS_ENDDOWNLOADDATA then
	                        		print('�������� ���������� ���������.')
									if bNotf then
						          		notf.addNotification((prefix..'���������� ���������!'), 4, 2)
						      		end
			                        goupdatestatus = true
			                        lua_thread.create(function() wait(500) thisScript():reload() end)
	                      		end
	                      		if status1 == dlstatus.STATUSEX_ENDDOWNLOAD then
		                        	if goupdatestatus == nil then
										if bNotf then
							          		notf.addNotification((prefix..'���������� ������ ��������.\n�������� ���������� ������..'), 4, 2)
							      		end
		                          		update = false
		                        	end
	                      		end
	                		end)
                  		end, prefix)
              		else
	                	update = false
						if bNotf then
							notf.addNotification(('v'..thisScript().version..': ���������� �� ���������.'), 4, 2)
						end
              		end
        		end
			else
				if bNotf then
					notf.addNotification(('�� ���� ��������� ����������.\n� ������� ������ �� ����������.'), 4, 2)
				end
				print('v'..thisScript().version..': �� ���� ��������� ����������. ��������� ��� ��������� �������������� �� '..url)
	        	update = false
			end
    	end
	end)
	while update ~= false do wait(100) end
end
--����
function checkKey()
    response = requests.get('http://localhost/test.php?code='..getserial())
    if not response.text:match("<body>(.*)</body>"):find("-1") then -- ���� ���� ���� � ��
        if not response.text:match("<body>(.*)</body>"):find("The duration of the key has expired.") then
			key = true
        else
			key = false
			sampAddChatMessage("����������� �������� �� ATools",-1)
			wait(10)
			unload()
        end
    else
		key = false
        sampAddChatMessage("���� �� �����������.",-1)
		wait(10)
		unload()
    end
end
-- �����
local fsClock = nil
-- ����� ��� ����
function imgui.BeforeDrawFrame()
	if fsClock == nil then
        fsClock = imgui.GetIO().Fonts:AddFontFromFileTTF(getFolderPath(0x14) .. '\\trebucbd.ttf', 25.0, nil, imgui.GetIO().Fonts:GetGlyphRangesCyrillic())
    end
end
--
function onExitScript()
	if bubbleBox then bubbleBox:free() end
end
--
function sampev.onPlayerChatBubble(playerId, color, distance, duration, message)
	if sampIsPlayerConnected(playerId) and bubbleBox then
		bubbleBox:add_message(playerId, color, distance, message)
	end
end
-- event ����
function sampev.onServerMessage(color, text)
    if jail.v and text:find('%[A%] (.*): /jail (.+)') then
        lua_thread.create(function()
            txt = text:match("/jail (.+)")
            nick = text:match("(.*)%[")
            jailid = text:match("/jail (...)")
            wait(1000)
            JailText.v = (u8('/jail '..txt..' / '..nick..' '..(os.date("", os.time()))))
            mainini.config.JailText = JailText.v
            inicfg.save(mainini, savee)
            jailmenu = true
            --sampSendChat('/jail '..txt..' // '..nick..' '..(os.date("[%d.%m]", os.time())))
            --sampAddChatMessage('/jail '..txt..' // '..nick..' '..(os.date("[%d.%m]", os.time())), -1)
        end)
    end
    if sban.v and text:find('%[A%] (.*): /sban (.+)') then
        lua_thread.create(function()
            txtban = text:match("/sban (.+)")
            nickban = text:match("(.*)%[")
            banid = text:match("/sban (...)")
            wait(1000)
            sBanText.v = (u8('/sban '..txtban..' / '..nickban..' '..(os.date("", os.time	()))))
            mainini.config.sBanText = sBanText.v
            inicfg.save(mainini, savee)
            sbanmenu = true
        end)
    end
    if ban.v and text:find('%[A%] (.*): /ban (.+)') then
        lua_thread.create(function()
            txtban = text:match("/ban (.+)")
            nickban = text:match("(.*)%[")
            banid = text:match("/ban (...)")
            wait(1000)
            BanText.v = (u8('/ban '..txtban..' / '..nickban..' '..(os.date("", os.time	()))))
            mainini.config.BanText = BanText.v
            inicfg.save(mainini, savee)
            banmenu = true
        end)
    end
    if skick.v and text:find('%[A%] (.*): /skick (.+)') then
        lua_thread.create(function()
            txtkick = text:match("/skick (.+)")
            nickkick = text:match("(.*)%[")
            kickid = text:match("/skick (...)")
            wait(1000)
            sKickText.v = (u8('/skick '..txtkick..' / '..nickkick..' '..(os.date("", os.time	()))))
            mainini.config.sKickText = sKickText.v
            inicfg.save(mainini, savee)
            skickmenu = true
        end)
    end
	if kick.v and text:find('%[A%] (.*): /kick (.+)') then
        lua_thread.create(function()
            txtkick = text:match("/kick (.+)")
            nickkick = text:match("(.*)%[")
            kickid = text:match("/kick (...)")
            wait(1000)
            KickText.v = (u8('/kick '..txtkick..' / '..nickkick..' '..(os.date("", os.time	()))))
            mainini.config.KickText = KickText.v
            inicfg.save(mainini, savee)
            kickmenu = true
        end)
    end
    if warn.v and text:find('%[A%] (.*): /warn (.+)') then
        lua_thread.create(function()
            txtwarn = text:match("/warn (.+)")
            nickwarn = text:match("(.*)%[")
            warnid = text:match("/warn (...)")
            wait(1000)
            WarnText.v = (u8('/warn '..txtwarn..' / '..nickwarn..' '..(os.date("", os.time()))))
            mainini.config.WarnText = WarnText.v
            inicfg.save(mainini, savee)
            warnmenu = true
        end)
    end
    if mute.v and text:find('%[A%] (.*): /mute (.+)') then
        lua_thread.create(function()
            txtmute = text:match("/mute (.+)")
            nickmute = text:match("(.*)%[")
            muteid = text:match("/mute (...)")
            wait(1000)
            MuteText.v = (u8('/mute '..txtmute..' / '..nickmute..' '..(os.date("", os.time()))))
            mainini.config.MuteText = MuteText.v
            inicfg.save(mainini, savee)
            mutemenu = true
        end)
    end
	if report.v and text:find('%[������%] �� (.*): (.+)') and not reportmenu == true then
        lua_thread.create(function()
            txtreport = text:match(": (.+)")
            nickreport = text:match("�� (.*)%[")
            reportid = text:match("%[(%d+)%]:")
            wait(1000)
            ReportText.v = (u8(''..txtreport))
            ReportTextOtvet.v = (u8(''))
            reportmenu = true
        end)
    end
	if text:find('%[A%] �� �� ������������. ����������� /apanel') then end
    if text:find('������������� (.*) ������ ������ (.*). �������: (.+)') then
        if bNotf then
            notf.addNotification(("Kick"), 4, 2)
        end
        addOneOffSound(0.0, 0.0, 0.0, 1139)
        local a = text:match("(.+)")
        addLog(a)
    end
    if text:find('������������� (.*) �������%(�%) ������ (.*) � �������� �� (.+) �����. �������: (.+)') then
        if bNotf then
            notf.addNotification(("Jail!"), 4, 2)
        end
        addOneOffSound(0.0, 0.0, 0.0, 1139)
        local b = text:match("(.+)")
        addLog(b)
    end
    if text:find('������������� (.*) ��������%(�%) ������ (.*) �� (.+) �����. �������: (.+)') then
        if bNotf then
            notf.addNotification(("Mute!"), 4, 2)
        end
        addOneOffSound(0.0, 0.0, 0.0, 1139)
        local c = text:match("(.+)")
        addLog(c)
    end
    if text:find('������������� (.*) �������%(�%) ������ (.*) �� (.+) ����. �������: (.+)') then
        if bNotf then
            notf.addNotification(("Ban!"), 4, 2)
        end
        addOneOffSound(0.0, 0.0, 0.0, 1139)
        local c = text:match("(.+)")
        addLog(c)
    end
	if text:find('������������� (.*) �����%(�%) �������������� ������ (.*) (.+) �������: (.+)') then
        if bNotf then
            notf.addNotification(("Warn!"), 4, 2)
        end
        addOneOffSound(0.0, 0.0, 0.0, 1139)
        local c = text:match("(.+)")
        addLog(c)
    end
    --������� �����
    local _, id = sampGetPlayerIdByCharHandle(PLAYER_PED)
    local nick = sampGetPlayerNickname(id)
    if text:find('%[A%] '..nick..' ������� ������') then
        mainini.status.report = rstat.v + 1
        inicfg.save(mainini, savee)
    end
    if text:find('%[A%] '..nick..' �������') then
        bstat = bstat + 1
    end
    if text:find('%[A%] '..nick..' �������') then
        sbstat = sbstat + 1
    end
    if text:find('%[A%] '..nick..' �������') then
        kstat = kstat + 1
    end
    if text:find('%[A%] '..nick..' �������') then
        skstat = skstat + 1
    end
    if text:find('%[A%] '..nick..' �������') then
        jstat = jstat + 1
    end
    if text:find('%[A%] '..nick..' �������') then
        mstat = mstat + 1
    end
end
-- event ��������
function sampev.onShowDialog(id, style, title, button1, button2, text)
    --if id == 2 then
    --end
    if id == 211 and adminpassACT.v then
        sampSendDialogResponse(id, 1, _,mainini.config.adminpass)
        return false
    end
end
-- event ����� ������ � �������
function sampev.onPlayerJoin(id, clist, isNPC, nick)
    if bNotf then
        notf.addNotification(("�����\n"..nick.."["..id.."]"), 4, 2)
    end
end
-- event ������ ������ � �������
function sampev.onPlayerQuit(id, reason)
    -- id �� ��������������(������ ��� ���� ��� ��������� �� ID)
    -- �������(ID' ������ �� 0 �� 2)
    -- 0. '�����', 1. '��� ��� ���', 2. 'TimedOut'
    nick = sampGetPlayerNickname(id)
    if reason == 0 then
        reas = "/q"
    elseif reason == 1 then
        reas = "��� ��� ���"
    elseif reason == 2 then
        reas = "TimedOut"
    end
    if bNotf then
        notf.addNotification(("�����\n"..nick.."["..id.."]\n�������: "..reas.."["..reason.."]"), 4, 2)
    end
end
-- ��������� ����
function onWindowMessage(msg, wparam, lparam)
    if msg == 0x100 or msg == 0x101 then
		if (wparam == 0x1B and esc.v and active_menu.v) and not isPauseMenuActive() then
			consumeWindowMessage(true, false)
			if msg == 0x101 then
                active_menu.v = false
            end
        end
    end
end
--�� �� ����
function nameTagOn()
    sSp = sampGetServerSettingsPtr()
    memory.setfloat(sSp + 39, 1200)
    memory.setint8(sSp + 47, 0)
    memory.setint8(sSp + 56, 1)
end
--�� �� ����
function nameTagOff()
    sSp = sampGetServerSettingsPtr()
    memory.setfloat(sSp + 39, 25.5)
    memory.setint8(sSp + 47, 1)
    memory.setint8(sSp + 56, 1)
end
--��
function sampev.onResetPlayerWeapons()
    if godmode.v then
        return false
    end
end
--��
function sampev.onSetCameraBehind()
    if godmode.v then
        return false
    end
end
--��
function sampev.onTogglePlayerControllable()
    if godmode.v then
        return false
    end
end
--��
function sampev.onSetPlayerHealth()
    if godmode.v then
        return false
    end
end
--��
function sampev.onBulletSync()
    if godmode.v then
        return false
    end
end
--��������� ������
function imgui.CenterText(text)
    local width = imgui.GetWindowWidth()
    local calc = imgui.CalcTextSize(text)
    imgui.SetCursorPosX( width / 2 - calc.x / 2 )
    imgui.Text(text)
end
-- ������
function imgui.Link(link,name,myfunc)
    myfunc = type(name) == 'boolean' and name or myfunc or false
    name = type(name) == 'string' and name or type(name) == 'boolean' and link or link
    local size = imgui.CalcTextSize(name)
    local p = imgui.GetCursorScreenPos()
    local p2 = imgui.GetCursorPos()
    local resultBtn = imgui.InvisibleButton('##'..link..name, size)
    if resultBtn then
        if not myfunc then
            os.execute('explorer '..link)
        end
    end
    imgui.SetCursorPos(p2)
    if imgui.IsItemHovered() then
        imgui.TextColored(imgui.GetStyle().Colors[imgui.Col.ButtonHovered], name)
        imgui.GetWindowDrawList():AddLine(imgui.ImVec2(p.x, p.y + size.y), imgui.ImVec2(p.x + size.x, p.y + size.y), imgui.GetColorU32(imgui.GetStyle().Colors[imgui.Col.ButtonHovered]))
    else
        imgui.TextColored(imgui.GetStyle().Colors[imgui.Col.Button], name)
    end
    return resultBtn
end
--�����
function apply_custom_style()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4
    local ImVec2 = imgui.ImVec2
    style.FramePadding = ImVec2(5, 5)
    style.WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
    colors[clr.FrameBg]                = ImVec4(0.16, 0.29, 0.48, 0.54)
    colors[clr.FrameBgHovered]         = ImVec4(0.26, 0.59, 0.98, 0.40)
    colors[clr.FrameBgActive]          = ImVec4(0.26, 0.59, 0.98, 0.67)
    colors[clr.TitleBg]                = ImVec4(0.04, 0.04, 0.04, 1.00)
    colors[clr.TitleBgActive]          = ImVec4(0.16, 0.29, 0.48, 1.00)
    colors[clr.TitleBgCollapsed]       = ImVec4(0.00, 0.00, 0.00, 0.51)
    colors[clr.CheckMark]              = ImVec4(0.26, 0.59, 0.98, 1.00)
    colors[clr.SliderGrab]             = ImVec4(0.24, 0.52, 0.88, 1.00)
    colors[clr.SliderGrabActive]       = ImVec4(0.26, 0.59, 0.98, 1.00)
    colors[clr.Button]                 = ImVec4(0.26, 0.59, 0.98, 0.40)
    colors[clr.ButtonHovered]          = ImVec4(0.26, 0.59, 0.98, 1.00)
    colors[clr.ButtonActive]           = ImVec4(0.06, 0.53, 0.98, 1.00)
    colors[clr.Header]                 = ImVec4(0.26, 0.59, 0.98, 0.31)
    colors[clr.HeaderHovered]          = ImVec4(0.26, 0.59, 0.98, 0.80)
    colors[clr.HeaderActive]           = ImVec4(0.26, 0.59, 0.98, 1.00)
    colors[clr.Separator]              = colors[clr.Border]
    colors[clr.SeparatorHovered]       = ImVec4(0.26, 0.59, 0.98, 0.78)
    colors[clr.SeparatorActive]        = ImVec4(0.26, 0.59, 0.98, 1.00)
    colors[clr.ResizeGrip]             = ImVec4(0.26, 0.59, 0.98, 0.25)
    colors[clr.ResizeGripHovered]      = ImVec4(0.26, 0.59, 0.98, 0.67)
    colors[clr.ResizeGripActive]       = ImVec4(0.26, 0.59, 0.98, 0.95)
    colors[clr.TextSelectedBg]         = ImVec4(0.26, 0.59, 0.98, 0.35)
    colors[clr.Text]                   = ImVec4(1.00, 1.00, 1.00, 1.00)
    colors[clr.TextDisabled]           = ImVec4(0.50, 0.50, 0.50, 1.00)
    colors[clr.WindowBg]               = ImVec4(0.06, 0.06, 0.06, 0.94)
    colors[clr.ChildWindowBg]          = ImVec4(1.00, 1.00, 1.00, 0.00)
    colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94)
    colors[clr.ComboBg]                = colors[clr.PopupBg]
    colors[clr.Border]                 = ImVec4(0.43, 0.43, 0.50, 0.50)
    colors[clr.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00)
    colors[clr.MenuBarBg]              = ImVec4(0.14, 0.14, 0.14, 1.00)
    colors[clr.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.53)
    colors[clr.ScrollbarGrab]          = ImVec4(0.31, 0.31, 0.31, 1.00)
    colors[clr.ScrollbarGrabHovered]   = ImVec4(0.41, 0.41, 0.41, 1.00)
    colors[clr.ScrollbarGrabActive]    = ImVec4(0.51, 0.51, 0.51, 1.00)
    colors[clr.CloseButton]            = ImVec4(0.41, 0.41, 0.41, 0.50)
    colors[clr.CloseButtonHovered]     = ImVec4(0.98, 0.39, 0.36, 1.00)
    colors[clr.CloseButtonActive]      = ImVec4(0.98, 0.39, 0.36, 1.00)
    colors[clr.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00)
    colors[clr.PlotLinesHovered]       = ImVec4(1.00, 0.43, 0.35, 1.00)
    colors[clr.PlotHistogram]          = ImVec4(0.90, 0.70, 0.00, 1.00)
    colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.60, 0.00, 1.00)
    colors[clr.ModalWindowDarkening]   = ImVec4(0.80, 0.80, 0.80, 0.35)
end
--���� ����
function ClickWP()
    require"lib.sampfuncs"
    local Matrix3X3 = require "matrix3x3"
    local Vector3D = require "vector3d"
    if not isSampfuncsLoaded() then return end
    initializeRender()
    while true do
        while isPauseMenuActive() do
            if cursorEnabled then
                showCursor(false)
            end
            wait(100)
            end
            if isKeyDown(VK_MBUTTON) and clickwarp.v then
                cursorEnabled = not cursorEnabled
                showCursor(cursorEnabled)
                while isKeyDown(VK_MBUTTON) do wait(80) end
            end
            if cursorEnabled and clickwarp.v and not active_menu.v then
            local mode = sampGetCursorMode()
            if mode == 0 then
                showCursor(true)
            end
            local sx, sy = getCursorPos()
            local sw, sh = getScreenResolution()
            if sx >= 0 and sy >= 0 and sx < sw and sy < sh then
            local posX, posY, posZ = convertScreenCoordsToWorld3D(sx, sy, 700.0)
            local camX, camY, camZ = getActiveCameraCoordinates()
            local result, colpoint = processLineOfSight(camX, camY, camZ, posX, posY, posZ, true, true, false, true, false, false, false)
            if result and colpoint.entity ~= 0 then
                local normal = colpoint.normal
                local pos = Vector3D(colpoint.pos[1], colpoint.pos[2], colpoint.pos[3]) - (Vector3D(normal[1], normal[2], normal[3]) * 0.1)
                local zOffset = 300
                if normal[3] >= 0.5 then zOffset = 1 end
                local result, colpoint2 = processLineOfSight(pos.x, pos.y, pos.z + zOffset, pos.x, pos.y, pos.z - 0.3, true, true, false, true, false, false, false)
                if result then
                    pos = Vector3D(colpoint2.pos[1], colpoint2.pos[2], colpoint2.pos[3] + 1)

                    local curX, curY, curZ  = getCharCoordinates(PLAYER_PED)
                    local dist              = getDistanceBetweenCoords3d(curX, curY, curZ, pos.x, pos.y, pos.z)
                    local hoffs             = renderGetFontDrawHeight(font)

                    sy = sy - 2
                    sx = sx - 2
                    renderFontDrawText(font, string.format("%0.2fm", dist), sx, sy - hoffs, 0xEEEEEEEE)

                    local tpIntoCar = nil
                    if colpoint.entityType == 2 then
                        local car = getVehiclePointerHandle(colpoint.entity)
                        if doesVehicleExist(car) and (not isCharInAnyCar(PLAYER_PED) or storeCarCharIsInNoSave(PLAYER_PED) ~= car) then
                            displayVehicleName(sx, sy - hoffs * 2, getNameOfVehicleModel(getCarModel(car)))
                            local color = 0xAAFFFFFF
                            if isKeyDown(VK_RBUTTON) then
                                tpIntoCar = car
                                color = 0xFFFFFFFF
                            end
                            renderFontDrawText(font2, "Hold right mouse button to teleport into the car", sx, sy - hoffs * 3, color)
                        end
                    end

                    createPointMarker(pos.x, pos.y, pos.z)

                    if isKeyDown(VK_LBUTTON) and clickwarp.v then
                        if tpIntoCar then
                            if not jumpIntoCar(tpIntoCar) and clickwarp.v then
                                teleportPlayer(pos.x, pos.y, pos.z)
                            end
                        else
                            if isCharInAnyCar(PLAYER_PED) then
                                local norm = Vector3D(colpoint.normal[1], colpoint.normal[2], 0)
                                local norm2 = Vector3D(colpoint2.normal[1], colpoint2.normal[2], colpoint2.normal[3])
                                rotateCarAroundUpAxis(storeCarCharIsInNoSave(PLAYER_PED), norm2)
                                pos = pos - norm * 1.8
                                pos.z = pos.z - 0.8
                            end
                            teleportPlayer(pos.x, pos.y, pos.z)
                        end
                        removePointMarker()

                        while isKeyDown(VK_LBUTTON) do wait(0) end
                        showCursor(false)
                        end
                    end
                end
            end
        end
        wait(0)
        removePointMarker()
    end
end
--������ ������ ��� �����
function initializeRender()
    font = renderCreateFont("Tahoma", 10, FCR_BOLD + FCR_BORDER)
    font2 = renderCreateFont("Arial", 8, FCR_ITALICS + FCR_BORDER)
end
--������� ��� ��������� �� ����� ������
function rotateCarAroundUpAxis(car, vec)
    local mat = Matrix3X3(getVehicleRotationMatrix(car))
    local rotAxis = Vector3D(mat.up:get())
    vec:normalize()
    rotAxis:normalize()
    local theta = math.acos(rotAxis:dotProduct(vec))
    if theta ~= 0 then
        rotAxis:crossProduct(vec)
        rotAxis:normalize()
        rotAxis:zeroNearZero()
        mat = mat:rotate(rotAxis, -theta)
    end
    setVehicleRotationMatrix(car, mat:get())
end
--������� ��� ��������� �� ����� ������
function readFloatArray(ptr, idx)
    return representIntAsFloat(readMemory(ptr + idx * 4, 4, false))
end
--������� ��� ��������� �� ����� ������
function writeFloatArray(ptr, idx, value)
    writeMemory(ptr + idx * 4, 4, representFloatAsInt(value), false)
end
--������� ��� ��������� �� ����� ������
function getVehicleRotationMatrix(car)
    local entityPtr = getCarPointer(car)
    if entityPtr ~= 0 then
        local mat = readMemory(entityPtr + 0x14, 4, false)
        if mat ~= 0 then
            local rx, ry, rz, fx, fy, fz, ux, uy, uz
            rx = readFloatArray(mat, 0)
            ry = readFloatArray(mat, 1)
            rz = readFloatArray(mat, 2)

            fx = readFloatArray(mat, 4)
            fy = readFloatArray(mat, 5)
            fz = readFloatArray(mat, 6)

            ux = readFloatArray(mat, 8)
            uy = readFloatArray(mat, 9)
            uz = readFloatArray(mat, 10)
            return rx, ry, rz, fx, fy, fz, ux, uy, uz
        end
    end
end
--������� ��� ��������� �� ����� ������
function setVehicleRotationMatrix(car, rx, ry, rz, fx, fy, fz, ux, uy, uz)
    local entityPtr = getCarPointer(car)
    if entityPtr ~= 0 then
        local mat = readMemory(entityPtr + 0x14, 4, false)
        if mat ~= 0 then
        writeFloatArray(mat, 0, rx)
        writeFloatArray(mat, 1, ry)
        writeFloatArray(mat, 2, rz)

        writeFloatArray(mat, 4, fx)
        writeFloatArray(mat, 5, fy)
        writeFloatArray(mat, 6, fz)

        writeFloatArray(mat, 8, ux)
        writeFloatArray(mat, 9, uy)
        writeFloatArray(mat, 10, uz)
        end
    end
end
-- ����� �������� ������
function displayVehicleName(x, y, gxt)
    x, y = convertWindowScreenCoordsToGameScreenCoords(x, y)
    useRenderCommands(true)
    setTextWrapx(640.0)
    setTextProportional(true)
    setTextJustify(false)
    setTextScale(0.33, 0.8)
    setTextDropshadow(0, 0, 0, 0, 0)
    setTextColour(255, 255, 255, 230)
    setTextEdge(1, 0, 0, 0, 100)
    setTextFont(1)
    displayText(x, y, gxt)
end
-- �������� ����� �����
function createPointMarker(x, y, z)
    pointMarker = createUser3dMarker(x, y, z + 0.3, 4)
end
-- �������� ����� �����
function removePointMarker()
    if pointMarker then
        removeUser3dMarker(pointMarker)
        pointMarker = nil
    end
end
-- ��������� ������
function getCarFreeSeat(car)
    if doesCharExist(getDriverOfCar(car)) then
        local maxPassengers = getMaximumNumberOfPassengers(car)
        for i = 0, maxPassengers do
        if isCarPassengerSeatFree(car, i) then
            return i + 1
        end
    end
    return nil
    else
        return 0
    end
end
-- �������� � ������
function jumpIntoCar(car)
    local seat = getCarFreeSeat(car)
    if not seat then return false end
    if seat == 0 then
        warpCharIntoCar(PLAYER_PED, car)
    else
        warpCharIntoCarAsPassenger(PLAYER_PED, car, seat - 1)
    end
    restoreCameraJumpcut()
    return true
end
-- �������� � ������
function teleportPlayer(x, y, z)
    if isCharInAnyCar(PLAYER_PED) then
        setCharCoordinates(PLAYER_PED, x, y, z)
    end
    setCharCoordinatesDontResetAnim(PLAYER_PED, x, y, z)
end
--�������� �� ����������
function setCharCoordinatesDontResetAnim(char, x, y, z)
    if doesCharExist(char) then
        local ptr = getCharPointer(char)
        setEntityCoordinates(ptr, x, y, z)
    end
end
--�������� �� ����������
function setEntityCoordinates(entityPtr, x, y, z)
    if entityPtr ~= 0 then
        local matrixPtr = readMemory(entityPtr + 0x14, 4, false)
        if matrixPtr ~= 0 then
            local posPtr = matrixPtr + 0x30
            writeMemory(posPtr + 0, 4, representFloatAsInt(x), false) -- X
            writeMemory(posPtr + 4, 4, representFloatAsInt(y), false) -- Y
            writeMemory(posPtr + 8, 4, representFloatAsInt(z), false) -- Z
        end
    end
end
-- ����� ������� ��� �����
function showCursor(toggle)
    if toggle then
        sampSetCursorMode(CMODE_LOCKCAM)
    else
        sampToggleCursor(false)
    end
    cursorEnabled = toggle
end
-- ������� �����
function imgui.TextColoredRGB(text)
    local width = imgui.GetWindowWidth()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local ImVec4 = imgui.ImVec4

    local explode_argb = function(argb)
        local a = bit.band(bit.rshift(argb, 24), 0xFF)
        local r = bit.band(bit.rshift(argb, 16), 0xFF)
        local g = bit.band(bit.rshift(argb, 8), 0xFF)
        local b = bit.band(argb, 0xFF)
        return a, r, g, b
    end

    local getcolor = function(color)
        if color:sub(1, 6):upper() == 'SSSSSS' then
            local r, g, b = colors[1].x, colors[1].y, colors[1].z
            local a = tonumber(color:sub(7, 8), 16) or colors[1].w * 255
            return ImVec4(r, g, b, a / 255)
        end
        local color = type(color) == 'string' and tonumber(color, 16) or color
        if type(color) ~= 'number' then return end
        local r, g, b, a = explode_argb(color)
        return imgui.ImColor(r, g, b, a):GetVec4()
    end

    local render_text = function(text_)
        for w in text_:gmatch('[^\r\n]+') do
            local textsize = w:gsub('{.-}', '')
            local text_width = imgui.CalcTextSize(u8(textsize))
            local text, colors_, m = {}, {}, 1
            w = w:gsub('{(......)}', '{%1FF}')
            while w:find('{........}') do
                local n, k = w:find('{........}')
                local color = getcolor(w:sub(n + 1, k - 1))
                if color then
                    text[#text], text[#text + 1] = w:sub(m, n - 1), w:sub(k + 1, #w)
                    colors_[#colors_ + 1] = color
                    m = n
                end
                w = w:sub(1, n - 1) .. w:sub(k + 1, #w)
            end
            if text[0] then
                for i = 0, #text do
                    imgui.TextColored(colors_[i] or colors[1], u8(text[i]))
                    imgui.SameLine(nil, 0)
                end
                imgui.NewLine()
            else
                imgui.Text(u8(w))
            end
        end
    end
    render_text(text)
end
--��� �������
ChatBox = function(pagesize, blacklist)
	local obj = {
		pagesize = pagesize,
			active = false,
			font = nil,
			messages = {},
			blacklist = blacklist,
			firstMessage = 0,
			currentMessage = 0,
	}

	function obj:initialize()
		if self.font == nil then
			self.font = renderCreateFont('Verdana', 8, FCR_BORDER + FCR_BOLD)
		end
	end

	function obj:free()
		if self.font ~= nil then
			renderReleaseFont(self.font)
			self.font = nil
		end
	end

	function obj:toggle(show)
		self:initialize()
		self.active = show
	end

  	function obj:draw(x, y)
		local add_text_draw = function(text, color)
			renderFontDrawText(self.font, text, x, y, color)
			y = y + renderGetFontDrawHeight(self.font)
		end

		-- draw caption
    	add_text_draw(u8"������� ���", 0xFFE4D8CC)

		-- draw page indicator
		if #self.messages == 0 then return end
		local cur = self.currentMessage
		local to = cur + math.min(self.pagesize, #self.messages) - 1
		add_text_draw(string.format("%d/%d", to, #self.messages), 0xFFE4D8CC)

		-- draw messages
		x = x + 4
		for i = cur, to do
			local it = self.messages[i]
			add_text_draw(
				string.format("{E4E4E4}[%s] (%.1fm) {%06X}%s{D4D4D4}({EEEEEE}%d{D4D4D4}): {%06X}%s",
					it.time,
					it.dist,
					argb_to_rgb(it.playerColor),
					it.nickname,
					it.playerId,
					argb_to_rgb(it.color),
					it.text),
				it.color)
		end
  	end

	function obj:add_message(playerId, color, distance, text)
		-- ignore blacklisted messages
		if self:is_text_blacklisted(text) then return end

		-- process only streamed in players
		local dist = get_distance_to_player(playerId)
		if dist ~= nil then
			color = bgra_to_argb(color)
			if dist > distance then color = set_argb_alpha(color, 0xA0)
			else color = set_argb_alpha(color, 0xF0)
			end
			table.insert(self.messages, {
				playerId = playerId,
				nickname = sampGetPlayerNickname(playerId),
				color = color,
				playerColor = sampGetPlayerColor(playerId),
				dist = dist,
				distLimit = distance,
				text = text,
				time = os.date('%X')})

			-- limit message list
			if #self.messages > messagesMax then
				self.messages[self.firstMessage] = nil
				self.firstMessage = #self.messages - messagesMax
			else
				self.firstMessage = 1
			end
			self:scroll(1)
		end
	end

	function obj:is_text_blacklisted(text)
		for _, t in pairs(self.blacklist) do
			if string.match(text, t) then
				return true
			end
		end
		return false
	end

	function obj:scroll(n)
		self.currentMessage = self.currentMessage + n
		if self.currentMessage < self.firstMessage then
			self.currentMessage = self.firstMessage
		else
			local max = math.max(#self.messages, self.pagesize) + 1 - self.pagesize
			if self.currentMessage > max then
				self.currentMessage = max
			end
		end
	end

  	setmetatable(obj, {})
  	return obj
end
--�������� ���������� � ����
function get_distance_to_player(playerId)
	if sampIsPlayerConnected(playerId) then
		local result, ped = sampGetCharHandleBySampPlayerId(playerId)
		if result and doesCharExist(ped) then
			local myX, myY, myZ = getCharCoordinates(playerPed)
			local playerX, playerY, playerZ = getCharCoordinates(ped)
			return getDistanceBetweenCoords3d(myX, myY, myZ, playerX, playerY, playerZ)
		end
	end
	return nil
end
function is_key_check_available()
    if not isSampfuncsLoaded() then
        return not isPauseMenuActive()
    end
    local result = not isSampfuncsConsoleActive() and not isPauseMenuActive()
    if isSampLoaded() and isSampAvailable() then
        result = result and not sampIsChatInputActive() and not sampIsDialogActive()
    end
    return result
end
function explode_argb(argb)
    local a = bit.band(bit.rshift(argb, 24), 0xFF)
    local r = bit.band(bit.rshift(argb, 16), 0xFF)
    local g = bit.band(bit.rshift(argb, 8), 0xFF)
    local b = bit.band(argb, 0xFF)
    return a, r, g, b
end
function join_argb(a, r, g, b)
    local argb = b  -- b
    argb = bit.bor(argb, bit.lshift(g, 8))  -- g
    argb = bit.bor(argb, bit.lshift(r, 16)) -- r
    argb = bit.bor(argb, bit.lshift(a, 24)) -- a
    return argb
end
function bgra_to_argb(bgra)
    local b, g, r, a = explode_argb(bgra)
    return join_argb(a, r, g, b)
end
function set_argb_alpha(color, alpha)
    local _, r, g, b = explode_argb(color)
    return join_argb(alpha, r, g, b)
end
function get_argb_alpha(color)
    local alpha = explode_argb(color)
    return alpha
end
function argb_to_rgb(argb)
    return bit.band(argb, 0xFFFFFF)
end
-- ���������� ���-����� �� ����
function DisaCheatsInSAMP()
    memory.write(0x4384D0, 0x9090, 2)
    memory.write(0x4384D2, 0x90, 1)
    memory.write(0x4384D3, 0xE9, 1)
    memory.write(0x4384D4, 0x000000CD, 4)
end
--�������� ����
ffi.cdef [[
    typedef unsigned long HANDLE;
    typedef HANDLE HWND;
    typedef const char *LPCTSTR;

    HWND GetActiveWindow(void);

    bool SetWindowTextA(HWND hWnd, LPCTSTR lpString);
]]
--������ �� �������) 
function onWindowMessage(msg, wparam, lparam)
  if msg == wm.WM_KILLFOCUS then
    thisScript():unload()
  end
end
-- ����
function imgui.OnDrawFrame()
    apply_custom_style()
    local tLastKeys = {}
    if active_menu.v then
        local x, y = getScreenResolution()
        imgui.GetStyle().Colors[imgui.Col.Text] = imgui.ImVec4(1.00,1.00,1.00,1.00)
        imgui.GetStyle().Colors[imgui.Col.ChildWindowBg] = imgui.ImVec4(0.26, 0.40, 0.98, 0.75)
        imgui.GetStyle().Colors[imgui.Col.WindowBg] = imgui.ImVec4(0.06, 0.05, 0.07, 0.95)
        imgui.GetStyle().Colors[imgui.Col.Button] = imgui.ImVec4(0.26, 0.47, 0.98, 1)
        imgui.GetStyle().Colors[imgui.Col.Header] = imgui.ImVec4(0.26, 0.47, 0.98, 1)
        imgui.SetNextWindowPos(imgui.ImVec2(x/2, y/2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(850, 495), imgui.Cond.FirstUseEver)
        imgui.Begin('Menu', active_menu, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoBringToFrontOnFocus + imgui.WindowFlags.NoSavedSettings + imgui.WindowFlags.NoTitleBar)
        imgui.Columns(2,"", true)
        imgui.SetColumnWidth(-1, 232)
        imgui.BeginChild("##menubok", imgui.ImVec2(225, 480), true)
            imgui.Image(png, imgui.ImVec2(210, 190))
            if not menu then menu = 2 end
			imgui.Separator()
			response = requests.get('http://localhost/test.php?code='..getserial())
		    if not response.text:match("<body>(.*)</body>"):find("-1") then -- ���� ���� ���� � ��
		        if not response.text:match("<body>(.*)</body>"):find("The duration of the key has expired.") then -- ���� ������ �� ������� ��� ���� �����.
		            imgui.Text(u8"�� ��������� ����� ��������:"..response.text:match("<body>(.*)</body>")..u8" ����") -- ������� ���-�� ���� �� ����� ��������
		        else
		            imgui.Text(response.text:match(u8"���� �������� �������� �����."), -1)
		        end
		    else
		        imgui.Text(u8"���� �� �����������.")
		    end
            imgui.Separator()
			--if key then
				--if mainini.config.debug then
	            --    if imgui.Button('Debug for Developers',imgui.ImVec2(207, 40)) then
	            --        menu = 1
	            --        if bNotf then
	            --            notf.addNotification(("������� Developers!"), 4, 2)
	            --        end
	            --    end
	            --end
	            if imgui.Button(u8'����� ����',imgui.ImVec2(207, 40)) then
	                menu = 2
	            end
	            if imgui.Button(u8'������ ���������',imgui.ImVec2(207, 40)) then
	                menu = 3
	            end
	            if imgui.Button(u8'����������',imgui.ImVec2(207, 40)) then
	                menu = 4
	            end
	            if imgui.Button(u8'���������',imgui.ImVec2(207, 40)) then
	                menu = 5
	            end
	            if imgui.Button(u8'������ ����������',imgui.ImVec2(207, 40)) then
	                menu = 6
	            end
			--else
				imgui.Text(u8'������ ��������� ����� ���\n��������� ������� � �������')
				imgui.Spacing()
			--end
        imgui.EndChild()
        imgui.SetColumnWidth(-1, 232)
        imgui.NextColumn()
        imgui.BeginChild("##zagolovok", imgui.ImVec2(600, 35), true)
            if menu == 1 then
                imgui.CenterText(u8'��� ������������')
            elseif menu == 2 then
                imgui.CenterText(u8"����� ����")
            elseif menu == 3 then
                imgui.CenterText(u8"������ ���������")
            elseif menu == 4 then
                imgui.CenterText(u8"����������")
            elseif menu == 5 then
                imgui.CenterText(u8"���������")
            elseif menu == 6 then
                imgui.CenterText(u8"������ ����������")
            elseif menu == 7 then
                imgui.CenterText(u8"��������� ������")
            end
        imgui.EndChild()
        if menu == 1 then
            imgui.Spacing()
        end
        if menu == 2 then
            imgui.Spacing()
            if imgui.Checkbox(u8"WallHack", wh) then
                mainini.config.wh = wh.v
                inicfg.save(mainini, savee)
                if wh.v then
                    nameTagOn()
                    addOneOffSound(0.0, 0.0, 0.0, 1139)
                else
                    nameTagOff()
                    addOneOffSound(0.0, 0.0, 0.0, 1139)
                end
            end
            imgui.Spacing()
            if imgui.Checkbox(u8"ClickWarp", clickwarp) then
                mainini.config.clickwarp = clickwarp.v
                inicfg.save(mainini, savee)
            end
            imgui.Spacing()
            if imgui.Checkbox(u8"GM", godmode) then
                mainini.config.godmode = godmode.v
                inicfg.save(mainini, savee)
            end
        end
        if menu == 3 then
            imgui.Spacing()
            imgui.BeginChild("##logText", imgui.ImVec2(600, 395))
            imgui.PushStyleVar(imgui.StyleVar.ItemSpacing, imgui.ImVec2(1, 2))

	    	if #logText > 0 then
		    	local fCount = 0
		    	for k, v in ipairs(logText) do
		    		if logFilter.v:len() > 0 then
		    			if string.find(string.rlower(v), string.rlower(u8:decode(logFilter.v)), 1, true) then
		    				imgui.TextWrapped(u8(v))
			    			fCount = fCount + 1
			    		end
		    		else
			    		imgui.TextWrapped(u8(v))
			    	end
			    	if (imgui.IsItemClicked(0) or imgui.IsItemClicked(1)) and (logFilter.v:len() == 0 or fCount > 0) then
			    		setClipboardText(v)
			    	end
			    end
		    	if logFilter.v:len() > 0 and fCount == 0 then
		    		imgui.Text(u8"���������� �� ������� ...")
		    	end
		    else
		    	imgui.Text(u8"������ ���� ...")
		    end
		    if ScrollToButton then
			imgui.SetScrollHere()
		    	ScrollToButton = false
	    	end
	        imgui.PopStyleVar()
            imgui.EndChild()
            imgui.BeginChild('##6', imgui.ImVec2(600, 38), true)
            if imgui.RadioButton(u8'�������� ������', clearlog) and #logText > 0 then
                logText = {}
                addLog("������ ������ ...")
                clearlog = false
            end
            imgui.SameLine()
            if imgui.RadioButton(u8'���������� ������', copylog) and #logText > 0 then
                local t = ""
                for k, v in ipairs(logText) do
                    t = t .. (tostring(t):len() > 0 and "\n" or "") .. v
                end
                setClipboardText(t)
                addLog("���������� ������� ����������� � �����. ����������� CTRL + V")
                copylog = false
            end
            imgui.SameLine()
            if imgui.RadioButton(u8'��������', testlog) then
                toLog = "������������� Angels_Vollar �������(�) Ya_Cheater � �������� �� 20 ���. �������: ��"
                addLog(toLog)
                testlog = false
            end
            imgui.EndChild()
        end
        if menu == 4 then
            imgui.Spacing()
            imgui.Text(u8'������ ������ ��� ������� Luxury RolePlay')
            imgui.SameLine()
            imgui.Link("vk.com/gta_online")

            imgui.TextColoredRGB('{FFFFFF}����� ���������� � Admin Tools. ������ ������ ������ ��� ������ �� ������� {FFCC00}Luxury RolePlay{FFFFFF}.')
			imgui.TextColoredRGB('{FFFFFF}������ ����� ����� �������� � .lua ����� ������� ��� ��� ������.')
            imgui.Spacing()
			imgui.TextColoredRGB('{FF1221}������ �� �������:')
			imgui.Spacing()
			imgui.TextColoredRGB('{9999FF}                                                     | ������������� ��������� ����� |')
			imgui.TextColoredRGB('{FFFFFF}������ ������� ��������� ����� ����� ��� ��������� �� ����� ����...')
			imgui.TextColoredRGB('{FFFFFF}��� ���� ���� ����������� �������������� ����� ��������� ��� �������.')
			imgui.Spacing()
			imgui.TextColoredRGB('{9999FF}                                                     | ������������� ������� ��� �� ���� |')
			imgui.TextColoredRGB('{FFFFFF}������ ������� ��������� ������� ��� ��������, �������� �������� �������...')
			imgui.TextColoredRGB('{FFFFFF}� ���������� � �������. ��� �� ����� � ����� ��� "{FFCC00}[Forma] sis-ma{FFFFFF}"')
			imgui.Spacing()
			imgui.TextColoredRGB('{9999FF}                                                     | ������������� ����� ������ |')
			imgui.TextColoredRGB('{FFFFFF}������ ������� ��������� ����� ������, �� ���� ������ ���, ����� ����������� ����...')
			imgui.TextColoredRGB('{FFFFFF}��� ������ �� ������. ��� �� ��� ������ �� ������ ����� �������, ������� � �.�.')
			imgui.Spacing()
			imgui.TextColoredRGB('{FFFFFF}����� �� ����� ���������� ��������� �� ����������.')
			imgui.TextColoredRGB('{FFFFFF}��������� ����������������� � {FFCC00}Admin Tools {FFFFFF} :)')
        end
        if menu == 5 then
            imgui.Spacing()
            imgui.PushFont(fsClock)
			imgui.PopFont()
            imgui.BeginChild('##RadioButtons', imgui.ImVec2(190, 415), true)
        	   	if imgui.RadioButton(u8'������� ���� � �����', Radio['clock']) then Radio['clock'] = not Radio['clock']; mainini.statTimers.clock = Radio['clock'] end
	            if imgui.RadioButton(u8'������ ������', Radio['sesOnline']) then Radio['sesOnline'] = not Radio['sesOnline']; mainini.statTimers.sesOnline = Radio['sesOnline'] end
	            imgui.Hint(u8'��� ����� ��� (������ ������)')
	            if imgui.RadioButton(u8'AFK �� ������', Radio['sesAfk']) then Radio['sesAfk'] = not Radio['sesAfk']; mainini.statTimers.sesAfk = Radio['sesAfk'] end
	            if imgui.RadioButton(u8'����� �� ������', Radio['sesFull']) then Radio['sesFull'] = not Radio['sesFull']; mainini.statTimers.sesFull = Radio['sesFull'] end
	            if imgui.RadioButton(u8'������ �� ����', Radio['dayOnline']) then Radio['dayOnline'] = not Radio['dayOnline']; mainini.statTimers.dayOnline = Radio['dayOnline'] end
	            imgui.Hint(u8'��� ����� ��� (������ ������)')
	            if imgui.RadioButton(u8'��� �� ����', Radio['dayAfk']) then Radio['dayAfk'] = not Radio['dayAfk']; mainini.statTimers.dayAfk = Radio['dayAfk'] end
	            if imgui.RadioButton(u8'����� �� ����', Radio['dayFull']) then Radio['dayFull'] = not Radio['dayFull']; mainini.statTimers.dayFull = Radio['dayFull'] end
	            if imgui.RadioButton(u8'������ �� ������', Radio['weekOnline']) then Radio['weekOnline'] = not Radio['weekOnline']; mainini.statTimers.weekOnline = Radio['weekOnline'] end
	            imgui.Hint(u8'��� ����� ��� (������ ������)')
	            if imgui.RadioButton(u8'��� �� ������', Radio['weekAfk']) then Radio['weekAfk'] = not Radio['weekAfk']; mainini.statTimers.weekAfk = Radio['weekAfk'] end
                if imgui.RadioButton(u8'����� �� ������', Radio['weekFull']) then Radio['weekFull'] = not Radio['weekFull']; mainini.statTimers.weekFull = Radio['weekFull'] end
                if imgui.RadioButton(u8'������ �� �� �����', Radio['report']) then Radio['report'] = not Radio['report']; mainini.statTimers.report = Radio['report'] end
                imgui.Hint(u8'� ���� ������')
                if imgui.RadioButton(u8'��� �� �� �����', Radio['ban']) then Radio['ban'] = not Radio['ban']; mainini.statTimers.ban = Radio['ban'] end
                imgui.Hint(u8'� ���� ������')
                if imgui.RadioButton(u8'����� ��� �� �� �����', Radio['sban']) then Radio['sban'] = not Radio['sban']; mainini.statTimers.sban = Radio['sban'] end
                imgui.Hint(u8'� ���� ������')
                if imgui.RadioButton(u8'��� �� �� �����', Radio['kick']) then Radio['kick'] = not Radio['kick']; mainini.statTimers.kick = Radio['kick'] end
                imgui.Hint(u8'� ���� ������')
                if imgui.RadioButton(u8'����� ��� �� �� �����', Radio['skick']) then Radio['skick'] = not Radio['skick']; mainini.statTimers.skick = Radio['skick'] end
                imgui.Hint(u8'� ���� ������')
                if imgui.RadioButton(u8'������� �� �� �����', Radio['jail']) then Radio['jail'] = not Radio['jail']; mainini.statTimers.jail = Radio['jail'] end
                imgui.Hint(u8'� ���� ������')
                if imgui.RadioButton(u8'��� �� �� �����', Radio['mute']) then Radio['mute'] = not Radio['mute']; mainini.statTimers.mute = Radio['mute'] end
                imgui.Hint(u8'� ���� ������')
            imgui.EndChild()
            imgui.SameLine()
            imgui.BeginChild('##Customisation', imgui.ImVec2(-1, 415), true)
                imgui.PushFont(fsClock) imgui.CenterTextColoredRGB('������') imgui.PopFont()
        	    if imadd.ToggleButton(u8('##State'), to) then
		    		mainini.statTimers.state = to.v
		    		inicfg.save(mainini, 'AdminTools/AdminTools.ini')
		    	end
		    	imgui.SameLine()
		    	if to.v then
		    		imgui.TextColored(imgui.ImVec4(0.00, 0.53, 0.76, 1.00), u8'������� ������')
		    	else
		    		imgui.TextDisabled(u8'�������� ������')
		    	end
        	    if imgui.Button(u8'�������������� �������', imgui.ImVec2(-1, 20)) then
	                lua_thread.create(function ()
	                    checkCursor = true
	                    sampSetCursorMode(4)
	                	sampAddChatMessage(tag..'������� {0087FF}SPACE{FFFFFF} ���-�� ��������� �������', mcx)
	                    while checkCursor do
	                        local cX, cY = getCursorPos()
	                        posX, posY = cX, cY
	                        if isKeyDown(32) then
	                        	sampSetCursorMode(0)
	                        	mainini.pos.x, mainini.pos.y = posX, posY
	                            checkCursor = false
	                            if inicfg.save(mainini, 'AdminTools/AdminTools.ini') then sampAddChatMessage(tag..'������� ���������!', mcx) end
	                        end
	                        wait(0)
	                    end
	                end)
	            end
	            if mainini.statTimers.server == sampGetCurrentServerAddress() then
	                if imgui.Button(u8(sampGetCurrentServerName()), imgui.ImVec2(-1, 20)) then
	                    mainini.statTimers.server = nil
	                    sampAddChatMessage(tag..'������ ���� ������ �� ��������� ��������!', mcx)
	                end
	            else
	                if imgui.Button(u8'���������� ���� ������ ��������', imgui.ImVec2(-1, 20)) then
	                    mainini.statTimers.server = sampGetCurrentServerAddress()
	                    sampAddChatMessage(tag..'������ ������ ����� ��������� ������ �� ���� �������!', mcx)
	                end
	                imgui.Hint(u8'������ ����� ����������� ������ �� ���� �������!')
	            end
        	    imgui.PushItemWidth(-1)
                imgui.PopItemWidth()
                if imgui.ColorEdit4(u8'���� ����', colorW, imgui.ColorEditFlags.NoInputs) then
		            argbW = imgui.ImColor.FromFloat4(colorW.v[1], colorW.v[2], colorW.v[3], colorW.v[4]):GetU32()
		            mainini.style.colorW = argbW
                end
                imgui.SameLine()
		        if imgui.ColorEdit4(u8'���� ������', colorT, imgui.ColorEditFlags.NoInputs) then
		            argbT = imgui.ImColor.FromFloat4(colorT.v[1], colorT.v[2], colorT.v[3], colorT.v[4]):GetU32()
		            mainini.style.colorT = argbT
                end
                imgui.PushFont(fsClock) imgui.CenterTextColoredRGB('������� ���') imgui.PopFont()
                if imgui.Checkbox(u8"������� ��� ", chat) then
                    --mainini.config.chat = chat.v
                    --inicfg.save(mainini, savee)
                end
                imgui.SameLine()
                if imgui.Button(u8'�������������� ������� ���', imgui.ImVec2(-1, 20)) then
	                lua_thread.create(function ()
	                    checkCursor = true
	                    sampSetCursorMode(4)
	                	sampAddChatMessage(tag..'������� {0087FF}SPACE{FFFFFF} ���-�� ��������� �������', mcx)
	                    while checkCursor do
	                        local cX, cY = getCursorPos()
	                        �posX, �posY = cX, cY
	                        if isKeyDown(32) then
	                        	sampSetCursorMode(0)
	                        	mainini.cpos.x, mainini.cpos.y = �posX, �posY
	                            checkCursor = false
	                            if inicfg.save(mainini, 'AdminTools/AdminTools.ini') then sampAddChatMessage(tag..'������� ���������!', mcx) end
	                        end
	                        wait(0)
	                    end
	                end)
                end
                imgui.Text(u8"������ ������� ���������")
                imgui.SameLine()
                imgui.PushItemWidth(100)
                if imgui.InputText(u8'##messagesMax', messagesMax) then
                    mainini.config.messagesMax = messagesMax.v
                    inicfg.save(mainini, savee)
                end
                imgui.Text(u8"������������ ���-��� ���������")
                imgui.SameLine()
                imgui.PushItemWidth(100)
                if imgui.InputText(u8'##pagesize', pagesize) then
                    mainini.config.pagesize  = pagesize.v
                    inicfg.save(mainini, savee)
                end
                imgui.Text(u8"������ ��� ��������� ���������")
                imgui.SameLine()
                imgui.PushItemWidth(100)
                if imgui.InputText(u8'##secondaryKey', secondaryKey) then
                    mainini.config.secondaryKey = secondaryKey.v
                    inicfg.save(mainini, savee)
                end
                imgui.PushFont(fsClock) imgui.CenterTextColoredRGB('ATools') imgui.PopFont()
                if imadd.ToggleButton('##adminpass', adminpassACT) then
                    mainini.config.adminpassACT = adminpassACT.v
                    inicfg.save(mainini, savee)
                end
                imgui.SameLine()
                imgui.Text(u8"������������� ���� � �����-������")
                imgui.SameLine()
                imgui.PushItemWidth(100)
                if imgui.InputText(u8'##adminpass', adminpass) then
                    mainini.config.adminpass = adminpass.v
                    inicfg.save(mainini, savee)
                end
                if imadd.ToggleButton('##az', adminzonea) then
                    mainini.config.adminzonea = adminzonea.v
                    inicfg.save(mainini, savee)
                end
                imgui.SameLine()
                imgui.Text(u8"������")
                imgui.SameLine()
                imgui.PushItemWidth(50)
                if imgui.InputText(u8'##az', adminzone) then
                    mainini.config.adminzone = adminzone.v
                    inicfg.save(mainini, savee)
                end
                imgui.SameLine()
                imgui.PushItemWidth(50)
                if imadd.ToggleButton('##esc', esc) then
                    mainini.config.esc = esc.v
                    inicfg.save(mainini, savee)
                end
                imgui.SameLine()
                imgui.Text(u8"��������� Admin Tools �� ESC")
                if imadd.ToggleButton('##jail', jail) then
                    mainini.config.jail = jail.v
                    inicfg.save(mainini, savee)
                end
                imgui.SameLine()
                imgui.Text(u8"������������� ��������� ����� ��� /jail   ")
                imgui.SameLine()
                if imgui.Button(u8'����##1') then
                    jailmenu = true
                end
                imgui.Spacing()
                if imadd.ToggleButton('##warn', warn) then
                    mainini.config.warn = warn.v
                    inicfg.save(mainini, savee)
                end
                imgui.SameLine()
                imgui.Text(u8"������������� ��������� ����� ��� /warn")
                imgui.SameLine()
                if imgui.Button(u8'����##2') then
                    warnmenu = true
                end
                imgui.Spacing()
                if imadd.ToggleButton('##mute', mute) then
                    mainini.config.mute = mute.v
                    inicfg.save(mainini, savee)
                end
                imgui.SameLine()
                imgui.Text(u8"������������� ��������� ����� ��� /mute")
                imgui.SameLine()
                if imgui.Button(u8'����##3') then
                    mutemenu = true
                end
                imgui.Spacing()
                if imadd.ToggleButton('##sban', sban) then
                    mainini.config.sban = sban.v
                    inicfg.save(mainini, savee)
                end
                imgui.SameLine()
                imgui.Text(u8"������������� ��������� ����� ��� /sban ")
                imgui.SameLine()
                if imgui.Button(u8'����##4') then
                    sbanmenu = true
                end
                if imadd.ToggleButton('##ban', ban) then
                    mainini.config.ban = ban.v
                    inicfg.save(mainini, savee)
                end
                imgui.SameLine()
                imgui.Text(u8"������������� ��������� ����� ��� /ban   ")
                imgui.SameLine()
                if imgui.Button(u8'����##5') then
                    banmenu = true
                end
                imgui.Spacing()
                if imadd.ToggleButton('##skick', skick) then
                    mainini.config.skick = skick.v
                    inicfg.save(mainini, savee)
                end
                imgui.SameLine()
                imgui.Text(u8"������������� ��������� ����� ��� /skick ")
                imgui.SameLine()
                if imgui.Button(u8'����##6') then
                    skickmenu = true
                end
                imgui.Spacing()
                if imadd.ToggleButton('##kick', kick) then
                    mainini.config.kick = kick.v
                    inicfg.save(mainini, savee)
                end
                imgui.SameLine()
                imgui.Text(u8"������������� ��������� ����� ��� /kick  ")
                imgui.SameLine()
                if imgui.Button(u8'����##7') then
                    kickmenu = true
                end
                imgui.Spacing()
                if imadd.ToggleButton('##report', report) then
                    mainini.config.report = report.v
                    inicfg.save(mainini, savee)
                end
                imgui.SameLine()
                imgui.Text(u8"������������� ����� ������")
            imgui.EndChild()
            if imgui.Button(u8'���������', imgui.ImVec2(-1, 20)) then
                if inicfg.save(mainini, 'AdminTools/AdminTools.ini') then
                    if bNotf then
                        notf.addNotification(("��������� ���������!"), 4, 2)
                    end
                end
            end
        end
        if menu == 6 then
            imgui.Spacing()
            imgui.Text(u8'������ �� ������')
            imgui.Text(u8'����� ��������: '..get_clock(mainini.onWeek.full))
            imgui.NewLine()
            for day = 1, 6 do -- �� -> ��
                imgui.Text(u8(tWeekdays[day])); imgui.SameLine(250)
                imgui.Text(get_clock(mainini.myWeekOnline[day]))
            end
            --> ��
            imgui.Text(u8(tWeekdays[0])); imgui.SameLine(250)
            imgui.Text(get_clock(mainini.myWeekOnline[0]))
            imgui.Text(u8'���������� ��� ��������')
            --imgui.Text(u8'sBan: '..sban..' ���')
            --imgui.Text(u8'Ban: '..bstat..' ���')
            --imgui.Text(u8'sKikc: '..skstat..' ���')
            --imgui.Text(u8'Kick: '..kstat..' ���')
            --imgui.Text(u8'Report: '..rstat..' ���')
            --imgui.Text(u8'Muts: '..mstat..' ���')
        end
    imgui.End()
    end
    if jailmenu then
        imgui.OpenPopup(u8'������ ������')
        if imgui.BeginPopupModal(u8'������ ������', true, imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoResize) then
            imgui.ShowCursor = true
            imgui.CenterText(u8" ----- ������ ������ ----- ")
            imgui.NewLine()
            imgui.PushItemWidth(250)
            if imgui.InputText(u8'', JailText) then
                mainini.config.JailText = JailText.v
                inicfg.save(mainini, savee)
            end
            imgui.NewLine()
            local wid = imgui.GetWindowWidth()
            imgui.SetCursorPosX(wid / 2 - 50)
            if imgui.Button(u8'������',imgui.ImVec2(100,30)) then
                sampSendChat(''..(u8:decode(JailText.v)), -1)
                imgui.CloseCurrentPopup()
                imgui.ShowCursor = false
                jailmenu = false
            end
            imgui.SetCursorPosX(wid / 2 - 50)
            if imgui.Button(u8'����������',imgui.ImVec2(100,30)) then
                sampSendChat('/re '..jailid, -1)
                imgui.CloseCurrentPopup()
                imgui.ShowCursor = false
                jailmenu = false
            end
            imgui.SetCursorPosX(wid / 2 - 50)
            if imgui.Button(u8'�������',imgui.ImVec2(100,30)) then
                imgui.CloseCurrentPopup()
                imgui.ShowCursor = false
                jailmenu = false
            end
            imgui.EndPopup()
        end
    end
    if sbanmenu then
        imgui.OpenPopup(u8'������ �����')
        if imgui.BeginPopupModal(u8'������ �����', true, imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoResize) then
            imgui.ShowCursor = true
            imgui.CenterText(u8" ----- ������ ����� ----- ")
            imgui.NewLine()
            imgui.PushItemWidth(250)
            if imgui.InputText(u8'', sBanText) then
                mainini.config.sBanText = sBanText.v
                inicfg.save(mainini, savee)
            end
            imgui.NewLine()
            local wid = imgui.GetWindowWidth()
            imgui.SetCursorPosX(wid / 2 - 50)
            if imgui.Button(u8'��������',imgui.ImVec2(100,30)) then
                sampSendChat(''..(u8:decode(sBanText.v)), -1)
                imgui.CloseCurrentPopup()
                imgui.ShowCursor = false
                sbanmenu = false
            end
            imgui.SetCursorPosX(wid / 2 - 50)
            if imgui.Button(u8'����������',imgui.ImVec2(100,30)) then
                sampSendChat('/re '..banid, -1)
                imgui.CloseCurrentPopup()
                imgui.ShowCursor = false
                sbanmenu = false
            end
            imgui.SetCursorPosX(wid / 2 - 50)
            if imgui.Button(u8'�������',imgui.ImVec2(100,30)) then
                imgui.CloseCurrentPopup()
                imgui.ShowCursor = false
                sbanmenu = false
            end
            imgui.EndPopup()
        end
    end
    if banmenu then
        imgui.OpenPopup(u8'������ ����')
        if imgui.BeginPopupModal(u8'������ ����', true, imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoResize) then
            imgui.ShowCursor = true
            imgui.CenterText(u8" ----- ������ ���� ----- ")
            imgui.NewLine()
            imgui.PushItemWidth(250)
            if imgui.InputText(u8'', BanText) then
                mainini.config.BanText = BanText.v
                inicfg.save(mainini, savee)
            end
            imgui.NewLine()
            local wid = imgui.GetWindowWidth()
            imgui.SetCursorPosX(wid / 2 - 50)
            if imgui.Button(u8'��������',imgui.ImVec2(100,30)) then
                sampSendChat(''..(u8:decode(BanText.v)), -1)
                imgui.CloseCurrentPopup()
                imgui.ShowCursor = false
                banmenu = false
            end
            imgui.SetCursorPosX(wid / 2 - 50)
            if imgui.Button(u8'����������',imgui.ImVec2(100,30)) then
                sampSendChat('/re '..banid, -1)
                imgui.CloseCurrentPopup()
                imgui.ShowCursor = false
                banmenu = false
            end
            imgui.SetCursorPosX(wid / 2 - 50)
            if imgui.Button(u8'�������',imgui.ImVec2(100,30)) then
                imgui.CloseCurrentPopup()
                imgui.ShowCursor = false
                banmenu = false
            end
            imgui.EndPopup()
        end
    end
    if skickmenu then
        imgui.OpenPopup(u8'������ �����')
        if imgui.BeginPopupModal(u8'������ �����', true, imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoResize) then
            imgui.ShowCursor = true
            imgui.CenterText(u8" ----- ������ ����� ----- ")
            imgui.NewLine()
            imgui.PushItemWidth(250)
            if imgui.InputText(u8'', sKickText) then
                mainini.config.sKickText = sKickText.v
                inicfg.save(mainini, savee)
            end
            imgui.NewLine()
            local wid = imgui.GetWindowWidth()
            imgui.SetCursorPosX(wid / 2 - 50)
            if imgui.Button(u8'�������',imgui.ImVec2(100,30)) then
                sampSendChat(''..(u8:decode(sKickText.v)), -1)
                imgui.CloseCurrentPopup()
                imgui.ShowCursor = false
                skickmenu = false
            end
            imgui.SetCursorPosX(wid / 2 - 50)
            if imgui.Button(u8'����������',imgui.ImVec2(100,30)) then
                sampSendChat('/re '..kickid, -1)
                imgui.CloseCurrentPopup()
                imgui.ShowCursor = false
                skickmenu = false
            end
            imgui.SetCursorPosX(wid / 2 - 50)
            if imgui.Button(u8'�������',imgui.ImVec2(100,30)) then
                imgui.CloseCurrentPopup()
                imgui.ShowCursor = false
                skickmenu = false
            end
            imgui.EndPopup()
        end
    end
	if kickmenu then
        imgui.OpenPopup(u8'������ ����')
        if imgui.BeginPopupModal(u8'������ ����', true, imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoResize) then
            imgui.ShowCursor = true
            imgui.CenterText(u8" ----- ������ ���� ----- ")
            imgui.NewLine()
            imgui.PushItemWidth(250)
            if imgui.InputText(u8'', KickText) then
                mainini.config.KickText = KickText.v
                inicfg.save(mainini, savee)
            end
            imgui.NewLine()
            local wid = imgui.GetWindowWidth()
            imgui.SetCursorPosX(wid / 2 - 50)
            if imgui.Button(u8'�������',imgui.ImVec2(100,30)) then
                sampSendChat(''..(u8:decode(KickText.v)), -1)
                imgui.CloseCurrentPopup()
                imgui.ShowCursor = false
                kickmenu = false
            end
            imgui.SetCursorPosX(wid / 2 - 50)
            if imgui.Button(u8'����������',imgui.ImVec2(100,30)) then
                sampSendChat('/re '..kickid, -1)
                imgui.CloseCurrentPopup()
                imgui.ShowCursor = false
                kickmenu = false
            end
            imgui.SetCursorPosX(wid / 2 - 50)
            if imgui.Button(u8'�������',imgui.ImVec2(100,30)) then
                imgui.CloseCurrentPopup()
                imgui.ShowCursor = false
                kickmenu = false
            end
            imgui.EndPopup()
        end
    end
    if warnmenu then
        imgui.OpenPopup(u8'������ �����')
        if imgui.BeginPopupModal(u8'������ �����', true, imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoResize) then
            imgui.ShowCursor = true
            imgui.CenterText(u8" ----- ������ ����� ----- ")
            imgui.NewLine()
            imgui.PushItemWidth(250)
            if imgui.InputText(u8'', WarnText) then
                mainini.config.WarnText = WarnText.v
                inicfg.save(mainini, savee)
            end
            imgui.NewLine()
            local wid = imgui.GetWindowWidth()
            imgui.SetCursorPosX(wid / 2 - 50)
            if imgui.Button(u8'���������',imgui.ImVec2(100,30)) then
                sampSendChat(''..(u8:decode(WarnText.v)), -1)
                imgui.CloseCurrentPopup()
                imgui.ShowCursor = false
                warnmenu = false
            end
            imgui.SetCursorPosX(wid / 2 - 50)
            if imgui.Button(u8'����������',imgui.ImVec2(100,30)) then
                sampSendChat('/re '..warnid, -1)
                imgui.CloseCurrentPopup()
                imgui.ShowCursor = false
                warnmenu = false
            end
            imgui.SetCursorPosX(wid / 2 - 50)
            if imgui.Button(u8'�������',imgui.ImVec2(100,30)) then
                imgui.CloseCurrentPopup()
                imgui.ShowCursor = false
                warnmenu = false
            end
            imgui.EndPopup()
    end end
    if mutemenu then
        imgui.OpenPopup(u8'������ ����')
        if imgui.BeginPopupModal(u8'������ ����', true, imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoResize) then
            imgui.ShowCursor = true
            imgui.CenterText(u8" ----- ������ ���� ----- ")
            imgui.NewLine()
            imgui.PushItemWidth(250)
            if imgui.InputText(u8'', MuteText) then
                mainini.config.MuteText = MuteText.v
                inicfg.save(mainini, savee)
            end
            imgui.NewLine()
            local wid = imgui.GetWindowWidth()
            imgui.SetCursorPosX(wid / 2 - 50)
            if imgui.Button(u8'��������',imgui.ImVec2(100,30)) then
                sampSendChat(''..(u8:decode(MuteText.v)), -1)
                imgui.CloseCurrentPopup()
                imgui.ShowCursor = false
                mutemenu = false
            end
            imgui.SetCursorPosX(wid / 2 - 50)
            if imgui.Button(u8'����������',imgui.ImVec2(100,30)) then
                sampSendChat('/re '..muteid, -1)
                imgui.CloseCurrentPopup()
                imgui.ShowCursor = false
                mutemenu = false
            end
            imgui.SetCursorPosX(wid / 2 - 50)
            if imgui.Button(u8'�������',imgui.ImVec2(100,30)) then
                imgui.CloseCurrentPopup()
                imgui.ShowCursor = false
                mutemenu = false
            end
            imgui.EndPopup()
    end end
    if reportmenu then
        imgui.OpenPopup(u8'����� �� ������')
        if imgui.BeginPopupModal(u8'����� �� ������', true, imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoResize) then
            imgui.ShowCursor = true
            imgui.CenterText(u8'����� ������ '..nickreport)
            imgui.NewLine()
            imgui.Text(u8''..ReportText.v)
            imgui.NewLine()
            imgui.PushItemWidth(500)
            imgui.InputText(u8'',  ReportTextOtvet)

            imgui.NewLine()
            local wid = imgui.GetWindowWidth()
            imgui.SetCursorPosX(wid / 2 - 50)
            if imgui.Button(u8'��������',imgui.ImVec2(100,30)) then
                sampSendChat('/pm '..reportid..' '..(u8:decode(ReportTextOtvet.v)), -1)
                imgui.CloseCurrentPopup()
                imgui.ShowCursor = false
                reportmenu = false
            end
            imgui.SetCursorPosX(wid / 2 - 50)
            if imgui.Button(u8'����������',imgui.ImVec2(100,30)) then
                sampSendChat('/re '..reportid, -1)
                imgui.CloseCurrentPopup()
                imgui.ShowCursor = false
                reportmenu = false
            end
            imgui.SameLine()
            imgui.SetCursorPosX(wid / 2 - 155)
            if imgui.Button(u8'�������',imgui.ImVec2(100,30)) then
                sampSendChat('/slap '..reportid, -1)
                imgui.CloseCurrentPopup()
                imgui.ShowCursor = false
                reportmenu = false
            end
            imgui.SameLine()
            imgui.SetCursorPosX(wid / 2 - -55)
            if imgui.Button(u8'/sethp '..reportid..' 0',imgui.ImVec2(100,30)) then
                sampSendChat('/sethp '..reportid..' 0')
                imgui.CloseCurrentPopup()
                imgui.ShowCursor = false
                reportmenu = false
            end
            imgui.SetCursorPosX(wid / 2 - 50)
            if imgui.Button(u8'�������',imgui.ImVec2(100,30)) then
                imgui.CloseCurrentPopup()
                imgui.ShowCursor = false
                reportmenu = false
            end
            imgui.EndPopup()
    end end
    -- timer window >>
    if to.v and not recon then
    	imgui.PushStyleColor(imgui.Col.WindowBg, imgui.ImVec4(imgui.ImColor(argbW):GetFloat4()))
	    imgui.PushStyleColor(imgui.Col.Text, imgui.ImVec4(imgui.ImColor(argbT):GetFloat4()))
    	imgui.PushStyleVar(imgui.StyleVar.WindowRounding, sRound.v)
        imgui.SetNextWindowPos(imgui.ImVec2(posX, posY), imgui.Cond.Always)
        imgui.Begin(u8'##timer', _, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove + imgui.WindowFlags.NoCollapse + imgui.WindowFlags.AlwaysAutoResize + imgui.WindowFlags.NoTitleBar)

        if mainini.statTimers.clock then
	        imgui.PushFont(fsClock)
	        imgui.CenterTextColoredRGB(nowTime)
            imgui.PopFont()
            imgui.SetCursorPosY(30)
            imgui.CenterTextColoredRGB(getStrDate(os.time()))
	        if mainini.statTimers.sesOnline or mainini.statTimers.sesAfk or mainini.statTimers.sesFull or mainini.statTimers.dayOnline or mainini.statTimers.dayAfk or mainini.statTimers.dayFull or mainini.statTimers.weekOnline or mainini.statTimers.weekAfk or mainini.statTimers.weekFull then
	       		imgui.Separator()
	    	end
	    end

        imgui.PushStyleVar(imgui.StyleVar.ItemSpacing, imgui.ImVec2(5, 2))
        if sampGetGamestate() ~= 3 then
            imgui.CenterTextColoredRGB("�����������: "..get_clock(connectingTime))
        else
            if mainini.statTimers.sesOnline then imgui.CenterTextColoredRGB("������ (������): "..get_clock(sesOnline.v)) end
            if mainini.statTimers.sesAfk then imgui.CenterTextColoredRGB("AFK �� ������: "..get_clock(sesAfk.v)) end
            if mainini.statTimers.sesFull then imgui.CenterTextColoredRGB("������ �� ������: "..get_clock(sesFull.v)) end
            if mainini.statTimers.dayOnline then imgui.CenterTextColoredRGB("�� ���� (������): "..get_clock(mainini.onDay.online)) end
            if mainini.statTimers.dayAfk then imgui.CenterTextColoredRGB("��� �� ����: "..get_clock(mainini.onDay.afk)) end
            if mainini.statTimers.dayFull then imgui.CenterTextColoredRGB("������ �� ����: "..get_clock(mainini.onDay.full)) end
            if mainini.statTimers.weekOnline then imgui.CenterTextColoredRGB("�� ������ (������): "..get_clock(mainini.onWeek.online)) end
            if mainini.statTimers.weekAfk then imgui.CenterTextColoredRGB("��� �� ������: "..get_clock(mainini.onWeek.afk)) end
            if mainini.statTimers.weekFull then imgui.CenterTextColoredRGB("������ �� ������: "..get_clock(mainini.onWeek.full)) end
            if mainini.statTimers.report then imgui.CenterTextColoredRGB("������ �� �������: "..rstat.v) end
            if mainini.statTimers.ban then imgui.CenterTextColoredRGB("Ban �� �� �����: "..bstat.v) end
            if mainini.statTimers.sban then imgui.CenterTextColoredRGB("SBan �� �� �����: "..sbstat.v) end
            if mainini.statTimers.kick then imgui.CenterTextColoredRGB("Kick �� �� �����: "..kstat.v) end
            if mainini.statTimers.skick then imgui.CenterTextColoredRGB("SKick �� �� �����: "..skstat.v) end
            if mainini.statTimers.jail then imgui.CenterTextColoredRGB("�������� �� �� �����: "..jstat.v) end
            if mainini.statTimers.mute then imgui.CenterTextColoredRGB("������� �� �� �����: "..mstat.v) end
        end
        imgui.PopStyleVar()
        imgui.End()
        imgui.PopStyleVar()
        imgui.PopStyleColor(2)
    end
end
-- main
function main()
	print("���� ��:"..getserial())
	checkKey()
    autoupdate("https://raw.githubusercontent.com/codero4ik/atols/main/updates.json", '['..string.upper(thisScript().name)..']: ', "https://raw.githubusercontent.com/codero4ik/atols/main/updates.json")
    while not isSampAvailable() do wait(100) end
    --bubbleBox = ChatBox(pagesize, mainini.config.blacklist)
    developer()
    if bNotf then
        notf.addNotification("[AdminTools]: Loaded! \n Author: Coderok, Alex", 5, 1)
    end
    if not doesFileExist('moonloader/config/AdminTools/AdminTools.ini') then
        if inicfg.save(mainini, 'AdminTools/AdminTools.ini') then sampfuncsLog(tag..'������ ���� ������������: AdminTools.ini') end
    end
    if mainini.statTimers.server ~= nil and mainini.statTimers.server ~= sampGetCurrentServerAddress() then
        sampAddChatMessage(tag..'�� ����� �� ���� �� �������� ������. ������ ��������!', mcx)
        thisScript():unload()
    end
     if mainini.onDay.today ~= os.date("%a") then
        mainini.onDay.today = os.date("%a")
        mainini.onDay.online = 0
        mainini.onDay.full = 0
        mainini.onDay.afk = 0
        dayFull.v = 0
        inicfg.save(mainini, 'AdminTools/AdminTools.ini')
    end
    if mainini.onWeek.week ~= number_week() then
        mainini.onWeek.week = number_week()
        mainini.onWeek.online = 0
        mainini.onWeek.full = 0
        mainini.onWeek.afk = 0
        weekFull.v = 0
        for _, v in pairs(mainini.myWeekOnline) do v = 0 end
        inicfg.save(mainini, 'AdminTools/AdminTools.ini')
    end
    lua_thread.create(time)
    lua_thread.create(autoSave)
    ClickWP = lua_thread.create(ClickWP)
    ffi.C.SetWindowTextA(ffi.C.GetActiveWindow(), '* ATools By Codero4ek/Alex')
    while true do wait(0) imgui.Process = true
        imgui.Process = to.v
        if active_menu.v then
            imgui.ShowCursor = true
            imgui.Process = true
        else
            imgui.ShowCursor = false
        end
        --if mainini.config.chat then
		--	bubbleBox:toggle(not bubbleBox.active)
        --end
        --if bubbleBox.active then
		--	bubbleBox:draw(cposX, cposY)
		--	if is_key_check_available() and isKeyDown(secondaryKey) then
		--		if getMousewheelDelta() ~= 0 then
		--			bubbleBox:scroll(getMousewheelDelta() * -1)
		--		end
		--	end
		--end
        if isKeyJustPressed(VK_F2) and not sampIsChatInputActive() and not isSampfuncsConsoleActive() then
            active_menu.v = not active_menu.v
        end

        if godmode.v then
            setCharProofs(PLAYER_PED, true, true, true, true, true)
            writeMemory(0x96916D, 1,  1, true)
            writeMemory(0xB7CEE6, 1, 1, true)
            makePlayerFireProof(PLAYER_HANDLE, true)
            local cped = getCharPointer(PLAYER_PED)
            local cped1 = cped + 66
            writeMemory(cped1, 1, 0xCC, false)
        else
            setCharProofs(PLAYER_PED, false, false, false, false, false)
            writeMemory(0x96916D, 1,  0, true)
            writeMemory(0xB7CEE6, 1, 0, true)
            makePlayerFireProof(PLAYER_HANDLE, false)
            local cped = getCharPointer(PLAYER_PED)
            local cped1 = cped + 66
            writeMemory(cped1, 1, 0, false)
        end
    end
end