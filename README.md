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

The primary market for Magic cards is monopolistic as Magic is the intellectual property of Wizards of the Coast and therefore they enjoy the exclusive right to print Magic cards. Under a monopoly, the price of Magic cards is elevated relative to a competitive market, which is beneficial to the monopolist, but detrimental to consumers.

The development of a secondary market for Magic cards introduces economic competition to the market. This has the effect of reducing price, which is beneficial for the players of Magic, but detrimental to Wizards of the Coast. Furthermore, the existence of a secondary market is likely to reduce the demand for booster packs as players have an alternative way to obtain the cards they desire.

MTG-marketplace allows players to buy specific cards, bypassing the regular card-acquisition cycle of buying booster packs, opening the packs to find that the desired card was not included, and then buying more. The advantages are the following:
- less gambling behaviour
- ability to construct the deck desired with certainty (i.e. without being exposed to the uncertainty of buying booster packs)
- ability to know in advance how much money a desired deck will cost to construct
- ability to sell cards which the player has acquired but does not wish to play themselves, reducing the total cost of developing a collection
- improving efficiency and reducing waste in the Magic card system by transferring cards from those who do not want their cards to those who would like them

## User stories

User stories and their implications for the features of MTG-marketplace are provided below.

<strong>1. As a player, I want to be able to buy individual Magic cards, so I don't have to gamble on booster packs</strong>

Implication: users should be able to view the details of individual cards before purchase, rather than buying without knowing the identity of the card

<strong>2. As a player, I want to be able to sell cards I don't use, so that I may recoup some of my costs
3. As someone who no longer plays Magic, I want to be able to sell my old cards, so I may recoup some of my costs</strong>

Implication: users should be able to list cards for sale on the website.

<strong>4. As a buyer, I want to be able to search all listings, so I may find the individual card I need</strong>

Implication: search functionality for listings should exist.

<strong>5. As a seller, I want to be able to see the prices that a card is selling at, so that I may set an appropriate price</strong>

Implication: as much detail on transaction prices should be provided as possible. Ideally this would include a price history over several months. However considering the scope of the project, the feature to be implemented is that users can see the prices of all cards currently listed.

<strong>6. As a seller, I want to be able to modify my listing after it is posted, so that I may correct any mistaken details I have entered</strong>

Implication: edit functionality should exist to change details of the listing, or even remove the listing completely.

<strong>7. As someone speculating on Magic cards without actually playing, I want to be able to see the prices that cards are selling at, so that I may identify an opportunity for profit</strong>

Implication: all visitors to the website should be able to view the listings without having to register on the site.

<strong>8. As both a buyer and a seller, I want the site to handle payment, so I don't have to worry about it</strong>

Implication: a reputable third-party payment gateway such as Stripe should be used on the site. 

<strong>9. As a buyer, I want to be able to enter my delivery details once, so that I may save time on multiple transactions</strong>

Implication: a user should have a persistent profile where information is automatically pulled from when necessary.

<strong>10. As a seller, I want the website to identify the full card information with as little input from me as possible, so I don't have to manually enter all the details myself
11. As a buyer, I want the website to check that the details of all cards listed for sale are correct, so I am protected from fraud</strong>

Implication: the website should ask sellers only for the minimum information required to uniquely identify a card, then retrieve the details of each card from a database, rather than asking sellers to enter all the details. This makes the experience easier on sellers as they need to enter less information, and protects buyers because listing details cannot be falsified.

<strong>12. As a user, no one should be able to edit my profile or buy or sell under my profile, so I have control over my activity on the site
13. As a seller, no one should be able to edit my listings but me, so I have control over what I am selling</strong>

Implication: an authentication system must exist which restricts users from accessing or editing certain information.

## The components of the application

MTG-marketplace is written using Ruby on Rails and the PostgreSQL database. The application utilises the model-view-controller (MVC) model to create separation of concerns and applies a RESTful API to define which methods are available on which endpoints.

This section will explain the different high-level abstractions in the app:
- database
- routes
- model
- view
- controller

#### The database

The role of the database is to hold the data. This is necessary so that data is persistent between sessions. Without a database, information can only be saved in variables, which are temporary memory storage. This means that when a user closes the app and re-opens it, their data would be lost. Data is saved in the database in rows and columns. A page of rows and columns, analogous to a spreadsheet is called a table. Some of the tables included in MTG-marketplace are cards and users, which store information regarding cards and users respectively. The columns within a database are called attributes and the rows are called records.

#### Routes

Routes are important for the rails application because they direct where information should flow between the models, controllers, and views, and which HTTP verbs are available on which endpoints. The routes are arranged in rails using RESTful API architecture.

Routes are declared in the 'routes.rb' file in the config directory. The verbs, controllers, and methods declared in the routes file determines which controllers, methods within those controllers, and views must be created.

#### The model

The database is accessed via the model, which has the responsibility of interfacing with the database and passing the information along to the controller. In Rails, the model must be named the singular version of the table to which it refers. For example the model for the cards table must be called 'cards.rb' by convention and placed in the app/models directory. The model should inherit from the ApplicationRecord class.

If these conventions are met, many instance and class-instance methods are made available on the Cards class. Some methods available on the class itself are the ability to create (.create) or view all instances of the class (.all). Some methods available on an instance of the class are to edit (.update) or destroy (.destroy).

#### The view

The role of the view is to display information to users. Therefore each webpage will have a view. Views are intended to contain very little logic, with only simple conditionals being acceptable. For example the view may contain a conditional to show a 'login' button if the user is logged out, but a 'logout' button if the user is logged in.

By convention, views are saved in the apps/views directory, and then inside another directory with the name of that page's controller. For example if the model was called 'card.rb', the controller would be called 'cards_controller.rb' and a directory named 'cards' would need to be created in apps/views, then any pages accessed through 'cards_controller.rb' would be saved in app/views/cards. These files would then have the name of the methods within the controller. Following on from our example, if there was a method called 'show' in 'cards_controller.rb', the view would be called 'show.html.erb'.

#### The controller

The controller contains the logic of the program and is responsible for connecting the model and view, meaning showing the information retrieved from the database to the user.

By convention, controllers are saved in app/controller and must be named with the plural of the model it interfaces with. For example if the model is called 'card.rb', the controller would be called 'cards_controller.rb'. In this file, a class called CardsController should be declared, which inherits from ApplicationController. Naming the controller using this convention allows access to inherited methods and helpers.

In MTG-marketplace, common tasks performed by the controller are passing information regarding groups or individual cards to the relevant views so that they may be displayed to the user. 

## The database structure

MTG-marketplace uses the PostgreSQL database for the persistent storage of data. The following tables are included:
- users
- addresses
- cards
- colors
- cards_colors
- all_cards
- images

For all tables, the attributes collected can be viewed in the ERD diagram in the following section. 

The users table exists to store information regarding individual buyers and sellers on the site.

The addresses table exists to store the postage address of each user so that sellers know where to send any purchased cards.

The relationship between users and addresses is:
- <strong>a user has one address
- an address belongs to a user</strong>

The cards table holds the details of all cards listed on the website.

The relationship between users and cards is:
- <strong>a user has many cards
- a card belongs to a user</strong>

The colours table holds a list of the five colors used in Magic, as well as colorless. This table is used to provide information about the color of individual cards rather than add six additional attributes to each card. Colors is connected to cards by the join table cards_colors.

The relationship between cards and colors are:
- <strong>a card has many cards_colors
- a card has many colors, through cards_colors
- a color has many cards_colors
- a color has many cards, through cards_colors</strong>

The all_cards table exists to hold all the information for all Magic cards in existance. The reason this table was created was that the magicthegathering.io API, which is used to retrieve records of individual cards, was created as a hobby project by an individual programmer. Therefore the reliability of the service is uncertain. To mitigate this, the entire set of Magic cards has been downloaded to our own database. This improves both the query speed because we will no longer be waiting for responses from an API, and reliability since we are not relying on a third party.

The relationship between all_cards and cards is:
- <strong>cards belongs to all_cards
- all_cards has many cards</strong>

The last table in the database structure is images, which is used to store images of both user avatars and cards. Images is therefore a polymorphic table which will have associations with both users and cards.

The relationships between users, cards, and images are:
- <strong>a user has many images, as imageable
- a card has many images, as imageable</strong>

## ERD

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

Having a pre-existing database of all Magic cards which is used to provide information about each card sold on MTG-marketplace solves this problem as well as leading to an easier experience for sellers.

## Task planning and tracking

Agile workflow was implemented in the development of MTG-marketplace. This was done despite the fact that the entire project had a duration of two weeks, while a single sprint under Agile methodology would last two weeks. Therefore sprints in the development of MTG-marketplace were planned to last only a few days each. This was characterised by cycles of:
1. Planning
2. Development of feature
3. Testing and code review
4. Acceptance of code, completion of feature

Features were planned sequentially as later features relied upon earlier feature to function. For example card listings cannot be created until the cards table has been created in the database.

All tasks were tracked with Trello.

#### Feature 1: The database
The database is the foundation of the entire application, without which only a static website could be created.

Planning the database included:
- tables and models to be generated
- attributes on each table
- associations between tables

Development of the feature included:
- creating the database
- generating and running the migrations
- writing the planned associations into the relevant models

Testing of the feature included running through multiple scenarios where the expected outcome was compared with the actual outcomes. Fixes were implemented if testing revealed errors in the program. Testing of the database involved making sure the following were completed successfully:
- a user can be created
- a user can be created with an address correctly associated
- a card listing can be created
- a card listing can be created with a user correctly associated
- a card listing correctly retrieves information from the all_cards table
- a card can be created with an image correctly associated
- a user can be created with an image correctly associated
- cards have colors correctly associated through the join table

When all tests are passed, review of the feature within the overall context of the project is conducted. If no reasons for deviating from the initially planned workflow are given, work on the next feature may begin.

#### Feature 2: 

