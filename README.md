# MTG-marketplace

Github: https://github.com/Mark-Ball/MTG_rails_app

Website: TBC

# Introduction
Magic: The Gathering (hereafter 'Magic') is a strategy game played with specially-printed cards. An example of a front and back of a Magic card is presented below.

![magic_cardback](/docs/mtg_example.jpg)

The game represents a battle between wizards called Planeswalkers in the in-game universe. A typical game involves playing creatures and spells to attack the opponent and the winner is the player who reduces their opponent's life to zero first.

Magic cards can be bought from games retailers such as EB Games or Goodgames, as well as larger retailers who carry games such as Target. 

## What is the problem we are trying to solve with MTG-marketplace?

Magic cards are usually bought in one of two ways:
- pre-built decks, or
- booster packs

Pre-built decks are designed to give new players to the game a legal deck which they are able to pick up and begin playing with immediately, without modifications. However, these decks are generally inferior compared to the best constructed decks. The problem of inferiority is solved by the second method: buying booster packs.

Booster packs are packages of 15 cards from a given set. Each booster pack will contain 1 rare or mythic rare (i.e. the highest quality, rarest, and generally most powerful cards), 3 uncommon cards, and the remainder common cards. It is through acquiring additional cards, especially the more powerful rare and mythic rare quality cards that the player improves the power of their deck.

Booster packs are available for around $7.00.

The problem with buying booster packs is that many of the cards are poor quality, or may be in colours which the player does not intend to use in their deck. The fact that booster packs are sealed in opaque wrapping means that the buyer cannot know whether they will receive the cards they want in advance of buying the booster pack.

This uncertain outcome is essentially gambling, which can lead to addictive buying behaviour.

MTG-marketplace allows players to buy specific cards, bypassing the regular card-acquisition cycle of buying booster packs, opening the packs to find that the desired card was not included, and then buying more. The advantages are the following:
- less gambling behaviour
- ability to construct the deck desired with certainty (i.e. without being exposed to the uncertainty of buying booster packs)
- ability to know in advance how much money a desired deck will cost to construct
- ability to sell cards which the player has acquired but does not wish to play themselves, reducing the total cost of developing a collection
- improving efficiency and reducing waste in the Magic card system by transferring cards from those who do not want their cards to those who would like them

## User stories

# Features

## Peer-to-peer selling

## Easy to list, easy to buy

## Secure system

## Seller reviews

## Third-party services MTG-marketplace uses

MTG-marketplace uses three third-party services:
- magicthegathering.io
- Stripe
- Devise

#### Stripe

Stripe is the payment system used in MTG-marketplace. 

#### magicthegathering.io

magicthegathering.io is an API developed by Andrew Backes, a software engineer from Milwaukee, Wisconsin. This API is developed as a hobby project by Backes, and is not affiliated with the organisation which owns Magic, Wizards of the Coast.

This API was used in MTG-marketplace to download a database of all existing Magic cards into our own table in postgres. This was a significant time-saver because over 15,000 unique Magic cards exist and producing a database of all these cards for the purpose of this project would have been impossible.

It is important to have a database of all Magic cards for this projects so that users may more easily identify the cards they wish to buy or sell. The alternative would be for sellers to input the information about each Magic card they choose to list. However, the problem with this is that sellers may falsify information, leading buyers to believe that a card is more powerful than it really is, or simply mistakenly enter incorrect information.

magicthegathering.io provides endpoints for groups of cards (this is the main endpoint which was used for MTG-marketplace), individual cards, all sets, individual sets, the content of booster packs, a list of card types (e.g. creatures, land, sorcery) and more. The API is rate-limited to 5,000 requests per hour. 

Having a pre-existing database of all Magic cards which is used to provide information about each card sold on MTG-marketplace solves this problem as well as leading to an easier experience for sellers.`