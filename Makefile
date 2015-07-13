IN = input
OUT = output
TRANS = transforms
APP_XML=$(IN)/application.xml
TABLE=$(OUT)/application-table.html
SIMPLIFIED=$(OUT)/application-table-reqs.html
APP_HTML=$(OUT)/application.html
APP_OP_HTML=$(OUT)/application-optionsappendix.html
APP_RECIPROCITY_WORKSHEET=$(OUT)/application-vetting-report-sample.html
APP_RELEASE_HTML=$(OUT)/application-release.html
all: $(TABLE) $(SIMPLIFIED) $(APP_HTML) $(APP_RECIPROCITY_WORKSHEET)

pp:$(APP_HTML)
$(APP_HTML):  $(TRANS)/pp2html.xsl $(APP_XML)
	xsltproc -o $(APP_HTML) $(TRANS)/pp2html.xsl $(APP_XML)
	xsltproc --stringparam appendicize on -o $(APP_OP_HTML) $(TRANS)/pp2html.xsl $(APP_XML)
	xsltproc --stringparam appendicize on --stringparam release final -o $(APP_RELEASE_HTML) $(TRANS)/pp2html.xsl $(APP_XML)

table: $(TABLE)
$(TABLE): $(TRANS)/pp2table.xsl $(APP_XML)
	xsltproc  --stringparam release final -o $(TABLE) $(TRANS)/pp2table.xsl $(APP_XML)

simplified: $(SIMPLIFIED)
$(SIMPLIFIED): $(TRANS)/pp2simplified.xsl $(APP_XML)
	xsltproc --stringparam release final -o $(SIMPLIFIED) $(TRANS)/pp2simplified.xsl $(APP_XML)

linkcheck:
	for bb in output/*.html; do for aa in $$(\
	  sed "s/href=['\"]/\nhref=\"/g" $$bb | grep "^href=[\"']#" | sed "s/href=[\"']#//g" | sed "s/[\"'].*//g"\
        ); do grep "id=[\"']$${aa}[\"']" -q  $$bb || echo "Detected missing link $$bb:$$aa"; done; done

vettingreport: $(APP_RECIPROCITY_WORKSHEET)
$(APP_RECIPROCITY_WORKSHEET): schema/results2vettingreport.xsl schema/results-example.xml
	xsltproc -o $(APP_RECIPROCITY_WORKSHEET) schema/results2vettingreport.xsl schema/results-example.xml

schema/application.rnc: schema/application.rng
	trang -I rng -O rnc  schema/application.rng schema/application.rnc

clean:
	@for f in a $(TABLE) $(SIMPLIFIED) $(APP_HTML) $(APP_RELEASE_HTML) $(APP_OP_HTML); do \
		if [ -f $$f ]; then \
			rm "$$f"; \
		fi; \
	done
