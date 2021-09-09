location = "canadaeast"
vnet = {
    name = "azvnet"
    rgName = "vnet-rg"
    address_space = ["10.0.0.0/16"]
}

subnet = {
        webtier = {
            name = "web_sbn"
            address_prefix = ["10.0.1.0/24"]
        }
        apptier = {
            name = "app_sbn"
            address_prefix = ["10.0.2.0/24"]
        }
        dbtier = {
            name = "db_sbn"
            address_prefix = ["10.0.3.0/24"]
        }

}

zones = ["1","2","3"]


image = {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "16.04-LTS"
        version   = "latest"
}

webVm = {
    prefix = "azwebvm"
    count = 5
    vmSize = "Standard_DS5_v2"
    rgName = "azwebtier-rg"
    tags = {
        environment = "production"
        owner = "Nitish Nigam"
        serverType = "Web Tier" 
    }
}

appVm = {
    prefix = "azappvm"
    count = 1
    vmSize = "Standard_DS5_v2"
    rgName = "azapptier-rg"
    tags = {
        environment = "production"
        owner = "Nitish Nigam"
        serverType = "App Tier" 
    }
}

dbVm = {
    prefix = "azdbvm"
    count = 1
    vmSize = "Standard_DS5_v2"
    rgName = "azdbtier-rg"
    tags = {
        environment = "production"
        owner = "Nitish Nigam"
        serverType = "DB Tier" 
    }
}

