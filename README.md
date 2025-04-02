# Stooge

**TL;DR:** Enable seamless conversion between various configuration file formats.

## Introduction

Is a creation of borderline madness from context switching during a start of new project or joining an existing one. Trying to find/understand/learn/adapt to a file format in which the project's configuration files are written in… I mean… How many config file formats you need to know to configure and run a single project?!

One configuration file format to rule them all! Not by creating yet another super-duper format, more like choosing one and sticking to it for the whole project while auto-generating the rest.

## Table of Contents

- Getting Started
  - Installation
  - Usage
  - Demo
- Features
- Configuration
- Code Structure
- Testing
- Contributing
- License

## Getting Started

### Installation

```shell
pnpm add --save-dev @idangoldman/stooge
```

### Usage

use `stooge` from the command line like so:

```shell
stooge \
  --format="yaml" \
  --input="path/to/input.json" \
  --output="path/to/output.yml" \
  --schema="path/to/schema.{json,yml}"
  --dictionary="path/to/dictionary.{json,yml}"

# or

stooge \
  --format="yaml" \
  --input="package.json" \
  --output="package.yml" \
  --schema="package.schema.yml" \
  --watch

# or

stooge \
  --schema="ghost.schema.yml" \
  --dictionary="markdown_to_ghost" \
  --sync
```

for more information, run `stooge --help`.

use `stooge` from the code like so:

```js
import stooge from "@idangoldman/stooge";

# to be determined later ...
```

## TODOs

- [ ] Migration from `#root/conversion.js` to `#root/cli.js` inside `#root/bin/index.js`

### Testing

- [ ] Test creation of output folder
- [ ] Test creation of output file without output option but with format option
- [ ] Test creation of output file with format option but without output option
- [ ] Test multiple inputs (glob) to output folder
- [ ] Error handling testing
  - [ ] Conversion format not supported
  - [ ] Input file not exist
  - [ ] Input file format not supported
  - [ ] Input file is empty
  - [ ] Input format not valid
  - [ ] Can't create output file
  - [ ] Can't create output folder
- [ ] Add `--schema` option to CLI
