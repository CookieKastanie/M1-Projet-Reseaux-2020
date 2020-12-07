# M1-Projet-Reseaux-2020

Template:
[nom_de_dossier/] 
{Rôle de ce dossier dans l’archive}

Dans notre archive, vous trouverez les éléments suivants:
[ iftun/ ] { Contient tout notre code C permettant de créer une interface tun0 }
    [ tunalloc.c et tunalloc.h ] { Code source et librarie de tunalloc }
    [ iftun.c et iftun.h ] { Code source et librarie de iftun }
    [ Makefile  ] { Permet de compiler iftun et d’envoyer directement dans /VMs/partage un executable de iftun (à l’aide de la commande “make”)}

[ VMs/ ]
    [ VM1/ à VM3-6/ ] { Répertoire des machines virtuelles du projet }
        [ Les fichiers salt (config.sls, top.sls) ] {Permet une configuration automatique des machines à leur lacement }
[ Vagrantfile ] { Permet le lancement d’une machine }
[ POUR VM1 UNIQUEMENT launch_server.sh ] { Lance l’extremité serveur du tunnel IPv6 sur IPv4 }
[ POUR VM3 UNIQUEMENT launch_client.sh ] { Lance l’extremité client du tunnel IPv6 sur IPv4 }

    [ partage/ ] { Dossier partagé par toutes les machines virtuelles }
        [ test_iftun ] { Exécutable de notre code C (création de tunnel) }
        [ client.js et server.js ] { Permettent de lancer respectivement le client et le serveur du tunnel. }
        [ config.json ] { Fichier de configuration utilisé par le client et le serveur }
        [ launch_salt.sh ] { Lance automatiquement dans le bon repertoire salt pour configurer la machine }
        [ routing.sh ] { Script qui affiche les routes IPv4 et IPv6 de la machine }

