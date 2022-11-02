.POSIX:
GH_TOKEN_FILE=gh_token.txt
GH_TOKEN=$(shell cat $(GH_TOKEN_FILE))
SEARCH_TERMS_FILE=searchterms.txt
S_TERM_LIST=$(shell paste -s -d, $(SEARCH_TERMS_FILE))
S_TERM_LIST_URI=$(shell cat $(SEARCH_TERMS_FILE) |  jq -Rr @uri)

.PHONY: runinct
runinct:
	@docker run --rm -it -v "$$(pwd):/data" -p "8000:8000" -w "/data" datasciencetoolbox/dsatcl2e -c "make gh_search gh_extract"

# ---

.PHONY: gh_search
gh_search:
	@echo "\nSEARCH: GitHub"
	@echo "=============="
	@while read -r LINE; do \
		S_TERM_URI=$$(echo $$LINE | jq -Rr @uri); \
		if [ -f ./data/github/gh_readme_$$S_TERM_URI.json ]; then \
            echo "$$LINE: file already exists"; \
		else \
            echo "$$LINE: curling..."; \
			curl \
				--fail \
				--retry 5 \
				--retry-delay 180 \
				--retry-max-time 240 \
				--retry-all-errors \
				--progress-bar \
				-H 'Accept: application/vnd.github+json; charset=utf-8' \
				-H 'Authorization: Bearer $(GH_TOKEN)' \
				-H 'Pragma: no-cache' \
				-H 'Cache-Control: no-cache' \
				"https://api.github.com/search/code?q=$$S_TERM_URI%20in%3Afile%20filename%3AREADME.md%20path%3A%2F&s=&per_page=100" | \
			tee ./data/github/gh_readme_$$S_TERM_URI.json | \
			jq; \
        fi \
	done <$(SEARCH_TERMS_FILE)

# ---

.PHONY: gh_extract
gh_extract:
	@echo "\nEXTRACT: GitHub search results"
	@echo "=============================="
	@while read -r LINE; do \
		S_TERM_URI=$$(echo $$LINE | jq -Rr @uri); \
		if [ -f ./data/github/gh_readme_$$S_TERM_URI.csv ]; then \
            echo "$$LINE: file already exists"; \
		else \
			echo "$$LINE: extracting..."; \
			cat ./data/github/gh_readme_$$S_TERM_URI.json | \
			jq -c -r '.items[]' | \
			json2csv -d "," -p -k repository.name,repository.full_name,repository.html_url,repository.description -o ./data/github/gh_readme_$$S_TERM_URI.csv; \
        fi \
	done <$(SEARCH_TERMS_FILE)

