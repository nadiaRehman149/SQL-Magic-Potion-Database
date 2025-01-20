CREATE DATABASE MedievalPotionShop;
USE MedievalPotionShop;

-- creating the tables

CREATE TABLE Alchemists (
    AlchemistID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    ExperienceLevel VARCHAR(50) NOT NULL,
    Specialty VARCHAR(50) NOT NULL
);

CREATE TABLE Ingredients (
    IngredientID INT PRIMARY KEY,
    IngredientName VARCHAR(50) NOT NULL,
    `Source` VARCHAR(100) NOT NULL,
    StockQuantity INT NOT NULL DEFAULT 0
);

CREATE TABLE Potions (
    PotionID INT PRIMARY KEY,
    PotionName VARCHAR(50) NOT NULL,
    Effects TEXT NOT NULL,
    AlchemistID INT NOT NULL,
    FOREIGN KEY (AlchemistID) REFERENCES Alchemists(AlchemistID)
);

CREATE TABLE PotionIngredients (
    PotionID INT NOT NULL,
    IngredientID INT NOT NULL,
    Quantity FLOAT NOT NULL,
    PRIMARY KEY (PotionID, IngredientID),
    FOREIGN KEY (PotionID) REFERENCES Potions(PotionID),
    FOREIGN KEY (IngredientID) REFERENCES Ingredients(IngredientID)
);

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Address TEXT NOT NULL,
    GoldCoins FLOAT NOT NULL
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT NOT NULL,
    PotionID INT NOT NULL,
    OrderDate DATE NOT NULL,
    Quantity INT NOT NULL,
    TotalPrice FLOAT NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (PotionID) REFERENCES Potions(PotionID)
);


-- Populating the tables
INSERT INTO Alchemists (AlchemistID, FirstName, ExperienceLevel, Specialty) VALUES
(1, 'Alaric', 'Master', 'Healing Potions'),
(2, 'Sabrina', 'Expert', 'Cursed Potions'),
(3, 'Oswin', 'Novice', 'Truth-telling Potions'),
(4, 'Rowena', 'Intermediate', 'Love Potions'),
(5, 'Balthazar', 'Master', 'Transmutation'),
(6, 'Ivor', 'Expert', 'Poison'),
(7, 'Theodora', 'Intermediate', 'Growth Potions'),
(8, 'Eldric', 'Novice', 'Strength Potions');

-- SELECT * FROM Alchemists;

INSERT INTO Ingredients (IngredientID, IngredientName, Source, StockQuantity) VALUES
(1, 'Dragon Scale', 'Dragon Cave', 20),
(2, 'Unicorn Hair', 'Enchanted Forest', 15),
(3, 'Nightshade', 'Dark Woods', 10),
(4, 'Phoenix Feather', 'Phoenix Nest', 8),
(5, 'Mandrake Root', 'Mystic Garden', 12),
(6, 'Hemlock', 'Shadow Marsh', 5),
(7, 'Fairy Dust', 'Fairy Grove', 18),
(8, 'Giant\'s Blood', 'Mountain Cave', 6);

-- SELECT * FROM Ingredients;

INSERT INTO Potions (PotionID, PotionName, Effects, AlchemistID) VALUES
(1, 'Elixir of Strength', 'Grants the drinker increased strength for a short time', 8),
(2, 'Healing Brew', 'Heals minor wounds and ailments', 1),
(3, 'Truth Serum', 'Forces the drinker to tell the truth', 3),
(4, 'Love Potion', 'Induces feelings of affection and attraction', 4),
(5, 'Transmutation Elixir', 'Temporarily changes the appearance of objects', 5),
(6, 'Deadly Poison', 'Causes severe harm or death', 6),
(7, 'Growth Serum', 'Accelerates the growth of plants', 7),
(8, 'Strength Serum', 'Temporarily boosts physical strength', 8);

-- SELECT * FROM Potions;

INSERT INTO PotionIngredients (PotionID, IngredientID, Quantity) VALUES
(1, 1, 2.0),
(2, 2, 1.5),
(3, 3, 0.5),
(4, 4, 1.0),
(5, 5, 1.5),
(6, 6, 2.0),
(7, 7, 1.0),
(8, 8, 1.5),
(1, 8, 0.5);

-- SELECT * FROM PotionIngredients;

INSERT INTO Customers (CustomerID, FirstName, LastName, Address, GoldCoins) VALUES
(1, 'Cedric', 'Blackwood', '123 Forest Lane', 100.0),
(2, 'Elowen', 'Thornfield', '456 River Road', 150.0),
(3, 'Gareth', 'Ironwood', '789 Mountain Pass', 75.0),
(4, 'Lysandra', 'Ravenwood', '321 Mystic Falls', 200.0),
(5, 'Rowan', 'Stormwind', '654 Thunder Bluff', 50.0),
(6, 'Thalia', 'Eversong', '987 Moonlit Glade', 120.0),
(7, 'Dorian', 'Shadowbrook', '741 Enchanted Forest', 80.0),
(8, 'Seraphina', 'Lightbringer', '852 Crystal Cove', 60.0),
(9, 'Bran', 'Stormrider', '963 Sunset Valley', 90.0);

-- SELECT * FROM Customers;

INSERT INTO Orders (OrderID, CustomerID, PotionID, OrderDate, Quantity, TotalPrice) VALUES
(1, 1, 1, '1524-06-01', 2, 50.0),
(2, 2, 2, '1524-07-02', 1, 30.0),
(3, 3, 3, '1524-08-03', 1, 20.0),
(4, 4, 4, '1524-09-04', 3, 45.0),
(5, 5, 5, '1524-10-05', 2, 40.0),
(6, 6, 6, '1524-11-06', 1, 60.0),
(7, 7, 7, '1524-12-07', 2, 70.0),
(8, 8, 8, '1525-01-08', 1, 25.0);

-- SELECT * FROM Orders;

-- Retrieve potion names and customer names for all orders
SELECT p.PotionName, c.FirstName, c.LastName
FROM Orders o
JOIN Potions p ON o.PotionID = p.PotionID
JOIN Customers c ON o.CustomerID = c.CustomerID;

-- Deleting an order first
DELETE FROM Orders WHERE CustomerID = 3;
-- SELECT * FROM Orders;

-- Deleting the customer
DELETE FROM Customers WHERE CustomerID = 3;
-- SELECT * FROM Customers;

-- Counting the total number of potions
SELECT COUNT(*) FROM Potions;

-- Calculating the average stock quantity of ingredients
SELECT AVG(StockQuantity) AS AverageStock FROM Ingredients;

-- Retrieving potion names and alchemist names
SELECT p.PotionName, a.FirstName AS AlchemistName
FROM Potions p
JOIN Alchemists a ON p.AlchemistID = a.AlchemistID;

-- Retrieving customer names and total number of orders
SELECT c.FirstName, c.LastName, COUNT(o.OrderID) AS TotalOrders
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID;

-- Converting the potion names to uppercase
SELECT UPPER(p.PotionName) FROM Potions p;

-- Concatenating the first and last names of customers
SELECT CONCAT(c.FirstName, ' ', c.LastName) AS FullName FROM Customers c;

-- Retrieving and sorting by name all the data from the Potions table
SELECT * FROM Potions p ORDER BY p.PotionName ASC;

-- Creating a stored procedure to add a new ingredient
DELIMITER //
CREATE PROCEDURE AddNewIngredient(IN name VARCHAR(100), IN source VARCHAR(100), IN stock INT)
BEGIN
    INSERT INTO Ingredients (IngredientName, Source, StockQuantity) VALUES (name, source, stock);
END //
DELIMITER ;