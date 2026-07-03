-- ========================================================
-- JOIN
-- ========================================================
-- JOIN / INNER JOIN	: hanya mengambil data yang memiliki pasangan yang cocok di semua tabel
-- LEFT JOIN			: mengutamakan semua (jika pakai *) data tabel pertama (setelah FROM) dan data kanan yang cocok
-- RIGHT JOIN			: mengutamakan semua (jika pakai *) data tabel kedua (setelah JOIN) dan data kiri yang cocok
-- SELF JOIN			: menggabungkan tabel dengan dirinya sendiri (wajib pakai AS yang berbeda)
-- ON					: penghubung antar tabel
-- ========================================================
USE parks_and_recreation;

SELECT *
FROM employee_demographics;

SELECT *
FROM employee_salary;

SELECT *
FROM employee_demographics
INNER JOIN employee_salary
	ON employee_demographics.employee_id = employee_salary.employee_id   -- pakai tab biar lebih mudah dibaca
;
-- query di atas terlalu panjang, jadi employee_demographics dan salary bisa disingkat pakai AS, contoh:

SELECT *
FROM employee_demographics AS dem
INNER JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id  
;

-- kalau SELECT * seperti di atas kemungkinan banyak kolom double, jadi bisa langsung dipilih kolom mana yang mau ditampilkan, contoh:

SELECT dem.employee_id, age, occupation
FROM employee_demographics AS dem
INNER JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id  
;

SELECT *
FROM employee_demographics AS dem
RIGHT JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id  
;

SELECT *
FROM employee_demographics AS dem
LEFT JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id  
;

SELECT *
FROM employee_salary emp1
JOIN employee_salary emp2
	ON emp1.employee_id + 1 = emp2.employee_id
;

SELECT emp1.employee_id AS emp_santa,
emp1.first_name AS first_name_santa,
emp1.last_name AS last_name_santa,
emp2.employee_id AS emp_santa,
emp2.first_name AS first_name_santa,
emp2.last_name AS last_name_santa
FROM employee_salary emp1
JOIN employee_salary emp2
	ON emp1.employee_id + 1 = emp2.employee_id
;

-- Joining multiple tables together

SELECT *
FROM employee_demographics AS dem		-- walaupun employee demographic tidak punya dept.id, hanya employee salary yang punya tapi karena sama sama punya employee id jadi mereka bisa saling menghubungkan 
RIGHT JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
INNER JOIN parks_departments AS pd
	ON sal.dept_id = pd.department_id
;

SELECT *
FROM parks_departments
;


-- ========================================================
-- UNIONS 
-- ========================================================
-- UNION		: menggabungkan data ke bawah dengan jumlah kolom yang sama dan menghapus duplikat (misal kolom penjualan tahun 2025 dan 2026)
-- UNION ALL	: sama seperti union, bedanya memasukkan semua data
-- ========================================================

SELECT first_name, last_name
FROM employee_demographics
UNION
SELECT first_name, last_name
FROM employee_salary
;

SELECT first_name, last_name
FROM employee_demographics
UNION ALL
SELECT first_name, last_name
FROM employee_salary
;

SELECT first_name, last_name, 'Old Man' AS Label
FROM employee_demographics
WHERE age > 40 AND gender = 'Male'
UNION
SELECT first_name, last_name, 'Old Lady' AS Label
FROM employee_demographics
WHERE age > 40 AND gender = 'Female'
UNION
SELECT first_name, last_name, 'Highly Paid Employee' AS Label
FROM employee_salary
WHERE salary > 70000
ORDER BY first_name, last_name
;

-- ========================================================
-- STRING FUNCTIONS : digunakan untuk memanipulasi, mengubah, membersihkan, atau memotong teks
-- ========================================================
-- TRIM		: membersihkan spasi berlebih
-- UPPER	: menjadikan semua huruf menjadi huruf kapital
-- LOWER	: menjadikan semua huruf menjadi huruf kecil
-- LENGHT	: menghitung berapa jumlah karakter dalam suatu teks
-- LEFT		: mengambil beberapa huruf dari posisi paling kiri
-- RIGHT	: mengambil beberapa huruf dari posisi paling kanan
-- SUBSTRING: mengambil huruf sesuai posisi yang diinginkan
-- REPLACE	:
-- LOCATE	:
-- ========================================================
SELECT LENGTH('skyfall');

SELECT first_name, LENGTH(first_name)
FROM employee_demographics
ORDER BY 2;		-- tidak disarankan ketik urutan kolom begini sebaiknya langsung sebut nama kolom

SELECT UPPER('sky');

SELECT LOWER('SKY');

SELECT first_name, UPPER(first_name)
FROM employee_demographics;

SELECT TRIM('			sky			');

SELECT LTRIM('			sky			');		-- left trim hanya membersihkan spasi di bagian kiri

SELECT RTRIM('     123sky88    ');		-- right trim hanya membersihkan spasi di bagian kanan

SELECT first_name, 
LEFT(first_name, 4),
RIGHT(first_name, 4),
SUBSTRING(first_name,3,2),
birth_date,
SUBSTRING(birth_date,6,2) AS birth_month
FROM employee_demographics;

SELECT first_name, REPLACE(first_name, 'a', 'z')    -- case sensitive, huruf kapital/kecil berpengaruh kalau mau huruf kapitalnya diganti juga bisa tumpuk lagi di sebelahnya 
FROM employee_demographics;

SELECT first_name, REPLACE(REPLACE(first_name, 'a', 'z'), 'A', 'Z')
FROM employee_demographics;

SELECT LOCATE('x', 'Alexander');

SELECT first_name, LOCATE('An', first_name)		-- locate tidak case-sensitive
FROM employee_demographics;

SELECT first_name, last_name,
CONCAT(first_name, ' ', last_name) AS full_name
FROM employee_demographics;

-- ========================================================
-- CASE STATEMENTS
-- ========================================================
SELECT first_name,
last_name,
age,
CASE
	WHEN age <= 30 THEN 'Young'
    WHEN age BETWEEN 31 and 50 THEN 'Old'
    WHEN age >= 50 THEN "On Death's Door"
END AS Age_Bracket
FROM employee_demographics;

-- Pay Increase and Bonus
-- < 50000	= 5%
-- >= 50000 = 7%
-- Finance 	= 10%

SELECT first_name, last_name, salary,
CASE
	WHEN salary < 50000 THEN salary * 1.05
    WHEN salary >= 50000 THEN salary * 1.07
END AS New_Salary,
CASE
	WHEN dept_id = 6 THEN salary * 0.10
    ELSE 0
END AS Bonus
FROM employee_salary;


-- ========================================================
-- Subquery		: kueri di dalam kueri, bisa diletakkan di SELECT; FROM; ATAU WHERE Clause
-- ========================================================
SELECT *
FROM employee_demographics
WHERE employee_id IN 
				(SELECT employee_id			-- kalau begini hanya boleh ambil 1 kolom
					FROM employee_salary
                    WHERE dept_id = 1)
;

SELECT first_name, salary, 
(SELECT AVG(salary)
FROM employee_salary)
FROM employee_salary
;

SELECT AVG(max_age)
FROM
(SELECT gender, 
AVG(age) AS avg_age, 
MAX(age) AS max_age, 
MIN(age) AS min_age, 
COUNT(age) AS count_age
FROM employee_demographics
GROUP BY gender) AS Agg_table
;


-- ========================================================
-- Window Functions	: fungsi yang dapat melakukan perhitungan agregasi tanpa menghilangkan baris data asli (beda kalau pakai GROUP BY fungsi agregat biasanya cuma keluar hasil akhir saja)
-- OVER()			: harus ditempatkan tepat di belakang fungsi agregasi, 
-- ROW_NUMBER()		: memberikan nomor urut baris, wajib berpasangan dengan OVER() tidak bisa berdiri sendiri. 
-- RANK()			: memberikan nomor urut sesuai rank (nilai) jika terdapat nilai/rank yang sama hasil ranknya akan sama namun nomor selanjutnya akan langsung lompat, misal ada 3 baris yang hasilnya rank 3 maka angka selanjutnya akan langsung 6 
-- DENSE_RANK()		: mirip RANK() bedanya tidak ada gap nomor urut
-- ========================================================
SELECT gender, AVG(salary) AS avg_salary
FROM employee_demographics AS dem
JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender
;

SELECT gender, AVG(salary) OVER()		-- dalam kurung over ini bisa diisi misal OVER(PARTITION BY ...) fungsinya sebagai sekat per kelompok, jika hanya tanda kurung kosong berarti hitungannya global
FROM employee_demographics AS dem
JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
;

SELECT dem.first_name, dem.last_name, gender, AVG(salary) OVER(PARTITION BY gender)		
FROM employee_demographics AS dem
JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
;

SELECT dem.first_name, dem.last_name, gender, salary,
SUM(salary) OVER(PARTITION BY gender ORDER BY dem.employee_id) AS Rolling_Total
FROM employee_demographics AS dem
JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
;

SELECT dem.employee_id, dem.first_name, dem.last_name, gender, salary,
ROW_NUMBER() OVER()
FROM employee_demographics AS dem
JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
;

SELECT dem.employee_id, dem.first_name, dem.last_name, gender, salary,
ROW_NUMBER() OVER(PARTITION BY gender)		-- urutan nomornya akan reset sendiri dari 1 setiap ganti kelompok
FROM employee_demographics AS dem
JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
;

SELECT dem.employee_id, dem.first_name, dem.last_name, gender, salary,
ROW_NUMBER() OVER(ORDER BY salary DESC)
FROM employee_demographics AS dem
JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
;

SELECT dem.employee_id, dem.first_name, dem.last_name, gender, salary,
ROW_NUMBER() OVER(PARTITION BY gender ORDER BY salary DESC) AS row_num,
RANK() OVER(PARTITION BY gender ORDER BY salary DESC) AS rank_num,
DENSE_RANK() OVER(PARTITION BY gender ORDER BY salary DESC) AS dense_rank_num
FROM employee_demographics AS dem
JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
;