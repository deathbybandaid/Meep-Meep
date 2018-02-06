import os, psutil
from datetime import timedelta


class System():

    @staticmethod
    def get_sysinfo():
        data = {}

        mem = psutil.virtual_memory()

        data['memory'] = {
            'total': mem.total,
            'used': mem.used,
            'used_percent': (mem.used * 100) / mem.total,
            'free': mem.free,
            'percent': mem.percent,
            'available': mem.available
        }

        data['cpu_percent'] = psutil.cpu_percent()

        data['cpu_count'] = psutil.cpu_count()

        data['storage'] = {}

        os_mount = '/'

        with open('/proc/uptime', 'r') as f:
            uptime_seconds = float(f.readline().split()[0])
            data['uptime'] = str(timedelta(seconds=uptime_seconds))

        os_storage = psutil.disk_usage(os_mount)
        data['storage']['os'] = {
            'mount': os_mount,
            'total': os_storage.total,
            'used': os_storage.used,
            'free': os_storage.free,
            'percent': os_storage.percent
        }

        return data
