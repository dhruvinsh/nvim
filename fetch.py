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
from pathlib import Path
from typing import Any, Optional

import requests

logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)

stream = logging.StreamHandler()
stream.setLevel(logging.INFO)

logger.addHandler(stream)


# A plugin file
plugin_file = Path("lua/orion/core/plugins.lua")

with open(plugin_file, mode="r", encoding="utf-8") as fp:
    lines = fp.readlines()

BASE_URL = "https://api.github.com"
username = os.getenv("GHUB_USERNAME")
token = os.getenv("GHUB_TOKEN")

if not (username and token):
    sys.exit(1)

sess = requests.Session()
sess.auth = (username, token)


def get_latest_commit(owner, repo):
    """
    from github fetch first commit for given repo
    """
    url = f"{BASE_URL}/repos/{owner}/{repo}/commits"
    req = sess.get(url)
    json_data = req.json()

    # we just need first 7 alphabets
    return json_data[0].get("sha")[:7]


def get_all_commits_count(owner, repo, sha):
    """
    from github fetch all commits
    """
    latest_commit = get_latest_commit(owner, repo)
    compare_url = f"{BASE_URL}/repos/{owner}/{repo}/compare/{latest_commit}...{sha}"
    logger.debug("compare_url is: %s", compare_url)

    commit_req = sess.get(compare_url)
    commit = commit_req.json()
    commit_count = commit.get("behind_by", 0)
    repository = f"{owner}/{repo}"
    if commit_count > 0:
        logger.info(
            "plugin \t %-70s %-3s commits behind \t %s..%s ",
            repository,
            commit_count,
            sha,
            latest_commit,
        )

    return {"old_commit": sha, "new_commit": latest_commit, "count": commit_count}


def fetch_plugins() -> list[dict[str, str]]:
    """
    Read the plugin file and and fetch the plugin name and its relevent commit
    if plugin commit not found then only plugin will be fetched in the data.
    """
    data: list[dict[str, Any]] = []

    plugin_regex = re.compile(r"\"(?P<plugin>.*)\"\]")
    commit_regex = re.compile(r"commit = \"(?P<commit>\w+)")

    for line in lines:
        plugin: Optional[dict[str, Any]] = None
        commit: Optional[dict[str, Any]] = None

        plugin_reg = plugin_regex.search(line)
        commit_reg = commit_regex.search(line)

        if plugin_reg:
            plugin_name = plugin_reg.groupdict()
            if plugin_name is None:
                continue
            owerner, repo = plugin_name.get("plugin").split("/")
            plugin = {
                "plugin": plugin_name.get("plugin"),
                "owner": owerner,
                "repo": repo,
            }

        if commit_reg:
            commit_val = commit_reg.groupdict(line)
            commit = {"commit": commit_val.get("commit")}

        if plugin and commit:
            # if we found plugin and commit both then update the data
            maps = {}
            maps.update(plugin)
            maps.update(commit)
            data.append(maps)
        elif plugin:
            # looks like we found just the plugin
            data.append(plugin)
        elif commit:
            # now we found the COMMIT, for which we already have partial data in the data
            maps = data.pop(-1)
            maps.update(commit)
            data.append(maps)

    return data


def main():
    """
    check the plugin status
    """
    plugins = fetch_plugins()
    for plugin in plugins:
        owner = plugin["owner"]
        repo = plugin["repo"]
        # Took the last commit, Can do it automatically also but keeping it open
        sha = plugin["commit"]
        data = get_all_commits_count(owner, repo, sha)
        if data["count"] < 1:
            continue

        if len(sys.argv) == 2 and sys.argv[1] in ["--update", "-u"]:
            with open(plugin_file, mode="r", encoding="utf-8") as fp:
                content = fp.read()

            with open(plugin_file, mode="w", encoding="utf-8") as fp:
                modified_content = re.sub(
                    rf"{data['old_commit']}", data["new_commit"], content, flags=re.M
                )
                fp.write(modified_content)


if __name__ == "__main__":
    main()
