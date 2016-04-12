<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<xsl:stylesheet version="1.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
xmlns:cc="http://common-criteria.rhcloud.com/ns/cc"
xmlns:rr="http://common-criteria.rhcloud.com/ns/rr"
xmlns:dc="http://purl.org/dc/elements/1.1/" 
xmlns:xhtml="http://www.w3.org/1999/xhtml">

<!-- This style sheet takes as input a Protection Profile expressed in XML and
	outputs a table of the SFRs and SARs. -->
	

  <!-- Put all common templates into ProtectionProfileCommons -->
  <!-- They can be redefined/overridden  -->
  <xsl:include href="../transforms/ppcommons.xsl"/>

  <!-- very important, for special characters and umlauts iso8859-1-->
  <xsl:output method="html" encoding="UTF-8" indent="yes" />

	<xsl:template match="/rr:report">
		<html>
		<head>
			<script type="text/javascript">			
				<!--
                    Called on page load to parse URL parameters and perform actions on them. -->
				function init(){
				if(getQueryVariable("tags") == "on"){
				showTags();
				}
				}
				
				<!--
                    Pass a URL variable to this function and it will return it 's value -->
				function getQueryVariable(variable)
				{
				var query = window.location.search.substring(1);
				var vars = query.split("&amp;");
				for (var i=0;i&lt;vars.length;i++) {
				var pair = vars[i].split("=");
				if(pair[0] == variable){return pair[1];}
				}
				return(false);
				}
				
				<!--
                    Shows all XML tags -->
				function showTags(){  
					var hidden_elements = document.getElementsByClassName('taghidden');
					for (var i = hidden_elements.length - 1; i >= 0; --i) {
					hidden_elements[i].className = (hidden_elements[i].className=='taghidden') ? 'tag':'taghidden';
					}

				}
			</script>
			<style type="text/css">
				h1
				{
				text-align: left; font-size: 200%;  margin-top: 2em; margin-bottom: 2em;
				font-family: verdana, arial, helvetica, sans-serif;
				margin-bottom: 1.0em;
				}
				h1.title
				{
				text-align: center;
				}
				h2
				{
				font-size: 125%;
				border-bottom: solid 1px gray; margin-bottom: 1.0em;
				margin-top: 2em; margin-bottom: 0.75em; margin-left: 3em; margin-right: 3em; 
				font-family: verdana, arial, helvetica, sans-serif;
				}
				tr.header
				{
				border-bottom: 3px solid gray; 
				padding: 8px 8px;
				text-align:left;
				font-weight: bold;
				}    
				
				table, th, td
				{
				border-collapse: collapse;
				border: 1px solid #000000;
				<!--border-left: none;
            border-right: none;-->
				vertical-align: top;
				text-align: left;
				padding: 2px;
				font-family: verdana,arial,sans-serif;
				font-size: normal;
				padding-right: 20px;
				margin-left: 4%;
				margin-bottom: 2em;
				}
				th
				{
				font-weight: bold;
				}
				.results, .results th, .results td
				{
				border-collapse: collapse;
				border: 1px solid #000000;
				<!--border-left: none;
            border-right: none;-->
				vertical-align: middle;
				text-align: center;
				padding: 2px;
				font-family: verdana,arial,sans-serif;
				font-size: normal;
				padding-right: 20px;
				margin-left: 4%;
				margin-bottom: 2em;
				}
				
				
				td.checkboxon
				{
				background-color: white;
				border: 3px solid black;
				padding: 3px 3px;
				border-spacing: 5px;
				width: 20px;
				height: 28px;
				text-align: center;
				font-weight: bold;
				}
				td.checkboxoff
				{
				background-color: white;
				border: 3px solid black;
				padding: 3px 3px;
				border-spacing: 5px;
				width: 20px;
				}
				
				td.pass
				{
				background:#9BBB59;
				text-align:center;
				}
				td.fail
				{
				background:#C0504D;
				text-align:center;
				}
				td.notTested
				{
				background:#959595;
				text-align:center;
				}
				
				pre {
				white-space: pre-wrap;
				white-space: -moz-pre-wrap !important;
				word-wrap:break-word;
				}
				table tr:nth-child(2n+2) { background-color: #f4f4f4; }
				thead
				{
				display: table-header-group;
				font-weight: bold;
				background-color: #dedede;
				}
				div.title
				{
				text-align: center; font-size: xx-large; font-weight:bold;
				font-family: verdana,arial,sans-serif;
				margin-left: 8%; margin-right: 8%;
				}
				div.center
				{
				display: block; margin-left: auto; margin-right: auto; text-align:center;
				}
				div.bodytext
				{
				text-align: left; font-size: normal; font-weight: normal;
				font-family: verdana,arial,sans-serif;
				margin-left: 4%; margin-right: 12%;
				padding-bottom: 1em;
				}
				div.sectiontitle
				{
				text-align: left; font-size: x-large; font-weight:bold; 
				font-family: verdana,arial,sans-serif;
				margin-top: 2em;
				margin-left: 3em; 
				margin-right: 3em; 
				border-top: solid 2px gray;
				border-bottom: solid 2px gray;
				padding-bottom: 0.25em; padding-top: 0.25em;
				}
				div.reqelementtitle
				{
				overflow:auto; text-align: left; font-size: x-large; font-weight:bold; 
				font-family: verdana,arial,sans-serif;
				border-bottom: solid 2px gray;
				padding-bottom: 0.25em; padding-top: 0.25em;
				margin-bottom: 1em;
				}
				.reqelementtitletext
				{
				float: left;
				font-size: large; font-weight:bold; 
				font-family: verdana,arial,sans-serif;
				}
				.reqelementtitleppref
				{
				float: right;
				text-decoration: none;
				font-size: large; color: #666699;
				font-family: verdana,arial,sans-serif;
				}
				.reqelement
				{
				text-align: left; font-size: large; font-weight:bold; 
				font-family: verdana,arial,sans-serif;
				margin-top: 2em;
				padding-bottom: 0.25em; padding-top: 0.25em;
				margin-left: 5em; 
				margin-right: 3em; 
				}
				.vertical-text {
				display: inline-block;
				overflow: hidden;
				width: 1.5em;
				}
				.vertical-text__inner {
				display: inline-block;
				white-space: nowrap;
				line-height: 1.5;
				transform: translate(0,100%) rotate(-90deg);
				transform-origin: 0 0;
				vertical-align: top;
				}
				/* This element stretches the parent to be square
				by using the mechanics of vertical margins  */
				.vertical-text__inner:after {
				content: "";
				display: block;
				margin: -1.5em 0 100%;
				}
				span.tag {
				float:right;
				font-size: small;
				font-weight: bold;
				}
				span.taghidden {
					float:right;
					font-size: small;
					font-weight: bold;
					display: none;
				}
				
				a.abbr:link {color:black; text-decoration:none;}
				a.abbr:visited {color:black; text-decoration:none;}
				a.abbr:hover {color:blue; text-decoration:none;}
				a.abbr:hover:visited {color:purple; text-decoration:none;}
				a.abbr:active {color:red; text-decoration:none;}
				
				a.ppreflink:link {color:#666699; text-decoration:none;}
				a.ppreflink:visited {color:#666699; text-decoration:none;}
				a.ppreflink:hover {color:blue; text-decoration:none;}
				a.ppreflink:hover:visited {color:purple; text-decoration:none;}
				a.ppreflink:active {color:red; text-decoration:none;}
			</style>
			<title>App Vetting Reciprocity Report for 
			<xsl:value-of select="/rr:report/rr:appinfo/rr:name" /></title>
		</head>
			<body onLoad="init()">
				<h1 class="title">Mobile App Security Vetting Reciprocity Report Visualization - <i>Generated from Schema</i></h1>
				<div class="reqelement" style="margin-left:25%; margin-right:25%; ">
					<div class="reqelementtitle">
						<span class="reqelementtitletext">Application Information</span>
					</div>
					<table>
						<tr>
							<td>
								<b>App Name</b>
							</td>
							<td>
								<span><xsl:value-of select="/rr:report/rr:appinfo/rr:name"/></span><span class="taghidden">&lt;<xsl:value-of select="name(/rr:report/rr:appinfo/rr:name)"/>&gt;</span>
							</td>
						</tr>
						<tr>
							<td>
								<b>Description</b>
							</td>
							<td>
								<span style="float:left"><xsl:value-of select="/rr:report/rr:appinfo/rr:description"/></span><span class="taghidden">&lt;<xsl:value-of select="name(/rr:report/rr:appinfo/rr:description)"/>&gt;</span>
							</td>
						</tr>
						<tr>
							<td>
								<b>Category/Genre</b>
							</td>
							<td>
								<span><xsl:value-of select="/rr:report/rr:appinfo/rr:category"/></span><span class="taghidden">&lt;<xsl:value-of select="name(/rr:report/rr:appinfo/rr:category)"/>&gt;</span>
							</td>
						</tr>
						<tr>
							<td>
								<b>Application Type (Commercial/Government)</b>
							</td>
							<td>
								<span><xsl:value-of select="/rr:report/rr:appinfo/rr:apptype"/></span><span class="taghidden">&lt;<xsl:value-of select="name(/rr:report/rr:appinfo/rr:apptype)"/>&gt;</span>
							</td>
						</tr>
						<tr>
							<td>
								<b>URL/Filename</b>
							</td>
							<td>
								<span><xsl:value-of select="/rr:report/rr:appinfo/rr:filename"/></span><span class="taghidden">&lt;<xsl:value-of select="name(/rr:report/rr:appinfo/rr:filename)"/>&gt;</span>
							</td>
						</tr>
						<tr>
							<td>
								<b>App ID</b>
							</td>
							<!-- insert SWID tags in here, should those become a thing -->
							<td>
								<span><xsl:value-of
									select="/rr:report/rr:appinfo/rr:packageidentification"/></span><span class="taghidden">&lt;<xsl:value-of select="name(/rr:report/rr:appinfo/rr:packageidentification)"/>&gt;</span>
							</td>
						</tr>
						<tr>
							<td>
								<b>Version</b>
							</td>
							<td>
								<span><xsl:value-of select="/rr:report/rr:appinfo/rr:version"/></span><span class="taghidden">&lt;<xsl:value-of select="name(/rr:report/rr:appinfo/rr:version)"/>&gt;</span>
							</td>
						</tr>
						<tr>
							<td>
								<b>SHA1 hash of package</b>
							</td>
							<td>
								<span><xsl:value-of select="/rr:report/rr:appinfo/rr:hash"/></span><span class="taghidden">&lt;<xsl:value-of select="name(/rr:report/rr:appinfo/rr:hash)"/>&gt;</span>
							</td>
						</tr>
						<tr>
							<td>
								<b>Hash of package signature</b>
							</td>
							<td>
								<span><xsl:value-of select="/rr:report/rr:appinfo/rr:signature"/></span><span class="taghidden">&lt;<xsl:value-of select="name(/rr:report/rr:appinfo/rr:signature)"/>&gt;</span>
							</td>
						</tr>
						<tr>
							<td>
								<b>OS Platform and Version</b>
							</td>
							<td>
								<span><xsl:value-of select="/rr:report/rr:appinfo/rr:platform"/></span><span class="taghidden">&lt;<xsl:value-of select="name(/rr:report/rr:appinfo/rr:platform)"/>&gt;</span>
								
							</td>
						</tr>
						<tr>
							<td>
								<b>Vendor</b>
							</td>
							<td><span>
								<xsl:value-of select="/rr:report/rr:appinfo/rr:vendor/rr:name"/>
								<p/>
								<xsl:value-of
									select="/rr:report/rr:appinfo/rr:vendor/rr:address/rr:street1"/>
								<p/>
								<xsl:value-of
									select="/rr:report/rr:appinfo/rr:vendor/rr:address/rr:street2"/>
								<p/>
								<xsl:value-of
									select="/rr:report/rr:appinfo/rr:vendor/rr:address/rr:city"/>
								<xsl:text>, </xsl:text>
								<xsl:value-of
									select="/rr:report/rr:appinfo/rr:vendor/rr:address/rr:state"/>
								<xsl:text> </xsl:text>
								<xsl:value-of
									select="/rr:report/rr:appinfo/rr:vendor/rr:address/rr:postalcode"/>
								<p/>
								<xsl:value-of
									select="/rr:report/rr:appinfo/rr:vendor/rr:address/rr:country"
								/>
							</span><span class="taghidden">&lt;<xsl:value-of select="name(/rr:report/rr:appinfo/rr:vendor)"/>&gt;</span>
							</td>
						</tr>

					</table>
				</div>
				
				<div class="reqelement" style="margin-left:25%; margin-right:25%; ">
					<div class="reqelementtitle">
						<span class="reqelementtitletext">Application Tester</span>
					</div>
					<table>
						<tr>
							<td>
								<b>Name</b>
							</td>
							<td>
								<span><xsl:value-of select="/rr:report/rr:apptester/rr:name"/></span><span class="taghidden">&lt;<xsl:value-of select="name(/rr:report/rr:apptester/rr:name)"/>&gt;</span>
							</td>
						</tr>
						<tr>
							<td>
								<b>E-mail</b>
							</td>
							<td>
								<span><xsl:value-of select="/rr:report/rr:apptester/rr:email"/></span><span class="taghidden">&lt;<xsl:value-of select="name(/rr:report/rr:apptester/rr:email)"/>&gt;</span>
							</td>
						</tr>
						<tr>
							<td>
								<b>Organization</b>
							</td>
							<td>
								<span><xsl:value-of select="/rr:report/rr:apptester/rr:organization"/></span><span class="taghidden">&lt;<xsl:value-of select="name(/rr:report/rr:apptester/rr:organization)"/>&gt;</span>
							</td>
						</tr>
						<tr>
							<td>
								<b>Date(s) App Tested</b>
							</td>
							<td>
								<span><xsl:value-of select="/rr:report/rr:apptester/rr:datestested"/></span><span class="taghidden">&lt;<xsl:value-of select="name(/rr:report/rr:apptester/rr:datestested)"/>&gt;</span>
							</td>
						</tr>
					</table>
				</div>
				
				<div class="reqelement" style="margin-left:25%; margin-right:25%; ">
					<div class="reqelementtitle">
						<span class="reqelementtitletext">Analysis Tools Used</span>
					</div>
					<table>
						<tr>
							<th>Tool</th>
							<th>Tool Description</th>
							<th>Notes</th>
						</tr>
						<xsl:for-each select="/rr:report/rr:analysistools/rr:analysistool">
							<xsl:call-template name="analysistool"/>
						</xsl:for-each>
					</table>
				</div>
				
				<div class="reqelement" style="margin-left:25%; margin-right:25%; ">
					<div class="reqelementtitle">
						<span class="reqelementtitletext">Other Analyses Performed</span>
					</div>
					<table>
						<tr>
							<td>
								<b>FIPS Certificate</b>
							</td>
							<td>
								<span><xsl:value-of select="/rr:report/rr:productcertifications/rr:fips"/></span><span class="taghidden">&lt;<xsl:value-of select="name(/rr:report/rr:productcertifications/rr:fips)"/>&gt;</span>
							</td>
						</tr>
						<tr>
							<td>
								<b>Common Criteria Certificate</b>
							</td>
							<td>
								<span><xsl:value-of select="/rr:report/rr:productcertifications/rr:niap"/></span><span class="taghidden">&lt;<xsl:value-of select="name(/rr:report/rr:productcertifications/rr:niap)"/>&gt;</span>
							</td>
						</tr>
						<tr>
							<td>
								<b>Supply Chain Risk Analysis</b>
							</td>
							<td>
								<span><xsl:value-of select="/rr:report/rr:supplychain/rr:riskassessment"/></span><span class="taghidden">&lt;<xsl:value-of select="name(/rr:report/rr:supplychain/rr:riskassessment)"/>&gt;</span>
							</td>
						</tr>
					</table>
				</div>
				
				<div class="reqelement" style="margin-left:25%; margin-right:25%; ">
					<div class="reqelementtitle">
						<span class="reqelementtitletext">Test Summary and Analyst Notes</span>
					</div>
					<table>
						<th>
							Test Summary and Analyst Notes:
						</th>
						<tr>
							<td><span><xsl:value-of select="/rr:report/rr:analystnotes/rr:summary"/></span><span class="taghidden">&lt;<xsl:value-of select="name(/rr:report/rr:analystnotes/rr:summary)"/>&gt;</span></td>
						</tr>
					</table>

					<table>
						<th>
							Analyst's Concerns and Mitigation Recommendations:
						</th>
						<tr>
							<td><span><xsl:value-of select="/rr:report/rr:analystnotes/rr:concerns"/></span><span class="taghidden">&lt;<xsl:value-of select="name(/rr:report/rr:analystnotes/rr:concerns)"/>&gt;</span></td>
						</tr>
					</table>
				</div>
				
				<div class="sectiontitle">How To Use This Document</div>
				<div class="reqelement">
					<div class="bodytext">
								The following sections of this document are organized according to
								security functionality classes found in the Common Criteria, which
								are used in the 
								<a href="https://www.niap-ccevs.org/pp/PP_APP_v1.1/">Application Software Protection Profile</a>
								and many other security
								requirements documents.  Each heading refers to
								security functionality classes used in the Common Criteria, around which individual 
								requirements or analyses
								can be organized.  Example are User Data Protection and Trusted Communication
								Paths.  Within each individual section,
								 data gathered by a tool or analyst is first presented.  This is shown
								 in order to provide evidence about how the program achieves each security 
								 functionality.  Next,
								each section lists the relevant <b>Results</b> that is, the analysis carried 
								out on this data, along with the analyst's determinations.
					</div>
				</div>


				<div class="sectiontitle"> User Data Protection </div>

				<div class="reqelement">
					<div class="reqelementtitle">
						<span class="reqelementtitletext">Access to Hardware Resources</span>
						<span class="reqelementtitleppref">
							<a class="ppreflink"
								href="https://www.niap-ccevs.org/pp/pp_app_v1.1_table.htm#FDP_DEC_EXT.1.1"
								>FDP_DEC_EXT.1.1</a>
						</span>
					</div>
					<div class="bodytext">
					The application accesses (or seeks permission to access) the following hardware resources:
						<table>
							<tr>
								<th>Hardware Resource</th>
								<th>Accessed by App</th>
							</tr>
							<tr>
								<td>
									Camera
								</td>
								<td>
									<xsl:call-template name="checkmark">
										<xsl:with-param name="check">
											<xsl:value-of select="/rr:report/rr:hardwareresources/rr:camera/rr:useraware"/>
										</xsl:with-param>
									</xsl:call-template>
								</td>
							</tr>
							<tr>
								<td>
									Microphone
								</td>
								<td>
									<xsl:call-template name="checkmark">
										<xsl:with-param name="check">
											<xsl:value-of select="/rr:report/rr:hardwareresources/rr:microphone/rr:useraware"/>
										</xsl:with-param>
									</xsl:call-template>
								</td>
							</tr>
							<tr>
								<td>
									Location Services
								</td>
								<td>
									<xsl:call-template name="checkmark">
										<xsl:with-param name="check">
											<xsl:value-of select="/rr:report/rr:hardwareresources/rr:locationservices/rr:useraware"/>
										</xsl:with-param>
									</xsl:call-template>
								</td>
							</tr>
							<tr>
								<td>
									NFC
								</td>
								<td>
									<xsl:call-template name="checkmark">
										<xsl:with-param name="check">
											<xsl:value-of select="/rr:report/rr:hardwareresources/rr:nfc/rr:useraware"/>
										</xsl:with-param>
									</xsl:call-template>
								</td>
							</tr>
							<tr>
								<td>
									Bluetooth
								</td>
								<td>
									<xsl:call-template name="checkmark">
										<xsl:with-param name="check">
											<xsl:value-of select="/rr:report/rr:hardwareresources/rr:bluetooth/rr:useraware"/>
										</xsl:with-param>
									</xsl:call-template>
								</td>
							</tr>
							<xsl:for-each select="/rr:report/rr:hardwareresources/rr:other/rr:resource">
								<tr>
									<td>
										<xsl:value-of select="rr:name"/>
									</td>
									<td>
										<xsl:call-template name="checkmark">
											<xsl:with-param name="check">
												<xsl:value-of select="rr:useraware"/>
											</xsl:with-param>
										</xsl:call-template>
									</td>
								</tr>
							</xsl:for-each>
						</table>
						<b>Results:</b>

						<xsl:apply-templates select="/rr:report/rr:hardwareresources/rr:results"/>


					</div>
				</div>
				<div class="reqelement">
					<div class="reqelementtitle">
						<span class="reqelementtitletext">Access to Sensitive Information
							Repositories</span>
						<span class="reqelementtitleppref">
							<a class="ppreflink"
								href="https://www.niap-ccevs.org/pp/pp_app_v1.1_table.htm#FDP_DEC_EXT.1.2"
								>FDP_DEC_EXT.1.2</a>
						</span>
					</div>
					<div class="bodytext">
					The application accesses (or seeks permission to access) the following sensitive information repositories:
						<table>
							<tr>
								<th>Repository</th>
								<th>Accessed by App</th>
							</tr>
							<tr>
								<td>
									Address Book
								</td>
								<td>
									<xsl:call-template name="checkmark">
										<xsl:with-param name="check">
											<xsl:value-of select="/rr:report/rr:inforepositories/rr:addressbook/rr:useraware"/>
										</xsl:with-param>
									</xsl:call-template>
								</td>
							</tr>
							<tr>
								<td>
									Calendar
								</td>
								<td>
									<xsl:call-template name="checkmark">
										<xsl:with-param name="check">
											<xsl:value-of select="/rr:report/rr:inforepositories/rr:calendar/rr:useraware"/>
										</xsl:with-param>
									</xsl:call-template>
								</td>
							</tr>
							<tr>
								<td>
									Call Lists
								</td>
								<td>
									<xsl:call-template name="checkmark">
										<xsl:with-param name="check">
											<xsl:value-of select="/rr:report/rr:inforepositories/rr:calllist/rr:useraware"/>
										</xsl:with-param>
									</xsl:call-template>
								</td>
							</tr>
							<tr>
								<td>
									System Logs
								</td>
								<td>
									<xsl:call-template name="checkmark">
										<xsl:with-param name="check">
											<xsl:value-of select="/rr:report/rr:inforepositories/rr:systemlogs/rr:useraware"/>
										</xsl:with-param>
									</xsl:call-template>
								</td>
							</tr>
							<xsl:for-each select="/rr:report/rr:inforepositories/rr:other/rr:resource">
								<tr>
									<td>
										<xsl:value-of select="rr:name"/>
									</td>
									<td>
										<xsl:call-template name="checkmark">
											<xsl:with-param name="check">
												<xsl:value-of select="rr:useraware"/>
											</xsl:with-param>
										</xsl:call-template>
									</td>
								</tr>
							</xsl:for-each>
						</table>
						<b>Results:</b>
						<xsl:apply-templates select="/rr:report/rr:inforepositories/rr:results"/>

					</div>
				</div>

				<div class="reqelement">
					<div class="reqelementtitle">
						<span class="reqelementtitletext">Sensitive Application Data</span>
						<span class="reqelementtitleppref">
								<a class="ppreflink" href="https://www.niap-ccevs.org/pp/pp_app_v1.1_table.htm#FDP_DAR_EXT.1.1">FDP_DAR_EXT.1.1</a>
						</span>
					</div>
					<div class="bodytext">
					The application writes the following data files:
						<table>
							<tr>
								<th>Data File</th>
								<th>Encryption</th>
							</tr>
							<xsl:for-each select="/rr:report/rr:filesencrypted/rr:files/rr:file">
									<tr>
										<td> <xsl:value-of select="rr:path"/> </td>
										<td> <xsl:value-of select="rr:encryption"/> </td>
									</tr>
							</xsl:for-each>
						</table>					
						<b>Results:</b>
						<xsl:apply-templates select="/rr:report/rr:filesencrypted/rr:results"/>

					</div>
				</div>


				<div class="reqelement">
					<div class="reqelementtitle">
						<span class="reqelementtitletext">Network Communication</span>
						<span class="reqelementtitleppref">
							<a class="ppreflink"
								href="https://www.niap-ccevs.org/pp/pp_app_v1.1_table.htm#FDP_DEC_EXT.1.4"
								>FDP_DEC_EXT.1.4</a>
						</span>
					</div>
					<div class="bodytext">
						<p>Application-initiated communications to external sites, services or networks:</p>
						<table>
							<tr>
								<th>
									<b>Host IP Address</b>
								</th>
								<th>
									<b>Port</b>
								</th>
								<th>
									<b>Hostname</b>
								</th>
								<th>
									<b>Protocol</b>
								</th>
							</tr>
							<xsl:for-each select="//rr:networkcomms/rr:appinitiatedconnections">
								<xsl:for-each select="rr:host">
	
									<tr>
										<td>
											<xsl:value-of select="rr:ipaddr"/>
										</td>
										<td>
											<xsl:value-of select="rr:port"/>
										</td>
										<td>
											<xsl:value-of select="rr:hostname"/>
										</td>
										<td>
											<xsl:value-of select="rr:protocol"/>
										</td>
									</tr>
								</xsl:for-each>
							</xsl:for-each>
						</table>
						<p>Remotely-initiated network communications (i.e. communications initiated from remote locations):</p>
						<table>
							<tr>
								<th>
									<b>Host IP Address</b>
								</th>
								<th>
									<b>Port</b>
								</th>
								<th>
									<b>Hostname</b>
								</th>
								<th>
									<b>Protocol</b>
								</th>
							</tr>
							<xsl:for-each select="/rr:report/rr:networkcomms/rr:remotelyinitiatedconnections">
								<xsl:for-each select="rr:host">
									
									<tr>
										<td> <xsl:value-of select="rr:ipaddr"/> </td>
										<td> <xsl:value-of select="rr:port"/> </td>
										<td> <xsl:value-of select="rr:hostname"/> </td>
										<td> <xsl:value-of select="rr:protocol"/> </td>
									</tr>
								</xsl:for-each>
							</xsl:for-each>
						</table>
						<b>Results:</b>
						<xsl:apply-templates select="/rr:report/rr:networkcomms/rr:results"/>

					</div>
				</div>

				<div class="sectiontitle">Trusted Communication Path/Channels</div>
				<div class="reqelement">
					<div class="reqelementtitle">
						<span class="reqelementtitletext">Protecting Data in Transit</span>
						<span class="reqelementtitleppref">
							<a class="ppreflink"
								href="https://www.niap-ccevs.org/pp/pp_app_v1.1_table.htm#FDP_DEC_EXT.1.4"
								>FDP_DEC_EXT.1.4</a>
						</span>
					</div>
					<div class="bodytext">
						<b>Results:</b>
						<xsl:apply-templates select="/rr:report/rr:networkcommsprotection/rr:results"/>
					</div>
				</div>

				<div class="sectiontitle">Security Configuration and Management</div>
				<div class="reqelement">
					<div class="reqelementtitle">
						<span class="reqelementtitletext">Default Credentials</span>
						<span class="reqelementtitleppref">
							<a class="ppreflink"
								href="https://www.niap-ccevs.org/pp/pp_app_v1.1_table.htm#FMT_CFG_EXT.1.1"
								>FMT_CFG_EXT.1.1</a>
						</span>
					</div>
					<div class="bodytext">
						<b>Results:</b>
						<xsl:apply-templates select="/rr:report/rr:defaultcreds/rr:results"/>
					</div>

					<div class="reqelementtitle">
						<span class="reqelementtitletext">File Permissions</span>
						<span class="reqelementtitleppref">
							<a class="ppreflink"
								href="https://www.niap-ccevs.org/pp/pp_app_v1.1_table.htm#FMT_CFG_EXT.1.2"
								>FMT_CFG_EXT.1.2</a>
						</span>
					</div>
					<div class="bodytext">
					The application writes the following files to local media, including removable storage:
						<table>
							<tr>
								<th>File</th>
								<th>Permissions</th>
							</tr>
							<xsl:for-each select="/rr:report/rr:files/rr:file">
									<tr>
										<td>
											<xsl:value-of select="rr:path"/>
										</td>
										<td>
											<xsl:value-of select="rr:permissions"/>
										</td>
									</tr>
							</xsl:for-each>
						</table>					
						<b>Results:</b>
						<xsl:apply-templates select="/rr:report/rr:files/rr:results"/>

					</div>
					
				</div>


				<!--
				<div class="reqelement">
					<div class="reqelementtitle">
						<span class="reqelementtitletext">Management Functions</span>
						<span class="reqelementtitleppref">
							<a class="ppreflink"
								href="https://www.niap-ccevs.org/pp/pp_app_v1.1_table.htm#FMT_SMF.1.1"
								>FMT_SMF.1.1</a>
						</span>
					</div>
					<div class="bodytext">
						<p>The application is capable of:</p>
						<table>
							<tr>
								<td>no management functions</td>
								<td></td>
							</tr>
							<tr>
								<td>enable/disable the transmission of any information describing the system's hardware, software, or configuration</td>
							 	<td></td>
							</tr>
							<tr>
								<td>enable/disable the transmission of any PII</td>
								<td></td>
							</tr>
							 <tr>
							 	<td>enable/disable transmission of any application state (e.g. crashdump) information</td>
							 	<td></td>
							 </tr>
							<tr>
								<td>enable/disable network backup functionality to: </td>
								<td></td>
							</tr>
							<tr>
								<td>enable/disable transmission of user location information used by the application</td>
								<td></td>
							</tr>
						</table>
						<b>Results:</b>
						<xsl:apply-templates select="/rr:report/rr:hardwareresources/rr:results"/>

					</div>
					
				</div>
-->

<!--
				<div class="sectiontitle">Cryptographic Support</div>
				<div class="reqelement">
					<div class="reqelementtitle">
						<span class="reqelementtitletext">Random Bit Generation Service</span>
						<span class="reqelementtitleppref">
							<a class="ppreflink" href="https://www.niap-ccevs.org/pp/pp_app_v1.1_table.htm#FCS_RBG_EXT.1.1">FCS_RBG_EXT.1.1</a>
						</span>
					</div>
					<div class="bodytext">
						<p>The application shall invoke platform-provided deterministic random bit generation (DRBG) functionality for its cryptographic operations.</p>
						<b>Results:</b>
						<xsl:apply-templates select="/rr:report/rr:hardwareresources/rr:results"/>

					</div>
				</div>
-->
				<div class="sectiontitle">Protection of Security Functionality and Integrity</div>
				
				<div class="reqelement">
					<div class="reqelementtitle">
						<span class="reqelementtitletext">Use of Supported Services and APIs</span>
						<span class="reqelementtitleppref">
							<a class="ppreflink" href="https://www.niap-ccevs.org/pp/pp_app_v1.1_table.htm#FPT_API_EXT.1.1">FPT_API_EXT.1.1</a>
						</span>
					</div>

					<div class="bodytext">
					The application uses the following services and APIs:
						<table>
							<tr>
								<th>API</th>
								<th>SDK</th>
							</tr>
							<xsl:for-each select="/rr:report/rr:supportedapis/rr:apis/rr:api">
								<tr>
									<td>
										<xsl:value-of select="rr:api"/>
									</td>
									<td>
										<xsl:value-of select="rr:sdk"/>
									</td>
								</tr>
							</xsl:for-each>
						</table>

						<b>Results:</b>
						<xsl:apply-templates select="/rr:report/rr:supportedapis/rr:results"/>

					</div>
				</div>
			
				<div class="reqelement">
					<div class="reqelementtitle">
						<span class="reqelementtitletext">Anti-Exploitation Capabilities</span>
						<span class="reqelementtitleppref">
							<a class="ppreflink" href="https://www.niap-ccevs.org/pp/pp_app_v1.1_table.htm#FPT_AEX_EXT.1.3">FPT_AEX_EXT.1.3</a>
						</span>
					</div>
					<div class="bodytext">
						<b>Results:</b>
						<xsl:apply-templates select="/rr:report/rr:antiexploitcompatible/rr:results"/>

					</div>
				</div>

				<div class="reqelement">
					<div class="reqelementtitle">
						<span class="reqelementtitletext">Third Party Libraries</span>
						<span class="reqelementtitleppref">
							<a class="ppreflink"
								href="https://www.niap-ccevs.org/pp/pp_app_v1.1_table.htm#FPT_LIB_EXT.1.1"
								>FPT_LIB_EXT.1.1</a>
						</span>
					</div>
					<div class="bodytext">
						<p>The application is packaged with the following third-party libraries:</p>
						<table>
							<tr>
								<th>Library Name</th>
								<th>Version</th>
								<th>Notes</th>
							</tr>
							<xsl:call-template name="library"></xsl:call-template>
						</table>
						<b>Results:</b>
						<xsl:apply-templates select="/rr:report/rr:libraries/rr:results"/>

					</div>

				</div>


				<div class="reqelement">
					<div class="reqelementtitle">
						<span class="reqelementtitletext">Untrusted Updates to Binary Code</span>
						<span class="reqelementtitleppref">
							<a class="ppreflink"
								href="https://www.niap-ccevs.org/pp/pp_app_v1.1_table.htm#FPT_TUD_EXT.1.4"
								>FPT_TUD_EXT.1.4</a>
						</span>
					</div>
					<div class="bodytext">
					The application writes or overwrites the following executable files after initial installation:
						<table>
							<tr>
								<th>Executable File</th>
								<th>Metadata</th>
							</tr>
							<xsl:for-each select="//rr:untrustedupdate">
								<xsl:for-each select="rr:file">
									<tr>
										<td>
											<xsl:value-of select="rr:path"/>
										</td>
										<td>
											<table>
												<tr>
													<td style="text-align:right; font-weight: bold;">Old
													Hash:</td>
													<td>
													<xsl:value-of select="rr:originalfilehash"/>
													</td>
												</tr>
												<tr>
													<td style="text-align:right; font-weight: bold;">New
													Hash:</td>
													<td>
													<xsl:value-of select="rr:newfilehash"/>
													</td>
												</tr>
												<tr>
													<td style="text-align:right; font-weight: bold;"
													>Source:</td>
													<td>
													<xsl:value-of select="rr:source"/>
													</td>
												</tr>
											</table>
										</td>
									</tr>
								</xsl:for-each>
							</xsl:for-each>
						</table>
						<b>Results:</b>
						<xsl:apply-templates select="/rr:report/rr:untrustedupdate/rr:results"/>

					</div>
				</div>


				<div class="sectiontitle">Vulnerability Assessment</div>
				<div class="reqelement">
					<div class="reqelementtitle">
						<span class="reqelementtitletext">Suitability for Testing</span>
						<span class="reqelementtitleppref">
								<a class="ppreflink" href="https://www.niap-ccevs.org/pp/pp_app_v1.1_table.htm#AVA_VAN_EXT.1.2C">AVA_VAN.1.2C</a>
						</span>
					</div>
					<div class="bodytext">
						<b>Results:</b>
						<xsl:apply-templates select="/rr:report/rr:suitability/rr:results"/>

					</div>

					<div class="reqelementtitle">
						<span class="reqelementtitletext">Vulnerability Survey</span>
						<span class="reqelementtitleppref">
								<a class="ppreflink" href="https://www.niap-ccevs.org/pp/pp_app_v1.1_table.htm#AVA_VAN_EXT.1.2E">AVA_VAN.1.2E</a>
						</span>
					</div>
					<div class="bodytext">
						<b>Results:</b>
						<xsl:apply-templates select="/rr:report/rr:vulnsurvey/rr:results"/>

					</div>
				</div>

<!--
					<div class="reqelementtitle">
						<span class="reqelementtitletext">Discussion Area</span>
					</div>
					<table class="results">
						<tr>
							<th>Criteria</th>
							<th>Notes</th>
						</tr>


						<tr>
							<td>
								Does the application write data to persistent memory accessible to other applications?<ul><li>List the shared file locations where the application write data to persistent memory</li></ul>
							</td>
							<td>This is handled by File Permissions - FMT_CFG_EXT.1.2.
							</td>
						</tr>
						<tr>
							<td>
								Encrypts sensitive data (including credentials) stored off the device (e.g., removable media, Cloud Storage, Remote Access Sessions, etc.).
							</td>
							<td>
							</td>
						</tr>
						<tr>
							<td>
								Sensitive data stored off the device is encrypted with FIPS 140-2 validated algorithms/modules.<ul><li>List encryption algorithms/modules used to encrypt data stored off the device</li></ul>
							</td>
							<td>This is out of scope.
							</td>
						</tr>

						<tr>
							<td>
								Does the behavior of encryption in transit change over different methods of communication? (i.e. Wi-Fi communications are encrypted but Cellular communications are not)<ul><li>List which communication channels were tested</li><li>If the app fails this test, provide information on how it fails</li></ul>
							</td>
							<td>This would be very odd/unlikely behavior.  Most apps are entirely unaware of the underlying transport, by design.
							</td>
						</tr>
						<tr>
							<td>
								Does the app perform certificate pinning?
							</td>
							<td>Do we have a specific use case, for where we want to require this?  If not, it's hard to demand it generally.
							</td>
						</tr>
						<tr>
							<td>List the identity services used for
							authentication to access sensitive data<ul><li>List
							the identity services used for authentication to
							access sensitive data</li><li>Are the
							authentication methods prioritized (i.e. biometric
							is used before pin)</li><li>Provide the level of
							Assurance (LOA) of thr
							authentication
							</li>
							</ul>
							</td>
							<td>Exact LOA depends upon what the underlying platform is using for storage - embedded hardware token, 
							UICC, SDcard, software module, hardware-backed storage.  This will vary by platform (indeed, by platform version) 
							and so it cannot be determined during app vetting.  
							</td>
						</tr>
						<tr>
							<td>
								Requires authentication to store sensitive data on the mobile device
							</td>
							<td>This is handled by platform settings.  Apps cannot generally query whether the platform has password-protection enabled.
							</td>
						</tr>

						<tr>
							<td>
								Does the App come with a crash reporting capability? (i.e. Does the app use something similar to Crashlytics)<ul><li>List crash reporting tool(s) used by the App</li><li>List remote locations where crash logs are sent</li></ul>
							</td>
							<td>Isn't the actual security goal to ensure that 3rd-party libraries are inventoried, and that files/logs do not
							contain sensitive information?
							</td>
						</tr>

						<tr>
							<td>Audit logs capture security information</td>
							<td>This is extremely difficult to define.</td>
						</tr>
						<tr>
							<td>
								Audit logs containing sensitive information are encrypted
							</td>
							<td>This can be put as part of analysis under Sensitive Application Data FDP_DAR_EXT.1.1.
							</td>
						</tr>
						<tr>
							<td>
								The Application does not log location information<p>List location information that is logged</p>
							</td>
							<td>This can be put as part of analysis under Sensitive Application Data FDP_DAR_EXT.1.1.
							</td>
						</tr>
					</table>
			-->	

			</body>
		</html>
	</xsl:template>


	<xsl:template match="rr:results">
		<table class="results">
			<tr>
				<th colspan="3">Determination</th>
				<th rowspan="2">Hypothesis</th>
				<th rowspan="2">Analysis</th>
			</tr>

			<tr style="font-size:small; font-weight:bold; text-align:center;"><td style="background:#9BBB59;"><div><i>Yes</i></div></td><td style="background:#C0504D;"><div><i>No</i></div></td><td style="background:#959595;"><div><i>Not Tested</i></div></td></tr>
			<xsl:for-each select="rr:result">
			<tr>
				<xsl:call-template name="determination">
					<xsl:with-param name="determination">
						<xsl:value-of select="rr:determination"/>
					</xsl:with-param>
				</xsl:call-template>
				<td style="text-align:left;"><xsl:value-of select="rr:analysis"/></td>
				<td style="text-align:left;"><xsl:value-of select="rr:notes"/></td>
			</tr>
			</xsl:for-each>
		</table>
	</xsl:template>

	<xsl:template match="cc:title">
	      		<xsl:apply-templates />
	</xsl:template>


	<!-- getting rid of XHTML namespace -->
	<xsl:template match="xhtml:*">
		<xsl:element name="{local-name()}">
 			<xsl:apply-templates select="node()|@*"/>
		</xsl:element>
	</xsl:template>

	
	<xsl:template name="analysistool">
	<tr>
		<td><span><xsl:value-of select="rr:name"/></span><span class="taghidden">&lt;<xsl:value-of select="name(rr:name)"/>&gt;</span></td>
		<td><span><xsl:value-of select="rr:description"/></span><span class="taghidden">&lt;<xsl:value-of select="name(rr:description)"/>&gt;</span></td>
		<td><span><xsl:value-of select="rr:note"/></span><span class="taghidden">&lt;<xsl:value-of select="name(rr:note)"/>&gt;</span></td>
	</tr>
	</xsl:template>
	
	<xsl:template name="checkmark">
		<xsl:param name="check"/>
		<xsl:choose>
			<xsl:when test="$check='yes'">
				&#10004;
			</xsl:when>
			<xsl:when test="$check='no'">
				&#10008;
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template name="permissions">
		<xsl:for-each select="/rr:report/rr:excessprivileges/rr:privilege">
			<tr>
				<td><xsl:value-of select="rr:name"/></td>
			</tr>
		</xsl:for-each>
	</xsl:template>
	
	<xsl:template name="determination">
		<xsl:param name="determination"/>
		<xsl:choose>
			<xsl:when test="$determination='Passed'" >
				<td class="pass">
					&#10004;
				</td>
				<td class="fail"/>
				<td class="notTested"/>
			</xsl:when>
			<xsl:when test="$determination='Failed'">
				<td class="pass"/>
				<td class="fail">
					&#10004;
				</td>
				<td class="notTested"/>
			</xsl:when>
			<xsl:when test="$determination='Not Tested'">
				<td class="pass"/>
				<td class="fail"/>
				<td class="notTested">
					&#10004;
				</td>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template name="library">
		<xsl:for-each select="/rr:report/rr:libraries/rr:library">
			<tr>
				<td><xsl:value-of select="rr:name"/></td>
				<td><xsl:value-of select="rr:version"/></td>
				<td><xsl:value-of select="rr:analysis/rr:note"/></td>
			</tr>
		</xsl:for-each>
	</xsl:template>
	
</xsl:stylesheet>
