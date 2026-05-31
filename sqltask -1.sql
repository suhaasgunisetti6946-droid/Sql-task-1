CREATE DATABASE IF NOT EXISTS simple_library_db;
USE simple_library_db;

DROP TABLE IF EXISTS borrowings;
DROP TABLE IF EXISTS books;
DROP TABLE IF EXISTS members;

CREATE TABLE members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    join_date DATE NOT NULL
);

CREATE TABLE books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    author VARCHAR(100) NOT NULL,
    genre VARCHAR(50),
    price DECIMAL(5, 2) NOT NULL
);

CREATE TABLE borrowings (
    borrow_id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT NOT NULL,
    book_id INT NOT NULL,
    borrow_date DATE NOT NULL,
    return_date DATE,
    CONSTRAINT fk_borrowings_member FOREIGN KEY (member_id) REFERENCES members(member_id),
    CONSTRAINT fk_borrowings_book FOREIGN KEY (book_id) REFERENCES books(book_id)
);

INSERT INTO members (first_name, last_name, email, join_date) VALUES
('Amit', 'Sharma', 'amit.sharma@email.com', '2026-01-15'),
('Priya', 'Patel', 'priya.patel@email.com', '2026-02-20'),
('Rahul', 'Singh', 'rahul.singh@email.com', '2026-03-10');

INSERT INTO books (title, author, genre, price) VALUES
('The Alchemist', 'Paulo Coelho', 'Fiction', 12.99),
('A Brief History of Time', 'Stephen Hawking', 'Science', 18.50),
('To Kill a Mockingbird', 'Harper Lee', 'Classic', 10.99);

INSERT INTO borrowings (member_id, book_id, borrow_date, return_date) VALUES
(1, 1, '2026-05-01', '2026-05-10'),
(2, 3, '2026-05-15', NULL),
(3, 2, '2026-05-20', '2026-05-28');

SELECT * FROM members;

SELECT title, author, price FROM books
WHERE genre = 'Classic';

SELECT
    m.first_name,
    m.last_name,
    b.title,
    br.borrow_date
FROM borrowings br
INNER JOIN members m ON br.member_id = m.member_id
INNER JOIN books b ON br.book_id = b.book_id
WHERE br.return_date IS NULL;

SELECT COUNT(*) AS total_books_count FROM books;

SELECT SUM(price) AS total_library_value FROM books;
