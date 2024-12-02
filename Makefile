.PHONY: test install pep8 release clean doc

test:
	py.test -v --cov=esengine -l --tb=short --maxfail=1 tests/ -vv

install:
	python setup.py develop

pep8:
	@flake8 esengine --ignore=F403 --ignore F821

release: test
	#@python setup.py sdist bdist_wheel upload
	@python setup.py sdist
	@twine upload dist/*

clean:
	@find ./ -name '*.pyc' -exec rm -f {} \;
	@find ./ -name 'Thumbs.db' -exec rm -f {} \;
	@find ./ -name '*~' -exec rm -f {} \;

epydoc:
	@git up && git checkout master
	@epydoc --html esengine -o /tmp/esengine_docs
	@git checkout gh-pages
	@cp -r /tmp/esengine_docs docs
	@git add docs/
	@git commit -am"updated docs"
	@git push -u origin gh-pages
	@git checkout master
