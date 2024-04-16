fx_version "cerulean"

description "Request Search by CFXStore"
author "CFXStore"
version "0.0.0"
repository "https://github.com/Cfx-Store/cfx_requestsearch"

lua54 "yes"

games {
  "gta5"
}

dependencies {
  "ox_lib",
  "ox_inventory"
}

client_scripts {
  "src/client/**/*.lua"
}

server_scripts {
  "src/server/**/*.lua"
}

shared_script {
  "@ox_lib/init.lua",
  "config.lua"
}
