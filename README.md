# Uneven Region-wise Random Sampling of FASTA Sequences

**Author:** Jayanthi Jayakumar  
**Purpose:** Randomly sample sequences from regional subsets of influenza H1N1 HA (or similar) FASTA datasets, maintaining uneven distribution when needed.

---

## Overview

The script performs the following steps:

1. **Single-line conversion** – converts multi-line FASTA sequences to single-line format for easier processing.  
2. **Region separation** – splits sequences into regional files based on keywords in sequence headers.  
3. **Random sampling** – shuffles and selects a user-specified number of sequences from each region.  
4. **Output generation** – creates final combined FASTA file of sampled sequences.

---

## Input

- Directory containing FASTA files (multi-line sequences).  
- Sequence headers must include region keywords:  
  `Africa, Europe, SG, MiddleE_WA, SEAsia, NorthAmerica, SouthAmerica, Oceania, SouthAsia, EastAsia`.

---

## Output

For each input FASTA file:

1. Directory named after the input file.  
2. Region-specific FASTA files (`Africa.fasta`, `Europe.fasta`, etc.)  
3. Randomly sampled sequences per region (`<region>_out_seq.fa`)  
4. Final combined file: `<input_file>_rdm.fasta`

Temporary files (`.txt`, `.fasta`, `.fa`) are removed automatically.

---

## Usage

```bash
perl uneven_region_random_sampling.pl
```

- The script uses a hard-coded pattern for input files:
  ```perl
  /Volumes/DATA/H1N1/Global_HA_March2019/year_wise/*.fasta
  ```
- When prompted, enter the number of sequences to randomly sample.

---

## Workflow Diagram

```text
Input FASTA (multi-line)
        │
        ▼
Convert to single-line FASTA (>seqID#sequence)
        │
        ▼
Separate by region (Africa, Europe, SG, etc.)
        │
        ▼
Randomly shuffle and sample sequences per region
        │
        ▼
Region-specific sampled FASTA files (<region>_out_seq.fa)
        │
        ▼
Combine into final output file: <input_file>_rdm.fasta
```

---

## Notes

- Sampling is random; repeated runs may yield different sequences.  
- User defines the number of sequences to sample.  
- Works best with properly formatted headers including region information.

