function ls()
  for k,v in pairs(file.list()) do
    print("name:"..k..", size:"..v)
  end
end

function cat(f)
  local fd = file.open(f)
  local fb = nil
  if fd == nil then
    return false
  end
  fb = fd.read()
  while fb do
    print(fb)
    fb = fd.read()
  end
end

function lwc()
    for mac,ip in pairs(wifi.ap.getclient()) do
        print(mac,ip)
    end
end
