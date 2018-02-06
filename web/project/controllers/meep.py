# -*- coding: utf-8 -*-
from project import app
from flask import render_template, request, jsonify
from flask_wtf import FlaskForm
from wtforms import StringField
from wtforms.validators import DataRequired
from datetime import datetime as DateTime
import speedtests
import settings
import system
import datetime

@app.route('/')
def start():
    return render_template('printer/index.html')


@app.route('/api/sysinfo', methods=['POST', 'GET'])
def sysinfo():
    return jsonify(system.System.get_sysinfo())


@app.route('/api/latest')
def latest():
    st = speedtests.SpeedtestClass();
    return jsonify(data=st.get_results())


@app.route('/api/last/<days>')
def last_n_days(days):
    st = speedtests.SpeedtestClass();
    # return st.last_n_days(days)
    return jsonify(data=st.last_n_days(days))


@app.route('/api/settings/<section>', methods=['GET', 'POST'])
def get_settings(section):
    set = settings.Settings()
    if request.method == 'POST':
        content = request.get_json(silent=True)
        set.set_all_settings(section, content)
        return "Success"
    else:
        results_dict = set.get_all_settings(section)
        return jsonify(results_dict)


@app.route('/api/live_speedtest')
def live_test():
    sp = speedtests.SpeedtestClass()
    results_dict = sp.live_test()
    # return results_dict
    return jsonify(results_dict)


@app.route('/<path:path>')
def static_file(path):
    return app.send_static_file(path)
