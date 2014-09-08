IN = input
OUT = output
TRANS = transforms
APP_XML=$(IN)/application.xml
TABLE=$(OUT)/application-table.html
CRITERIA=$(OUT)/application-table-criteria.html
APP_HTML=$(OUT)/application.html
all: $(TABLE) $(CRITERIA) $(APP_HTML)

pp:$(APP_HTML)
$(APP_HTML):  $(TRANS)/pp2html.xsl $(APP_XML)
	xsltproc -o $(APP_HTML) $(TRANS)/pp2html.xsl $(APP_XML)

table: $(TABLE)
$(TABLE): $(TRANS)/pp2table.xsl $(APP_XML)
	xsltproc -o $(TABLE) $(TRANS)/pp2table.xsl $(APP_XML)

simplified: $(CRITERIA)
$(CRITERIA): $(TRANS)/pp2simplified.xsl $(APP_XML)
	xsltproc -o $(CRITERIA) $(TRANS)/pp2simplified.xsl $(APP_XML)

schema/application.rnc: schema/application.rng
	trang -I rng -O rnc  schema/application.rng schema/application.rnc

clean:
	@for f in a $(TABLE) $(CRITERIA) $(APP_HTML); do \
		if [ -f $$f ]; then \
			rm "$$f"; \
		fi; \
	done
