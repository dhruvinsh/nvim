########################
# Author: Dhruivn Shah #
# Date: 8th Oct 2022   #
########################

"""
Update checker for my config. All of the plugin are pin to specific commit hence this
tool allow to check if any update is available for given plugins and make changes in
the plugin file.
"""

import logging
import os
import re
import sys
from dataclasses import dataclass
from pathlib import Path
from typing import Any, Generator, Optional

import requests


def setup_logger(name: str = __name__, level: int = logging.INFO) -> logging.Logger:
    """logging setup.

    Args:
        name (str): logger name, default set to __name__
        level (int): logger level, default set to INFO

    Returns:
        logging.Logger object
    """
    formatter = logging.Formatter("%(asctime)s : %(levelname)8s : %(message)s")

    # pylint: disable=redefined-outer-name
    logger = logging.getLogger(name)
    logger.setLevel(level)

    stream = logging.StreamHandler()
    stream.setLevel(level)
    stream.setFormatter(formatter)

    logger.addHandler(stream)

    return logger


logger = setup_logger()


@dataclass
class Plugin:
    """Plugin data holder"""

    repo: Any
    commit: Any

    @property
    def owner(self) -> Optional[str]:
        """From the repo find the username name"""
        if self.repo is None:
            return None
        return self.repo.split("/", maxsplit=1)[0]

    @property
    def plugin(self) -> Optional[str]:
        """From the repo find the plugin name"""
        if self.repo is None:
            return None
        return self.repo.split("/")[1]


class Github:
    """
    Github API
    """

    def __init__(self, username: str, token: str, url: str) -> None:
        """setup github api.

        Args:
            username (str): github username
            token (str): gitub auth token.
        """
        self.username = username
        self.token = token
        self.url = url
        self.logger = setup_logger(name=self.__class__.__name__)

        self.sess = requests.Session()
        self.sess.auth = (self.username, self.token)

    def get_latest_commit(self, plugin: Plugin) -> str:
        """from github fetch first commit for given repo and ony return short sha.
        (SHA size 7)

        Args:
            plugin: a `Plugin` instance

        Returns:
            SHA size of 7.
        """
        url = f"{self.url}/repos/{plugin.repo}/commits"
        self.logger.debug("Fetching latest commit: %s", url)
        req = self.sess.get(url)
        json_data = req.json()

        # we just need first 7 alphabets
        return json_data[0].get("sha")[:7]

    def get_all_commits_count(self, plugin: Plugin) -> dict[str, Any]:
        """get the commit counts from specific repo to the latest head.

        Args:
            owner (str): repository owner.
            repo (str): repository name.
            sha (str): point of sha from which head diff required.

        Returns:
            {"old_commit": str, "new_commit": str, "count": int}
        """
        # fetch the lated commit for given repo
        latest_commit = self.get_latest_commit(plugin)

        compare_url = (
            f"{self.url}/repos/{plugin.repo}/compare/{latest_commit}...{plugin.commit}"
        )
        self.logger.debug("Fetch diff commits from: %s", compare_url)

        # fetch the diff between given commit to latest commit
        commit_req = self.sess.get(compare_url)
        commit = commit_req.json()

        commit_count = commit.get("behind_by", 0)
        if commit_count > 0:
            logger.info(
                "plugin: %-50s %-3s commits behind \t %s..%s ",
                plugin.repo,
                commit_count,
                plugin.commit,
                latest_commit,
            )

        return {
            "old_commit": plugin.commit,
            "new_commit": latest_commit,
            "count": commit_count,
        }


class PluginParser:
    """Read the plugin file and parse it to the python object."""

    def __init__(self, plugin_file: Path) -> None:
        self.plugin_file = plugin_file

        self.repo_regex = re.compile(r"\"(?P<repo>.*)\"\]")
        self.commit_regex = re.compile(r"commit = \"(?P<commit>\w+)")

        self.logger = setup_logger(self.__class__.__name__)

    @property
    def lines(self) -> list[str]:
        """read files and return it"""
        # pylint: disable=C0103
        with open(self.plugin_file, mode="r", encoding="utf-8") as fp:
            lines = fp.readlines()

        return [line.strip() for line in lines if line.strip()]

    def plugin_data(self) -> Generator[str, None, None]:
        """compile multiline plugins to single line data"""
        data = []
        plugin_start = False

        for line in self.lines:
            if line.startswith('["') and line.endswith("},"):
                yield line
                continue

            if line.startswith('["'):
                data.append(line)
                plugin_start = True
                continue

            if line.endswith("},"):
                data.append(line)
                yield " ".join(data)

                data.clear()
                plugin_start = False

            if plugin_start:
                data.append(line)

    def parse(self) -> list[Plugin]:
        """parse the plugin file to dict"""
        data: list[Plugin] = []
        for plugin_data in self.plugin_data():
            self.logger.debug(plugin_data)

            repo = self.repo_regex.search(plugin_data)
            commit = self.commit_regex.search(plugin_data)

            if not (repo and commit):
                self.logger.error("No plugin data detected %s and %s", repo, commit)
                continue

            repo_val = repo.groupdict()
            commit_val = commit.groupdict()

            plug = Plugin(repo=repo_val.get("repo"), commit=commit_val.get("commit"))

            data.append(plug)

        return data


def update_file(plugin_file: Path, data: dict[str, Any]):
    """update the plugin file with latest commit if required"""
    # pylint: disable=C0103
    with open(plugin_file, mode="r", encoding="utf-8") as fp:
        content = fp.read()

    # pylint: disable=C0103
    with open(plugin_file, mode="w", encoding="utf-8") as fp:
        modified_content = re.sub(
            rf"{data['old_commit']}", data["new_commit"], content, flags=re.M
        )
        fp.write(modified_content)


def main(plugin_file: Path, username: str, token: str, base_url: str):
    """
    check the plugin status
    """
    plugin_parser = PluginParser(plugin_file)
    plugins = plugin_parser.parse()

    ghub = Github(username, token, base_url)

    for plugin in plugins:
        data = ghub.get_all_commits_count(plugin)

        if data["count"] < 1:
            continue

        if len(sys.argv) == 2 and sys.argv[1] in ["--update", "-u"]:
            update_file(plugin_file, data)


if __name__ == "__main__":

    BASE_URL = "https://api.github.com"
    PLUGIN_FILE = Path("lua/orion/core/plugins.lua")
    USERNAME = os.getenv("GHUB_USERNAME", "")
    TOKEN = os.getenv("GHUB_TOKEN", "")

    if not (USERNAME and TOKEN):
        logger.info("Usernme and Password not set, exiting..")
        sys.exit(1)

    main(PLUGIN_FILE, USERNAME, TOKEN, BASE_URL)
