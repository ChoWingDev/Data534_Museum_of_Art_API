
# Contributing to TheMetR

Thanks for contributing to **TheMetR** — an R package that wraps The Metropolitan Museum of Art (The Met) Collection REST API and returns tidy, analysis-ready tibbles.

This repository is developed for the **DATA 534 Group Project**. We follow a PR-first workflow with CI checks.

---

## Project principles

- **Tidy outputs by default**: Most exported functions should return a `tibble`.
- **Minimal but useful wrangling**: Standardize common fields (IDs, dates, names) but keep highly specific transformations in vignettes/examples.
- **Stable schema**: `met_object()` and `met_objects()` should produce consistent column names/types as much as possible.
- **Clear documentation & testing**: Every exported function is documented and tested.

---

## Getting started (local development)

### 1) Clone and open the project
```r
# Recommended: use RStudio or VS Code with an R extension.
````

### 2) Install dependencies

```r
install.packages(c("devtools", "roxygen2", "testthat", "pkgdown"))
```

### 3) Install package dependencies and load

```r
devtools::install_deps(dependencies = TRUE)
devtools::load_all()
```

### 4) Run checks and tests

```r
devtools::check()
devtools::test()
```

---

## Branching & PR workflow (required)

### Branch strategy

* **No direct commits to `main`**
* All work happens on a feature branch:

  * `feature/<short-description>` (e.g., `feature/met-search`)
  * `fix/<short-description>` (e.g., `fix/na-date-parse`)
  * `docs/<short-description>` (e.g., `docs/readme-quickstart`)

### Pull Requests

A PR should:

* Be focused (one feature/fix at a time)
* Include tests for new behavior (or explain why not)
* Include documentation updates if needed
* Pass CI (R CMD check on Windows/macOS/Linux)

**Review rule**: At least **1 teammate approval** is required before merge.

---

## Coding standards

### Style

* Follow the tidyverse style guide (snake_case, readable pipelines).
* Prefer small, composable functions.
* Put shared HTTP/parsing logic in `R/utils_*` files.

### Function design

* Exported functions:

  * `met_departments()`
  * `met_search()`
  * `met_object()`
  * `met_objects()`
* Helpers:

  * `met_tidy_object()` (and other internal helpers)
  * HTTP helper: `met_get()` / `request_json()` (single source of truth for requests)

### Input validation & errors

* Validate inputs early and fail with informative messages.

  * Example: `object_id` must be integer-like.
* Handle:

  * empty results (return empty tibble with correct columns)
  * API downtime or unexpected responses (clear error message)

---

## Commit message guidelines

Use clear, descriptive commit messages. Prefer conventional prefixes:

* `feat: add met_search()`
* `fix: handle empty search results`
* `docs: update vignette example`
* `test: add validation tests for object_id`
* `chore: update CI config`

---

## Documentation requirements

### Roxygen2

* Every exported function must have:

  * `@description`
  * `@param` for each argument
  * `@return`
  * `@examples` (small, runnable example if possible)
  * `@export`

Generate docs before opening a PR:

```r
devtools::document()
```

### README

* Must include Installation + Quickstart (“Zero → Graph”)

### Vignette

* Must demonstrate an end-to-end workflow:

  1. Search (get object IDs)
  2. Fetch objects
  3. Minimal cleaning (e.g., filter missing dates)
  4. Plot (ggplot2)

---

## Testing requirements

We use **testthat**.

### What to test

Minimum coverage should include:

* `met_search()` returns a tibble with expected columns
* `met_object()` returns a 1-row tibble (or empty tibble on invalid ID, depending on spec)
* `met_objects()` returns a tibble with stable schema
* validation behavior (bad inputs produce informative errors)

Run tests locally:

```r
devtools::test()
```

> If tests depend on live API calls, prefer adding guard rails (e.g., skip on CI if needed), but aim to keep tests stable.

---

## CI (Continuous Integration)

CI runs **R CMD check** on Windows/macOS/Linux.

Before opening a PR:

* `devtools::check()` should pass locally
* ensure vignette still knits (if changed)

---

## File organization (recommended)

```
R/
  utils_request.R   # base URL, HTTP requests, retries, error handling
  utils_parse.R     # safe parsing, flatten nested fields
  met_departments.R
  met_search.R
  met_object.R
  met_objects.R
  met_tidy_object.R
tests/testthat/
vignettes/
.github/workflows/
```

---

## Making changes: suggested PR checklist

* [ ] Branch created from latest `main`
* [ ] Code implemented with consistent naming/types
* [ ] Added/updated tests
* [ ] Added/updated roxygen docs (`devtools::document()`)
* [ ] `devtools::test()` passes
* [ ] `devtools::check()` passes
* [ ] PR description includes what changed and how to test it

---

## Team roles (for this course project)

* **Gladys**: Search + Departments + shared request helper
* **Rachel**: Object(s) + tidy schema standardization
* **Kara**: Vignette + Tests + CI + README polish

All teammates should contribute reviews and small improvements across areas.

---

## Questions / coordination

Use GitHub Issues to:

* propose changes
* assign tasks
* track progress

Keep PRs small and frequent to reduce merge conflicts and review time.



