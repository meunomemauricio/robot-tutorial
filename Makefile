# Directories containing src files to generate documentation for GitHub page
GH_PAGES_SOURCES = docs tests

# Automatically builds and publishes the documentation
gh-pages:
	git checkout gh-pages
	rm -rf build _sources _static rst
	git checkout master $(GH_PAGES_SOURCES)
	git reset HEAD
	cd docs; make html
	mv -fv docs/build/html/* ./
	rm -rf $(GH_PAGES_SOURCES)
	git add -A
	git commit -m "Generated gh-pages for `git log master -1 --pretty=short --abbrev-commit`"
	git push origin gh-pages
	git checkout master

