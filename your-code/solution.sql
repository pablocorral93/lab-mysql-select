CREATE DATABASE publications;

USE publications;

-- Challenge 1 - Who Have Published What At Where?

SELECT 
	a.au_id,
	a.au_lname,
    a.au_fname,
    t.title,
    p.pub_name
FROM 
	authors a
JOIN 
	titleauthor ta ON ta.au_id = a.au_id
JOIN 
	titles t ON t.title_id = ta.title_id
JOIN
	publishers p ON p.pub_id = t.pub_id;


-- Challenge 2 - Who Have Published How Many At Where?

SELECT 
	a.au_id,
	a.au_lname,
    a.au_fname,
    p.pub_name,
    COUNT(t.title) AS title_count
FROM 
	authors a
JOIN 
	titleauthor ta ON ta.au_id = a.au_id
JOIN 
	titles t ON t.title_id = ta.title_id
JOIN
	publishers p ON p.pub_id = t.pub_id
GROUP BY
	 a.au_id, a.au_lname, a.au_fname, p.pub_name
ORDER BY
    a.au_id;

-- Challenge 3 - Best Selling Authors

SELECT 
	a.au_id,
	a.au_lname,
    a.au_fname,
    SUM(s.qty) AS total_sales
FROM 
	authors a
JOIN 
	titleauthor ta ON ta.au_id = a.au_id
JOIN 
	titles t ON t.title_id = ta.title_id
JOIN
	sales s ON s.title_id = t.title_id
GROUP BY
	 a.au_id, a.au_lname, a.au_fname
ORDER BY
    total_sales DESC
LIMIT 3;

-- Challenge 4 - Best Selling Authors Ranking

SELECT 
    a.au_id,
    a.au_lname,
    a.au_fname,
    IFNULL(SUM(s.qty), 0) AS total_sales
FROM 
    authors a
JOIN 
    titleauthor ta ON ta.au_id = a.au_id
JOIN 
    titles t ON t.title_id = ta.title_id
LEFT JOIN
    sales s ON s.title_id = t.title_id
GROUP BY
    a.au_id, a.au_lname, a.au_fname
ORDER BY
    total_sales DESC;