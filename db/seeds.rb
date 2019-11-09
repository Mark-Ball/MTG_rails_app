# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#download cards for Throne of Eldraine
i = 1
while true
    response = HTTParty.get("https://api.magicthegathering.io/v1/cards?setName=Throne of Eldraine&page=#{i}")

    cards = JSON.parse(response.body)["cards"]
    break if cards.length == 0

    puts "retrieving page #{i} of 7"

    for card in cards
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
    end
    puts "finished page #{i} of 7"
    i += 1
end

# #deleting cards with no associated image
Card.where(imageUrl: nil).destroy_all

#downloading images
i = 1
while i < 458
    card = Card.find_by_id(i)
    if card && card.imageUrl
        img = Down.download(card.imageUrl)
        card.image.attach(io: img, filename: "#{card.name}_#{card.set}.jpg")
        puts "Card #{i} of 457 downloaded"
    end
    i += 1
end

#seed 3 users
User.create(
    email: "mark@test.com",    
    name: "Mark",
    alias: "Mark",
    password: "qwerty"
)
puts "user 1 created"

User.create(
    email: "garret@test.com",
    name: "Garret",
    alias: "G",
    password: "qwerty"
)
puts "user 2 created"

User.create(
    email: "hamish@test.com",
    name: "Hamish",
    alias: "Hamish",
    password: "qwerty"
)
puts "user 3 created"

#seed the listings
card_ids = [10, 79, 89, 455, 430, 155]
for id in card_ids
    price = rand(100..500)
    User.first.listings.create(condition: "mint", price: price, card_id: id)
end
puts "listings created for user 1"

card_ids = [398, 351, 452, 455]
for id in card_ids
    price = rand(100..500)
    User.find(2).listings.create(condition: "mint", price: price, card_id: id)
end
puts "listings created for user 2"

card_ids = [455, 91, 94, 145]
for id in card_ids
    price = rand(100..500)
    User.find(3).listings.create(condition: "mint", price: price, card_id: id)
end
puts "listings created for user 3"