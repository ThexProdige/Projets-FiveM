const mysql = require('mysql');

// / / / / / / / A COMPLETER / / / / / / /
var vipRole = [] 
var serverName = ""


const con = mysql.createConnection({  // Information de Connection à la BDD

    host: "",
    user: "",
    password:"",
    database: ""
    // /    /   /   /   /   /   /   /   /   /   /   /   /   /   /
    // SQL A EXECUTER : ALTER TABLE `vip_table` ADD `premium` BOOLEAN NOT NULL AFTER `premium`, ADD `discord_id` TEXT NOT NULL AFTER `1`;
    //
    //
    //  /   /   /   /   /   /   /   /   /   /   /   /   /   /   /   

});

con.connect(err => { //Connection
    if(err) throw err;
    console.info("Connecté à la base de donnée");
});
module.exports =  {
    func0: function(client,role,server){ //mettre en commantaire les fonctions à ne pas utiliser
        vipRole = role
        serverName = server

        if (this.funcTest(client)){//Si tout est OK

            this.func11(client)//Initialisation (OBLIGATOIRE)
            this.func2(client)//Mise à jour en temps Réel (OBLIGATOIRE)
            this.func3(client)// Admin command
          //  this.func4()//creation fichier cfg pour permission FiveM
        }

    },
    func11: function(client){//Init v2
        const guild =  client.guilds.find(serverid => serverid.name === serverName)

        let user_ID = []
        let membre = []
        for(var i = 0 ; i < vipRole.length; i++){
            const roles = guild.roles.find(roles => roles.name == vipRole[i]) //tableau de référence (renvoie l'id du role)
            
            vipRole[i] = roles.id
        }  // récupération des ID des roles
        
        for(var i = 0; i < vipRole.length;i++){ 
            const roleList = guild.roles.find(role => role.id === vipRole[i]); //on recherche notre role 
            let mRole = roleList.members; //stock les membres du rôle 

             membre[i] = mRole.keyArray(); //stock tout les ID des membres dans un tableau.  tier du plus petit au plus grand
             
             
        }//creation des tableaux
        if(membre.length === 1){
                user_ID = membre[0]
        }//Si y a qu'un 1 role, il zappe la boucle For juste en dessous
        for(var i = 1; i < membre.length; i++){
                user_ID = membre[0].concat(membre[i])
        }// Fusion des tableaux

        user_ID.sort(function(a, b){return a - b}); //Trie par ordre croissant

        for(var i = 0; i< user_ID.length;i++){
            if(user_ID[i + 1] == null){
                break
            }
            else if(user_ID[i + 1] === user_ID[i]){
                user_ID.splice(i,1)
            }
        }//ANTI DOUBLONS (ça peut arrivé si un utilisateur à deux roles premium)
        
        con.query("SELECT * FROM `vip_table` ORDER BY `vip_table`.`discord_id` ASC", (err,rows) => {
            if (err) throw err;
            var rowsLen = Object.keys(rows).length;
            for(var i = 0 ; i < rowsLen; i++){
                if(rows[i].premium === 1){
                    var find = user_ID.findIndex(fFind)
                    if (find === -1){
                        update(rows[i].discord_id, 0)
                    }//SUPPR
                    else{
                        user_ID.splice(find,1)
                    }
                }else if(rows[i].premium === 0){
                    var find = user_ID.findIndex(fFind)
                    if (find != -1){
                        update(rows[i].discord_id, 1)
                        user_ID.splice(find,1)
                    }//AJOUT
                }
            }//UPDATE

            for(var i = 0 ; i < user_ID.length; i++){
                create(user_ID[i],"")
            }//CREATION
            function fFind(value,index,array){
                return value === rows[i].discord_id
            }//RECHERCHE EGALITE

        })//MISE A JOUR DE LA BDD
    },

    func2: function(client){//Actualisation en temps réél
        
        client.on("guildMemberUpdate", (oldMember,newMember) => {
            var user = oldMember.user.id //ID_discord du membre

            
            
            var ancien = oldMember.roles.keyArray() //renvoie les anciens roles du membre
            var nouveau = newMember.roles.keyArray() //renvoie les nouveau roles

            var oldP = compare(vipRole, ancien) //verifie s'il avais un des role premium
            var newP = compare(vipRole, nouveau) //verifie s'il a 

           
            if( !oldP && newP){// Est devenu premium
                con.query('SELECT COUNT(1) as ctn FROM `vip_table` WHERE discord_id=' + user , (err, rows) =>{
                    if (err) throw err;
                    if (rows[0].ctn === 1){ // s'il a déjà etait premium avant
                        update(user, 1)
                    }
                    else{
                        create(user,"") //sinon on l'enregistre
                    }
                })
            }
            else if (oldP && !newP){ // n'est plus premium
                update(user, 0)
            }
        });


    },
    func3: function(client){ //association manuelle pour admin

        client.on("message", message => {
                if(message.content.startsWith("$link")){ // SI LE MESSAGE COMMENCE PAR $LINK
                    if(message.member.hasPermission("KICK_MEMBERS")){ //SEULEMENT LES UTILISATEURS QUI ONT LES PERMISSIONS POUR KICK PEUVENT UTILISER LA COMMANDE

                        var split = message.content.split(" ", 3)//DIVISION DU MESSAGE EN ARRAY
                        if(split[2] == null || split[1] == null)// ON VERIFIE QUE LUTILISATEUR SEST PAS TROMPER
                        {
                            message.reply("Erreur lors de la saisie de la commande. Utilisation $link `discord_id` `steam3ID 64bit(hex)`")
                        }
                        else if(!split[2].startsWith("steam:")){
                            message.reply("L'identifiant steam est incorrect!")
                        }else{//SI TOUT EST CORRECT 
                            con.query('SELECT * FROM `vip_table` WHERE discord_id="' + split[1] + '"', (err,rows) => { //ON RECHERCHE ID DISCORD DANS LA BDD
                                if(err) throw err;
                                try{
                                    updateAdmin(rows[0].discord_id, split[2]) //UPDATE
                                    message.reply("<@" + rows[0].discord_id +"> à bien etait associer à `"+ split[2] +"`")
                                        .catch(()=> message.reply("Une erreur est inconnue est survenue, si le problème persiste contactez Maxime#0002"))
                                    
                                }catch(err){//SIL EXISTE PAS OU QUE LUTILISATEUR A MIS UN MAUVAIS DISCORD ID OU QUIL NA PAS LE ROLE PREMIUM

                                    message.reply("L'utilisateur mentionné n'est membre d'aucun rôle premium, ajoutez-lui le rôle avant l'association manuelle")
                                        
                                }
                            })
                        }
                    }else{
                        message.reply("Vous n'avez pas la permission d'utiliser cette commande, un administrateur a été averti")
                    }
                }
            

        })
    },

    func4: function(){ //ecriture du fichier donateur.cfg
        
        con.query("SELECT * FROM `vip_table` WHERE premium=1", (err,rows)=> {
            if(err) throw err;
            var length = Object.keys(rows).length
            var data = "#Ajout des donateurs dans le groupe group.donateur ça peut toujours servir le jour ou il y aura des avantage IG\n\n"

            for(var i = 0; i < length; i++){
                if(rows[i].identifier != ""){
                    data = data + "add_principal identifier." + rows[i].identifier + " group.donateur #Discord ID " + rows[i].discord_id + "\n"
                }
                    
            }
            writeFile('./donateur.cfg', data)
        })
        
        
    },
    funcTest: function(client){
        const guild =  client.guilds.find(serverid => serverid.name === serverName)
        if (guild == null){
            console.warn("VIP n'a pas pu démarrer (Nom serveur incorrect)")
            return false
        }else{
            for(var i = 0 ; i < vipRole.length; i++){
                const roles = guild.roles.find(roles => roles.name == vipRole[i]) //tableau de référence (renvoie l'id du role)
                if (roles == null){
                    console.warn("VIP n'a pas pu démarrer (Nom rôle incorrect)")
                    return false
                }
                
            }
            return true 
        } 
    }

};

function compare(ref, aCompare){
    for (var i = 0; i < aCompare.length ; i++){
        for(var i2 = 0 ; i2 < ref.length; i2++){
            if (aCompare[i] == ref[i2]){
                return true
            }
        }
    }
    return false

}
function update(discord_id, statut){

    con.query('UPDATE `vip_table` SET `premium`=' + statut + ' WHERE `discord_id` =' + discord_id)
}
function updateAdmin(discord_id, identifier){

    con.query('UPDATE `vip_table` SET `identifier`="' + identifier + '" WHERE `discord_id` ="' + discord_id + '"')
}
function create(discord_id, identifier){
    con.query('INSERT INTO `vip_table`(`discord_id`,`identifier`, `premium`) VALUES ("' + discord_id + '","' + identifier + '",1)');
}
function writeFile(filePath, data){

    var fs = require('fs');
    
    fs.writeFile(filePath,data, 'ascii',
        function(err) { 
            if (err) throw err;
            console.info("Donateur mis à jour")
    });
}
