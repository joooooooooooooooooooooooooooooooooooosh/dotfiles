from ranger.api.commands import Command


class mkcd(Command):
    def execute(self):
        if not self.arg(1):
            self.fm.notify("Need directory name", bad=True)
            return

        self.fm.run(["mkdir", self.arg(1)])
        self.fm.execute_console(f"cd {self.arg(1)}")
