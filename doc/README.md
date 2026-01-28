# TheMetR (DATA 534 Group Project)

**TheMetR** is an R package that wraps **The Metropolitan Museum of Art (The Met) Collection REST API** and returns tidy, analysis-ready data structures (tibbles) for exploration and visualization.

- **API (base endpoint):** `https://collectionapi.metmuseum.org/public/collection/v1/`
- **Course:** DATA 534 Group Project — Wrap data API!

---

## Features

- Search The Met collection by keyword and filters
- Retrieve metadata for one artwork or many artworks
- Return consistent **tibbles** (minimal but useful wrangling)
- Includes a vignette that demonstrates a full workflow **from zero to graph**

---

## Installation

### From GitHub (development version)

```r
# install.packages("remotes")
remotes::install_github("YOUR_ORG_OR_USERNAME/TheMetR")
```

Then load it:

```r
library(TheMetR)
```

---

## Quickstart (Zero → Graph)

```r
library(TheMetR)
library(dplyr)
library(ggplot2)

# 1) Search for object IDs (example: "monet")
res <- met_search("monet", has_images = TRUE)

# 2) Fetch details for a small sample
objs <- met_objects(res$object_id[1:50])

# 3) Minimal cleaning (example: keep objects with an end date)
objs_clean <- objs %>%
  filter(!is.na(object_end_date))

# 4) Plot: artworks over time
ggplot(objs_clean, aes(x = object_end_date)) +
  geom_histogram() +
  labs(
    title = "The Met Collection: Artworks Over Time (sample)",
    x = "Object End Year",
    y = "Count"
  )
```

---

## Core Functions (Planned)

> Final function names may change slightly as the package develops.

* `met_departments()`
  Returns a tibble of department IDs and department names.

* `met_search(q, has_images = TRUE, ...)`
  Searches the collection and returns a tibble of matching `object_id`s plus query metadata.

* `met_object(object_id)`
  Retrieves metadata for one object and returns a tidy tibble (single row) or a named list.

* `met_objects(object_ids, progress = TRUE)`
  Fetches metadata for multiple objects and returns a combined tibble.

* `met_tidy_object(x)` *(helper)*
  Standardizes/cleans common fields (dates, dimensions, nested fields) into a consistent schema.

---

## Output Design

The package aims to:

* return **tibbles** as the default output for most functions,
* provide minimal, general wrangling that most users want (e.g., consistent column names, NA-safe parsing),
* keep highly specific transformations in the vignette/examples.

---

## Error Handling

Functions are expected to:

* validate inputs (e.g., `object_id` must be numeric/integer-like),
* fail gracefully with informative messages when the API is unavailable or returns unexpected responses,
* handle empty results (e.g., a search with no matches).

---

## Development Workflow (Course Requirement)

* No direct commits to `main`
* All changes go through **pull requests**
* Frequent commits and clear commit messages
* CI runs on Windows/macOS/Linux

---

## License

This project will include an open-source license (TBD by the team, e.g., MIT).

---

## Code of Conduct / Contributing

* `CODE_OF_CONDUCT.md` defines expected behavior for team interactions.
* `CONTRIBUTING.md` explains our PR workflow and contribution expectations.

---

## Acknowledgements

* The Metropolitan Museum of Art Collection API
  Base endpoint: `https://collectionapi.metmuseum.org/public/collection/v1/`

---

## Project Context

This package is developed as part of the **DATA 534 Group Project**: build an R package that wraps a REST API, with strong documentation, testing, and a vignette demonstrating a full workflow including plotting.

```

 repo path ：`https://github.com/ChoWingDev/Data534_Museum_of_Art_API.
```
