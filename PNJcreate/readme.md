
## Installation
- Créer une table mysql nommé `eldo_PNJ` ou alors modifié le nom dans server.lua `nomTable = `
ou alors Copier/coller ce code (modifier DATABASE_NAME)
``` CREATE TABLE `DATABASE_NAME`.`eldo_PNJ` ( `AI` INT NOT NULL AUTO_INCREMENT , `type` INT NOT NULL , `model` TEXT NOT NULL , `posx` FLOAT NOT NULL , `posy` FLOAT NOT NULL , `posz` FLOAT NOT NULL , `rot` FLOAT NOT NULL , PRIMARY KEY (`AI`)) ENGINE = InnoDB;```


## Dans le futur 
- Ajoutez un refresh all, undo


Les PNJ ne sont plus sous les effets Freeze/no fear une fois le script stopper