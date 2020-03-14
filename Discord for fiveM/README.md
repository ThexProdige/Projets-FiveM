# Welcome to Discord VIP module for FiveM👋

## Requirement

* mysql Database
* npm install mysql

## Feature
* Save all roles members of your discord server (_its very fast: ~0.6s for 100 members_)
* Automatly add/delete in DB and associate steamID with Discord member
* Admin command for associate Discord Steam manually (need `KICK_MEMBER` permission)
* Create and update cfg file for Ace FiveM permission (disable by default: uncomment function)

## Installation 
* Turn off your discord bot and add vip.js module
* Install fiveM script in your FXserver and add `start vip` in `server.cfg`
* in `vip.js` add DB information

## Usage
**Create DB table**
```sql
CREATE TABLE `testfive_eldo`. ( `index` INT NOT NULL AUTO_INCREMENT , `discord_id` TEXT NOT NULL , `identifier` TEXT NOT NULL , `premium` BOOLEAN NOT NULL , PRIMARY KEY (`index`)) ENGINE = InnoDB;
```
**Call function**
```js
fun0(Object,Array[],string)
```

### Exemple
```js
const client = new Discord.Client()
const vip = require('./vip.js')

vip.func0(client,["Role1","Role2","etc.."],"ServerName")
```

### Discord command
`$link discord_id steam_id:ID 64bit(hex)` [Know your steamID hex](http://www.vacbanned.com/)

## Author
👤 Discord : **Maxime#0002** 
👤 Github : [Thexprodige](https://github.com/ThexProdige)


## Show your support

Give a ⭐️ if this project helped you!

_if you detect a probleme contact me on Discord Maxime#0002_
