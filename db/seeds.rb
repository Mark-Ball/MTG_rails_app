# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

response = HTTParty.get("https://api.magicthegathering.io/v1/cards?name=Ascendant Evincar&setName=Nemesis")

card = JSON.parse(response.body)["cards"][0]

Card.create(
    name: card["name"],
    names: card["names"],
    manacost: card["manaCost"],
    cmc: card["cmc"],
    colors: card["colors"],
    colorIdentity: card["colorIdentity"],
    card_type: card["type"],
    supertypes: card["supertypes"],
    types: card["types"],
    subtypes: card["subtypes"],
    rarity: card["rarity"],
    set: card["setName"],
    text: card["text"],
    artist: card["artist"],
    number: card["number"],
    power: card["power"],
    toughness: card["toughness"],
    layout: card["layout"],
    multiverseid: card["multiverseid"],
    imageUrl: card["imageUrl"],
    rulings: card["rulings"],
    foreignNames: card["foreignNames"],
    printings: card["printings"],
    originalText: card["originalText"],
    originalType: card["originalType"],
    magic_card_id: card["id"]
)