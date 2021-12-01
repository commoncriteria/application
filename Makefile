DIFF_DIR=diff
#DIFF_TAGS=v1.3
TRANS?=transforms
# Application PP requires slightly different transforms, which is specified below.
#PP2HTML_XSL?=local/pp2html.xsl
#PP2SIMPLIFIED_XSL?=local/pp2simplified.xsl
#PP2TABLE_XSL?=local/pp2table.xsl
#RNG_FILE?=local/Application.rng

# PREV_RELEASE_PP_URL?=https://www.niap-ccevs.org/MMO/PP/-394-/pp_app_v1.2.htm

# Let user's include their own makefiles (if they exist)
-include User.make
-include ~/commoncriteria/User.make
include $(TRANS)/Helper.make

#APP_RECIPROCITY_WORKSHEET=$(OUT)/application-vetting-report-sample.html
#all: $(APP_RECIPROCITY_WORKSHEET)
#$(APP_RECIPROCITY_WORKSHEET): schema/results2vettingreport.xsl schema/results-example.xml
#	xsltproc -o $(APP_RECIPROCITY_WORKSHEET) schema/results2vettingreport.xsl schema/results-example.xml

