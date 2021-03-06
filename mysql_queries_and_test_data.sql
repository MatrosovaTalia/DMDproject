-- This is the MySQL file that contains queries and a test data to check
-- the correctness.
SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone="+00:00";

CREATE TABLE users (
    user_id int(11) NOT NULL,
    `type` varchar(32),
    name varchar(32),
    surname varchar(32),
    age int(11),
    gender varchar(16),
    PRIMARY KEY (user_id)
) ENGINE=MyISAM;

CREATE TABLE administrators (
    user_id int(11) NOT NULL,
    access_level varchar(32),
    PRIMARY KEY (user_id),
    FOREIGN KEY (user_id) REFERENCES employees (user_id)
) ENGINE=MyISAM;

CREATE TABLE appointments (
    id int(11) NOT NULL,
    patient_id int(11),
    doctor_id int(11),
    ap_datetime timestamp NOT NULL,
    PRIMARY KEY (id)
) ENGINE=MyISAM;

CREATE TABLE doctors (
    specialization varchar(32),
    user_id int(11) NOT NULL,
    PRIMARY KEY (user_id),
    FOREIGN KEY (user_id) REFERENCES employees (user_id)
) ENGINE=MyISAM;

CREATE TABLE employees (
    user_id int(11) NOT NULL,
    salary int(11),
    PRIMARY KEY (user_id),
    FOREIGN KEY (user_id) REFERENCES users (user_id)
) ENGINE=MyISAM;

CREATE TABLE med_histories (
    patient_id int(11) NOT NULL,
    med_info varchar(100),
    PRIMARY KEY (patient_id),
    FOREIGN KEY (patient_id) REFERENCES patients (user_id)
) ENGINE=MyISAM;

CREATE TABLE med_reports (
    medr_id int(11) NOT NULL,
    doctor_id int(11) NOT NULL,
    content text, 
    PRIMARY KEY (medr_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors (user_id)
) ENGINE=MyISAM;

CREATE TABLE messages (
    id int(11) NOT NULL,
    user1_id int(11) NOT NULL,
    user2_id int(11) NOT NULL,
    message varchar(200),
    PRIMARY KEY (id),
    FOREIGN KEY (user1_id) REFERENCES users (user_id),
    FOREIGN KEY (user2_id) REFERENCES users (user_id)
) ENGINE=MyISAM;

CREATE TABLE notifications (
    id int(11) NOT NULL,
    user_id int(11),
    content varchar(100),
    PRIMARY KEY (id),
    FOREIGN KEY (user_id) REFERENCES users (user_id)
) ENGINE=MyISAM;

CREATE TABLE orders (
    id int(11) NOT NULL,
    supplier_id int(11) NOT NULL,
    employee_id int(11) NOT NULL,
    price int(11),
    PRIMARY KEY (id),
    FOREIGN KEY (employee_id) REFERENCES employees (user_id),
    FOREIGN KEY (supplier_id) REFERENCES suppliers (id)
) ENGINE=MyISAM;

CREATE TABLE patients (
    user_id int(11) NOT NULL,
    PRIMARY KEY (user_id),
    FOREIGN KEY (user_id) REFERENCES users (user_id)
) ENGINE=MyISAM;

CREATE TABLE payment_services (
    id int(11) NOT NULL,
    ps_name varchar(30),
    PRIMARY KEY (id)
) ENGINE=MyISAM;

CREATE TABLE questions (
    id int(11) NOT NULL,
    user_id int(11) NOT NULL,
    question varchar(200) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (user_id) REFERENCES users (user_id)
) ENGINE=MyISAM;

CREATE TABLE suppliers (
    id int(11) NOT NULL,
    product varchar(50),
    PRIMARY KEY (id)
) ENGINE=MyISAM;

CREATE TABLE transactions (
    id int(11) NOT NULL,
    user_id int(11) NOT NULL,
    p_service_id int(11) NOT NULL,
    amount int(11) NOT NULL,
    `type` varchar(50),
    PRIMARY KEY (id),
    FOREIGN KEY (user_id) REFERENCES users (user_id),
    FOREIGN KEY (p_service_id) REFERENCES payment_services (id)
) ENGINE=MyISAM;



INSERT INTO users (user_id, name, surname, type, age, gender)
VALUES (0, 'Doctor', 'Givago', 'doctor', 46, 'F');
INSERT INTO users (user_id, name, surname, type, age, gender)
VALUES (001, 'Alexander', 'Mikhailov', 'doctor', 24, 'M');
INSERT INTO users (user_id, name, surname, type, age, gender)
VALUES (002, 'Ruphina', 'Matrosova', 'doctor', 22, 'F');
INSERT INTO users (user_id, name, surname, type, age, gender)
VALUES (003, 'Helen', 'Sirgalina', 'doctor', 46, 'F');
INSERT INTO users (user_id, name, surname, type, age, gender)
VALUES (004, 'Mary', 'Sirgalina', 'doctor', 47, 'F');
INSERT INTO users (user_id, name, surname, type, age, gender)
VALUES (005, 'Mikhail', 'Mikhailov', 'doctor', 24, 'M');

INSERT INTO users (user_id, name, surname, type, age, gender)
VALUES (101, 'Ruphina', 'Matrosova', 'admin', 38, 'F');
INSERT INTO users (user_id, name, surname, type, age, gender)
VALUES (102, 'Helen', 'Sirgalina', 'admin', 27, 'F');
INSERT INTO users (user_id, name, surname, type, age, gender)
VALUES (103, 'Artyom', 'Sirgalina', 'admin', 53, 'M');

INSERT INTO users (user_id, name, surname, type, age, gender)
VALUES (201, 'Artyom', 'Ivanov', 'patient', 51, 'M');
INSERT INTO users (user_id, name, surname, type, age, gender)
VALUES (203, 'Aleksey', 'Mikhailov', 'patient', 15, 'M');
INSERT INTO users (user_id, name, surname, type, age, gender)
VALUES (204, 'Mary', 'Yuloskov', 'patient', 13, 'F');
INSERT INTO users (user_id, name, surname, type, age, gender)
VALUES (205, 'Mary', 'Ivanova', 'patient', 51, 'F'); #  check this guy for query 1
INSERT INTO users (user_id, name, surname, type, age, gender)
VALUES (202, 'Aleksey', 'Ivanov', 'patient', 53, 'M');
INSERT INTO users (user_id, name, surname, type, age, gender)
VALUES (206, 'John', 'Ivanov', 'patient', 34, 'M');


INSERT INTO users (user_id, name, surname, type, age, gender) VALUES (6, 'Ruphina', 'Sirgalina', 'patient', 54, 'M');
INSERT INTO users (user_id, name, surname, type, age, gender) VALUES (7, 'Artyom', 'Molodets', 'patient', 28, 'F');
INSERT INTO users (user_id, name, surname, type, age, gender) VALUES (8, 'Alexander', 'Molodets', 'patient', 61, 'M');
INSERT INTO users (user_id, name, surname, type, age, gender) VALUES (9, 'Artyom', 'Matrosova', 'patient', 46, 'F');
INSERT INTO users (user_id, name, surname, type, age, gender) VALUES (10, 'Alexander', 'Sergeev', 'patient', 34, 'M');
INSERT INTO users (user_id, name, surname, type, age, gender) VALUES (11, 'Artyom', 'Molodets', 'patient', 12, 'M');

INSERT INTO employees (user_id, salary)
VALUES (101, 21845);
INSERT INTO employees (user_id, salary)
VALUES (102, 25293);
INSERT INTO employees (user_id, salary)
VALUES (103, 41347);
INSERT INTO employees (user_id, salary)
VALUES (0, 21566);
INSERT INTO employees (user_id, salary)
VALUES (001, 24156);
INSERT INTO employees (user_id, salary)
VALUES (002, 45059);
INSERT INTO employees (user_id, salary)
VALUES (003, 32021);
INSERT INTO employees (user_id, salary)
VALUES (004, 35814);

INSERT INTO doctors (user_id, specialization)
VALUES (0, 'Anesthesiology');
INSERT INTO doctors (user_id, specialization)
VALUES (001, 'Emergency');
INSERT INTO doctors (user_id, specialization)
VALUES (002, 'Family');
INSERT INTO doctors (user_id, specialization)
VALUES (003, 'Emergency');
INSERT INTO doctors (user_id, specialization)
VALUES (004, 'Emergency');

INSERT INTO administrators (user_id, access_level)
VALUES (101, 2);
INSERT INTO administrators (user_id, access_level)
VALUES (102, 3);
INSERT INTO administrators (user_id, access_level)
VALUES (103, 1);

INSERT INTO patients (user_id)
VALUES (201);
INSERT INTO patients (user_id)
VALUES (202);
INSERT INTO patients (user_id)
VALUES (203);
INSERT INTO patients (user_id)
VALUES (205);
INSERT INTO patients (user_id)
VALUES (204);
INSERT INTO patients (user_id)
VALUES (206);
INSERT INTO patients (user_id) VALUES (6);
INSERT INTO patients (user_id) VALUES (7);
INSERT INTO patients (user_id) VALUES (8);
INSERT INTO patients (user_id) VALUES (9);
INSERT INTO patients (user_id) VALUES (10);
INSERT INTO patients (user_id) VALUES (11);

INSERT INTO med_histories (patient_id, med_info)
VALUES (201, 'Picture create operation throughout together even ');
INSERT INTO med_histories (patient_id, med_info)
VALUES (202, 'Hot final city art hospital kind although. Purpose');
INSERT INTO med_histories (patient_id, med_info)
VALUES (203, 'Art beautiful world toward. Dog always power coach');
INSERT INTO med_histories (patient_id, med_info)
VALUES (205, 'Artist dream direction theory. Consider almost set');
INSERT INTO med_histories (patient_id, med_info)
VALUES (204, 'Will wrong son maybe. Play large after blood incre');
INSERT INTO med_histories (patient_id, med_info)
VALUES (206, 'Special media feel most professional set debate. T');

INSERT INTO employees (user_id, salary)
VALUES (005, 21845);
INSERT INTO doctors (user_id, specialization)
VALUES (005, 'Emergency');

INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime)
VALUES (500, 205, 002, '2019-11-12 13:58:47');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime)
VALUES (501, 205, 004, '2019-11-12 14:58:47');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime)
VALUES (502, 205, 005, '2019-11-12 15:58:47');

INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime)
VALUES (503, 205, 002, '2019-11-04 13:58:47');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime)
VALUES (504, 205, 004, '2019-11-10 14:58:47');

INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime)
VALUES (514, 203, 002, '2019-11-05 13:58:47');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime)
VALUES (515, 203, 004, '2019-11-06 14:58:47');

INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime)
VALUES (505, 205, 005, '2019-10-30 15:58:47');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime)
VALUES (506, 205, 002, '2019-10-29 13:58:47');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime)
VALUES (518, 203, 002, '2019-10-29 13:58:47');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime)
VALUES (519, 203, 002, '2019-10-29 13:58:47');

INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime)
VALUES (507, 205, 004, '2019-10-22 14:58:47');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime)
VALUES (508, 205, 005, '2019-10-23 15:58:47');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime)
VALUES (516, 203, 005, '2019-10-23 15:58:47');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime)
VALUES (517, 203, 005, '2019-10-23 15:58:47');

INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime)
VALUES (509, 201, 002, '2019-11-12 13:58:47');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime)
VALUES (510, 202, 004, '2019-11-13 14:58:47');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime)
VALUES (511, 203, 005, '2019-11-14 15:58:47');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime)
VALUES (512, 204, 005, '2019-11-14 15:58:47');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime)
VALUES (513, 203, 005, '2019-11-14 15:58:47');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime)
VALUES (520, 201, 002, '2019-11-12 19:58:47');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime)
VALUES (521, 201, 003, '2019-11-13 19:58:47');


INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (43, 6, 0, '2008-06-27 01:42:39');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (44, 11, 0, '2008-04-19 05:11:52');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (45, 8, 0, '2008-07-27 15:43:25');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (46, 8, 0, '2008-02-06 10:56:13');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (47, 9, 0, '2008-10-07 09:20:09');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (48, 9, 0, '2008-02-20 22:17:10');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (49, 6, 0, '2008-05-05 09:19:34');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (50, 8, 0, '2008-09-09 02:54:29');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (51, 11, 0, '2008-07-22 15:24:30');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (52, 11, 0, '2008-07-29 05:14:38');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (53, 11, 0, '2008-04-12 04:03:46');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (54, 7, 0, '2008-10-20 17:36:46');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (55, 10, 0, '2009-01-28 04:45:51');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (56, 7, 0, '2009-10-27 17:04:58');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (57, 8, 0, '2009-08-17 17:48:23');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (58, 7, 0, '2009-01-13 20:04:58');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (59, 8, 0, '2009-02-22 13:20:14');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (60, 9, 0, '2009-08-31 03:24:25');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (61, 11, 0, '2009-04-22 15:58:52');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (62, 7, 0, '2009-10-10 16:22:20');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (63, 11, 0, '2009-07-26 16:52:12');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (64, 10, 0, '2009-10-19 17:37:12');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (65, 6, 0, '2009-06-13 13:39:29');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (66, 8, 0, '2009-12-16 15:53:07');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (67, 10, 0, '2010-11-26 12:39:01');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (68, 9, 0, '2010-10-07 11:04:44');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (69, 9, 0, '2010-02-08 08:29:25');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (70, 9, 0, '2010-03-06 07:35:53');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (71, 7, 0, '2010-05-24 01:00:06');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (72, 6, 0, '2010-09-25 03:31:11');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (73, 11, 0, '2010-09-02 08:46:02');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (74, 6, 0, '2010-07-31 21:33:17');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (75, 8, 0, '2010-03-03 03:40:14');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (76, 7, 0, '2010-06-18 03:28:03');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (77, 9, 0, '2010-10-01 10:01:07');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (78, 8, 0, '2010-03-01 02:48:31');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (79, 9, 0, '2011-05-05 07:08:06');

INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (80, 7, 0, '2011-07-10 19:34:24');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (81, 8, 0, '2011-12-09 04:56:43');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (82, 7, 0, '2011-04-28 04:35:08');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (83, 8, 0, '2011-07-10 15:37:30');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (84, 8, 0, '2011-05-08 21:35:45');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (85, 10, 0, '2011-01-16 13:43:06');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (86, 9, 0, '2011-06-18 15:57:09');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (87, 9, 0, '2011-03-20 17:36:42');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (88, 10, 0, '2011-02-27 07:33:44');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (89, 11, 0, '2011-09-10 05:01:21');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (90, 7, 0, '2011-10-15 13:20:51');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (91, 6, 0, '2012-09-21 06:06:28');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (92, 9, 0, '2012-10-13 05:11:10');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (93, 9, 0, '2012-09-17 10:23:31');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (94, 9, 0, '2012-01-07 17:07:09');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (95, 7, 0, '2012-01-28 03:45:59');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (96, 9, 0, '2012-09-04 21:12:41');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (97, 11, 0, '2012-01-07 05:13:31');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (98, 8, 0, '2012-03-09 00:16:49');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (99, 10, 0, '2012-01-11 22:52:11');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (100, 8, 0, '2012-08-18 08:21:05');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (101, 6, 0, '2012-05-18 02:55:49');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (102, 6, 0, '2012-02-28 03:42:10');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (103, 7, 0, '2013-01-08 21:57:02');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (104, 7, 0, '2013-06-01 13:33:54');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (105, 9, 0, '2013-09-11 03:58:31');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (106, 9, 0, '2013-03-31 14:06:46');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (107, 7, 0, '2013-11-14 11:33:08');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (108, 6, 0, '2013-02-12 02:50:13');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (109, 10, 0, '2013-07-14 15:23:45');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (110, 8, 0, '2013-11-10 10:29:45');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (111, 7, 0, '2013-10-22 07:40:19');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (112, 6, 0, '2013-07-05 18:14:27');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (113, 7, 0, '2013-06-09 17:08:13');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (114, 6, 0, '2013-02-12 12:34:44');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (115, 8, 0, '2014-01-06 06:50:20');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (116, 11, 0, '2014-11-14 22:35:53');

INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (117, 10, 0, '2014-09-12 13:15:22');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (118, 11, 0, '2014-04-06 02:49:04');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (119, 7, 0, '2014-11-28 11:23:24');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (120, 7, 0, '2014-07-22 21:33:42');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (121, 9, 0, '2014-05-15 09:46:23');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (122, 7, 0, '2014-01-24 20:17:56');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (123, 10, 0, '2014-07-23 01:28:04');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (124, 8, 0, '2014-10-02 00:11:55');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (125, 10, 0, '2014-10-10 12:40:14');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (126, 7, 0, '2014-03-20 05:01:31');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (127, 11, 0, '2015-08-25 08:05:33');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (128, 7, 0, '2015-02-18 23:17:43');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (129, 11, 0, '2015-12-19 03:53:27');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (130, 6, 0, '2015-07-25 13:13:38');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (131, 7, 0, '2015-01-12 13:59:39');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (132, 6, 0, '2015-06-18 08:32:20');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (133, 9, 0, '2015-06-02 21:18:50');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (134, 11, 0, '2015-12-12 12:21:28');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (135, 6, 0, '2015-08-19 01:39:13');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (136, 11, 0, '2015-12-18 10:23:35');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (137, 6, 0, '2015-06-10 07:28:38');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (138, 8, 0, '2015-12-04 18:55:06');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (139, 9, 0, '2016-11-22 17:29:36');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (140, 6, 0, '2016-04-13 08:32:41');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (141, 11, 0, '2016-02-08 05:45:01');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (142, 7, 0, '2016-05-17 23:41:24');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (143, 6, 0, '2016-10-20 06:56:45');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (144, 7, 0, '2016-01-18 02:19:15');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (145, 7, 0, '2016-12-22 14:21:43');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (146, 11, 0, '2016-12-19 16:58:00');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (147, 7, 0, '2016-01-05 06:32:53');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (148, 11, 0, '2016-10-04 22:15:06');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (149, 9, 0, '2016-10-13 17:37:27');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (150, 9, 0, '2016-05-02 14:59:48');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (151, 8, 0, '2017-03-22 06:05:47');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (152, 10, 0, '2017-11-01 01:55:31');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (153, 7, 0, '2017-07-24 03:56:27');

INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (154, 10, 0, '2017-05-17 15:36:32');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (155, 10, 0, '2017-02-13 01:50:27');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (156, 9, 0, '2017-11-03 03:03:48');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (157, 9, 0, '2017-06-08 12:24:34');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (158, 8, 0, '2017-11-20 08:57:57');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (159, 7, 0, '2017-04-24 08:13:11');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (160, 9, 0, '2017-08-28 13:50:26');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (161, 11, 0, '2017-08-21 18:50:15');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (162, 9, 0, '2017-08-09 05:50:09');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (163, 8, 0, '2018-03-25 21:52:50');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (164, 10, 0, '2018-07-21 19:36:27');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (165, 10, 0, '2018-02-01 10:29:35');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (166, 11, 0, '2018-05-14 13:10:50');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (167, 10, 0, '2018-02-09 10:47:43');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (168, 9, 0, '2018-05-21 00:04:59');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (169, 11, 0, '2018-07-26 15:43:06');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (170, 11, 0, '2018-02-21 20:50:20');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (171, 11, 0, '2018-07-28 09:51:05');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (172, 10, 0, '2018-03-03 21:54:39');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (173, 7, 0, '2018-06-17 06:29:59');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (174, 8, 0, '2018-04-22 06:32:22');

INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (175, 11, 0, '2019-02-21 20:50:20');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (176, 11, 0, '2019-07-28 09:51:05');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (177, 10, 0, '2019-03-03 21:54:39');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (178, 7, 0, '2019-06-17 06:29:59');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (179, 8, 0, '2019-04-22 06:32:22');


# doctror 001 have 5 appointments per year but less than 100 per 10 years
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (180, 11, 1, '2019-02-21 20:50:20');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (181, 11, 1, '2019-07-28 09:51:05');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (182, 10, 1, '2019-03-03 21:54:39');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (183, 7, 1, '2019-06-17 06:29:59');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (184, 8, 1, '2019-04-22 06:32:22');

INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (185, 11, 1, '2018-02-21 20:50:20');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (186, 11, 1, '2018-07-28 09:51:05');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (187, 10, 1, '2018-03-03 21:54:39');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (188, 7, 1, '2018-06-17 06:29:59');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (189, 8, 1, '2018-04-22 06:32:22');

INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (190, 11, 1, '2017-02-21 20:50:20');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (191, 11, 1, '2017-07-28 09:51:05');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (192, 10, 1, '2017-03-03 21:54:39');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (193, 7, 1, '2017-06-17 06:29:59');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (194, 8, 1, '2017-04-22 06:32:22');

INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (195, 11, 1, '2016-02-21 20:50:20');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (196, 11, 1, '2016-07-28 09:51:05');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (197, 10, 1, '2016-03-03 21:54:39');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (198, 7, 1, '2016-06-17 06:29:59');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (199, 8, 1, '2016-04-22 06:32:22');

INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (200, 11, 1, '2015-02-21 20:50:20');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (201, 11, 1, '2015-07-28 09:51:05');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (202, 10, 1, '2015-03-03 21:54:39');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (203, 7, 1, '2015-06-17 06:29:59');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (204, 8, 1, '2015-04-22 06:32:22');

INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (205, 11, 1, '2014-02-21 20:50:20');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (206, 11, 1, '2014-07-28 09:51:05');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (207, 10, 1, '2014-03-03 21:54:39');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (208, 7, 1, '2014-06-17 06:29:59');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (209, 8, 1, '2014-04-22 06:32:22');

INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (210, 11, 1, '2013-02-21 20:50:20');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (211, 11, 1, '2013-07-28 09:51:05');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (212, 10, 1, '2013-03-03 21:54:39');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (213, 7, 1, '2013-06-17 06:29:59');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (214, 8, 1, '2013-04-22 06:32:22');

INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (215, 11, 1, '2012-02-21 20:50:20');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (216, 11, 1, '2012-07-28 09:51:05');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (217, 10, 1, '2012-03-03 21:54:39');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (218, 7, 1, '2012-06-17 06:29:59');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (219, 8, 1, '2012-04-22 06:32:22');

INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (220, 11, 1, '2011-02-21 20:50:20');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (221, 11, 1, '2011-07-28 09:51:05');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (222, 10, 1, '2011-03-03 21:54:39');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (223, 7, 1, '2011-06-17 06:29:59');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (224, 8, 1, '2011-04-22 06:32:22');

INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (225, 11, 1, '2010-02-21 20:50:20');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (226, 11, 1, '2010-07-28 09:51:05');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (227, 10, 1, '2010-03-03 21:54:39');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (228, 7, 1, '2010-06-17 06:29:59');
INSERT INTO appointments (id, patient_id, doctor_id, ap_datetime) VALUES (229, 8, 1, '2010-04-22 06:32:22');


# -------------------------------------------------------------------------------

# TASK description:
# A patient claims that she forgot her bag in the room where she had a medical
# appointment on the last time she came to the hospital. The problem is that she had
# several appointments on that same day. She believes that the doctor’s name (first or last
# name, but not both) starts with “M” or “L” - she doesn’t have a good memory either. Find
# all the possible doctors that match the description.

# given the patient id and date return doctors' names
# test with specific values (patient 205, day '2019-11-12')

# QUERY 1
select name, surname
from appointments a inner join users u on a.doctor_id = u.user_id
  and patient_id = 205
  and date(ap_datetime) = (
            select
                max(date(a.ap_datetime))
            from appointments a
            where a.patient_id = 205
            )
  and (((substr(name, 1, 1) = 'L' or substr(name, 1, 1) = 'M')
    and (substr(surname, 1, 1) != 'L' and substr(surname, 1, 1) != 'M'))
    or ((substr(surname, 1, 1) = 'L' or substr(surname, 1, 1) = 'M')
        and (substr(name, 1, 1) != 'L' and substr(name, 1, 1) != 'M')));
        

# -------------------------------------------------------------------------------

# TASK DESCRIPTION:
# The hospital management team wants to get statistics on the appointments per doctors.
# For each doctor, the report should present the total and average number of
# appointments in each time slot of the week during the last year. For example, a report
# generated on 01/12/2019 should consider data since 01/12/2018.

# ASSUMPTIONS:
# there are 12 timeslots, with duration on 2 hours each
# only non-null timeslots for each doctor are shown, there are 52 weeks in a year

# QUERY 2

select  
case    
    when week_day = 0 then 'Monday'
    when week_day = 1 then 'Tuesday'
    when week_day = 2 then 'Wednesday'
    when week_day = 3 then 'Thursday'
    when week_day = 4 then 'Friday'
    when week_day = 5 then 'Saturday'
    when week_day = 6 then 'Sunday'


end as "day_of_week",
case
    when timeslot = 0 then '00:00 - 01:59'
    when timeslot = 1 then '02:00 - 03:59'
    when timeslot = 2 then '04:00 - 05:59'
    when timeslot = 3 then '06:00 - 07:59'
    when timeslot = 4 then '08:00 - 09:59'
    when timeslot = 5 then '10:00 - 11:59'
    when timeslot = 6 then '12:00 - 13:59'
    when timeslot = 7 then '14:00 - 15:59'
    when timeslot = 8 then '16:00 - 17:59'
    when timeslot = 9 then '18:00 - 19:59'
    when timeslot = 10 then '20:00 - 21:59'
    when timeslot = 11 then '22:00 - 23:59'

end as "timeslot", name, surname, total_appointments, average_appointments

from(
    select doctor_id, timeslot, week_day, count(*) as total_appointments,
           round(count(*)/ 52.0, 4) as average_appointments
    from (
        select doctor_id, floor(extract(hour from ap_datetime) div 2) as timeslot,
               weekday(ap_datetime) as week_day
        from appointments
        where date(ap_datetime) > current_date - interval 1 YEAR
        ) timeslot_doctor
    group by doctor_id, timeslot, week_day
        ) t_d inner join users u on u.user_id = t_d.doctor_id


order by week_day, timeslot;


# -------------------------------------------------------------------------------

# TASK DESCRIPTION:
# The hospital wants to retrieve information on the patients who had an appointment
# during the previous month. However, an information which is relevant for some
# managers is to find which patients visited the hospital every week, at least twice a week.
# Such patients probably should receive home visits from doctors

# ASSUMPTIONS:
# test with specific values (from 2019-11-17)
# previous month == previous 28 days starting from current date.

# QUERY 3 FOR 2019-11-17

select name, surname 
from (
    select patient_id
    from (
        select patient_id
        from (
            select patient_id, ceil(('2019-11-17' - date(ap_datetime)) / 7) as week_num
            from appointments
            where '2019-11-17' - date(ap_datetime) < 28) month_patients
        group by week_num, patient_id
        having count(*) >= 2) week_patients
    group by patient_id
    having count(*) = 4
    ) required_patients
inner join users u on required_patients.patient_id = u.user_id;


# QUERY 3 FOR CURRENT DATE
select name, surname # query3, previous month == previous 28 days starting from current date.
from (
    select patient_id
    from (
        select patient_id
        from (
            select patient_id, ceil((current_date - date(ap_datetime)) / 7) as week_num
            from appointments
            where current_date - date(ap_datetime) < 28) month_patients
        group by week_num, patient_id
        having count(*) >= 2) week_patients
    group by patient_id
    having count(*) = 4
    ) required_patients
inner join users u on required_patients.patient_id = u.user_id;


# -------------------------------------------------------------------------------

# TASK DESCRIPTION:
# Managers want to project the expected monthly income if the hospital start to charge a
# small value from each patient. The value per appointment would depend on the age and
# the number of appointments per month. The rules are summarised as follows:

# ---------------------------------------------------------------------
# |         |appointments in a month < 3 |appointments in a month >= 3|
# |Age < 50 |          200 Rub           |             250 Rub        |
# |Age >= 50|          400 Rub           |             500 Rub        |
# ---------------------------------------------------------------------

# ASSUMPTIONS:
# test with specific values (from 2019-11-17)

# QUERY 4 FOR 2019-11-17

select sum(
    case
        when age < 50 and n_visits < 3 then 200 * n_visits
        when age < 50 and n_visits >= 3 then 250 * n_visits
        when age >= 50 and n_visits < 3 then 400 * n_visits
        when age >= 50 and n_visits >= 3 then 500 * n_visits
    end
    ) as "hospital_income"
from (
    select age, count(*) as n_visits
    from (
        select age, patient_id
        from (
            select patient_id
            from appointments
            where DATEDIFF('2019-11-17', date(ap_datetime)) < 31) m_p
            #where '2019-11-17' - date(ap_datetime) < 31) m_p
        inner join users u on m_p.patient_id = u.user_id
     ) month_ap
    group by patient_id, age
    ) age_visits;


# QUERY 4 FOR CURRENT DATE
select sum(
    case
        when age < 50 and n_visits < 3 then 200 * n_visits
        when age < 50 and n_visits >= 3 then 250 * n_visits
        when age >= 50 and n_visits < 3 then 400 * n_visits
        when age >= 50 and n_visits >= 3 then 500 * n_visits
    end
    ) as "hospital_income"
from (
    select age, count(*) as n_visits
    from (
        select age, patient_id
        from (
            select patient_id
            from appointments
            where current_date - date(ap_datetime) < 31) m_p
        inner join users u on m_p.patient_id = u.user_id
     ) month_ap
    group by patient_id, age
    ) age_visits;


# ------------------------------------------------------------------------------

# TASK DESCRIPTION
# The managers want to reward experienced and long serving doctors. For that, they want
# to find out the doctors who have attended at least five patients per year for the last 10
# years. Also, such doctors should have had attended a total of at least 100 patients in this
# period.

# QUERY 5 FOR CURRENT DATE

select name, surname #  query5
from (
    select doctor_id
    from (
        select doctor_id
        from (
            select doctor_id, count(*) as num_app
            from (
                select doctor_id, datediff(current_date, date(ap_datetime)) div 365 as year_num
                from appointments
                where date(ap_datetime) > (current_date - interval 10 YEAR)
                ) app_10_years
            group by doctor_id, year_num
            having count(*) >= 5
            ) d_5_per_year
        group by doctor_id
        having count(*) = 10 and sum(num_app) >= 100
        )d_10_years
    ) requested_doctors
inner join users u on requested_doctors.doctor_id = u.user_id;