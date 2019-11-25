import psycopg2
import tkinter as tk
from functools import partial
import tkinter.ttk as ttk


class PopUpWindow(object):
    def __init__(self, root, value):
        self.value = None
        self.top = tk.Toplevel(root)

        self.label = tk.Label(self.top, text=value)
        self.label.pack()
        self.entry = tk.Entry(self.top)
        self.entry.pack()
        self.ok_button = tk.Button(self.top, text='Ok', command=self.cleanup)
        self.ok_button.pack()

    def cleanup(self):
        self.value = self.entry.get()
        self.top.destroy()


class Table(tk.Frame):
    def __init__(self, parent=None, headings=tuple(), rows=tuple()):
        super().__init__(parent)

        table = ttk.Treeview(self, show="headings", selectmode="browse")
        table["columns"] = headings
        table["displaycolumns"] = headings

        for head in headings:
            table.heading(head, text=head, anchor=tk.CENTER)
            table.column(head, anchor=tk.CENTER)

        for row in rows:
            table.insert('', tk.END, values=tuple(row))

        scrollable = tk.Scrollbar(self, command=table.yview)
        table.configure(yscrollcommand=scrollable.set)
        scrollable.pack(side=tk.RIGHT, fill=tk.Y)
        table.pack(expand=tk.YES, fill=tk.BOTH)


class Interface:
    def __init__(self, root):
        self.root = root
        conn = psycopg2.connect(dbname='postgres', user='postgres',
                                password='docker', host='localhost')
        self.cursor = conn.cursor()
        self.table = Table(root)

        self.patient_id = 205

        self.queries = ["select name, surname "
                        "from appointments a inner join users u on "
                        "a.doctor_id = u.user_id and patient_id = "
                        "id_to_be_inserted "
                        "and date(ap_datetime) = ( "
                        "select "
                        "MAX (date (a.ap_datetime)) "
                        "from appointments a "
                        "where a.patient_id = 205 "
                        ") "
                        "and (((substr("
                        "name, 1, 1) = 'L' or substr(name, 1, 1) = 'M') "
                        "and "
                        "(substr(surname, 1, 1) != 'L' and substr(surname, "
                        "1, 1) != 'M')) or ((substr(surname, 1, 1) = 'L' or "
                        "substr(surname, 1, 1) = 'M') and (substr(name, 1, "
                        "1) != 'L' and substr(name, 1, 1) != 'M')));",
                        "select "
                        "case "
                        "when week_day = 1 then 'Monday'"
                        "when week_day = 2 then 'Tuesday'"
                        "when week_day = 3 then 'Wednesday'"
                        "when week_day = 4 then 'Thursday'"
                        "when week_day = 5 then 'Friday'"
                        "when week_day = 6 then 'Saturday'"
                        "when week_day = 7 then 'Sunday'"
                        "end as \"day_of_week\","
                        "case "
                        "when timeslot = 0 then '00:00 - 01:59'"
                        "when timeslot = 1 then '02:00 - 03:59'"
                        "when timeslot = 2 then '04:00 - 05:59'"
                        "when timeslot = 3 then '06:00 - 07:59'"
                        "when timeslot = 4 then '08:00 - 09:59'"
                        "when timeslot = 5 then '10:00 - 11:59'"
                        "when timeslot = 6 then '12:00 - 13:59'"
                        "when timeslot = 7 then '14:00 - 15:59'"
                        "when timeslot = 8 then '16:00 - 17:59'"
                        "when timeslot = 9 then '18:00 - 19:59'"
                        "when timeslot = 10 then '20:00 - 21:59'"
                        "when timeslot = 11 then '22:00 - 23:59'"
                        "end as \"timeslot\", name, surname, total_appointments, average_appointments "
                        "from( "
                        "select doctor_id, timeslot, week_day, count(*) as "
                        "total_appointments, "
                        "round(count(*)/ 52.0, 4) as average_appointments "
                        "from ("
                        "select doctor_id, floor(extract(hour from "
                        "ap_datetime)/2) as timeslot, "
                        "EXTRACT(isodow from ap_datetime) as week_day, "
                        "ap_datetime "
                        "from Appointments "
                        "where date(ap_datetime) > current_date - interval "
                        "'1 year' "
                        ") timeslot_doctor "
                        "group by doctor_id, timeslot, week_day "
                        ") t_d inner join users u on u.user_id = "
                        "t_d.doctor_id "
                        "order by week_day, timeslot;",
                        "select name, surname "
                        "from ( "
                        "select patient_id "
                        "from ( "
                        "select patient_id "
                        "from ( "
                        "select patient_id, ceil(('2019-11-17' - date("
                        "ap_datetime)) / 7) as week_num "
                        "from Appointments "
                        "where '2019-11-17' - date(ap_datetime) < 28) "
                        "month_patients "
                        "group by week_num, patient_id "
                        "having count(*) >= 2) week_patients "
                        "group by patient_id "
                        "having count(*) = 4 "
                        ") required_patients "
                        "inner join users u on required_patients.patient_id "
                        "= u.user_id; ",
                        "select sum( "
                        "case "
                        "when age < 50 and n_visits < 3 then 200 * n_visits "
                        "when age < 50 and n_visits >= 3 then 250 * n_visits "
                        "when age >= 50 and n_visits < 3 then 400 * n_visits "
                        "when age >= 50 and n_visits >= 3 then 500 * n_visits "
                        "end "
                        ") as \"hospital_income\" "
                        "from ( "
                        "select age, count(*) as n_visits "
                        "from ( "
                        "select age, patient_id "
                        "from ( "
                        "select patient_id "
                        "from Appointments "
                        "where '2019-11-17' - date(ap_datetime) < 31) m_p "
                        "inner join users u on m_p.patient_id = u.user_id "
                        ") month_ap "
                        "group by patient_id, age "
                        ") age_visits; ",
                        "select name, surname "
                        "from ( "
                        "select doctor_id "
                        "from ( "
                        "select doctor_id "
                        "from ( "
                        "select doctor_id, count(*) as num_app "
                        "from ( "
                        "select doctor_id, (current_date - date(ap_datetime))/365 as year_num "
                        "from Appointments "
                        "where date(ap_datetime) > current_date - interval '10 years' "
                        ") app_10_years "
                        "group by doctor_id, year_num "
                        "having count(*) >= 5 "
                        ") d_5_per_year "
                        "group by doctor_id "
                        "having count(*) = 10 and sum(num_app) >= 100 "
                        ")d_10_years "
                        ") requested_doctors "
                        "inner join users u on requested_doctors.doctor_id = u.user_id; "]

        hor_pad = 10
        ver_pad = 10
        buttons = tk.LabelFrame(text="Get your query")
        buttons.pack(side=tk.BOTTOM, padx=hor_pad, pady=ver_pad)

        self.query_1_button = tk.Button(buttons, command=partial(
            self.run_predefined_query,
            0),
                                        text="Get query 1")
        self.query_1_button.pack(side=tk.LEFT, padx=hor_pad, pady=ver_pad)

        query_2_button = tk.Button(buttons,
                                   command=partial(self.run_predefined_query,
                                                   1),
                                   text="Get query 2")
        query_2_button.pack(side=tk.LEFT, padx=hor_pad, pady=ver_pad)

        query_3_button = tk.Button(buttons,
                                   command=partial(self.run_predefined_query,
                                                   2),
                                   text="Get query 3")
        query_3_button.pack(side=tk.LEFT, padx=hor_pad, pady=ver_pad)

        query_4_button = tk.Button(buttons,
                                   command=partial(self.run_predefined_query,
                                                   3),
                                   text="Get query 4")
        query_4_button.pack(side=tk.LEFT, padx=hor_pad, pady=ver_pad)

        query_5_button = tk.Button(buttons,
                                   command=partial(self.run_predefined_query,
                                                   4),
                                   text="Get query 5")
        query_5_button.pack(side=tk.LEFT, padx=hor_pad, pady=ver_pad)

        self.custom_query_button = tk.Button(buttons,
                                             command=self.run_custom_query,
                                             text="Run your query")
        self.custom_query_button.pack(side=tk.LEFT, padx=hor_pad, pady=ver_pad)

        root.mainloop()

    def popup(self, button, value):
        self.popupW = PopUpWindow(self.root, value)
        button["state"] = "disabled"
        self.root.wait_window(self.popupW.top)
        button["state"] = "normal"

    def popup_entry_value(self):
        return self.popupW.value

    def run_custom_query(self):
        self.popup(self.custom_query_button, "Enter your query")
        query = self.popup_entry_value()

        self.show_query(query)

    def run_predefined_query(self, query_num):
        query = self.queries[query_num]
        if query_num == 0:
            self.popup(self.query_1_button, "Enter patient_id")
            new_id = self.popup_entry_value()
            if new_id != "":
                self.patient_id = new_id
            query = query.replace('id_to_be_inserted', str(self.patient_id))
        self.show_query(query)

    def show_query(self, query):
        self.cursor.execute(query)
        records = self.cursor.fetchall()

        columns = []
        for d in self.cursor.description:
            columns.append(d[0])

        self.table.destroy()
        self.table = Table(root, headings=tuple(columns),
                           rows=records)
        self.table.pack(expand=tk.YES, fill=tk.BOTH)


if __name__ == "__main__":
    root = tk.Tk()
    root.title('Queries')
    root.geometry('1280x720')
    app = Interface(root)
