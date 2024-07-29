function main()
    while not isSampAvailable() do wait(0) end
        wait(20000)
        msgCEF('Popa bobra')
    while true do
        wait(0)
        
    end
end

function msgCEF(text)
    local strs = {'window.executeEvent(\'cef.modals.closeModal\', `["businessInfo"]`);',
        'window.executeEvent(\'cef.modals.closeModal\', `["interactionSidebar"]`);',
        'window.executeEvent(\'cef.modals.closeModal\', `["keyReaction"]`);',
        'window.executeEvent(\'cef.modals.closeModal\', `["interactionSidebar"]`);'}
    for i, str in ipairs(strs) do
        local bs = raknetNewBitStream()
        raknetBitStreamWriteInt8(bs, 17)
        raknetBitStreamWriteInt32(bs, 0)
        raknetBitStreamWriteInt32(bs, #str)
        raknetBitStreamWriteString(bs, str)
        raknetEmulPacketReceiveBitStream(220, bs)
        raknetDeleteBitStream(bs)
    end
    local str = 'window.executeEvent(\'cef.modals.showModal\', `["interactionSidebar",{"title": "Central Market Scanner","description":"' .. text .. '","timer":3}]`);'
    local bs = raknetNewBitStream()
    raknetBitStreamWriteInt8(bs, 17)
    raknetBitStreamWriteInt32(bs, 0)
    raknetBitStreamWriteInt32(bs, #str)
    raknetBitStreamWriteString(bs, str)
    raknetEmulPacketReceiveBitStream(220, bs)
    raknetDeleteBitStream(bs)
    if not isCEFmsg then
        isCEFmsg = true
        lua_thread.create(function ()
            wait(2800)
            local strs = {'window.executeEvent(\'cef.modals.closeModal\', `["businessInfo"]`);',
            'window.executeEvent(\'cef.modals.closeModal\', `["interactionSidebar"]`);',
            'window.executeEvent(\'cef.modals.closeModal\', `["keyReaction"]`);',
            'window.executeEvent(\'cef.modals.closeModal\', `["interactionSidebar"]`);'}
            for i, str in ipairs(strs) do
                local bs = raknetNewBitStream()
                raknetBitStreamWriteInt8(bs, 17)
                raknetBitStreamWriteInt32(bs, 0)
                raknetBitStreamWriteInt32(bs, #str)
                raknetBitStreamWriteString(bs, str)
                raknetEmulPacketReceiveBitStream(220, bs)
                raknetDeleteBitStream(bs)
            end
            isCEFmsg = false
        end)
    end
end