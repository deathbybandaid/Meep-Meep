import speedtest
from datetime import datetime as DateTime, timedelta as TimeDelta
import database
import json

class SpeedtestClass():
    def __init__(self):
        self.date = ''
        self.dbfile = 'project/config/speedtest.db'

    def live_test(self):
        servers = []
        time_now = DateTime.today()

        s = speedtest.Speedtest()
        s.get_servers(servers)
        s.get_best_server()
        s.download()
        s.upload()
        s.results.share()
        s.upload(pre_allocate=False)

        results_dict = s.results.dict()

        insert = '''"{0}", "{1}", "{2}", "{3}", \'{4}\', "{5}", "{6}", "{7}" '''. \
            format(results_dict['bytes_received'], results_dict['bytes_sent'],
                   results_dict['download'], results_dict['ping'], json.dumps(results_dict['server']),
                   results_dict['share'], time_now.strftime('%Y-%m-%d %H:%M:%S'), results_dict['upload'])

        db = database.Database()
        db.open(self.dbfile)
        db.write('speedtest', 'bytes_received,bytes_sent,download,ping,server,share,timestamp,upload', insert);
        db.close()
        return results_dict

    def get_results(self):
        api_results = []
        db = database.Database()
        db.open(self.dbfile)
        results = db.get('speedtest', '*')
        for item in results:
            item['server'] = json.loads(item['server'])
            api_results.append(item)

        db.close()
        return api_results

    def last_n_days(self, days):
        api_results = []

        date_1 = DateTime.today()
        end_date = date_1 - TimeDelta(days=int(days))

        sql = '''SELECT * FROM speedtest where timestamp between '{0}' and '{1}' '''\
            .format(end_date.strftime('%Y-%m-%d %H:%M:%S'), date_1.strftime('%Y-%m-%d %H:%M:%S'))

        db = database.Database()
        db.open(self.dbfile)
        db.query(sql)

        rows = db.cursor.fetchall()
        rows = [dict(ix) for ix in rows]

        db.close()
        for item in rows:
            item['server'] = json.loads(item['server'])
            api_results.append(item)

        return api_results
