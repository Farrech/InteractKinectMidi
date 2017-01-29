# PROJET INTUI'SON

Ce travail est le fruit du projet transpromotionnel "Intui'Son" mené à l'ENSC au premier semestre de l'année scolaire 2016/2017. Le programme est un prototype d'instrument MIDI dématérialisé contrôlable via Kinect.

Une rapide description technique est donnée ci-dessous: pour plus d'informations (guide des fonctionnalités, vidéo de démonstration,démarche, questions...) contacter l'un des auteurs.


Liste des élèves ayant participé au développement : Docteur Nina, Metge Adrien, Rouch Thierry, Sanchez Suarez Eric, Catella Solène, Lepagnot Marc, et Rosalie Rodolphe



___________

Processing est un environnement de programmation spécialisé pour les développements artistiques et créatifs. Création graphique, animation 2D, applications interactives, traitement des images et du son sont autant de possibilités qu’offre le langage et autant de raisons qui nous ont conduits à le choisir. La mobilisation de librairies d’extension telles TheMidiBus nous ont permis de pousser encore plus loin les capacités du logiciel.


La première page ProgrammePrincipal contient le programme principal : c’est là que se trouvent les méthodes setup() et draw(), permettant respectivement l’instanciation des variables/objets et l’exécution d’un algorithme au rythme de 60 boucles par seconde. C’est dans cette dernière que se trouve la partie du programme permettant à la fois l’affichage de l’interface (tracerTouche()), du squelette (drawBody() et drawHandState()), ainsi que l’interprétation des gestes de l’utilisateurs et le jeu de note via la fonction suiviMain(). On retrouve également dans la fonction mouseClicked() les instructions permettant d’activer les options cliquables (autoriser la reconfiguration ainsi que jouer des accords ou jeu « libre »).

La seconde page, Dessin, contient la fonction tracerTouche() qui permet le dessin de l’interface-utilisateur.

La troisième page, FonctionsMusique, regroupe les différentes fonctions propres aux accords ainsi qu’aux changements d’instruments.

Dans la quatrième page, GestionKinect, on retrouve les fonctions liées au dessin du « squelette » de l’utilisateur.
La cinquième page, GestionMain contient la fonction suiviMain(), permettant d’identifier les mouvements et états d’une main (passés en paramètre), et de leur associer une commande MIDI. On y retrouve également calculVitesse(), fonction permettant le calcul de la vitesse d’une main.

La sixième page, Initialisation, permet d’initialiser un tableau de notes ainsi qu’un tableau de touches, qui seront indispensables pour gérer l’activation et la désactivation des notes. 

Finalement, dans la dernière page Classes, on retrouve les classes permettant la création de différents objets : l’objet touche, qui permet d’associer une note à chacune des touches créées, mais aussi ses différentes caractéristiques (couleur, coordonnées, etc.). La classe instru permet de stocker les différents instruments disponibles. Finalement, la classe bouton permet de définir un bouton cliquable (seul le bouton définissant le mode de jeu, « jeu libre » ou « accord », a été défini ainsi, cette solution ayant été mis en place sur le tard).


___________
Pour installer Processing : https://processing.org/download/ (choisir No Donation puis Download)
Une fois les fichiers .pde (contenant le programme) téléchargés, vous pouvez les ouvrir dans Processing

Pour pouvoir lancer les programmes, trois librairies sont indispensable :
- dans la fenetre Procesing, cliquer sur Sketch => Importer une librairie => Ajouter une librairie
- dans la barre de recherche, taper kinect. Selectionner Kinect V2 for Processing, puis cliquez sur installer.
- de nouveau, chercher Midi, et installer la librairie The MidiBus
- finalement, chercher Cp5 et installer la librairie ControlCP5

Bien sûr, ce programme nécessite une Kinect V2 pour PC.

