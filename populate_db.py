"""
This module provides a possibility to generate SQL insert statements for the
tables in postgres_tables.sql. You can vary the amount of data you need to
generate in the parameters of the constructor.

"""

import copy
import datetime
from faker import Faker
from random import choice, randint


class CodeGenerator:
    def __init__(self, db_tables, num_of_doctors, num_of_admins,
                 num_of_patients,
                 num_of_medical_reports, num_of_notifications,
                 num_of_appointments, num_of_suppliers, num_of_orders,
                 num_of_payment_services, num_of_transactions,
                 num_of_messages, num_of_questions, include_special_doctor):

        self.fake = Faker()

        self.db_tables = db_tables

        self.messages = ["Hi", "Bye", "Call Dr. Jimmth", "Come to 319",
                         "Emergency case in 111", "Need nurse in 109", "Done"]
        self.surnames = ["Bekket", "Backer", "Smith", "Jonson", "Wharshall",
                         "Hamilton", "Chain"]
        self.names = ["Eugen", "Samu", "Fain", "Sasha", "Tomm", "Oman"]
        self.med_history = ["Had chickenpox when was 10",
                            "Had chickenpox when was 18",
                            "Never had chickenpox",
                            "Sick with measles",
                            "Broke left wrist at age 15",
                            "Broke rigth wrist at age 15",
                            "Sick of scarlet fever at age 6",
                            "Sick of scarlet fever at age 17",
                            "Sick of scarlet fever last year",
                            "Catches cold every winter"]

        self.specializations = ["Family", "Anesthesiology", "Emergency"]
        self.products = ["mocha", "gavno", "confety"]
        self.payment_services = ["visa", "mastercard"]
        self.last_id = 0

        # DOCTORS
        doctor_ids = self.get_ids(num_of_doctors)
        doctors_specializations = self.get_spec(num_of_doctors)
        doctors_specified_values = {"user_id": doctor_ids, "specialization":
            doctors_specializations}

        # SPECIAL DOCTOR
        special_doctor_id = doctor_ids[0]

        # PATIENTS
        patients_ids = self.get_ids(num_of_patients)
        patients_specified_values = {"user_id": patients_ids}

        # ADMINS
        admins_ids = self.get_ids(num_of_admins)
        admins_levels = self.get_random_numbers(1, 3, num_of_admins)
        admins_specified_values = {"user_id": admins_ids,
                                   "access_level": admins_levels}

        # EMPLOYEES
        num_of_employees = num_of_doctors + num_of_admins
        employee_ids = doctor_ids + admins_ids
        salaries = self.get_random_numbers(10000, 50000, num_of_employees)
        emplyees_specified_values = {"user_id": employee_ids, "salary":
            salaries}

        # USERS
        num_of_users = num_of_employees + num_of_patients
        user_types = ['doctor' for i in range(num_of_doctors)] + ['admin'
                                                                  for
                                                                  i in range(
                num_of_admins)] + ['patient' for i in range(num_of_patients)]
        user_ids = employee_ids + patients_ids
        user_names = self.get_user_names(num_of_users)
        user_surnames = self.get_user_surnames(num_of_users)
        user_ages = self.get_random_numbers(10, 70, num_of_users)
        genders = self.get_genders(num_of_users)
        users_specified_values = {"user_id": user_ids,
                                  "name": user_names, "surname": user_surnames,
                                  "age": user_ages, "gender": genders,
                                  "type": user_types}

        # MEDICAL REPORTS
        med_reports_ids = self.get_ids(num_of_medical_reports)
        med_report_content = self.generate_text(150, num_of_medical_reports)
        med_reports_specified_values = {"medR_id": med_reports_ids,
                                        "doctor_id": doctor_ids,
                                        "content": med_report_content}

        # MEDICAL HISTORIES
        med_histories_specified_values = {"patient_id": patients_ids,
                                          "med_info":
                                              self.med_history}

        # NOTIFICATIONS
        notifications_ids = self.get_ids(num_of_notifications)
        notifications_content = self.generate_text(50, num_of_notifications)
        notifications_specified_values = {"id": notifications_ids, "user_id":
            user_ids, "content": notifications_content}

        # APPOINTMENTS
        appointments_ids = self.get_ids(num_of_appointments)
        appointments_dates = self.get_date_and_time(2018, 11, 23, 2019, 11, 23,
                                                    num_of_appointments)
        appointments_specified_values = {"id": appointments_ids, "patient_id":
            patients_ids, "doctor_id": doctor_ids,
                                         "ap_datetime": appointments_dates}

        # SPECIAL APPOINTMENTS
        if include_special_doctor:
            num_of_special_appointments = 132
            special_appointments_ids = self.get_ids(
                num_of_special_appointments)
            special_appointments_dates = []
            for i in range(0, 11):
                special_appointments_dates += self.get_date_and_time(2008 + i,
                                                                     1, 1,
                                                                     2008 + i
                                                                     + 1,
                                                                     1, 1, 12)

            special_appointments_specified_values = {
                "id": special_appointments_ids,
                "patient_id": patients_ids,
                "doctor_id":
                    [special_doctor_id],
                "ap_datetime": special_appointments_dates}

        # SUPPLIERS
        suppliers_ids = self.get_ids(num_of_suppliers)
        suppliers_products = [choice(self.products) for i in
                              range(num_of_suppliers)]
        supplier_specified_values = {"id": suppliers_ids,
                                     "product": suppliers_products}

        # ORDERS
        orders_ids = self.get_ids(num_of_orders)
        orders_prices = self.get_random_numbers(100, 20000, num_of_orders)
        orders_specified_values = {"id": orders_ids, "supplier_id":
            suppliers_ids, "employee_id": employee_ids, "price": orders_prices}

        # PAYMENT SERVICES
        payment_services_ids = self.get_ids(num_of_payment_services)
        payment_services_names = [choice(self.payment_services) for i in
                                  range(num_of_payment_services)]
        payment_services_specified_values = {"id": payment_services_ids,
                                             "ps_name": payment_services_names}

        # TRANSACTIONS
        transactions_ids = self.get_ids(num_of_transactions)
        transactions_types = [choice(['income', 'expense']) for i in
                              range(num_of_transactions)]
        amounts = self.get_random_numbers(1, 100000, num_of_transactions)
        transactions_specified_values = {"id": transactions_ids, "user_id":
            user_ids, "p_service_id": payment_services_ids, "amount":
                                             amounts,
                                         "type": transactions_types}

        # MESSAGES
        messages_ids = self.get_ids(num_of_messages)
        messages_specified_values = {"id": messages_ids, "user1_id":
            user_ids, "user2_id": user_ids, "message": self.messages}

        # QUESTIONS
        questions_ids = self.get_ids(num_of_questions)
        questions_content = self.generate_text(150, num_of_questions)
        questions_specified_values = {"id": questions_ids, "user_id": user_ids,
                                      "question": questions_content}

        # Populate tables in the needed order
        self.populate_table("users", num_of_users,
                            copy.deepcopy(users_specified_values))

        self.populate_table("employees", num_of_employees,
                            copy.deepcopy(emplyees_specified_values))

        self.populate_table("doctors", num_of_doctors,
                            copy.deepcopy(doctors_specified_values))

        self.populate_table("administrators", num_of_admins,
                            copy.deepcopy(admins_specified_values))

        self.populate_table("patients", num_of_patients,
                            copy.deepcopy(patients_specified_values))

        self.populate_table("med_histories", num_of_patients, copy.deepcopy(
            med_histories_specified_values), ["med_info"])

        self.populate_table("med_reports", num_of_medical_reports,
                            copy.deepcopy(med_reports_specified_values),
                            ["doctor_id"])

        self.populate_table("notifications", num_of_notifications,
                            copy.deepcopy(notifications_specified_values),
                            ["user_id"])

        self.populate_table("appointments", num_of_appointments,
                            copy.deepcopy(appointments_specified_values),
                            ["patient_id", "doctor_id"])

        # SPECIAL APPOINTMENTS
        if include_special_doctor:
            self.populate_table("appointments", num_of_special_appointments,
                                copy.deepcopy(
                                    special_appointments_specified_values),
                                ["patient_id", "doctor_id"])

        self.populate_table("suppliers", num_of_suppliers,
                            copy.deepcopy(supplier_specified_values))

        self.populate_table("orders", num_of_orders, copy.deepcopy(
            orders_specified_values), ["supplier_id", "employee_id"])

        self.populate_table("payment_services", num_of_payment_services,
                            copy.deepcopy(payment_services_specified_values))

        self.populate_table("transactions", num_of_transactions,
                            copy.deepcopy(transactions_specified_values),
                            ["user_id", "p_service_id"])

        self.populate_table("messages", num_of_messages, copy.deepcopy(
            messages_specified_values), ["user1_id", "user2_id", "message"])

        self.populate_table("questions", num_of_questions, copy.deepcopy(
            questions_specified_values), ["user_id"])

    def populate_table(self, table, num_of_items, specified_fields=None,
                       random_from=None):
        fields = self.get_fields(self.db_tables[table])

        for i in range(num_of_items):
            values = self.get_values(self.db_tables[table], specified_fields,
                                     random_from)
            print(f"INSERT INTO {table} {fields} VALUES {values}")

    def get_field_value(self, _type):
        return "'prikol'"

    def get_date_and_time(self, year_a, month_a, day_a, year_b, month_b,
                          day_b, num_of_els):
        dates = self.get_date(year_a, month_a, day_a, year_b, month_b, day_b,
                              num_of_els)
        times = []
        for i in range(num_of_els):
            times.append(self.fake.time(pattern="%H:%M:%S", end_datetime=None))

        res = [f"{dates} {times}" for dates, times in zip(dates,
                                                          times)]
        return res

    def get_date(self, year_a, month_a, day_a, year_b, month_b, day_b,
                 num_of_els):
        dates = []
        for i in range(num_of_els):
            st_d = datetime.date(year_a, month_a, day_a)
            end_d = datetime.date(year_b, month_b, day_b)
            dates.append(
                self.fake.date_between(start_date=st_d, end_date=end_d))
        return dates

    @staticmethod
    def get_fields(fields):
        s = "("

        for field in fields:
            s += f"{field}, "

        s = s[:-2]
        s += ")"
        return s

    def get_values(self, fields, specified_fields, random_from):
        s = "("

        for field in fields:
            if specified_fields and field in specified_fields:
                if random_from and field in random_from:
                    item = choice(specified_fields[field])
                    if fields[field] == "str":
                        s += f"'{item}', "
                    else:
                        s += f"{item}, "
                else:
                    item = specified_fields[field][0]

                    if fields[field] == "str":
                        s += f"'{item}', "
                    else:
                        s += f"{item}, "
                    specified_fields[field].remove(item)
            else:
                s += f"{self.get_field_value(fields[field])}, "

        s = s[:-2]
        s += ");"

        return s

    def get_ids(self, num_of_ids):
        ids = []
        for i in range(self.last_id, num_of_ids + self.last_id):
            ids.append(i)
        self.last_id = num_of_ids + self.last_id
        return ids

    def generate_name(self):
        return choice(self.names)

    def get_user_names(self, num_of_users):
        names = []
        for i in range(num_of_users):
            names.append(self.generate_name())
        return names

    def generate_surname(self):
        return choice(self.surnames)

    def get_user_surnames(self, num_of_users):
        names = []
        for i in range(num_of_users):
            names.append(self.generate_surname())
        return names

    def get_random_numbers(self, a, b, num_of_els):
        nums = []
        for i in range(num_of_els):
            nums.append(randint(a, b))
        return nums

    def get_spec(self, num_of_els):
        res = []
        for i in range(num_of_els):
            res.append(choice(self.specializations))
        return res

    def get_genders(self, num_of_els):
        res = []
        for i in range(num_of_els):
            res.append(choice(['M', 'F']))
        return res

    def generate_text(self, num_of_symbols, num_of_els):
        res = []
        for i in range(num_of_els):
            res.append(self.fake.text()[:num_of_symbols])
        return res


if __name__ == "__main__":
    users = {"user_id": "int", "name": "str", "surname": "str", "type": "str",
             "age": "int",
             "gender": "str"}

    employees = {"user_id": "int", "salary": "int"}
    admins = {"user_id": "int", "access_level": "int"}
    doctors = {"user_id": "int", "specialization": "str"}
    patients = {"user_id": "int"}
    med_histories = {"patient_id": "int", "med_info": "str"}
    med_reports = {"medR_id": "int", "doctor_id": "int", "content": "str"}
    notifications = {"id": "int", "user_id": "int", "content": "str"}
    appointments = {"id": "int", "patient_id": "int", "doctor_id": "int",
                    "ap_datetime": "str"}
    suppliers = {"id": "int", "product": "str"}
    orders = {"id": "int", "supplier_id": "int", "employee_id": "int",
              "price": "int"}
    payment_services = {"id": "int", "ps_name": "str"}
    transactions = {"id": "int", "user_id": "int", "p_service_id": "int",
                    "amount": "int", "type": "str"}
    messages = {"id": "int", "user1_id": "int", "user2_id": "int",
                "message": "str"}
    questions = {"id": "int", "user_id": "int", "question": "str"}

    tables = {"users": users, "employees": employees, "doctors": doctors,
              "administrators": admins,
              "patients": patients, "med_histories": med_histories,
              "med_reports": med_reports, "notifications": notifications,
              "appointments": appointments, "suppliers": suppliers,
              "orders": orders, "payment_services": payment_services,
              "transactions": transactions, "messages": messages,
              "questions": questions}

    # Change the number of items here!!!
    cg = CodeGenerator(tables, num_of_doctors=4, num_of_admins=3,
                       num_of_patients=6,
                       num_of_medical_reports=12, num_of_notifications=6,
                       num_of_appointments=200, num_of_suppliers=2,
                       num_of_orders=4, num_of_payment_services=1,
                       num_of_transactions=7, num_of_messages=15,
                       num_of_questions=10, include_special_doctor=False)
