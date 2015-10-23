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

		<head>
			<title>App Vetting Reciprocity Report for 
			<xsl:value-of select="/rr:report/rr:appinfo/rr:name" /></title>
		</head>
			<body>
				<h1 class="title">Mobile App Security Vetting Reciprocity Report Visualization</h1>
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
								<xsl:value-of select="/rr:report/rr:appinfo/rr:name"/>
							</td>
						</tr>
						<tr>
							<td>
								<b>Description</b>
							</td>
							<td>
								<xsl:value-of select="/rr:report/rr:appinfo/rr:description"/>
							</td>
						</tr>
						<tr>
							<td>
								<b>Category/Genre</b>
							</td>
							<td>
								<xsl:value-of select="/rr:report/rr:appinfo/rr:category"/>
							</td>
						</tr>
						<tr>
							<td>
								<b>Application Type (Commercial/Government)</b>
							</td>
							<td>
								<xsl:value-of select="/rr:report/rr:appinfo/rr:apptype"/>
							</td>
						</tr>
						<tr>
							<td>
								<b>URL/Filename</b>
							</td>
							<td>
								<xsl:value-of select="/rr:report/rr:appinfo/rr:filename"/>
							</td>
						</tr>
						<tr>
							<td>
								<b>App ID</b>
							</td>
							<!-- insert SWID tags in here, should those become a thing -->
							<td>
								<xsl:value-of
									select="/rr:report/rr:appinfo/rr:packageidentification"/>
							</td>
						</tr>
						<tr>
							<td>
								<b>Version</b>
							</td>
							<td>
								<xsl:value-of select="/rr:report/rr:appinfo/rr:version"/>
							</td>
						</tr>
						<tr>
							<td>
								<b>SHA1 hash of package</b>
							</td>
							<td>
								<xsl:value-of select="/rr:report/rr:appinfo/rr:hash"/>
							</td>
						</tr>
						<tr>
							<td>
								<b>Hash of package signature</b>
							</td>
							<td>
								<xsl:value-of select="/rr:report/rr:appinfo/rr:signature"/>
							</td>
						</tr>
						<tr>
							<td>
								<b>OS Platform and Version</b>
							</td>
							<td>
								<xsl:apply-templates select="/rr:report/rr:appinfo/rr:platform"
								/>
							</td>
						</tr>
						<tr>
							<td>
								<b>Vendor</b>
							</td>
							<td>
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
								<xsl:value-of select="/rr:report/rr:apptester/rr:name"/>
							</td>
						</tr>
						<tr>
							<td>
								<b>E-mail</b>
							</td>
							<td>
								<xsl:value-of select="/rr:report/rr:apptester/rr:email"/>
							</td>
						</tr>
						<tr>
							<td>
								<b>Organization</b>
							</td>
							<td>
								<xsl:value-of select="/rr:report/rr:apptester/rr:organization"/>
							</td>
						</tr>
						<tr>
							<td>
								<b>Date(s) App Tested</b>
							</td>
							<td>
								<xsl:value-of select="/rr:report/rr:apptester/rr:datestested"/>
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
								<xsl:value-of select="/rr:report/rr:productcertifications/rr:fips"/>
							</td>
						</tr>
						<tr>
							<td>
								<b>Common Criteria Certificate</b>
							</td>
							<td>
								<xsl:value-of select="/rr:report/rr:productcertifications/rr:niap"/>
							</td>
						</tr>
						<tr>
							<td>
								<b>Supply Chain Risk Analysis</b>
							</td>
							<td>
								<xsl:value-of select="/rr:report/rr:supplychain/rr:riskassessment"/>
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
							<td><xsl:value-of select="/rr:report/rr:analystnotes/rr:summary"/></td>
						</tr>
					</table>

					<table>
						<th>
							Analyst's Concerns and Mitigation Recommendations:
						</th>
						<tr>
							<td><xsl:value-of select="/rr:report/rr:analystnotes/rr:concerns"/></td>
						</tr>
					</table>
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
						<span class="reqelementtitletext">File Permissions</span>
						<span class="reqelementtitleppref">
							<a class="ppreflink"
								href="https://www.niap-ccevs.org/pp/pp_app_v1.1_table.htm#FMT_CFG_EXT.1.2"
								>FMT_CFG_EXT.1.2</a>
						</span>
					</div>
					<div class="bodytext">
						<table>
							<tr>
								<th>File</th>
								<th>Permissions</th>
							</tr>
							<xsl:for-each select="//rr:files">
								<xsl:for-each select="rr:file">
	
									<tr>
										<td>
											<xsl:value-of select="rr:path"/>
										</td>
										<td>
											<xsl:value-of select="rr:permissions"/>
										</td>
									</tr>
								</xsl:for-each>
							</xsl:for-each>
						</table>					
						<b>Results:</b>
						<xsl:apply-templates select="/rr:report/rr:files/rr:results"/>

					</div>
					
				</div>
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

				<div class="sectiontitle">Protection of Security Functionality and Integrity</div>
				
				<div class="reqelement">
					<div class="reqelementtitle">
						<span class="reqelementtitletext">Use of Supported Services and APIs</span>
						<span class="reqelementtitleppref">
							<a class="ppreflink" href="https://www.niap-ccevs.org/pp/pp_app_v1.1_table.htm#FPT_API_EXT.1.1">FPT_API_EXT.1.1</a>
						</span>
					</div>

					<div class="bodytext">
						<table>
							<tr>
								<th>API</th>
								<th>SDK</th>
							</tr>
							<xsl:for-each select="/rr:report/rr:supportedAPIs/rr:apis/rr:api">
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
						<xsl:apply-templates select="/rr:report/rr:hardwareresources/rr:results"/>

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
						<p>The application shall be compatible with security features provided by the platform vendor.</p>
						<p><b>Application Note:</b> This requirement is designed to ensure that platform security features do not need to be disabled in order for the application to run.</p>
						<b>Results:</b>
						<xsl:apply-templates select="/rr:report/rr:hardwareresources/rr:results"/>

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
							<tr>
								<td>OpenSSL</td>
								<td>1.0.1f</td>
								<td>What could possibly go wrong?</td>
							</tr>
							<tr>
								<td>AdMob</td>
								<td>1.3</td>
								<td>Google's mobile advertising network.</td>
							</tr>
							<tr>
								<td>Appcelerator Titanium</td>
								<td>3.2.2</td>
								<td></td>
							</tr>
						</table>
						List of FIPS Libraries and the algorithms/modules used:
						<table>
							<tr>
								<th>FIPS Library</th>
								<th>Version</th>
								<th>Algorithms/modules</th>
							</tr>
							<tr><td>Samsung Kernel Cryptographic Module</td><td>SKC1.6</td><td>AES, ECDSA</td></tr>
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
						<p>The application shall not download, modify, replace or update its own binary code.</p>
						<p><b>Application Note:</b> This requirement applies to the code of the application; it does not apply to mobile code technologies that are designed for download and execution by the application.</p>
						<table>
							<tr>
								<th>Executable File Changed</th>
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


					<div class="reqelementtitle">
						<span class="reqelementtitletext">Discussion Area</span>
					</div>
					<table class="results">
						<tr>
							<th rowspan="2">Category</th>
							<th colspan="3">Status</th>
							<th rowspan="2">Criteria</th>
							<th rowspan="2">Analysis</th>
						</tr>
						<tr><td style="background:#9BBB59;"><div><i>Passed</i></div></td><td style="background:#C0504D;"><div><i>Failed</i></div></td><td style="background:#959595;"><div><i>Not Tested</i></div></td></tr>
						<tr>
							<td>Permissions</td>
							<xsl:call-template name="status">
								<xsl:with-param name="status">
									<xsl:value-of select="/rr:report/rr:testresults/rr:permissions/rr:req[@ref='fdp_dec_ext.1.2']/rr:status"/>
								</xsl:with-param>
							</xsl:call-template>
							<td>
								The application notifies the user of any access to other applications.<ul><li>List any Failure of notification of any access to other applications or information repositories</li><li>List any Successful notification of any access to other applications or information repositories</li></ul>
							</td>
							<td>This is dependent upon the underlying platform's semantics for sharing data between applications.
							</td>
						</tr>
						<tr>
							<td rowspan="6">
								<b>Storing Data</b>
							</td>
						</tr>
						<tr>
							<td class="pass"></td>
							<td class="fail"></td>
							<td class="notTested"></td>
							<td>
								Does the application write data to persistent memory accessible to other applications?<ul><li>List the shared file locations where the application write data to persistent memory</li></ul>
							</td>
							<td>This is handled by File Permissions - FMT_CFG_EXT.1.2.
							</td>
						</tr>
						<tr>
							<td class="pass"></td>
							<td class="fail"></td>
							<td class="notTested"></td>
							<td>
								Encryptes sensitive data (including credentials) stored off the device (e.g., removable media, Cloud Storage, Remote Access Sessions, etc.).
							</td>
							<td>
							</td>
						</tr>
						<tr>
							<td class="pass"></td>
							<td class="fail"></td>
							<td class="notTested"></td>
							<td>
								Sensitive data stored off the device is encrypted with FIPS 140-2 validated algorithms/modules.<ul><li>List encryption algorithms/modules used to encrypt data stored off the device</li></ul>
							</td>
							<td>This is out of scope.
							</td>
						</tr>
						<tr>
							<td class="pass"></td>
							<td class="fail"></td>
							<td class="notTested"></td>
							<td>
								Cloud storage used by App is explicitly
								referenced and complies with FedRAMP
								certification<ul><li>List Cloud storage
								provider(s)</li></ul>
							</td>
							<td>
							    
							</td>
						</tr>
						<tr>
							<td class="pass"></td>
							<td class="fail"></td>
							<td class="notTested"></td>
							<td>
								The app removes temporary files when it is closed or removed.
							</td>
							<td>Removing all temporarily files when the application is removed is actually a requirement on the mobile platform.
							Also, mobile platforms quite literally save the
							entire application state when the application is
							closed -- this is how apps resume when they are
							started back up.
							</td>
						</tr>
						<tr>
							<td rowspan="4">
								<b>Transmitting Data</b>
							</td>
						</tr>
						<tr>
							<td class="pass"></td>
							<td class="fail"></td>
							<td class="notTested"></td>
							<td>
								The app verifies destination before transmitting data. <p>If the app fails this test, provide information on how it fails (i.e. certificate is not signed by a trusted CA or certificate is expired)</p>
							</td>
							<td>This is part of TLS connection setup.  This could be reworked into "Protecting Data in Transit".
							</td>
						</tr>
						<tr>
							<td class="pass"></td>
							<td class="fail"></td>
							<td class="notTested"></td>
							<td>
								Does the behavior of encryption in transit change over different methods of communication? (i.e. Wi-Fi communications are encrypted but Cellular communications are not)<ul><li>List which communication channels were tested</li><li>If the app fails this test, provide information on how it fails</li></ul>
							</td>
							<td>This would be very odd/unlikely behavior.  Most apps are entirely unaware of the underlying transport, by design.
							</td>
						</tr>
						<tr>
							<td class="pass"></td>
							<td class="fail"></td>
							<td class="notTested"></td>
							<td>
								Does the app perform certificate pinning?
							</td>
							<td>Do we have a specific use case, for where we want to require this?  If not, it's hard to demand it generally.
							</td>
						</tr>
						<tr>
							<td rowspan="3">
								<b>Authentication</b>
							</td>
							<td class="pass"></td>
							<td class="fail"></td>
							<td class="notTested"></td>
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
							<td>Exact LOA depends upon what the underlying platform is using for storage --- embedded hardware token, 
							UICC, SDcard, software module, hardware-backed storage.  This will vary by platform (indeed, by platform version) 
							and so it cannot be determined during app vetting.  
							</td>
						</tr>
						<tr>
							<td class="pass"></td>
							<td class="fail"></td>
							<td class="notTested"></td>
							<td>
								Requires authentication to store sensitive data on the mobile device
							</td>
							<td>This is handled by platform settings.  Apps cannot generally query whether the platform has password-protection enabled.
							</td>
						</tr>
						<tr>
							<td class="pass"></td>
							<td class="fail"></td>
							<td class="notTested"></td>
							<td>
								Does not store hard-coded credentials<ul><li>List the hard-coded credentials</li><li>Describe what the hard-coded credentials are used for</li></ul>
							</td>
							<td>
								This could be part of FMT_CFG_EXT.1.1.
							</td>
						</tr>
						<tr>
							<td rowspan="2">
								<b>Privacy</b>
							</td>
						</tr>
						<tr>
							<td class="pass"></td>
							<td class="fail"></td>
							<td class="notTested"></td>
							<td>
								Provide a list of advertising networks accessed by the mobile application
							</td>
							<td>Handle in analysis portions of network connections and 3rd-party libraries.
							</td>
						</tr>
						<tr>
							<td rowspan="3">
								<b>Source Code Analysis/Programming Logic</b>
							</td>
						</tr>
						<tr>
							<td class="pass"></td>
							<td class="fail"></td>
							<td class="notTested"></td>
							<td>
								Does the App come with a crash reporting capability? (i.e. Does the app use something similar to Crashlytics)<ul><li>List crash reporting tool(s) used by the App</li><li>List remote locations where crash logs are sent</li></ul>
							</td>
							<td>Isn't the actual security goal to ensure that 3rd-party libraries are inventoried, and that files/logs do not
							contain sensitive information?
							</td>
						</tr>
						<tr>
							<td class="pass"></td>
							<td class="fail"></td>
							<td class="notTested"></td>
							<td>
								Code components can be scanned
							</td>
							<td>Something about AVA_VAN.1.1C.
							</td>
						</tr>
						<tr>
							<td>
								<b>Resource Use</b>
							</td>
							<td class="pass"></td>
							<td class="fail"></td>
							<td class="notTested"></td>
							<td>The application uses resources aligned with its stated function<ul><li>List resources tested</li><li>Describe how the Application failed to comply with this requirement</li></ul></td>
							<td></td>
						</tr>
						<tr>
							<td rowspan="3">
								<b>Audit/Logging</b>
							</td>
							<td class="pass"></td>
							<td class="fail"></td>
							<td class="notTested"></td>
							<td>Audit logs capture security information</td>
							<td>This is extremely difficult to define.</td>
						</tr>
						<tr>
							<td class="pass"></td>
							<td class="fail"></td>
							<td class="notTested"></td>
							<td>
								Audit logs containing sensitive information are encrypted
							</td>
							<td>This can be put as part of analysis under Sensitive Application Data FDP_DAR_EXT.1.1.
							</td>
						</tr>
						<tr>
							<td class="pass"></td>
							<td class="fail"></td>
							<td class="notTested"></td>
							<td>
								The Application does not log location information<p>List location information that is logged</p>
							</td>
							<td>This can be put as part of analysis under Sensitive Application Data FDP_DAR_EXT.1.1.
							</td>
						</tr>
					</table>
				

			</body>
		</html>
	</xsl:template>


	<xsl:template match="rr:results">
		<table class="results">
			<tr>
				<th colspan="3">Determination</th>
				<th rowspan="2">Requirement</th>
				<th rowspan="2">Analysis</th>
			</tr>

			<tr style="font-size:small; font-weight:bold; text-align:center;"><td style="background:#9BBB59;"><div><i>Passed</i></div></td><td style="background:#C0504D;"><div><i>Failed</i></div></td><td style="background:#959595;"><div><i>Not Tested</i></div></td></tr>
			<xsl:for-each select="rr:result">
			<tr>
				<xsl:call-template name="status">
					<xsl:with-param name="status">
						<xsl:value-of select="rr:status"/>
					</xsl:with-param>
				</xsl:call-template>
				<td><xsl:value-of select="rr:analysis"/></td>
				<td><xsl:value-of select="rr:notes"/></td>
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
		<td><xsl:value-of select="rr:name"/></td>
		<td><xsl:value-of select="rr:description"/></td>
		<td><xsl:value-of select="rr:note"/></td>
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
	
	<xsl:template name="status">
		<xsl:param name="status"/>
		<xsl:choose>
			<xsl:when test="$status='Passed'" >
				<td class="pass">
					&#10004;
				</td>
				<td class="fail"/>
				<td class="notTested"/>
			</xsl:when>
			<xsl:when test="'Failed' = $status">
				<td class="pass"/>
				<td class="fail">
					&#10004;
				</td>
				<td class="notTested"/>
			</xsl:when>
			<xsl:otherwise>
				<td class="pass"/>
				<td class="fail"/>
				<td class="notTested">
					&#10004;
				</td>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
</xsl:stylesheet>
