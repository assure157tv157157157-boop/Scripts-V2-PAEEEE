-- WindUI Remote Spy v1.0
-- Baseado no SimpleSpy v2.2

local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

-- Inicializa o WindUI
local Window = WindUI:CreateWindow({
    Title = "WindUI Remote Spy",
    StartupSound = false
})

-- Funções auxiliares
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- Variáveis globais
local remotesLog = {}
local selectedRemote = nil
local blacklist = {}
local blocklist = {}
local isSpying = false
local originalNamecall
local originalFireServer
local originalInvokeServer
local hookfunction = hookfunction or function() end
local getrawmetatable = getrawmetatable or function() return {} end
local setreadonly = setreadonly or function() end

-- Instâncias para hookfunction
local remoteEvent = Instance.new("RemoteEvent")
local remoteFunction = Instance.new("RemoteFunction")

-- Configurações
local MAX_LOGS = 100
local currentTabId = 1

-- Função para converter valor para string
local function valueToString(value, indent, processed)
    indent = indent or 0
    processed = processed or {}
    
    if type(value) == "string" then
        return string.format("%q", value)
    elseif type(value) == "number" then
        return tostring(value)
    elseif type(value) == "boolean" then
        return tostring(value)
    elseif type(value) == "nil" then
        return "nil"
    elseif type(value) == "userdata" then
        if typeof(value) == "Instance" then
            return string.format("game:GetService(\"%s\")", value.ClassName) .. (value:IsA("Player") and string.format(":FindFirstChild(\"%s\")", value.Name) or "")
        else
            return string.format("nil --[[%s]]", typeof(value))
        end
    elseif type(value) == "table" then
        if table.find(processed, value) then
            return "{} --[[RECURSIVE]]"
        end
        table.insert(processed, value)
        
        local result = "{\n"
        local newIndent = string.rep(" ", indent + 4)
        
        for k, v in pairs(value) do
            local keyStr = type(k) == "string" and string.format("[%q] = ", k) or string.format("[%s] = ", valueToString(k, indent + 4, processed))
            local valStr = valueToString(v, indent + 4, processed)
            result = result .. newIndent .. keyStr .. valStr .. ",\n"
        end
        
        local endIndent = string.rep(" ", indent)
        return result .. endIndent .. "}"
    else
        return string.format("nil --[[%s]]", type(value))
    end
end

-- Função para gerar script do remote
local function generateScript(remote, args, remoteType)
    local script = ""
    
    -- Cabeçalho
    script = script .. "-- Script gerado por WindUI Remote Spy\n\n"
    
    -- Variáveis dos argumentos
    if args and #args > 0 then
        script = script .. "local args = " .. valueToString(args) .. "\n\n"
    end
    
    -- Caminho do remote
    local remotePath = "game"
    local parent = remote.Parent
    local path = "." .. remote.Name
    
    while parent and parent ~= game do
        path = "." .. parent.Name .. path
        parent = parent.Parent
    end
    
    remotePath = remotePath .. path
    
    -- Chamada do remote
    if remoteType == "FireServer" then
        if args and #args > 0 then
            script = script .. remotePath .. ":FireServer(unpack(args))"
        else
            script = script .. remotePath .. ":FireServer()"
        end
    elseif remoteType == "InvokeServer" then
        if args and #args > 0 then
            script = script .. remotePath .. ":InvokeServer(unpack(args))"
        else
            script = script .. remotePath .. ":InvokeServer()"
        end
    end
    
    return script
end

-- Função para criar nova aba com o remote
local function createRemoteTab(remoteName, remoteType, args, remoteInstance)
    currentTabId = currentTabId + 1
    local tabId = "remote_" .. currentTabId
    
    -- Gera o script
    local script = generateScript(remoteInstance, args, remoteType)
    
    -- Cria a tab
    local Tab = Window:CreateTab({
        Title = remoteName,
        Icon = remoteType == "FireServer" and "rbxassetid://13410983925" or "rbxassetid://13410984884"
    })
    
    -- Seção do código
    local CodeSection = Tab:CreateSection({
        Title = "Script Gerado"
    })
    
    local codeBox = CodeSection:CreateTextBox({
        Title = "Código",
        Default = script,
        Placeholder = "Código será gerado aqui...",
        MultiLine = true,
        Callback = function(value)
            -- Callback opcional para edição
        end
    })
    
    -- Botão para copiar
    CodeSection:CreateButton({
        Title = "📋 Copiar Código",
        Callback = function()
            setclipboard(script)
            WindUI:Notify({
                Title = "Sucesso",
                Content = "Código copiado para a área de transferência!",
                Duration = 3
            })
        end
    })
    
    -- Informações do remote
    local InfoSection = Tab:CreateSection({
        Title = "Informações"
    })
    
    InfoSection:CreateLabel({
        Title = "Tipo",
        Content = remoteType
    })
    
    InfoSection:CreateLabel({
        Title = "Instância",
        Content = remoteInstance:GetFullName()
    })
    
    InfoSection:CreateLabel({
        Title = "Hora",
        Content = os.date("%H:%M:%S")
    })
    
    -- Adiciona ao log
    table.insert(remotesLog, 1, {
        Name = remoteName,
        Type = remoteType,
        Instance = remoteInstance,
        Args = args,
        Tab = Tab,
        Timestamp = os.time()
    })
    
    -- Limita o número de logs
    if #remotesLog > MAX_LOGS then
        local oldest = remotesLog[#remotesLog]
        if oldest and oldest.Tab then
            oldest.Tab:Destroy()
        end
        table.remove(remotesLog, #remotesLog)
    end
    
    return Tab
end

-- Função para lidar com remotes
local function handleRemote(remote, args, remoteType, funcInfo)
    if not remote or not remote:IsA("RemoteEvent") and not remote:IsA("RemoteFunction") then
        return
    end
    
    local remoteName = remote.Name
    
    -- Verifica blacklist
    if blacklist[remote] or blacklist[remoteName] then
        return
    end
    
    -- Verifica blocklist
    local isBlocked = blocklist[remote] or blocklist[remoteName]
    
    if isBlocked then
        -- Adiciona marcador de bloqueado
        remoteName = remoteName .. " [BLOQUEADO]"
    end
    
    -- Cria a tab
    createRemoteTab(remoteName, remoteType, args, remote)
    
    -- Se estiver bloqueado, não envia para o servidor
    if isBlocked then
        if remoteType == "InvokeServer" then
            return nil -- Retorna nil para InvokeServer bloqueado
        end
        return -- Retorna sem fazer nada para FireServer bloqueado
    end
end

-- Hook para RemoteEvent
local function hookFireServer(...)
    local remote, args = ...
    
    if typeof(remote) == "Instance" and (remote:IsA("RemoteEvent") or remote:IsA("RemoteFunction")) then
        local funcInfo = debug.getinfo(2)
        handleRemote(remote, {select(2, ...)}, "FireServer", funcInfo)
    end
    
    return originalFireServer(...)
end

-- Hook para RemoteFunction
local function hookInvokeServer(...)
    local remote, args = ...
    
    if typeof(remote) == "Instance" and (remote:IsA("RemoteEvent") or remote:IsA("RemoteFunction")) then
        local funcInfo = debug.getinfo(2)
        handleRemote(remote, {select(2, ...)}, "InvokeServer", funcInfo)
        
        -- Verifica se está bloqueado
        if blocklist[remote] or blocklist[remote.Name] then
            return nil
        end
    end
    
    return originalInvokeServer(...)
end

-- Hook para __namecall
local function hookNamecall(self, ...)
    local method = getnamecallmethod()
    
    if (method == "FireServer" or method == "InvokeServer") and 
       (self:IsA("RemoteEvent") or self:IsA("RemoteFunction")) then
        
        local args = {...}
        local funcInfo = debug.getinfo(2)
        
        handleRemote(self, args, method, funcInfo)
        
        -- Verifica se está bloqueado
        if blocklist[self] or blocklist[self.Name] then
            if method == "InvokeServer" then
                return nil
            else
                return
            end
        end
    end
    
    return originalNamecall(self, ...)
end

-- Função para iniciar/parar o spy
local function toggleSpy()
    if isSpying then
        -- Para o spy
        if hookfunction and originalFireServer then
            hookfunction(remoteEvent.FireServer, originalFireServer)
            hookfunction(remoteFunction.InvokeServer, originalInvokeServer)
        end
        
        if getrawmetatable then
            local mt = getrawmetatable(game)
            if mt and originalNamecall then
                setreadonly(mt, false)
                mt.__namecall = originalNamecall
                setreadonly(mt, true)
            end
        end
        
        WindUI:Notify({
            Title = "Remote Spy",
            Content = "Spy DESATIVADO",
            Duration = 3
        })
    else
        -- Inicia o spy
        if hookfunction then
            originalFireServer = hookfunction(remoteEvent.FireServer, hookFireServer)
            originalInvokeServer = hookfunction(remoteFunction.InvokeServer, hookInvokeServer)
        end
        
        if getrawmetatable then
            local mt = getrawmetatable(game)
            if mt then
                setreadonly(mt, false)
                originalNamecall = mt.__namecall
                mt.__namecall = hookNamecall
                setreadonly(mt, true)
            end
        end
        
        WindUI:Notify({
            Title = "Remote Spy",
            Content = "Spy ATIVADO",
            Duration = 3
        })
    end
    
    isSpying = not isSpying
    return isSpying
end

-- Cria a interface principal
local MainTab = Window:CreateTab({
    Title = "Controle",
    Icon = "rbxassetid://13410986279"
})

-- Seção de Controle
local ControlSection = MainTab:CreateSection({
    Title = "Controle do Spy"
})

ControlSection:CreateToggle({
    Title = "Ativar/Desativar Spy",
    Default = false,
    Callback = function(value)
        toggleSpy()
    end
})

ControlSection:CreateButton({
    Title = "Limpar Logs",
    Callback = function()
        for i = #remotesLog, 1, -1 do
            local log = remotesLog[i]
            if log and log.Tab then
                log.Tab:Destroy()
            end
            table.remove(remotesLog, i)
        end
        WindUI:Notify({
            Title = "Logs",
            Content = "Todos os logs foram limpos!",
            Duration = 3
        })
    end
})

-- Seção de Configurações
local ConfigSection = MainTab:CreateSection({
    Title = "Configurações"
})

ConfigSection:CreateInput({
    Title = "Adicionar à Blacklist",
    Default = "",
    Placeholder = "Nome do Remote",
    Callback = function(value)
        if value and value ~= "" then
            blacklist[value] = true
            WindUI:Notify({
                Title = "Blacklist",
                Content = string.format("'%s' adicionado à blacklist", value),
                Duration = 3
            })
        end
    end
})

ConfigSection:CreateInput({
    Title = "Adicionar ao Blocklist",
    Default = "",
    Placeholder = "Nome do Remote",
    Callback = function(value)
        if value and value ~= "" then
            blocklist[value] = true
            WindUI:Notify({
                Title = "Blocklist",
                Content = string.format("'%s' adicionado ao blocklist", value),
                Duration = 3
            })
        end
    end
})

ConfigSection:CreateButton({
    Title = "Limpar Blacklist",
    Callback = function()
        blacklist = {}
        WindUI:Notify({
            Title = "Blacklist",
            Content = "Blacklist limpa!",
            Duration = 3
        })
    end
})

ConfigSection:CreateButton({
    Title = "Limpar Blocklist",
    Callback = function()
        blocklist = {}
        WindUI:Notify({
            Title = "Blocklist",
            Content = "Blocklist limpo!",
            Duration = 3
        })
    end
})

-- Seção de Informações
local InfoSection = MainTab:CreateSection({
    Title = "Informações"
})

InfoSection:CreateLabel({
    Title = "Remotes Capturados",
    Content = "0"
})

InfoSection:CreateLabel({
    Title = "Status",
    Content = "Desativado"
})

-- Atualiza as informações periodicamente
coroutine.wrap(function()
    while true do
        wait(1)
        if InfoSection then
            -- Atualiza contagem de remotes
            local remoteCount = 0
            for _, tab in pairs(Window.Tabs) do
                if tab.Title and tab.Title ~= "Controle" then
                    remoteCount = remoteCount + 1
                end
            end
            
            -- Atualiza status
            local status = isSpying and "🟢 ATIVADO" or "🔴 DESATIVADO"
            
            -- Procura os labels para atualizar (simplificado)
            -- Em uma implementação real, você guardaria as referências dos labels
        end
    end
end)()

-- Inicialização
WindUI:Notify({
    Title = "WindUI Remote Spy",
    Content = "Pronto para uso! Clique em 'Ativar/Desativar Spy' para começar.",
    Duration = 5
})

-- Retorna a interface para possível uso externo
return {
    Window = Window,
    toggleSpy = toggleSpy,
    remotesLog = remotesLog,
    blacklist = blacklist,
    blocklist = blocklist
}