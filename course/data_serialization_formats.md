---
jupytext:
  cell_metadata_filter: -all
  formats: md:myst
  text_representation:
    extension: .md
    format_name: myst
    format_version: 0.13
    jupytext_version: 1.11.5
kernelspec:
  display_name: Python
  language: python
  name: python3
---

# Data serialization formats

In this chapter we present YAML, JSON, and XML, 3 widely used generic hierarchical data formats, useful to export/import custom data to/from an application.

## Custom data

Here is some custom data that we would like to save on disk and reload later in our application:
```{code-cell}
maze = {
    'height': 5,
    'width': 5,
    'cell_type': 'wall',
    'cells': [(0,0), (0,2), (0, 4), (1,0), (2,2), (2,3), (3,4), (4,0), (4,4)]
}
```
Instead of designing our own custom file format we will see how we can export and import this custom data using YAML, JSON and XML.

## JSON

```{note}
:class: margin
See *json* package documentation at <https://docs.python.org/3/library/json.html>.
```

The `json` module handles export and import of data in [JSON](https://en.wikipedia.org/wiki/JSON) format.

We can convert our data object into a JSON string with the following simple command:
```{code-cell}
import json
json.dumps(maze)
```
The format looks very much like Python syntax.
```{important}
In our example, the tuples have been converted to lists. JSON does not distinguish between those two Python specific data structures.
```

To save the JSON into a file, we must first open the destination file:
```{code-cell}
with open("maze.json", 'w') as f:
    json.dump(maze, f, indent=4)
```

```{caution}
:class: margin
Note the names of the two functions: `dumps()` with a final s for *string* and `dump()` without a final s for exporting into a file.
```

We have used the `indent=4` argument in order to "pretty print" (i.e.: to print in a more human-readable format) into the file. You can look at the result here:
```{code-cell}
:tags: ["hide-cell"]
!cat maze.json
```

Loading the data back from the file is done by calling `json.load()`:
```{tip}
:class: margin
Loading from a string is done with `json.loads()`.
```
```{code-cell}
with open("maze.json", 'r') as f:
    maze_from_json = json.load(f)
    print(maze_from_json)
```
```{warning}
The initial tuples are not rebuilt. Instead we get `list` objects.
This is because, as noted earlier, JSON does not handle tuples but only lists.
The reason is that a `tuple` is an immutable list in Python, and mutability is a concept which only has sense during the execution of a code.
Inside a data file, mutability has no sense since everything is frozen.
```
The loss of the `tuple` information is not concerning.
Usually, before writing the JSON file, we have a stage where we collect all information needed to be saved.
On load time, we have an equivalent stage where we may run any transformation process that will rebuild original objects.

## YAML

```{note}
:class: margin
See *PyYAML* package documentation at <https://pyyaml.org/wiki/PyYAMLDocumentation>.
```

`pyyaml` module *PyYAML* 

```{code-cell}
import yaml
print(yaml.dump(maze))
```

```{code-cell}
print(yaml.safe_dump(maze))
```

```{code-cell}
with open("maze.yml", "w") as f:
    yaml.dump(maze, f)
```

```{code-cell}
:tags: ["hide-input"]
!cat maze.yml
```

<!-- TODO Load -->
```{code-cell}
with open("maze.yml", "r") as f:
    maze_from_yaml = yaml.load(f, Loader=yaml.Loader)
    print(maze_from_yaml)
```

## XML

xml package <https://docs.python.org/3/library/xml.html>

## Hands-on work

```{admonition} Exercice
Use one of YAML, JSON or XML to save and load your custom data format in one of the class projects.
```
