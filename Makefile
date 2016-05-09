APP_RECIPROCITY_WORKSHEET=$(OUT)/application-vetting-report-sample.html

TRANS?=transforms
PP2HTML_XSL=local/pp2html.xsl
PP2SIMPLIFIED_XSL=local/pp2simplified.xsl
PP2TABLE_XSL=local/pp2table.xsl
include $(TRANS)/Helper.make


#all: $(APP_RECIPROCITY_WORKSHEET)
#$(APP_RECIPROCITY_WORKSHEET): schema/results2vettingreport.xsl schema/results-example.xml
#	xsltproc -o $(APP_RECIPROCITY_WORKSHEET) schema/results2vettingreport.xsl schema/results-example.xml
