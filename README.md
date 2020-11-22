# WDI2020
Kod z prezentacji na Warszawskich Dniach Informatyki 2020

W aplikacji należy utworzyć własny plik Credentials.swift według wzoru:

struct Credentials {

static let BROKER_ADDRESS = "0.0.0.0" // URL do brokera MQTT
static let USERNAME = "" // nazwa użytkownika konta brokera MQTT
static let PASSWORD = "" // hasło użytkownika do brokera MQTT
static let SUB_SUBJECT = "aquarium_data" // przykładowy temat, na który wysyłane są dane z temepraturą
static let PUB_SUBJECT = "aquarium_command" // przykładowy temat, na który wysyłana jest informacja o włączeniu światła

} 
