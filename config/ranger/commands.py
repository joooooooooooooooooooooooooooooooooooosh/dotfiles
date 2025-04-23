from ranger.api.commands import Command

import re


class mkcd(Command):
    def execute(self):
        if not self.rest(1):
            self.fm.notify("Need directory name", bad=True)
            return

        self.fm.run(["mkdir", "-p", self.rest(1)])
        self.fm.execute_console(f"cd {self.rest(1)}")
