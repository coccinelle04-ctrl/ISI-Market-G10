DROP DATABASE IF EXISTS isi_market;
CREATE DATABASE isi_market CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE isi_market;

CREATE TABLE Vendeurs (
    id_vendeur INT PRIMARY KEY,
    nom VARCHAR(50),
    prenom VARCHAR(50),
    contact VARCHAR(100),
    date_ins DATE
);

CREATE TABLE categories (
    id_categorie INT PRIMARY KEY,
    libelle VARCHAR(50) NOT NULL,
    desc_categorie TEXT
);

CREATE TABLE annonces (
    id_annonce INT PRIMARY KEY AUTO_INCREMENT,
    titre VARCHAR(100) NOT NULL,
    prix INT,
    desc_annonce TEXT, 
    etat VARCHAR(50) NULL, -- NULL autorisé pour les services
    date_depot DATE,
    statut VARCHAR(50),
    id_vendeur INT,
    id_categorie INT,
    CONSTRAINT chk_statut CHECK (statut IN ('disponible', 'vendu')),
    FOREIGN KEY (id_vendeur) REFERENCES Vendeurs(id_vendeur) ON DELETE CASCADE,
    FOREIGN KEY (id_categorie) REFERENCES categories(id_categorie) ON DELETE CASCADE
);

INSERT INTO Vendeurs (id_vendeur, nom, prenom, contact, date_ins) VALUES
(1, 'Nguede', 'Rosalie', '789876543', '2026-02-20'),
(2, 'Diagne', 'Codou', '765432109', '2026-03-05'),
(3, 'Diakite', 'Mamadou', '771234567', '2026-01-15'),
(4, 'Ngom', 'Fatou', '701112233', '2026-04-12'),
(5, 'Cissé', 'Amadou', '778889900', '2026-05-01');

INSERT INTO categories (id_categorie, libelle, desc_categorie) VALUES
(1, 'Livre', 'Romans, manuels scolaires, bandes dessinées et magazines'),
(2, 'Matériel', 'Outils, équipements électroniques, informatique et objets physiques'),
(3, 'Service', 'Cours particuliers, dépannage, services à la personne et freelancing'),
(4, 'Autre', 'Tout ce qui ne rentre pas dans les catégories précédentes');

INSERT INTO annonces (id_annonce, titre, desc_annonce, prix, etat, date_depot, statut, id_vendeur, id_categorie) VALUES
-- --- LIVRE ---
(1, 'Livre Algèbre Linéaire', 'Manuel universitaire pour licence 1 et 2, très bon état.', 15000, 'Très bon état', '2026-06-01', 'disponible', 1, 1),
(2, 'Roman Le Vieux Nègre et la Médaille', 'Classique de la littérature africaine, état neuf.', 4500, 'Neuf', '2026-06-03', 'disponible', 3, 1),
(3, 'Lot de 5 BD Tintin', 'Collection vintage, quelques traces d usure sur la couverture.', 25000, 'Usagé', '2026-06-18', 'disponible', 5, 1),
(4, 'Dictionnaire Larousse 2025', 'Grand format, illustré, parfait pour les collégiens.', 18000, 'Bon état', '2026-06-05', 'vendu', 2, 1),

-- --- MATÉRIEL ---
(5, 'PC Portable Lenovo ThinkPad', 'Core i5, 8GB RAM, 256GB SSD. Parfait pour la bureautique.', 185000, 'Très bon état', '2026-06-06', 'disponible', 4, 2),
(6, 'Appareil Photo Canon EOS 4000D', 'Vendu avec objectif 18-55mm et sacoche de transport.', 220000, 'Neuf', '2026-06-15', 'disponible', 2, 2),
(7, 'Perceuse à percussion sans fil', 'Marque Makita, livrée avec deux batteries 18V et son coffret.', 75000, 'Bon état', '2026-05-20', 'vendu', 3, 2),
(8, 'Imprimante HP DeskJet 2710', 'Imprimante multifonction Wifi (Scanner et Copie).', 30000, 'Bon état', '2026-06-10', 'disponible', 1, 2),

-- --- SERVICE ---
(9, 'Cours de Mathématiques à domicile', 'Professeur expérimenté propose soutien scolaire pour lycéens. Prix par heure.', 5000, NULL, '2026-06-19', 'disponible', 5, 3),
(10, 'Maintenance Climatisation split', 'Technicien qualifié pour pose, recharge de gaz et nettoyage de split.', 25000, NULL, '2026-06-02', 'disponible', 4, 3),
(11, 'Création de site web WordPress', 'Développeur freelance réalise votre site vitrine ou e-commerce sur mesure.', 150000, NULL, '2026-05-15', 'vendu', 1, 3),
(12, 'Lavage auto professionnel à domicile', 'Nettoyage complet intérieur et extérieur de votre véhicule.', 7000, NULL, '2026-06-14', 'disponible', 3, 3),

-- --- AUTRE ---
(13, 'Chien Berger Allemand 3 mois', 'Chiot sevré et vacciné, cherche une famille accueillante.', 120000, 'Neuf', '2026-06-08', 'disponible', 2, 4),
(14, 'Canapé convertible de salon', 'Canapé 3 places transformable en lit, couleur bleu nuit.', 140000, 'Très bon état', '2026-06-12', 'disponible', 4, 4),
(15, 'Plante de salon Monstera Deliciosa', 'Belle plante verte d intérieur en pot, hauteur 1m20.', 15000, 'Très bon état', '2026-06-17', 'vendu', 5, 4);

SELECT id_annonce, titre, prix, statut 
FROM annonces 
WHERE id_categorie = 2 AND titre LIKE '%Portable%';

SELECT a.id_annonce AS annonce_id, 
       a.titre, 
       a.prix, 
       v.prenom AS prenom_vendeur, 
       v.nom AS nom_vendeur
FROM annonces a
INNER JOIN Vendeurs v ON a.id_vendeur = v.id_vendeur;

SELECT c.libelle AS categorie, 
       COUNT(a.id_annonce) AS nombre_annonces, 
       AVG(a.prix) AS prix_moyen
FROM categories c
LEFT JOIN annonces a ON c.id_categorie = a.id_categorie
GROUP BY c.id_categorie, c.libelle;

SELECT titre, prix, date_depot, statut 
FROM annonces 
ORDER BY date_depot DESC, prix ASC;


