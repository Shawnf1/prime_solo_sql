-- 1. Which authors are represented in our store?
SELECT * FROM authors;

-- 2. Which authors are also distinguished authors?
SELECT * FROM distinguished_authors;

-- 3. Which authors are not distinguished authors?
SELECT * FROM authors AS a LEFT JOIN distinguished_authors AS da ON a.id = da.id WHERE da.id IS NULL;

-- 4. How many authors are represented in our store?
SELECT COUNT(*) FROM authors;

-- 5. Who are the favorite authors of the employee with the first name of Michael?
SELECT * FROM authors AS a
WHERE CONCAT(a.first_name, ' ', a.last_name) IN
(SELECT unnest(fa.authors_and_titles[1:3][1])
FROM favorite_authors AS fa
JOIN employees AS e ON fa.employee_id = e.id
WHERE e.first_name = 'Michael');

-- 6. What are the titles of all the books that are in stock today?
SELECT isbn_to_title(s.isbn) AS title FROM stock AS s GROUP BY title ORDER BY title;

-- 7. Insert one of your favorite books into the database.
--    Hint: You’ll want to create data in at least 2 other tables to completely create this book.
WITH auth AS (
	INSERT INTO authors(id, last_name, first_name) VALUES (30000, 'Weber', 'David')
	RETURNING id
), book AS (
	INSERT INTO books(id, title, author_id, subject_id)
	SELECT 45000, 'Off Armageddon Reef', id, 15 FROM auth
	RETURNING id
), pub AS (
	INSERT INTO publishers(id, name, address) VALUES(1, 'Tor Books', 'Tor Books 175 Fifth Avenue New York, NY 10010')
	RETURNING id
)
INSERT INTO editions (isbn, book_id, edition, publisher_id, publication, type)
SELECT 0765353970, book.id, 1, pub.id, '2008-01-02', 'p' FROM book, pub;

-- 8. What authors have books that are not in stock?
SELECT a.last_name, a.first_name
FROM authors AS a
JOIN books as b ON a.id = b.author_id
JOIN editions AS e ON b.id = e.book_id
FULL JOIN stock AS s ON e.isbn = s.isbn
WHERE s.stock IS NULL OR s.stock = 0
GROUP BY a.id
ORDER BY a.last_name ASC, a.first_name ASC;

-- 9. What is the title of the book that has the most stock?
SELECT b.title
FROM authors AS a
JOIN books as b ON a.id = b.author_id
JOIN editions AS e ON b.id = e.book_id
JOIN stock AS s ON e.isbn = s.isbn
ORDER BY stock DESC
LIMIT 1;