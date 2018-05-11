function connect_cb(info)
    print('wifi: connected to '..info.SSID..'('..info.BSSID..') on channel '..info.channel)
end
function disconnect_cb(info)
    print('wifi:disconnect from '..info.SSID..'('..info.BSSID..') for reason  '..tostring(info.reason))
end
function got_ip_cb(info)
    print('wifi: got ip '..info.IP..' with gateway '..info.gateway..'('..info.netmask..')')
    resetState()
end

cfg={}
cfg.ssid="spahan" 
cfg.pwd="misantrop"
cfg.auto=true
cfg.connect_cb=connect_cb
cfg.disconnect_cb=disconnect_cb
cfg.got_ip_cb=got_ip_cb

--cfg.auth=wifi.WPA2_PSK
--cfg.channel=13

wifi.sta.config(cfg)
