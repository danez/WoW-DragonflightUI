local DF = LibStub('AceAddon-3.0'):GetAddon('DragonflightUI')

local moduleOptions = {}
local options = {
    type = 'group',
    args = {
        general = {
            type = 'group',
            inline = true,
            name = 'General Options',
            args = {
                unlock = {
                    type = 'execute',
                    name = 'Do Nothing',
                    desc = 'Does nothing',
                    func = function()
                        DF:Print('Dont press me, i do nothing!')
                    end,
                    order = 69
                }
            }
        }
    }
}

function DF:SetupOptions()
    self.optFrames = {}
    LibStub('AceConfigRegistry-3.0'):RegisterOptionsTable('DragonflightUI', options)
    self.optFrames['DragonflightUI'] = LibStub('AceConfigDialog-3.0'):AddToBlizOptions('DragonflightUI',
                                                                                       'DragonflightUI')

    local profiles = LibStub('AceDBOptions-3.0'):GetOptionsTable(self.db)
    profiles.order = 666
    LibStub('AceConfig-3.0'):RegisterOptionsTable('DragonflightUI_Profiles', profiles)
    LibStub('AceConfigDialog-3.0'):AddToBlizOptions('DragonflightUI_Profiles', 'Profiles', 'DragonflightUI')
end

function DF:RegisterModuleOptions(name, options)
    -- self:Print('RegisterModuleOptions()', name, options)
    moduleOptions[name] = options
    -- function AceConfigDialog:AddToBlizOptions(appName, name, parent, ...)
    LibStub('AceConfigRegistry-3.0'):RegisterOptionsTable('DragonflightUI_' .. name, options)

    self.optFrames[name] = LibStub('AceConfigDialog-3.0'):AddToBlizOptions('DragonflightUI_' .. name, name,
                                                                           'DragonflightUI')
end

function DF:SetupNewOptions()
    self:Print('SetupNewOptions')
    local category, layout = Settings.RegisterVerticalLayoutCategory("DragonflightUI");
    Settings.RegisterAddOnCategory(category);

    self.optFrames = {}
    self.optFrames['DragonflightUI'] = category
end

function DF:RegisterNewModuleOptions(name, options)
    self:Print('RegisterNewModuleOptions()', name, options)
    -- local category = Settings.GetCategory("DragonflightUI")
    local category = self.optFrames['DragonflightUI']

    local subcategory, layout = Settings.RegisterVerticalLayoutSubcategory(category, name);
    Settings.RegisterAddOnCategory(subcategory);

    -- layout:AddInitializer(CreateSettingsListSectionHeaderInitializer(NAMES_LABEL));
    -- Settings.SetupCVarCheckBox(subcategory, "UnitNameOwn", UNIT_NAME_OWN, OPTION_TOOLTIP_UNIT_NAME_OWN);

    -- DF:AddHeaderToLayout(layout, 'Test')
    return subcategory, layout
end

function DF:AddHeaderToLayout(layout, header)
    layout:AddInitializer(CreateSettingsListSectionHeaderInitializer(header));
end

function DF:RegisterSlashCommands()
    self:RegisterChatCommand('df', 'SlashCommand')
    self:RegisterChatCommand('dragonflight', 'SlashCommand')

    -- "default" quick reload command
    self:RegisterChatCommand('rl', 'ReloadCommand')
    self:RegisterChatCommand('test', 'TestCommand')
end

function DF:TestCommand(msg)
    -- Settings.OpenToCategory('DragonFlightUINEW')
    -- Settings.OpenToCategory('DragonFlightUINEW')
    -- InterfaceOptionsFrame_OpenToCategory("DragonFlightUINEW")

end

function DF:SlashCommand(msg)
    -- self:Print('Slash: ' .. msg)
    InterfaceOptionsFrame_OpenToCategory('DragonflightUI')
    InterfaceOptionsFrame_OpenToCategory('DragonflightUI')
end

function DF:ReloadCommand()
    ReloadUI()
end
