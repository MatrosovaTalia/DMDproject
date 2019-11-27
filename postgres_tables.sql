-- This is the PostgresSQL file that contains SQL tables. You can use insert
-- generator populate_db.py to fill up these tables.

DROP TABLE if exists Users, Employees, Doctors, Appointments, Agenda, Med_Histories, Med_reports, Messages, Notifications,
    Orders, Patients, Payment_Services, Questions, Suppliers, Transactions, Users, Administrators;

create table Users
(
    user_id integer not null,
    type    varchar(32),
    name    varchar(32),
    surname varchar(32),
    age     integer,
    gender  varchar(16),
    primary key (user_id)
);

create table Employees
(
    user_id integer not null,
    salary  integer,
    primary key (user_id),
    foreign key (user_id) references Users (user_id)
);

create table Doctors
(
    specialization varchar(32),
    user_id        integer not null,
    primary key (user_id),
    foreign key (user_id) references Employees (user_id)
);

create table Administrators
(
    user_id      integer not null,
    access_level varchar(32),
    primary key (user_id),
    foreign key (user_id) references Employees (user_id)
);

create table Patients
(
    user_id integer not null,
    primary key (user_id),
    foreign key (user_id) references Users (user_id)
);

create table Appointments
(
    id          integer   not null,
    patient_id  integer references Patients (user_id),
    doctor_id   integer references Doctors (user_id),
    ap_datetime timestamp not null,
    primary key (id)
);


create table Med_Histories
(
    patient_id  integer not null,
    med_info varchar(100), -- represents medical history to achieve better treatment
    primary key (patient_id),
    foreign key (patient_id) references Patients (user_id)
);

create table Notifications
(
    id      integer not null,
    user_id integer,
    content varchar(100),
    primary key (id),
    foreign key (user_id) references Users (user_id)
);

create table Med_reports
(
    medR_id   integer not null,
    doctor_id integer not null,
    content   varchar(300),
    primary key (medR_id),
    foreign key (doctor_id) references Doctors (user_id)
);

create table Suppliers
(
    id integer not null,
    product     varchar(50),
    primary key (id)
);

create table Orders
(
    id    integer not null,
    supplier_id integer not null,
    employee_id integer not null,
    price       integer,
    primary key (id),
    foreign key (employee_id) references Employees (user_id),
    foreign key (supplier_id) references Suppliers (id)
);


create table Payment_Services
(
    id integer not null,
    ps_name      varchar(30),
    primary key (id)
);


create table Transactions
(
    id integer not null,
    user_id        integer not null,
    p_service_id   integer not null,
    amount         integer not null,
    type           varchar(50), -- income/expense for the hospital
    primary key (id),
    foreign key (user_id) references Users (user_id),
    foreign key (p_service_id) references Payment_Services (id)
);

create table Messages
(
    id integer not null,
    user1_id   integer not null,
    user2_id   integer not null,
    message    varchar(200),
    primary key (id),
    foreign key (user1_id) references Users (user_id),
    foreign key (user2_id) references Users (user_id)

);

create table Questions
(
    id integer      not null,
    user_id     integer      not null,
    question    varchar(200) not null,
    primary key (id),
    foreign key (user_id) references Users (user_id)
);
