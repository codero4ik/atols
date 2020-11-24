script_author("Coder,Alex")
script_version('0.1.1')
--Библиотеки
require "lib.moonloader"
local memory = require 'memory' -- для варпа
local imgui = require 'imgui' -- GUI
local bNotf, notf = pcall(import, "imgui_notf.lua")
local flags = require 'moonloader'.font_flag
local key = require 'vkeys' -- Клавиши
local encoding = require 'encoding' -- для язык
local inicfg = require 'inicfg' -- для конфигов
imgui.HotKey = require 'imgui_addons'.HotKey -- для чекера)
local sampev = require 'lib.samp.events' -- samp event
local v = require 'semver' -- для чекера
local dlstatus = require('moonloader').download_status -- узнаём статус загрузки
encoding.default = 'CP1251' -- ставим кодировку
u8 = encoding.UTF8 -- выводим кодировку в UTF8 для игры
--Создание папки и скаживание фотки
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
--Конфиг
local mainini = inicfg.load({
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
        debug = false
    },
    status = {
        sban = 0,
        ban = 0,
        skick = 0,
        kick = 0,
        report = 0,
        warn = 0,
        jail = 0,
        mute = 0,
    },
    statTimers = {
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
	onDay = {
		today = os.date("%a"),
		online = 0,
		afk = 0,
		full = 0
	},
	onWeek = {
		week = 1,
		online = 0,
		afk = 0,
		full = 0
	},
    myWeekOnline = {
        [0] = 0,
        [1] = 0,
        [2] = 0,
        [3] = 0,
        [4] = 0,
        [5] = 0,
        [6] = 0
    },
    pos = {
        x = 0,
        y = 0
    },
    style = {
    	round = 10.0,
    	colorW = 4279834905,
    	colorT = 4286677377
    },
    settings = {
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
    lists = {
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
--Проверка на конфиг если нету то создаём
local status = inicfg.load(mainini, 'AdminTools/AdminTools.ini')
if not doesFileExist('moonloader/config/AdminTools/AdminTools.ini') then inicfg.save(mainini, 'AdminTools/AdminTools.ini') end
--Буфферы
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
jstat = imgui.ImBuffer(mainini.status.jail)
sBanText = imgui.ImBuffer(u8''.. mainini.config.BanText, 256)
sbstat = imgui.ImBuffer(mainini.status.sban)
BanText = imgui.ImBuffer(u8''.. mainini.config.BanText, 256)
bstat = imgui.ImBuffer(''.. mainini.status.ban, 256)
sKickText = imgui.ImBuffer(u8''.. mainini.config.sKickText, 256)
skstat = imgui.ImBuffer(mainini.status.skick)
KickText = imgui.ImBuffer(u8''.. mainini.config.KickText, 256)
kstat = imgui.ImBuffer(mainini.status.kick)
WarnText = imgui.ImBuffer(u8''.. mainini.config.WarnText, 256)
wstat = imgui.ImBuffer(mainini.status.warn)
MuteText = imgui.ImBuffer(u8''.. mainini.config.MuteText, 256)
mstat = imgui.ImBuffer(mainini.status.mute)
ReportText = imgui.ImBuffer(2560)
rstat = imgui.ImBuffer(mainini.status.report)
ReportTextOtvet = imgui.ImBuffer(2560)
active_menu = imgui.ImBool(false)
--Лог
local logText = {} -- Буфер для логов
local logFilter = imgui.ImBuffer(128) -- максимальный буфер
local clearlog = false -- отчиска буфера
local copylog = false -- копировать буфер
local testlog = false -- тест лого
local savee = "AdminTools/AdminTools.ini" -- сохранение файла
-- переменные
mcx = 0x0087FF
local sX, sY = getScreenResolution() -- узнаём разрешение экрана у игры
local tag = '{0087FF}ATools: {FFFFFF}' --Название в чате
local prefix = 'Checker'
local bindID = 0
local loadedUsers = {}
local onlineUsers = {}
local tempBuffers = {}
local to = imgui.ImBool(mainini.statTimers.state) -- ставим время в таймер
local nowTime = os.date("%H:%M:%S", os.time()) -- узнаём дату
local pos = false -- для настройки места таймера
local restart = false -- рестарт таймера
local recon = false -- проверка если в recon
local sesOnline = imgui.ImInt(0) -- запись в онлайне
local sesAfk = imgui.ImInt(0) -- запись в афка
local sesFull = imgui.ImInt(0) -- полный онлайн
local dayFull = imgui.ImInt(mainini.onDay.full) -- запись онлайна за день
local weekFull = imgui.ImInt(mainini.onWeek.full) -- запись онлайна за неделю
local sRound = imgui.ImFloat(mainini.style.round) -- 
local argbW = mainini.style.colorW -- цвет для таймера
local argbT = mainini.style.colorT -- цвет для таймера
local colorW = imgui.ImFloat4(imgui.ImColor(argbW):GetFloat4()) -- изменяем цвет таймера
local colorT = imgui.ImFloat4(imgui.ImColor(argbT):GetFloat4()) -- изменяеи цвет таймера
local posX, posY = mainini.pos.x, mainini.pos.y -- Pos x, Pos y для таймера
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
-- Выбор для таймера
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
	['weekFull'] = mainini.statTimers.weekFull
}
-- Дни недели
local tWeekdays = {
    [0] = 'Воскресенье',
    [1] = 'Понедельник', 
    [2] = 'Вторник', 
    [3] = 'Среда', 
    [4] = 'Четверг', 
    [5] = 'Пятница', 
    [6] = 'Суббота'
}
--Иконки

-- Окна
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
            if not menu then menu = 1 end
            imgui.Separator()
            if mainini.config.debug then
                if imgui.Button('Debug for Developers',imgui.ImVec2(207, 50)) then
                    menu = 0
                    if bNotf then
                        notf.addNotification(("Вкладка Developers!"), 4, 2)
                    end
                end
            end
            if imgui.Button(u8'Основное',imgui.ImVec2(207, 50)) then
                menu = 1
            end
            if imgui.Button(u8'Админ читы',imgui.ImVec2(207, 50)) then 
                menu = 2
            end
            if imgui.Button(u8'Журнал наказаний',imgui.ImVec2(207, 50)) then 
                menu = 3
            end
            if imgui.Button(u8'Информация',imgui.ImVec2(207, 50)) then 
                menu = 4
            end
            if imgui.Button(u8'Настройки',imgui.ImVec2(207, 50)) then
                menu = 5
            end
            if imgui.Button(u8'Таймер Статистика',imgui.ImVec2(207, 50)) then
                menu = 6
            end
        imgui.EndChild()
        imgui.SetColumnWidth(-1, 232)
        imgui.NextColumn()
        imgui.BeginChild("##zagolovok", imgui.ImVec2(600, 35), true)
        if menu == 0 then 
            imgui.CenterText(u8'Для разработчика')
        elseif menu == 1 then
            imgui.CenterText(u8"Основное")
        elseif menu == 2 then
            imgui.CenterText(u8"Админ читы")
        elseif menu == 3 then
            imgui.CenterText(u8"Журнал наказаний")
        elseif menu == 4 then
            imgui.CenterText(u8"Информация")
        elseif menu == 5 then
            imgui.CenterText(u8"Настройки")
        elseif menu == 6 then
            imgui.CenterText(u8"Таймер Статистика")
        elseif menu == 7 then
            imgui.CenterText(u8"Настройки Чекера")
        end
        imgui.EndChild()
        if menu == 0 then 
            imgui.Spacing()
        end
        if menu == 1 then
            imgui.Spacing()
            if imgui.Checkbox(u8"Автоматически принимать форму для /jail  ", jail) then
                mainini.config.jail = jail.v
                inicfg.save(mainini, savee)
            end
            imgui.SameLine()
            if imgui.Button(u8'Меню##1') then
                jailmenu = true
            end
            imgui.Spacing()
            if imgui.Checkbox(u8"Автоматически принимать форму для /warn", warn) then
                mainini.config.warn = warn.v
                inicfg.save(mainini, savee)
            end
            imgui.SameLine()
            if imgui.Button(u8'Меню##2') then
                warnmenu = true
            end
            imgui.Spacing()
            if imgui.Checkbox(u8"Автоматически принимать форму для /mute", mute) then
                mainini.config.mute = mute.v
                inicfg.save(mainini, savee)
            end
            imgui.SameLine()
            if imgui.Button(u8'Меню##3') then
                mutemenu = true
            end
            imgui.Spacing()
            if imgui.Checkbox(u8"Автоматически принимать форму для /sban   ", sban) then
                mainini.config.sban = sban.v
                inicfg.save(mainini, savee)
            end
            imgui.SameLine()
            if imgui.Button(u8'Меню##4') then
                sbanmenu = true
            end
            if imgui.Checkbox(u8"Автоматически принимать форму для /ban   ", ban) then
                mainini.config.ban = ban.v
                inicfg.save(mainini, savee)
            end
            imgui.SameLine()
            if imgui.Button(u8'Меню##5') then
                banmenu = true
            end
            imgui.Spacing()
            if imgui.Checkbox(u8"Автоматически принимать форму для /skick", skick) then
                mainini.config.skick = skick.v
                inicfg.save(mainini, savee)
            end
            imgui.SameLine()
            if imgui.Button(u8'Меню##6') then
                skickmenu = true
            end
			imgui.Spacing()
            if imgui.Checkbox(u8"Автоматически принимать форму для /kick", kick) then
                mainini.config.kick = kick.v
                inicfg.save(mainini, savee)
            end
            imgui.SameLine()
            if imgui.Button(u8'Меню##7') then
                kickmenu = true
            end
            imgui.Spacing()
            if imgui.Checkbox(u8"Автоматически брать репорт", report) then
                mainini.config.report = report.v
                inicfg.save(mainini, savee)
            end
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
		    		imgui.Text(u8"Совпадения не найдены ...")
		    	end
		    else
		    	imgui.Text(u8"Журнал пуст ...")
		    end
		    if ScrollToButton then
			imgui.SetScrollHere()
		    	ScrollToButton = false
	    	end
	        imgui.PopStyleVar()
            imgui.EndChild()
            imgui.BeginChild('##6', imgui.ImVec2(600, 38), true)
            if imgui.RadioButton(u8'Очистить журнал', clearlog) and #logText > 0 then
                logText = {}
                addLog("Журнал очищен ...")
                clearlog = false
            end
            imgui.SameLine()
            if imgui.RadioButton(u8'Копировать журнал', copylog) and #logText > 0 then
                local t = ""
                for k, v in ipairs(logText) do
                    t = t .. (tostring(t):len() > 0 and "\n" or "") .. v
                end
                setClipboardText(t)
                addLog("Содержимое журнала скопировано в буфер. Используйте CTRL + V")
                copylog = false
            end
            imgui.SameLine()
            if imgui.RadioButton(u8'Проверка', testlog) then
                toLog = "Администратор Angels_Vollar посадил(а) Ya_Cheater в ДеМорган на 20 мин. Причина: ДМ"
                addLog(toLog) 
                testlog = false
            end
            imgui.EndChild()
        end
        if menu == 4 then
            imgui.Spacing()
            imgui.Text(u8'Скрипт сделан для проекта Luxury RolePlay')
            imgui.SameLine()
            imgui.Link("vk.com/gta_online")

            imgui.TextColoredRGB('{FFFFFF}Добро пожаловать в Admin Tools. Данный скрипт сделан для работы на сервере {FFCC00}Luxury RolePlay{FFFFFF}.') 
			imgui.TextColoredRGB('{FFFFFF}Скрипт легко можно изменить в .lua через блокнот под Ваш сервер.') 
            imgui.Spacing()
			imgui.TextColoredRGB('{FF1221}Помощь по скрипту:') 
			imgui.Spacing()
			imgui.TextColoredRGB('{9999FF}                                                     | Автоматически принимать форму |') 
			imgui.TextColoredRGB('{FFFFFF}Данная функция позволяет брать форму для наказания из админ чата...') 
			imgui.TextColoredRGB('{FFFFFF}При этом есть возможность корректировать время наказания или причину.') 
			imgui.Spacing()
			imgui.TextColoredRGB('{9999FF}                                                     | Автоматически снимать мут за спам |') 
			imgui.TextColoredRGB('{FFFFFF}Данная функция позволяет снимать мут человеку, которого замутила система...') 
			imgui.TextColoredRGB('{FFFFFF}В подозрение в рекламе. Так же пишет в Общий Чат "{FFCC00}[Forma] sis-ma{FFFFFF}"') 
			imgui.Spacing()
			imgui.TextColoredRGB('{9999FF}                                                     | Автоматически брать репорт |') 
			imgui.TextColoredRGB('{FFFFFF}Данная функция позволяет брать репорт, то есть делать так, чтобы выскакивало меню...') 
			imgui.TextColoredRGB('{FFFFFF}При жалобе от игрока. Так же при ответе на жалобу можно слапать, убивать и т.д.') 
			imgui.Spacing()
			imgui.TextColoredRGB('{FFFFFF}Думаю со всеми остальными функциями вы разберётесь.') 
			imgui.TextColoredRGB('{FFFFFF}Приятного Администрирования с {FFCC00}Admin Tools {FFFFFF} :)') 
			
        end
        if menu == 5 then
            imgui.Spacing()
            imgui.PushFont(fsClock) 
			imgui.PopFont()
            imgui.BeginChild('##RadioButtons', imgui.ImVec2(190, 245), true)
        	   	if imgui.RadioButton(u8'Текущее дата и время', Radio['clock']) then Radio['clock'] = not Radio['clock']; mainini.statTimers.clock = Radio['clock'] end
	            if imgui.RadioButton(u8'Онлайн сессию', Radio['sesOnline']) then Radio['sesOnline'] = not Radio['sesOnline']; mainini.statTimers.sesOnline = Radio['sesOnline'] end
	            imgui.Hint(u8'Без учёта АФК (Чистый онлайн)')
	            if imgui.RadioButton(u8'AFK за сессию', Radio['sesAfk']) then Radio['sesAfk'] = not Radio['sesAfk']; mainini.statTimers.sesAfk = Radio['sesAfk'] end
	            if imgui.RadioButton(u8'Общий за сессию', Radio['sesFull']) then Radio['sesFull'] = not Radio['sesFull']; mainini.statTimers.sesFull = Radio['sesFull'] end
	            if imgui.RadioButton(u8'Онлайн за день', Radio['dayOnline']) then Radio['dayOnline'] = not Radio['dayOnline']; mainini.statTimers.dayOnline = Radio['dayOnline'] end
	            imgui.Hint(u8'Без учёта АФК (Чистый онлайн)')
	            if imgui.RadioButton(u8'АФК за день', Radio['dayAfk']) then Radio['dayAfk'] = not Radio['dayAfk']; mainini.statTimers.dayAfk = Radio['dayAfk'] end
	            if imgui.RadioButton(u8'Общий за день', Radio['dayFull']) then Radio['dayFull'] = not Radio['dayFull']; mainini.statTimers.dayFull = Radio['dayFull'] end
	            if imgui.RadioButton(u8'Онлайн за неделю', Radio['weekOnline']) then Radio['weekOnline'] = not Radio['weekOnline']; mainini.statTimers.weekOnline = Radio['weekOnline'] end
	            imgui.Hint(u8'Без учёта АФК (Чистый онлайн)')
	            if imgui.RadioButton(u8'АФК за неделю', Radio['weekAfk']) then Radio['weekAfk'] = not Radio['weekAfk']; mainini.statTimers.weekAfk = Radio['weekAfk'] end
	            if imgui.RadioButton(u8'Общий за неделю', Radio['weekFull']) then Radio['weekFull'] = not Radio['weekFull']; mainini.statTimers.weekFull = Radio['weekFull'] end
            imgui.EndChild()
            imgui.SameLine()
            imgui.BeginChild('##Customisation', imgui.ImVec2(-1, 245), true)
        	    if imgui.Checkbox(u8('##State'), to) then 
		    		mainini.statTimers.state = to.v
		    		inicfg.save(mainini, 'AdminTools/AdminTools.ini')
		    	end
		    	imgui.SameLine()
		    	if to.v then
		    		imgui.TextColored(imgui.ImVec4(0.00, 0.53, 0.76, 1.00), u8'Включено')
		    	else
		    		imgui.TextDisabled(u8'Выключено')
		    	end
        	    if imgui.Button(u8'Местоположение', imgui.ImVec2(-1, 20)) then
	                lua_thread.create(function ()
	                    checkCursor = true
	                    sampSetCursorMode(4)
	                	sampAddChatMessage(tag..'Нажмите {0087FF}SPACE{FFFFFF} что-бы сохранить позицию', mcx)
	                    while checkCursor do
	                        local cX, cY = getCursorPos()
	                        posX, posY = cX, cY
	                        if isKeyDown(32) then
	                        	sampSetCursorMode(0)
	                        	mainini.pos.x, mainini.pos.y = posX, posY
	                            checkCursor = false
	                            if inicfg.save(mainini, 'AdminTools/AdminTools.ini') then sampAddChatMessage(tag..'Позиция сохранена!', mcx) end
	                        end
	                        wait(0)
	                    end
	                end)
	            end
	            if mainini.statTimers.server == sampGetCurrentServerAddress() then
	                if imgui.Button(u8(sampGetCurrentServerName()), imgui.ImVec2(-1, 20)) then 
	                    mainini.statTimers.server = nil
	                    sampAddChatMessage(tag..'Теперь этот сервер не считается основным!', mcx)
	                end
	            else
	                if imgui.Button(u8'Установить этот сервер основным', imgui.ImVec2(-1, 20)) then 
	                    mainini.statTimers.server = sampGetCurrentServerAddress()
	                    sampAddChatMessage(tag..'Теперь онлайн будет считаться только на этом сервере!', mcx)
	                end
	                imgui.Hint(u8'Скрипт будет запускаться только на этом сервере!')
	            end
        	    imgui.PushItemWidth(-1)
                imgui.PopItemWidth()

                if imgui.ColorEdit4(u8'Цвет фона', colorW, imgui.ColorEditFlags.NoInputs) then
		            argbW = imgui.ImColor.FromFloat4(colorW.v[1], colorW.v[2], colorW.v[3], colorW.v[4]):GetU32()
		            mainini.style.colorW = argbW
		        end
		        if imgui.ColorEdit4(u8'Цвет текста', colorT, imgui.ColorEditFlags.NoInputs) then
		            argbT = imgui.ImColor.FromFloat4(colorT.v[1], colorT.v[2], colorT.v[3], colorT.v[4]):GetU32()
		            mainini.style.colorT = argbT
		        end

                imgui.SetCursorPosY(imgui.GetWindowHeight() - 20)
            imgui.EndChild()
            imgui.PushFont(fsClock) imgui.CenterTextColoredRGB('ATools') imgui.PopFont()
            if imgui.Checkbox(u8"Автоматически вводить пароль от админ-панели", adminpassACT) then
                mainini.config.adminpassACT = adminpassACT.v
                inicfg.save(mainini, savee)
            end
            imgui.SameLine()
            imgui.PushItemWidth(50)
            if imgui.InputText(u8'##adminpass1', adminpass) then
                mainini.config.adminpass = adminpass.v
                inicfg.save(mainini, savee)
            end  
            if imgui.Checkbox(u8"АвтоТП в админ зону", adminzonea) then
                mainini.config.adminzonea = adminzonea.v
                inicfg.save(mainini, savee)
            end
            imgui.SameLine()
            imgui.PushItemWidth(50)
            if imgui.InputText(u8'##adminzone1', adminzone) then
                mainini.config.adminzone = adminzone.v
                inicfg.save(mainini, savee)
            end  
            imgui.SameLine()
            imgui.PushItemWidth(50)
            if imgui.Checkbox(u8"Закрывать Admin Tools на ESC", esc) then
                mainini.config.esc = esc.v
                inicfg.save(mainini, savee)
            end
			if imgui.Button(u8'Сохранить', imgui.ImVec2(-1, 20)) then
                if inicfg.save(mainini, 'AdminTools/AdminTools.ini') then 
                	if bNotf then
                        notf.addNotification(("Настройки сохранины!"), 4, 2)
                    end
                end
            end
        end
        if menu == 6 then
            imgui.Spacing()
            imgui.Text(u8'Онлайн за неделю')
            imgui.Text(u8'Всего отыграно: '..get_clock(mainini.onWeek.full))
            imgui.NewLine()
            for day = 1, 6 do -- ПН -> СБ
                imgui.Text(u8(tWeekdays[day])); imgui.SameLine(250)
                imgui.Text(get_clock(mainini.myWeekOnline[day]))
            end 
            --> ВС
            imgui.Text(u8(tWeekdays[0])); imgui.SameLine(250)
            imgui.Text(get_clock(mainini.myWeekOnline[0]))
            imgui.Text(u8'Статистика для автоформ')
            --imgui.Text(u8'sBan: '..sban..' раз')
            --imgui.Text(u8'Ban: '..bstat..' раз')
            --imgui.Text(u8'sKikc: '..skstat..' раз')
            --imgui.Text(u8'Kick: '..kstat..' раз')
            --imgui.Text(u8'Report: '..rstat..' раз')
            --imgui.Text(u8'Muts: '..mstat..' раз')
        end
        imgui.End()
    end
    if jailmenu then 
        imgui.OpenPopup(u8'Выдача джаила') 
        if imgui.BeginPopupModal(u8'Выдача джаила', true, imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoResize) then
            imgui.ShowCursor = true
            imgui.CenterText(u8" ----- Выдача джаила ----- ")	
            imgui.NewLine()
            imgui.PushItemWidth(250)
            if imgui.InputText(u8'', JailText) then
                mainini.config.JailText = JailText.v
                inicfg.save(mainini, savee) 
            end
            imgui.NewLine()
            local wid = imgui.GetWindowWidth()
            imgui.SetCursorPosX(wid / 2 - 50)
            if imgui.Button(u8'Выдать',imgui.ImVec2(100,30)) then 
                sampSendChat(''..(u8:decode(JailText.v)), -1)
                imgui.CloseCurrentPopup() 
                imgui.ShowCursor = false
                jailmenu = false
            end
            imgui.SetCursorPosX(wid / 2 - 50)
            if imgui.Button(u8'Проследить',imgui.ImVec2(100,30)) then 
                sampSendChat('/re '..jailid, -1)
                imgui.CloseCurrentPopup() 
                imgui.ShowCursor = false
                jailmenu = false
            end
            imgui.SetCursorPosX(wid / 2 - 50)
            if imgui.Button(u8'Закрыть',imgui.ImVec2(100,30)) then 
                imgui.CloseCurrentPopup() 
                imgui.ShowCursor = false
                jailmenu = false
            end
            imgui.EndPopup()
        end 
    end
    if sbanmenu then 
        imgui.OpenPopup(u8'Выдача сбана') 
        if imgui.BeginPopupModal(u8'Выдача сбана', true, imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoResize) then
            imgui.ShowCursor = true
            imgui.CenterText(u8" ----- Выдача сбана ----- ")	
            imgui.NewLine()
            imgui.PushItemWidth(250)
            if imgui.InputText(u8'', sBanText) then
                mainini.config.sBanText = sBanText.v
                inicfg.save(mainini, savee) 
            end
            imgui.NewLine()
            local wid = imgui.GetWindowWidth()
            imgui.SetCursorPosX(wid / 2 - 50)
            if imgui.Button(u8'Забанить',imgui.ImVec2(100,30)) then 
                sampSendChat(''..(u8:decode(sBanText.v)), -1)
                imgui.CloseCurrentPopup() 
                imgui.ShowCursor = false
                sbanmenu = false
            end
            imgui.SetCursorPosX(wid / 2 - 50)
            if imgui.Button(u8'Проследить',imgui.ImVec2(100,30)) then 
                sampSendChat('/re '..banid, -1)
                imgui.CloseCurrentPopup() 
                imgui.ShowCursor = false
                sbanmenu = false
            end
            imgui.SetCursorPosX(wid / 2 - 50)
            if imgui.Button(u8'Закрыть',imgui.ImVec2(100,30)) then 
                imgui.CloseCurrentPopup() 
                imgui.ShowCursor = false
                sbanmenu = false
            end
            imgui.EndPopup()
        end 
    end
    if banmenu then 
        imgui.OpenPopup(u8'Выдача бана') 
        if imgui.BeginPopupModal(u8'Выдача бана', true, imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoResize) then
            imgui.ShowCursor = true
            imgui.CenterText(u8" ----- Выдача бана ----- ")	
            imgui.NewLine()
            imgui.PushItemWidth(250)
            if imgui.InputText(u8'', BanText) then
                mainini.config.BanText = BanText.v
                inicfg.save(mainini, savee) 
            end
            imgui.NewLine()
            local wid = imgui.GetWindowWidth()
            imgui.SetCursorPosX(wid / 2 - 50)
            if imgui.Button(u8'Забанить',imgui.ImVec2(100,30)) then 
                sampSendChat(''..(u8:decode(BanText.v)), -1)
                imgui.CloseCurrentPopup() 
                imgui.ShowCursor = false
                banmenu = false
            end
            imgui.SetCursorPosX(wid / 2 - 50)
            if imgui.Button(u8'Проследить',imgui.ImVec2(100,30)) then 
                sampSendChat('/re '..banid, -1)
                imgui.CloseCurrentPopup() 
                imgui.ShowCursor = false
                banmenu = false
            end
            imgui.SetCursorPosX(wid / 2 - 50)
            if imgui.Button(u8'Закрыть',imgui.ImVec2(100,30)) then 
                imgui.CloseCurrentPopup() 
                imgui.ShowCursor = false
                banmenu = false
            end
            imgui.EndPopup()
        end 
    end
    if skickmenu then 
        imgui.OpenPopup(u8'Выдача скика') 
        if imgui.BeginPopupModal(u8'Выдача скика', true, imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoResize) then
            imgui.ShowCursor = true
            imgui.CenterText(u8" ----- Выдача скика ----- ")	
            imgui.NewLine()
            imgui.PushItemWidth(250)
            if imgui.InputText(u8'', sKickText) then
                mainini.config.sKickText = sKickText.v
                inicfg.save(mainini, savee) 
            end
            imgui.NewLine()
            local wid = imgui.GetWindowWidth()
            imgui.SetCursorPosX(wid / 2 - 50)
            if imgui.Button(u8'Кикнуть',imgui.ImVec2(100,30)) then 
                sampSendChat(''..(u8:decode(sKickText.v)), -1)
                imgui.CloseCurrentPopup() 
                imgui.ShowCursor = false
                skickmenu = false
            end
            imgui.SetCursorPosX(wid / 2 - 50)
            if imgui.Button(u8'Проследить',imgui.ImVec2(100,30)) then 
                sampSendChat('/re '..kickid, -1)
                imgui.CloseCurrentPopup() 
                imgui.ShowCursor = false
                skickmenu = false
            end
            imgui.SetCursorPosX(wid / 2 - 50)
            if imgui.Button(u8'Закрыть',imgui.ImVec2(100,30)) then 
                imgui.CloseCurrentPopup() 
                imgui.ShowCursor = false
                skickmenu = false
            end
            imgui.EndPopup()
        end 
    end
	if kickmenu then 
        imgui.OpenPopup(u8'Выдача кика') 
        if imgui.BeginPopupModal(u8'Выдача кика', true, imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoResize) then
            imgui.ShowCursor = true
            imgui.CenterText(u8" ----- Выдача кика ----- ")	
            imgui.NewLine()
            imgui.PushItemWidth(250)
            if imgui.InputText(u8'', KickText) then
                mainini.config.KickText = KickText.v
                inicfg.save(mainini, savee) 
            end
            imgui.NewLine()
            local wid = imgui.GetWindowWidth()
            imgui.SetCursorPosX(wid / 2 - 50)
            if imgui.Button(u8'Кикнуть',imgui.ImVec2(100,30)) then 
                sampSendChat(''..(u8:decode(KickText.v)), -1)
                imgui.CloseCurrentPopup() 
                imgui.ShowCursor = false
                kickmenu = false
            end
            imgui.SetCursorPosX(wid / 2 - 50)
            if imgui.Button(u8'Проследить',imgui.ImVec2(100,30)) then 
                sampSendChat('/re '..kickid, -1)
                imgui.CloseCurrentPopup() 
                imgui.ShowCursor = false
                kickmenu = false
            end
            imgui.SetCursorPosX(wid / 2 - 50)
            if imgui.Button(u8'Закрыть',imgui.ImVec2(100,30)) then 
                imgui.CloseCurrentPopup() 
                imgui.ShowCursor = false
                kickmenu = false
            end
            imgui.EndPopup()
        end 
    end
    if warnmenu then 
        imgui.OpenPopup(u8'Выдача варна') 
        if imgui.BeginPopupModal(u8'Выдача варна', true, imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoResize) then
            imgui.ShowCursor = true
            imgui.CenterText(u8" ----- Выдача варна ----- ")	
            imgui.NewLine()
            imgui.PushItemWidth(250)
            if imgui.InputText(u8'', WarnText) then
                mainini.config.WarnText = WarnText.v
                inicfg.save(mainini, savee) 
            end
            imgui.NewLine()
            local wid = imgui.GetWindowWidth()
            imgui.SetCursorPosX(wid / 2 - 50)
            if imgui.Button(u8'Заварнить',imgui.ImVec2(100,30)) then 
                sampSendChat(''..(u8:decode(WarnText.v)), -1)
                imgui.CloseCurrentPopup() 
                imgui.ShowCursor = false
                warnmenu = false
            end
            imgui.SetCursorPosX(wid / 2 - 50)
            if imgui.Button(u8'Проследить',imgui.ImVec2(100,30)) then 
                sampSendChat('/re '..warnid, -1)
                imgui.CloseCurrentPopup() 
                imgui.ShowCursor = false
                warnmenu = false
            end
            imgui.SetCursorPosX(wid / 2 - 50)
            if imgui.Button(u8'Закрыть',imgui.ImVec2(100,30)) then 
                imgui.CloseCurrentPopup() 
                imgui.ShowCursor = false
                warnmenu = false
            end
            imgui.EndPopup()
    end end
    if mutemenu then 
        imgui.OpenPopup(u8'Выдача мута') 
        if imgui.BeginPopupModal(u8'Выдача мута', true, imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoResize) then
            imgui.ShowCursor = true
            imgui.CenterText(u8" ----- Выдача мута ----- ")	
            imgui.NewLine()
            imgui.PushItemWidth(250)
            if imgui.InputText(u8'', MuteText) then
                mainini.config.MuteText = MuteText.v
                inicfg.save(mainini, savee) 
            end
            imgui.NewLine()
            local wid = imgui.GetWindowWidth()
            imgui.SetCursorPosX(wid / 2 - 50)
            if imgui.Button(u8'Замутить',imgui.ImVec2(100,30)) then 
                sampSendChat(''..(u8:decode(MuteText.v)), -1)
                imgui.CloseCurrentPopup() 
                imgui.ShowCursor = false
                mutemenu = false
            end
            imgui.SetCursorPosX(wid / 2 - 50)
            if imgui.Button(u8'Проследить',imgui.ImVec2(100,30)) then 
                sampSendChat('/re '..muteid, -1)
                imgui.CloseCurrentPopup() 
                imgui.ShowCursor = false
                mutemenu = false
            end
            imgui.SetCursorPosX(wid / 2 - 50)
            if imgui.Button(u8'Закрыть',imgui.ImVec2(100,30)) then 
                imgui.CloseCurrentPopup() 
                imgui.ShowCursor = false
                mutemenu = false
            end
            imgui.EndPopup()
    end end
    if reportmenu then 
        imgui.OpenPopup(u8'Ответ на репорт') 
        if imgui.BeginPopupModal(u8'Ответ на репорт', true, imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoResize) then
            imgui.ShowCursor = true
            imgui.CenterText(u8'Ответ игроку '..nickreport)	
            imgui.NewLine()
            imgui.Text(u8''..ReportText.v)
            imgui.NewLine()
            imgui.PushItemWidth(500)
            imgui.InputText(u8'',  ReportTextOtvet) 
            
            imgui.NewLine()
            local wid = imgui.GetWindowWidth()
            imgui.SetCursorPosX(wid / 2 - 50)
            if imgui.Button(u8'Ответить',imgui.ImVec2(100,30)) then 
                sampSendChat('/pm '..reportid..' '..(u8:decode(ReportTextOtvet.v)), -1)
                imgui.CloseCurrentPopup() 
                imgui.ShowCursor = false
                reportmenu = false
            end
            imgui.SetCursorPosX(wid / 2 - 50)
            if imgui.Button(u8'Проследить',imgui.ImVec2(100,30)) then 
                sampSendChat('/re '..reportid, -1)
                imgui.CloseCurrentPopup() 
                imgui.ShowCursor = false
                reportmenu = false
            end
            imgui.SameLine()
            imgui.SetCursorPosX(wid / 2 - 155)
            if imgui.Button(u8'Слапнут',imgui.ImVec2(100,30)) then 
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
            if imgui.Button(u8'Закрыть',imgui.ImVec2(100,30)) then 
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
            imgui.CenterTextColoredRGB("Подключение: "..get_clock(connectingTime))
        else
            if mainini.statTimers.sesOnline then imgui.CenterTextColoredRGB("Сессия (чистый): "..get_clock(sesOnline.v)) end
            if mainini.statTimers.sesAfk then imgui.CenterTextColoredRGB("AFK за сессию: "..get_clock(sesAfk.v)) end
            if mainini.statTimers.sesFull then imgui.CenterTextColoredRGB("Онлайн за сессию: "..get_clock(sesFull.v)) end
            if mainini.statTimers.dayOnline then imgui.CenterTextColoredRGB("За день (чистый): "..get_clock(mainini.onDay.online)) end
            if mainini.statTimers.dayAfk then imgui.CenterTextColoredRGB("АФК за день: "..get_clock(mainini.onDay.afk)) end
            if mainini.statTimers.dayFull then imgui.CenterTextColoredRGB("Онлайн за день: "..get_clock(mainini.onDay.full)) end
            if mainini.statTimers.weekOnline then imgui.CenterTextColoredRGB("За неделю (чистый): "..get_clock(mainini.onWeek.online)) end
            if mainini.statTimers.weekAfk then imgui.CenterTextColoredRGB("АФК за неделю: "..get_clock(mainini.onWeek.afk)) end
            if mainini.statTimers.weekFull then imgui.CenterTextColoredRGB("Онлайн за неделю: "..get_clock(mainini.onWeek.full)) end
        end
        imgui.PopStyleVar()

        imgui.End()
        imgui.PopStyleVar()
        imgui.PopStyleColor(2)
    end
end
-- система debug
function developer()
    local _, id = sampGetPlayerIdByCharHandle(playerPed)
    if sampGetPlayerNickname(id) == 'Nikita_Dobrov' or 'Hola_Bola' then
        mainini.config.debug = true
        inicfg.save(mainini, savee)
    else
        mainini.config.debug = false
        inicfg.save(mainini, savee)
    end 
end
-- система логов
function addLog(string)
	logText[#logText+1] = string.format("[%s] %s", os.date("%H:%M:%S"), string)
end
function sampev.onTogglePlayerSpectating(state) recon = state end -- если вы админ, то в реконе скрипт будет отключать табличку, сделал чисто для себя, если надо - удалите
-- система таймера
function time()
	startTime = os.time()                                               -- "Точка отсчёта"
    connectingTime = 0
    while true do
        wait(1000)
        nowTime = os.date("%H:%M:%S", os.time())
        if sampGetGamestate() == 3 then 								-- Игровой статус равен "Подключён к серверу" (Что бы онлайн считало только, когда, мы подключены к серверу)
	        sesOnline.v = sesOnline.v + 1 								-- Онлайн за сессию без учёта АФК
	        sesFull.v = os.time() - startTime 							-- Общий онлайн за сессию
	        sesAfk.v = sesFull.v - sesOnline.v							-- АФК за сессию

	        mainini.onDay.online = mainini.onDay.online + 1 					-- Онлайн за день без учёта АФК
	        mainini.onDay.full = dayFull.v + sesFull.v 						-- Общий онлайн за день
	        mainini.onDay.afk = mainini.onDay.full - mainini.onDay.online			-- АФК за день

	        mainini.onWeek.online = mainini.onWeek.online + 1 					-- Онлайн за неделю без учёта АФК
	        mainini.onWeek.full = weekFull.v + sesFull.v 					-- Общий онлайн за неделю
	        mainini.onWeek.afk = mainini.onWeek.full - mainini.onWeek.online		-- АФК за неделю

            local today = tonumber(os.date('%w', os.time()))
            mainini.myWeekOnline[today] = mainini.onDay.full

            connectingTime = 0
	    else
            connectingTime = connectingTime + 1                         -- Вермя подключения к серверу
	    	startTime = startTime + 1									-- Смещение начала отсчета таймеров
	    end
    end
end
-- авто сохранение конфига
function autoSave()
	while true do 
		wait(60000) -- сохранение каждые 60 секунд
		inicfg.save(mainini, "AdminTools/AdminTools")
	end
end
-- сохранение конфига при выходе из игры
function onScriptTerminate(script, quitGame)
	if script == thisScript() and not restart then 
		if inicfg.save(mainini, 'AdminTools/AdminTools.ini') then sampfuncsLog(tag..' {FFFFFF}Ваш онлайн сохранён!') end
	end
end
-- получение номера недели в году
function number_week()
    local current_time = os.date'*t'
    local start_year = os.time{ year = current_time.year, day = 1, month = 1 }
    local week_day = ( os.date('%w', start_year) - 1 ) % 7
    return math.ceil((current_time.yday + week_day) / 7)
end
-- система узнавание месяца
function getStrDate(unixTime)
    local tMonths = {'января', 'февраля', 'марта', 'апреля', 'мая', 'июня', 'июля', 'августа', 'сентября', 'октября', 'ноября', 'декабря'}
    local day = tonumber(os.date('%d', unixTime))
    local month = tMonths[tonumber(os.date('%m', unixTime))]
    local weekday = tWeekdays[tonumber(os.date('%w', unixTime))]
    return string.format('%s, %s %s', weekday, day, month)
end
-- вывод таймера
function get_clock(time)
    local timezone_offset = 86400 - os.date('%H', 0) * 3600
    if tonumber(time) >= 86400 then onDay = true else onDay = false end
    return os.date((onDay and math.floor(time / 86400)..'д ' or '')..'%H:%M:%S', time + timezone_offset)
end
--
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
--
function imgui.Hint(text, delay)
    if imgui.IsItemHovered() then
        if go_hint == nil then go_hint = os.clock() + (delay and delay or 0.0) end
        local alpha = (os.clock() - go_hint) * 5 -- скорость появления
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
                  sampAddChatMessage((prefix..'Обнаружено обновление. Пытаюсь обновиться c '..thisScript().version..' на '..updateversion), color)
                  wait(250)
                  downloadUrlToFile(updatelink, thisScript().path,
                    function(id3, status1, p13, p23)
                      if status1 == dlstatus.STATUS_DOWNLOADINGDATA then
                        print(string.format('Загружено %d из %d.', p13, p23))
                      elseif status1 == dlstatus.STATUS_ENDDOWNLOADDATA then
                        print('Загрузка обновления завершена.')
                        sampAddChatMessage((prefix..'Обновление завершено!'), color)
                        goupdatestatus = true
                        lua_thread.create(function() wait(500) thisScript():reload() end)
                      end
                      if status1 == dlstatus.STATUSEX_ENDDOWNLOAD then
                        if goupdatestatus == nil then
                          sampAddChatMessage((prefix..'Обновление прошло неудачно. Запускаю устаревшую версию..'), color)
                          update = false
                        end
                      end
                    end
                  )
                  end, prefix
                )
              else
                update = false
                print('v'..thisScript().version..': Обновление не требуется.')
              end
            end
          else
            print('v'..thisScript().version..': Не могу проверить обновление. Смиритесь или проверьте самостоятельно на '..url)
            update = false
          end
        end
      end
    )
    while update ~= false do wait(100) end
  end
-- main
function main()
    autoupdate("https://raw.githubusercontent.com/codero4ik/atols/main/updates.json", '['..string.upper(thisScript().name)..']: ', "https://raw.githubusercontent.com/codero4ik/atols/main/updates.json")
    while not isSampAvailable() do wait(100) end
    developer()
    if bNotf then
        notf.addNotification("[AdminTools]: Loaded! \n Author: Coderok, Alex", 5, 1)
    end
    if not doesFileExist('moonloader/config/AdminTools/AdminTools.ini') then
        if inicfg.save(mainini, 'AdminTools/AdminTools.ini') then sampfuncsLog(tag..'Создан файл конфигурации: AdminTools.ini') end
    end

    if mainini.statTimers.server ~= nil and mainini.statTimers.server ~= sampGetCurrentServerAddress() then 
        sampAddChatMessage(tag..'Вы зашли на свой не основной сервер. Скрипт отключён!', mcx)
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

    sampRegisterChatCommand('did')
    lua_thread.create(time)
    lua_thread.create(autoSave)
	ClickWP = lua_thread.create(ClickWP)

    while true do wait(0) imgui.Process = true
        imgui.Process = to.v
        if active_menu.v then
            imgui.ShowCursor = true
            imgui.Process = true
        else
            imgui.ShowCursor = false
        end

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
-- сброс
local fsClock = nil
-- шрифт
function imgui.BeforeDrawFrame()
	if fsClock == nil then
        fsClock = imgui.GetIO().Fonts:AddFontFromFileTTF(getFolderPath(0x14) .. '\\trebucbd.ttf', 25.0, nil, imgui.GetIO().Fonts:GetGlyphRangesCyrillic())
    end
end
-- система samp event
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
	if report.v and text:find('%[Жалоба%] от (.*): (.+)') and not reportmenu == true then
        lua_thread.create(function()
            txtreport = text:match(": (.+)")
            nickreport = text:match("от (.*)%[")
            reportid = text:match("%[(%d+)%]:")
            wait(1000)
            ReportText.v = (u8(''..txtreport))
            ReportTextOtvet.v = (u8(''))
            reportmenu = true
        end) 
    end

    
    --! [Подозрение в рекламе]:Проверьте сообщение игрока Robert_Armando[91] он попытался отправить текст: Эу сука
    if text:find('Администратор (.*) кикнул игрока (.*). Причина: (.+)') then
        if bNotf then
            notf.addNotification(("Kick"), 4, 2)
        end
        addOneOffSound(0.0, 0.0, 0.0, 1139)
        local a = text:match("(.+)")
        addLog(a)
    end
    if text:find('Администратор (.*) посадил%(а%) игрока (.*) в деморган на (.+) минут. Причина: (.+)') then
        if bNotf then
            notf.addNotification(("Jail!"), 4, 2)
        end
        addOneOffSound(0.0, 0.0, 0.0, 1139)
        local b = text:match("(.+)")    
        addLog(b)
    end
    if text:find('Администратор (.*) заглушил%(а%) игрока (.*) на (.+) минут. Причина: (.+)') then
        if bNotf then
            notf.addNotification(("Mute!"), 4, 2)
        end
        addOneOffSound(0.0, 0.0, 0.0, 1139)
        local c = text:match("(.+)")
        addLog(c)
    end
    if text:find('Администратор (.*) забанил%(а%) игрока (.*) на (.+) дней. Причина: (.+)') then
        if bNotf then
            notf.addNotification(("Mute!"), 4, 2)
        end
        addOneOffSound(0.0, 0.0, 0.0, 1139)
        local c = text:match("(.+)")
        addLog(c)
    end
end
function sampev.onShowDialog(id, style, title, button1, button2, text)
    --if id == 2 then
    --end
    if id == 211 and adminpassACT.v then
        sampSendDialogResponse(id, 1, _,mainini.config.adminpass)
        return false
    end
end
function sampev.onPlayerJoin(id, clist, isNPC, nick)
    if bNotf then
        notf.addNotification(("Зашёл\n"..nick.."["..id.."]"), 4, 2)
    end
end
function sampev.onPlayerQuit(id, reason)
    -- id ИД отключившегося(узнать имя путём его получения по ID)
    -- причина(ID' причин от 0 до 2)
    -- 0. 'Выход', 1. 'Кик или Бан', 2. 'TimedOut'
    nick = sampGetPlayerNickname(id)
    if reason == 0 then
        reas = "/q"
    elseif reason == 1 then 
        reas = "Кик или Бан"
    elseif reason == 2 then
        reas = "TimedOut"
    end
    if bNotf then
        notf.addNotification(("Вышел\n"..nick.."["..id.."]\nПричина: "..reas.."["..reason.."]"), 4, 2)
    end
end
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
function nameTagOn()
    sSp = sampGetServerSettingsPtr()
    memory.setfloat(sSp + 39, 1200)
    memory.setint8(sSp + 47, 0)
    memory.setint8(sSp + 56, 1)
end
function nameTagOff()
    sSp = sampGetServerSettingsPtr()
    memory.setfloat(sSp + 39, 25.5)
    memory.setint8(sSp + 47, 1)
    memory.setint8(sSp + 56, 1)
end
function sampev.onResetPlayerWeapons()
    if godmode.v then 
        return false
    end 
end
function sampev.onSetCameraBehind()
    if godmode.v then 
        return false
    end 
end
function sampev.onTogglePlayerControllable()
    if godmode.v then 
        return false
    end 
end
function sampev.onSetPlayerHealth()
    if godmode.v then 
        return false
    end 
end
function sampev.onBulletSync()
    if godmode.v then 
        return false
    end 
end
function imgui.CenterText(text)
    local width = imgui.GetWindowWidth()
    local calc = imgui.CalcTextSize(text)
    imgui.SetCursorPosX( width / 2 - calc.x / 2 )
    imgui.Text(text)
end
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
--стиль
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
--Клик варп
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
--рендер шрифта для варпа 
function initializeRender()
    font = renderCreateFont("Tahoma", 10, FCR_BOLD + FCR_BORDER)
    font2 = renderCreateFont("Arial", 8, FCR_ITALICS + FCR_BORDER)
end
--система для разварота на мести машины
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
--система для разварота на мести машины
function readFloatArray(ptr, idx)
    return representIntAsFloat(readMemory(ptr + idx * 4, 4, false))
end
--система для разварота на мести машины
function writeFloatArray(ptr, idx, value)
    writeMemory(ptr + idx * 4, 4, representFloatAsInt(value), false)
end
--система для разварота на мести машины
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
--система для разварота на мести машины
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
-- показ название машины
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
-- создание точки варпа  
function createPointMarker(x, y, z)
    pointMarker = createUser3dMarker(x, y, z + 0.3, 4)
end
-- удаление Точки варпа
function removePointMarker()
    if pointMarker then
        removeUser3dMarker(pointMarker)
        pointMarker = nil
    end
end
-- узнавание машины
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
-- телепорт в машину
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
-- телепорт к игроку     
function teleportPlayer(x, y, z)
    if isCharInAnyCar(PLAYER_PED) then
        setCharCoordinates(PLAYER_PED, x, y, z)
    end
    setCharCoordinatesDontResetAnim(PLAYER_PED, x, y, z)
end
          
function setCharCoordinatesDontResetAnim(char, x, y, z)
    if doesCharExist(char) then
        local ptr = getCharPointer(char)
        setEntityCoordinates(ptr, x, y, z)
    end
end
          
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
-- показ курсора для варпа   
function showCursor(toggle)
    if toggle then
        sampSetCursorMode(CMODE_LOCKCAM)
    else
        sampToggleCursor(false)
    end
    cursorEnabled = toggle
end

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