# aoc2021

tis the season,

Advent of Code 2021

## Getting started

Create a [virtualenv](https://docs.python.org/3/library/venv.html) and activate it:

```sh
python3 -m venv env
source env/bin/activate
```

Install `cairo-lang`:

```sh
pip3 install cairo-lang
pip3 install contextvars
```

Install python helpers:

```sh
pip3 install ./aocutil
```

## Usage

Compile a cairo challenge

```sh
cd day{xx}
cairo-compile task.cairo --output task_compiled.json
```

Run the cairo program

```sh
cairo-run --program=task_compiled.json --print_output --print_info --relocate_prints --layout=small
```