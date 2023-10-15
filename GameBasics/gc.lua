function CountAll(f)
    local seen = {}
    local countTable
    countTable = function(t)
        if seen[t] then return end
        f(t)
        seen[t] = true
        for k,v in pairs(t) do
            if type(v) == "table" then
                countTable(v)
            elseif type(v) == "userdata" then
                f(v)
            end
        end
    end
    countTable(_G)
end

function TypeCount()
    local counts = {}
    local enumerate = function(o)
        local t = TypeName(o)
        counts[t] = (counts[t] or 0) + 1
    end
    CountAll(enumerate)
    return counts
end

GlobalTypeTable = nil
function TypeName(o)
    if GlobalTypeTable == nil then
        GlobalTypeTable = {}
        for k,v in pairs(_G) do
            GlobalTypeTable[v] = k
        end
        GlobalTypeTable[0] = "table"
    end
    return GlobalTypeTable[getmetatable(o) or 0] or "Unknown"
end

function GCDump()
    print("Before collection: " .. collectgarbage("count")/1024)
    collectgarbage("collect")
    print("After collection: " .. collectgarbage("count")/1024)
    print("Object count: ")
    local counts = TypeCount()
    for k, v in pairs(counts) do print(k, v) end
    print("-------------------------------------")
end