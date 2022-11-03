# Free Technical Solutions for Ecological Momentary Assessments

This repo contains the retrieved data and all files to replicate the research on **EMA frameworks** that are *license-free* as well as hostable on-premise.

```
├── data
│   ├── github
│   └── misc
├── methodology
│   ├── PRISMA_2020_flow_diagram.pdf
│   ├── PRISMA_2020_flow_diagram.png
│   └── README.md
├── results
│   ├── 0_exclusion_criteria.csv
│   ├── 1_identification_all.csv
│   ├── 2_identification_dedup.csv
│   ├── 3_screening_title.csv
│   ├── 4_screening_fulltext.csv
│   ├── 5_included.csv
│   └── README.md
├── Makefile
├── README.md
└── searchterms.txt
```


## Methodology

The GitHub search was performed with the following parameters:

- in a *file* with the filename `README.md` in the top path (i.e., path=`/`)
- **best match** sorting
- limited to the **first 100 results**
  - only search term *Digital Phenotyping* was affected (» 27 repositories not included)

The research was also enriched by a Google search and other matching projects taken from two registers: 

- [Ecological Momentary Assessment in Mental Health Research](https://jruwaard.github.io/aph_ema_handbook/ema-instruments-catalogue.html#ema-platforms-apps)
- [ESM & Mobile Sensing Solutions: Feature Table](https://docs.google.com/spreadsheets/d/18R9x9Qbl9tADJGpJBJID_T9EWZeQ_4W3OFdn3iKRU7U/edit#gid=204277638)


## Usage

- create a file called `gh_token.txt` with your personal access token for GitHub
- run `make`


## Questions?

If you have questions about this repository, please email me or create an issue.
