# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#download cards
# i = 1
# while true
#     response = HTTParty.get("https://api.magicthegathering.io/v1/cards?page=#{i}")

#     cards = JSON.parse(response.body)["cards"]
#     break if cards.length == 0

#     puts "retrieving page #{i}"

#     for card in cards
#         Card.create(
#             name: card["name"],
#             names: card["names"],
#             manacost: card["manaCost"],
#             cmc: card["cmc"],
#             colors: card["colors"],
#             colorIdentity: card["colorIdentity"],
#             card_type: card["type"],
#             supertypes: card["supertypes"],
#             types: card["types"],
#             subtypes: card["subtypes"],
#             rarity: card["rarity"],
#             set: card["setName"],
#             text: card["text"],
#             artist: card["artist"],
#             number: card["number"],
#             power: card["power"],
#             toughness: card["toughness"],
#             layout: card["layout"],
#             multiverseid: card["multiverseid"],
#             imageUrl: card["imageUrl"],
#             rulings: card["rulings"],
#             foreignNames: card["foreignNames"],
#             printings: card["printings"],
#             originalText: card["originalText"],
#             originalType: card["originalType"],
#             magic_card_id: card["id"]
#         )
#     end
#     puts "finished page #{i}"
#     i += 1
# end

# #deleting cards with no imageUrl
# Card.where(imageURL: nil).destroy_all

#downloading images
i = 15694
while i < 16151 #this range represents all Tenth Edition cards
    card = Card.find_by_id(i)
    if card && card.imageUrl
        img = Down.download(card.imageUrl)
        card.image.attach(io: img, filename: "#{card.name}_#{card.set}.jpg")
        puts "Card #{i} downloaded"
    end
    i += 1
end

#seed the listings
#must create users manually first
# card_ids = [131, 182, 158, 390, 434, 454]
# for id in card_ids
#     price = rand(100..500)
#     User.first.listings.create(condition: "mint", price: price, card_id: id)
# end