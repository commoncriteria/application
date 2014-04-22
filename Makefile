IN = input
OUT = output
TRANS = transforms

all: pp table

pp:
	xsltproc -o $(OUT)/application.html $(TRANS)/pp2html.xsl $(IN)/application.xml

table:
	xsltproc -o $(OUT)/application-table.html $(TRANS)/pp2table.xsl $(IN)/application.xml

clean:
	rm $(OUT)/application.html

