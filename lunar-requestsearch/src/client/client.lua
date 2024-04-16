local initiator = nil
local keybind

local function getPlayerFromPed(ped)
  local players = GetActivePlayers()
  for _, player in ipairs(players) do
    if GetPlayerPed(player) == ped then
      return player
    end
  end
end

local function requestSearch(data)
  local entity = data.entity
  local target = getPlayerFromPed(entity)
  local targetId = GetPlayerServerId(target)

  lib.callback.await("cfx_requestsearch:sendRequest", 0, targetId)
end

local function acceptSearchRequest()
  lib.callback.await("cfx_requestsearch:acceptRequest", 0, initiator)

  initiator = nil
  keybind:disable(true)
end

local function start()
  exports.ox_target:addGlobalPlayer({
    label = "Fouilleer Verzoek",
    icon = "fas fa-search",
    onSelect = requestSearch
  })

  keybind = lib.addKeybind({
    name = "accept_request_search",
    description = "press Y to accept request search",
    defaultKey = "Y",
    onPressed = acceptSearchRequest
  })
  keybind:disable(true)
end

Citizen.CreateThread(start)

lib.callback.register("cfx_requestsearch:receiveRequest", function(from)
  cfx.sendNotification("Fouilleer Verzoek",
    ("Je hebt een fouilleer verzoek ontvangen, druk op Y om hem te accepteren."):format(from))

  initiator = from
  keybind:disable(false)

  Citizen.CreateThread(function()
    Citizen.Wait(Config.requestExpiry)

    if initiator ~= nil then
      cfx.sendNotification("Fouilleer Verzoek",
        ("Je fouilleer verzoek is velopen."):format(from))

      initiator = nil
      keybind:disable(true)
    end
  end)
end)
