-- ===============================================================
-- SELECT STATEMENT
-- ===============================================================
-- USE [database_name]	: aktifkan/pilih database yang mau dipakai
-- SELECT				: ambil/tampilkan kolom data
-- * (Asterisk)			: ambil semua kolom yang ada di tabel
-- FROM [table_name]	: data tabel mana yang mau diambil
-- #PEMDAS				: urutan hitung matematika; Parentheses (), Exponents ^, Multiplication *, Division /, Addition +, Subtraction - 
-- SELECT DISTINCT		: hanya mengambil data unik (menghilangkan duplikat)
-- ;					: sebagai tanda titik/mengakhiri satu perintah query
-- []					: untuk membungkus nama tabel atau kolom yang memiliki spasi agar tidak error
-- ===============================================================
USE parks_and_recreation;

SELECT * 
FROM parks_and_recreation.employee_demographics;

SELECT first_name, 
last_name, 
birth_date,
age,
(age + 10) * 10 + 10
FROM parks_and_recreation.employee_demographics;
# PEMDAS

SELECT DISTINCT first_name, gender
FROM parks_and_recreation.employee_demographics;


-- ===============================================================
-- WHERE CLAUSE
-- ===============================================================
-- WHERE				: filter data berdasarkan kondisi tertentu
-- !=					: tidak sama dengan (bukan)
-- ===============================================================
SELECT *
FROM employee_salary
WHERE first_name = 'Leslie'
;

SELECT *
FROM employee_salary
WHERE salary <= 50000
;

SELECT *
FROM employee_demographics
WHERE gender != 'Female'
;

SELECT *
FROM employee_demographics
WHERE gender = 'Female'
;

SELECT *
FROM employee_demographics
WHERE birth_date > '1985-01-01'
;


-- ===============================================================
-- AND OR NOT -- Logical Operators
-- ===============================================================
-- AND					: menyaring data yang harus memenuhi semua kondisi
-- OR					: menyaring data yang boleh memenuhi salah satu kondisi saja
-- NOT					: menyaring data yang bukan/kecuali dari kondisi tersebut, fungsinya mirip tanda seru hanya beda penempatan
-- ===============================================================
SELECT *
FROM employee_demographics
WHERE birth_date > '1985-01-01'
AND gender = 'male'
;

SELECT *
FROM employee_demographics
WHERE birth_date > '1985-01-01'
OR gender = 'male'
;

SELECT *
FROM employee_demographics
WHERE birth_date > '1985-01-01'
OR NOT gender = 'male'
;

SELECT *
FROM employee_demographics
WHERE (first_name = 'Leslie' AND age = '44') OR age > 55
;


-- ===============================================================
-- LIKE STATEMENT 
-- ===============================================================
-- LIKE		: digunakan untuk mencari data berdasarkan kemiripan teks tertentu (mirip find)
-- %		: bebas diisi oleh huruf apa saja dan berapa saja jumlahnya
-- _		: menggantikan huruf sesuai jumlahnya
-- ===============================================================
SELECT *
FROM employee_demographics
WHERE first_name LIKE 'Jer__'
;

SELECT *
FROM employee_demographics
WHERE first_name LIKE '%a%'
;

SELECT *
FROM employee_demographics
WHERE first_name LIKE 'a___%'
;

SELECT *
FROM employee_demographics
WHERE birth_date LIKE '1989%'
;


-- ===============================================================
-- GROUP BY & ORDER BY
-- ===============================================================
-- GROUP BY		: mengelompokkan baris data yang memiliki nilai yang sama ke dalam satu kelompok, hampir selalu berpasangan dengan aggregate functions (count, avg, sum, min, max)
-- ORDER BY 	: mengurutkan data, ASC dari kecil ke besar, DESC dari besar ke kecil
-- ,			: pemisah antar kolom
-- ===============================================================
SELECT gender, AVG(age)
FROM employee_demographics
GROUP BY gender
;

SELECT occupation, salary
FROM employee_salary
GROUP BY occupation, salary
;

SELECT gender, AVG(age), MAX(age), MIN(age), COUNT(age)
FROM employee_demographics
GROUP BY gender
;

SELECT *
FROM employee_demographics
ORDER BY first_name DESC;

SELECT *
FROM employee_demographics
ORDER BY gender, age
;

-- atau bisa ini tapi tidak direkomendasikan karena bisa cause a lot a issues. ex ada perubahan urutan kolom jadi hasilnya tidak akurat
SELECT *
FROM employee_demographics
ORDER BY 5, 4
;


-- ===============================================================
-- HAVING vs WHERE
-- ===============================================================
-- WHERE		: untuk saring data mentah di awal tidak bisa pakai fungsi agregat
-- HAVING		: untuk saring data kelompok di akhir setelah group by wajib pakai fungsi agregat
-- ===============================================================
SELECT gender, AVG(age)
FROM employee_demographics
GROUP BY gender
HAVING AVG(age) > 40
;

SELECT occupation, AVG(salary)
FROM employee_salary
WHERE occupation LIKE '%manager%'
GROUP BY occupation
HAVING AVG(salary) > 75000
;


-- ===============================================================
-- LIMIT & ALIASING
-- ===============================================================
-- LIMIT	: membatasi jumlah baris data yang mau ditampilkan, terkadang limit ditulis dengan dua angka contoh; 2, 1 yang artinya (2) lewati sebanyak 2 baris dari atas (1) ambil 1 baris saja setelah lompatan itu 
-- ALIASING	: untuk mengubah nama kolom bawaan menjadi nama baru dengan kata kunci AS (namun hanya bersifat sementara, berlaku di query tersebut saja)
-- ===============================================================
SELECT *
FROM employee_demographics
ORDER BY age DESC
LIMIT 3
;

SELECT *
FROM employee_demographics
ORDER BY age DESC
LIMIT 3, 1
;

SELECT gender, AVG(age) AS avg_age -- kalau AS nya dihapus juga bisa
FROM employee_demographics
GROUP BY gender
HAVING avg_age > 40
;

