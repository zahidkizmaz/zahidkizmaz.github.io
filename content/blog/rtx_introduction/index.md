+++
sort_by = "date"
date = "2024-01-01"
title = "rtx: The Secret Weapon for Streamlining Your Development Environments"
description = "rtx allows you to manage multiple versions of programming languages amd directrory specific environments variables with a single binary."
+++

## Rtx: The Ultimate Tool for Managing Development Environments

---

Are you tired of juggling multiple development environments and
struggling to keep track of different versions of programming languages?

Look no further!
I've got a game-changing tool that will revolutionize your workflow - [rtx](https://github.com/jdx/rtx).
This powerful, open-source tool simplifies the process of managing language installations,
environment variables and more.
With rtx, you can save time and effort, and improve productivity and consistency across teams.

### What is [rtx](https://github.com/jdx/rtx)?

rtx is inspired from [asdf](https://asdf-vm.com/) and can benefit from asdf's vast plugin ecosystem.
It allows you to manage multiple versions of programming languages with a single binary and a simple shell setup.

### Talk is Cheap; Show Me the Code

I won't bore you with installation details,
but it's worth mentioning that rtx is dead simple to install and available in most common platforms.
You can find installation instructions in the [documentation](https://github.com/jdx/rtx#installation).

Per directory or project subdirectory, you can create a `.rtx.toml` file to define needs of your project. Here's an example:

```toml
[tools]
python = '3.11.7'
```

This will automatically install Python 3.11.7 if it's not already installed and adjust the PATH variable accordingly,
when you're in this directory or subdirectories, Python points to 3.11.7 which was installed by rtx.

But that's not all rtx can do with Python. It can also manage virtual environments.
Here is an example:

```toml
[tools]
python = {version='3.11.7', virtualenv='.venv/py3117'}
```

This will create a Python virtual environment in `.venv/py3117` folder from the specified Python version
and activate it when we enter this directory. Amazing!

Now, let's say our Django project needs Node 20 for the frontend. It should be easy to define so:

```toml
[tools]
python = {version='3.11.7', virtualenv='.venv/py3117'}
node = '20'
```

What if we want to set certain environment variables? We can do that as following:

```toml
[env]
DJANGO_SETTINGS = 'dev'
[tools]
python = {version='3.11.7', virtualenv='.venv/py3117'}
node = '20'
```

Now, when we enter this directory, DJANGO_SETTINGS will be set accordingly.
This is very cool, but sometimes projects already have their .env files and I would not prefer to copy-paste these
variable definitions again. Thankfully, we can just tell rtx to read variables from a file:

```toml
[tools]
python = {version='3.11.7', virtualenv='.venv/py3117'}
node = '20'

# Read environment variables from .env file
env_file = '.env.dev'
```

Fantastic!

Lastly, I want to mention setting extending the PATH variable per directory:

```toml
[tools]
python = {version='3.11.7', virtualenv='.venv/py3117'}
node = '20'

# Set environment variables from .env file
env_file = '.env.dev'

# Set path variables for this directory
env_path = [
    "./node_modules/.bin",
]
```

### Python virtual environment demo

```bash
mkdir tmp && cd tmp

cat > .rtx.toml << EOL
[tools]
python = {version='3.11.7', virtualenv='.venv/py3117'}
EOL

which python
# outputs this:
# ~/tmp/.venv/py3117/bin/python

tree -a -L 3 .
# outputs this:
.
├── .rtx.toml
└── .venv
    └── py3117
        ├── bin
        ├── include
        ├── lib
        └── pyvenv.cfg
```

### Sum up

rtx is an excellent tool for setting up development environments,
simplifying many things and changing the language version just by changing a number in the configuration.
I highly recommend it to anyone looking to streamline their development workflow.
