cfx = {}

function cfx.sendNotification(title, message)
  exports["cfx_chatmessage"]:sendChatMessage({
    title = title,
    message = message,
    color = "#c95e28",
    hueRotation = 180
  })
end
