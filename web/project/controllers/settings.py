import ConfigParser


class Settings():
    def __init__(self):
        self.configfile = 'project/config/meep.cfg'
        self.config = ConfigParser.RawConfigParser()

    def init_config(self, init_data):
        with open(self.configfile, 'wb') as configfile:
            self.config.write(self.configfile)

    def get_all_settings(self, section):
        self.config.read(self.configfile)
        try:
            settings = dict(self.config.items(section))
        except:
            settings = {}
        return settings

    def set_all_settings(self,section,dict_settings):
        self.config.read(self.configfile)

        if self.config.has_section(section):
            pass
        else:
            self.config.add_section(section)

        for k,v in dict_settings.items():
            self.config.set(section, k, v)

        with open(self.configfile, 'wb') as configfile:
            self.config.write(configfile)

    def get_setting(self, section, title):
        settings = {}
        self.config.read(self.configfile)
        try:
            settings[title] = self.config.get(section, title)
        except:
            settings = {}
        return settings