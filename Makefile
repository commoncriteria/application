IN = input
OUT = output
TRANS = transforms
APP_XML=$(IN)/application.xml
ESR_XML=$(IN)/esr.xml
TABLE=$(OUT)/application-table.html
SIMPLIFIED=$(OUT)/application-table-reqs.html
APP_HTML=$(OUT)/application.html
ESR_HTML=$(OUT)/application-esr.html
APP_OP_HTML=$(OUT)/application-optionsappendix.html
APP_RECIPROCITY_WORKSHEET=$(OUT)/application-vetting-report-sample.html
APP_RELEASE_HTML=$(OUT)/application-release.html
all: $(TABLE) $(SIMPLIFIED) $(APP_HTML) $(APP_RECIPROCITY_WORKSHEET) $(ESR_HTML)

pp:$(APP_HTML)
$(APP_HTML):  $(TRANS)/pp2html.xsl $(APP_XML)
	xsltproc -o $(APP_HTML) $(TRANS)/pp2html.xsl $(APP_XML)
	xsltproc --stringparam appendicize on -o $(APP_OP_HTML) $(TRANS)/pp2html.xsl $(APP_XML)
	xsltproc --stringparam appendicize on --stringparam release final -o $(APP_RELEASE_HTML) $(TRANS)/pp2html.xsl $(APP_XML)

esr:$(ESR_HTML)
$(ESR_HTML):  $(TRANS)/esr2html.xsl $(ESR_XML)
	xsltproc -o $(ESR_HTML) $(TRANS)/esr2html.xsl $(ESR_XML)

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

transforms/schemas/schema.rnc: transforms/schemas/schema.rng
	trang -I rng -O rnc  transforms/schemas/schema.rng transforms/schemas/schema.rnc

clean:
	@for f in a $(TABLE) $(SIMPLIFIED) $(APP_HTML) $(APP_RELEASE_HTML) $(APP_OP_HTML) $(APP_RECIPROCITY_WORKSHEET) $(ESR_HTML); do \
		if [ -f $$f ]; then \
			rm "$$f"; \
		fi; \
	done
