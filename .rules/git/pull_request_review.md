
# Github Pull Request Review Rules

### Overview

This rule automatically retrieves and summarizes the pull request content and diff of the currently checked out branch, allowing you to perform a complete review workflow in a single prompt.

### How to use

A comprehensive PR review is possible by running the following command:

"Please review the content and diff of the pull request created in this branch and summarize the changes. Also, please suggest any areas that require detailed review. Based on the information obtained, please summarize the purpose of the PR, the main changes, and the scope of impact in Japanese."

This rule is expected to improve the efficiency and quality of PR reviews.


```sh
# Check out the target branch
git branch --show-current
# Get PR title, description, reviewers, status etc.
gh pr view > PR_VIEW.log
# Get PR diff using
gh pr diff > PR_DIFF.log
```
