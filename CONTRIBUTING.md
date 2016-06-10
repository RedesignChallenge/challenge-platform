# Contributing to the Challenge Platform

Thank you for taking the time and interest in contributing to the Challenge Platform. This document is to serve as a guideline for you as a contributor to follow when making improvements to the platform.


## What We Use to Track Issues

We are leveraging a public [Waffle board](https://waffle.io/RedesignChallenge/challenge-platform) with which we keep tabs on all of our issues:

 - Bugs
 - Feature requests
 - Refactorings

This aligns directly with our [GitHub issues page](https://github.com/RedesignChallenge/challenge-platform/issues), and changes in one will be reflected in the other.

However, we make use of [Waffle's keywords](https://github.com/waffleio/waffle.io/wiki/FAQs#general-support-1) to allow us to observe the progress of these tasks.  This allows the team to internally determine the state of our work in a Kanban style.

### Branch Naming

We require that all branches follow the style:

    [ISSUE-NUMBER]-[TASK-NAME]

### Pull Request Naming

We require that all PRs follow the style:

    Closes [ISSUE-NUMBER]: [TASK-NAME]

### Issue Reporting and Pull Request Conventions

To ensure clear and concise communication of the issue being highlighted, or the solution being presented, we ask that reporters follow these conventions.

 - When reporting a bug, describe what the bug is and leave **clear reproduction steps** in the issue.  Even if one is submitting a pull request to address the issue, it helps facilitate understanding as to why this behavior is a bug in the first place.
 - If this issue is an urgent feature request, please politely indicate so in the issue.  Depending on the work required, we may be able to accommodate the request in a timely fashion; however, please understand that we may not be able to introduce a rapid turnaround.
 - When submitting a pull request, please be aware that we may reject it due to conflicts with upstream consumers. **We reserve the right to reject any PR, at any time, for any reason,** however we will often endeavor to provide an explanation as to the rejection.
 - Except in extrenuous and varying circumstances, **pull requests without any associated tests will be rejected.**

## Code Style and Conventions

A living document of our coding style and conventions [can be found in our Wiki](https://github.com/RedesignChallenge/challenge-platform/wiki/Style-Guide). To ensure a successful PR, please adhere to these guidelines.

At any time, if you wish to dispute or correct inaccuracies or inconsistencies with the conventions, you are encouraged to file an issue tagged with "style-guide".

## Testing

We expect that all code that is submitted in a PR is thoroughly tested.  This includes:

 - **Unit tests** using RSpec and Jasmine, where approriate
 - **Manual regression tests**, ensuring that no existing behavior orthogonal to the change introduced has been altered
 - **Full test steps** which allow any maintainer or volunteer to validate the changes against the issue


## Contributor Covenant Code of Conduct

### Our Pledge

In the interest of fostering an open and welcoming environment, we as contributors and maintainers pledge to making participation in our project and our community a harassment-free experience for everyone, regardless of age, body size, disability, ethnicity, gender identity and expression, level of experience, nationality, personal appearance, race, religion, or sexual identity and orientation.

### Our Standards

Examples of behavior that contributes to creating a positive environment include:

- Using welcoming and inclusive language
- Being respectful of differing viewpoints and experiences
- Gracefully accepting constructive criticism
- Focusing on what is best for the community
- Showing empathy towards other community members

Examples of unacceptable behavior by participants include:

- The use of sexualized language or imagery and unwelcome sexual attention or advances
- Trolling, insulting/derogatory comments, and personal or political attacks
- Public or private harassment
- Publishing others' private information, such as a physical or electronic address, without explicit permission
- Other conduct which could reasonably be considered inappropriate in a professional setting
- Our Responsibilities

Project maintainers are responsible for clarifying the standards of acceptable behavior and are expected to take appropriate and fair corrective action in response to any instances of unacceptable behavior.

Project maintainers have the right and responsibility to remove, edit, or reject comments, commits, code, wiki edits, issues, and other contributions that are not aligned to this Code of Conduct, or to ban temporarily or permanently any contributor for other behaviors that they deem inappropriate, threatening, offensive, or harmful.

### Scope

This Code of Conduct applies both within project spaces and in public spaces when an individual is representing the project or its community. Examples of representing a project or community include using an official project e-mail address, posting via an official social media account, or acting as an appointed representative at an online or offline event. Representation of a project may be further defined and clarified by project maintainers.

### Enforcement

Instances of abusive, harassing, or otherwise unacceptable behavior will be captured internally by the team.  All complaints will be reviewed and investigated and will result in a response that is deemed necessary and appropriate to the circumstances. The project team is obligated to maintain confidentiality with regard to the reporter of an incident. Further details of specific enforcement policies may be posted separately.

Project maintainers who do not follow or enforce the Code of Conduct in good faith may face temporary or permanent repercussions as determined by other members of the project's leadership.

### Attribution

This Code of Conduct is adapted from the Contributor Covenant, version 1.4, available at [http://contributor-covenant.org/version/1/4](http://contributor-covenant.org/version/1/4).