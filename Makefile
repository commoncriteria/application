IN = input
OUT = output
TRANS = transforms
DOCBOOK = ~/Downloads/docbook-xsl-1.78.1/xhtml5

pp:
	xsltproc -o $(OUT)/application.html $(TRANS)/pp2html.xsl $(IN)/application.xml

dbk-xhtml:
	cp $(IN)/style.css $(OUT)/style.css
	xsltproc -o $(OUT)/application2.dbk $(TRANS)/pp2dbk.xsl $(IN)/application2.xml
	xsltproc \
		--stringparam html.stylesheet style.css \
		-o $(OUT)/application2.xhtml $(DOCBOOK)/docbook.xsl $(OUT)/application2.dbk

clean:
	rm $(OUT)/*.dbk $(OUT)/*.*html $(OUT)/*.css
