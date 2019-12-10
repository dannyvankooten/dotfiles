import sqlite3
import os
import sys

'''
Migrate Fathom data from a SQLite database to a MySQL database.

TODO: Convert None-type to empty string or SQL NULL
TODO: Ensure values do not exceed column length
'''

if len(sys.argv) < 2:
   print("ERROR: too few arguments, expected SQLite database on position 1")
   exit(1)

db_file = sys.argv[1]
conn = sqlite3.connect(db_file, detect_types=sqlite3.PARSE_DECLTYPES | sqlite3.PARSE_COLNAMES)
conn.row_factory = sqlite3.Row

def query(sql):
   cur = conn.execute(sql)
   rows = cur.fetchall()
   cur.close()
   return rows

### users
rows = query('SELECT * FROM users')
print('INSERT INTO users(email, password) ')
print('VALUES ')
i = 1
for r in rows:
   suffix = "," if i < len(rows) else ';'
   print("('{:s}', '{:s}'){:s}".format(r['email'], r['password'], suffix))
   i+= 1 


### site stats 
rows =  query('SELECT * FROM daily_site_stats')
print('INSERT INTO daily_site_stats(pageviews, visitors, sessions, bounce_rate, avg_duration, known_durations, date) ')
print('VALUES ')
i = 1
for r in rows:
   suffix = "," if i < len(rows) else ';'
   print("({:d}, {:d}, {:d}, {:.4f}, {:.4f}, {:d}, '{}'){:s}".format(r['pageviews'], r['visitors'], r['sessions'], r['bounce_rate'], r['avg_duration'], r['known_durations'], r['date'], suffix))
   i+= 1 


### page stats
rows = query('SELECT * FROM daily_page_stats')
print('INSERT INTO daily_page_stats(hostname, pathname, pageviews, visitors, entries, bounce_rate, known_durations, avg_duration, date) ')
print('VALUES ')

i = 1
for r in rows:
   suffix = "," if i < len(rows) else ';'
   print("('{:s}', '{:s}', {:d}, {:d}, {:d}, {:.4f}, {:d}, {:.4f}, '{}'){:s}".format(r['hostname'], r['pathname'], r['pageviews'], r['visitors'], r['entries'], r['bounce_rate'], r['known_durations'], r['avg_duration'], r['date'], suffix))
   i+= 1 


### referrer stats
rows =  query('SELECT * FROM daily_referrer_stats')
print('INSERT INTO daily_referrer_stats(hostname. pathname, groupname, pageviews, visitors. bounce_rate, avg_duration. known_durations, date) ')
print('VALUES ')
i = 1
for r in rows:
   suffix = "," if i < len(rows) else ';'
   print("('{:s}', '{:s}', '{:s}', {:d}, {:d}, {:.4f}, {:.4f}, {:d}, '{}'){:s}".format(r['hostname'], r['pathname'], str(r['groupname']), r['pageviews'], r['visitors'], r['bounce_rate'], r['avg_duration'], r['known_durations'], r['date'], suffix))
   i+= 1 
