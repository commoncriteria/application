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

	<xsl:template match="/rr:results">
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
             border-bottom: 3px solid gray; padding: 8px 8px; text-align:left; font-weight: bold;
        } 
        table, th, td
        {
            border-collapse: collapse; 
            border: 2px solid #dcdcdc;
            border-left: none;
            border-right: none;
            vertical-align: top;
            text-align: left;
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
			<xsl:value-of select="/rr:results/rr:identifier/rr:name" /></title>
		</head>
		<body>
		<h1 class="title">App Vetting Reciprocity Report</h1>

		<div class="reqelement" style="margin-left:25%; margin-right:25%; ">
		<div class="reqelementtitle" >
		  <span class="reqelementtitletext">App Identification</span>
		  <span class="reqelementtitleppref">
		  <a class="ppreflink" href="https://www.niap-ccevs.org/pp/pp_app_v1.1_table.htm#ALC_CMC.1.1C">ALC_CMC.1</a></span>
		</div>
		<p/>
		<table>
		<tr>
		<td><b>Name</b></td>
		<td><xsl:value-of select="/rr:results/rr:identifier/rr:name" /></td>
		</tr>
		<tr>
		<td><b>Description</b></td>
		<td><xsl:value-of select="/rr:results/rr:identifier/rr:description" /></td>
		</tr>
		<tr>
		<td><b>Software Identifier</b></td>
		<!-- insert SWID tags in here, should those become a thing -->
		<td><xsl:value-of select="/rr:results/rr:identifier/rr:packageidentification" /></td>
		</tr>
		<tr>
		<td><b>Version</b></td>
		<td><xsl:value-of select="/rr:results/rr:identifier/rr:version" /></td>
		</tr>
		<tr>
		<td><b>Vendor</b></td>
		<td>
		<xsl:value-of select="/rr:results/rr:identifier/rr:vendor/rr:name" /><p/>
		<xsl:value-of select="/rr:results/rr:identifier/rr:vendor/rr:address/rr:street1" /><p/>
		<xsl:value-of select="/rr:results/rr:identifier/rr:vendor/rr:address/rr:street2" /><p/>
		<xsl:value-of select="/rr:results/rr:identifier/rr:vendor/rr:address/rr:city" /><xsl:text>, </xsl:text>
		<xsl:value-of select="/rr:results/rr:identifier/rr:vendor/rr:address/rr:state" /><xsl:text> </xsl:text>
		<xsl:value-of select="/rr:results/rr:identifier/rr:vendor/rr:address/rr:postalcode"/><p/>
		<xsl:value-of select="/rr:results/rr:identifier/rr:vendor/rr:address/rr:country" />
		</td>
		</tr>
		<tr>
		<td><b>Test Platform</b></td>
		<td><xsl:apply-templates select="/rr:results/rr:identifier/rr:platform" /></td>
		</tr>
		</table>
		</div>
		
		<div class="sectiontitle">
		User Data Protection
		</div>

		<div class="reqelement">
		<div class="reqelementtitle">
		  <span class="reqelementtitletext">Access to Hardware Resources</span>
		  <span class="reqelementtitleppref">
		  <a class="ppreflink" href="https://www.niap-ccevs.org/pp/pp_app_v1.1_table.htm#FDP_DEC_EXT.1.1">FDP_DEC_EXT.1.1</a></span>
		</div>
		<table>
		<tr>
		<td><b>Network</b></td>
		<td class="checkboxon">X</td>
		</tr>
		<tr>
		<td><b>Camera</b></td>
		<td class="checkboxon"></td>
		</tr>
		<tr>
		<td><b>Microphone</b></td>
		<td class="checkboxon"></td>
		</tr>
		<tr>
		<td><b>Location Services</b></td>
		<td class="checkboxon"></td>
		</tr>
		<tr> <td><b>NFC</b></td>
		<td class="checkboxoff"> </td>
		</tr>
		<tr> <td><b>Bluetooth</b></td>
		<td class="checkboxoff"> </td>
		</tr>
		</table>
		</div>
		<div class="reqelement">
		<div class="reqelementtitle">
		  <span class="reqelementtitletext">Access to Sensitive Information Repositories</span>
		  <span class="reqelementtitleppref">
		  <a class="ppreflink" href="https://www.niap-ccevs.org/pp/pp_app_v1.1_table.htm#FDP_DEC_EXT.1.2">FDP_DEC_EXT.1.2</a></span>
		</div>
		<table>
		<tr>
		<td><b>Address Book</b></td>
		<td class="checkboxon">X</td>
		</tr>
		<tr>
		<td><b>Calendar</b></td>
		<td class="checkboxoff"> </td>
		</tr>
		<tr>
		<td><b>Photos</b></td>
		<td class="checkboxoff"></td>
		</tr>
		<tr>
		<td><b>Notes</b></td>
		<td class="checkboxon">X</td>
		</tr>
		</table>
		</div>

		<div class="reqelement">
		<div class="reqelementtitle">
		  <span class="reqelementtitletext">Justified Access to Resources</span>
		  <span class="reqelementtitleppref">
		  <a class="ppreflink" href="https://www.niap-ccevs.org/pp/pp_app_v1.1_table.htm#FDP_DEC_EXT.1.3">FDP_DEC_EXT.1.3</a></span>
		</div>
		<div class="bodytext">The app does not appear to need the Address Book permission, but all other permissions
		are within its expected function.
		</div>

		</div>


		<div class="reqelement">
		<div class="reqelementtitle">
		  <span class="reqelementtitletext">Network Communication</span>
		  <span class="reqelementtitleppref">
		  <a class="ppreflink" href="https://www.niap-ccevs.org/pp/pp_app_v1.1_table.htm#FDP_DEC_EXT.1.4">FDP_DEC_EXT.1.4</a></span>
		</div>
		<div class="bodytext">The app engages in communication with the following systems:
		</div>
		<table>
		<tr>
		<th><b>Host IP Address</b></th>
		<th><b>Port</b></th>
		<th><b>Hostname</b></th>
		<th><b>Whois Information</b></th>
		</tr>
		<xsl:for-each select="//rr:networkcomms/rr:connections">
			<xsl:for-each select="rr:host">

				<tr>
				<td><xsl:value-of select="rr:ipaddr"/></td>
				<td><xsl:value-of select="rr:port"/></td>
				<td><xsl:value-of select="rr:hostname"/></td>
				<td><xsl:value-of select="rr:whois"/></td>
				</tr>
			</xsl:for-each>
		</xsl:for-each>
		</table>
		</div>

		<div class="sectiontitle">Trusted Communication Path/Channels</div>
		<div class="reqelement">
		<div class="reqelementtitle">
		  <span class="reqelementtitletext">Network Communication</span>
		  <span class="reqelementtitleppref">
		  <a class="ppreflink" href="https://www.niap-ccevs.org/pp/pp_app_v1.1_table.htm#FDP_DEC_EXT.1.4">FDP_DEC_EXT.1.4</a></span>
		</div>
		<div class="bodytext">The app engages in communication with the following systems:
		</div>
		<table>
		<tr>
		<th><b>Host IP Address</b></th>
		<th><b>Port</b></th>
		<th><b>Hostname</b></th>
		<th><b>Whois Information</b></th>
		</tr>
		<xsl:for-each select="//rr:networkcomms/rr:connections">
			<xsl:for-each select="rr:host">

				<tr>
				<td><xsl:value-of select="rr:ipaddr"/></td>
				<td><xsl:value-of select="rr:port"/></td>
				<td><xsl:value-of select="rr:hostname"/></td>
				<td><xsl:value-of select="rr:whois"/></td>
				</tr>
			</xsl:for-each>
		</xsl:for-each>
		</table>
		</div>

		<div class="sectiontitle">Security Configuration and Management</div>
		<div class="reqelement">
		<div class="reqelementtitle">
		  <span class="reqelementtitletext">File Permissions</span>
		  <span class="reqelementtitleppref">
		  <a class="ppreflink" href="https://www.niap-ccevs.org/pp/pp_app_v1.1_table.htm#FMT_CFG_EXT.1.2">FMT_CFG_EXT.1.2</a></span>
		</div>
		<table>
		<tr>
		<th>File</th>
		<th>Permissions</th>
		<th>Notes</th>
		</tr>
		<xsl:for-each select="//rr:files">
			<xsl:for-each select="rr:file">

				<tr>
				<td><xsl:value-of select="rr:path"/></td>
				<td><xsl:value-of select="rr:permissions"/></td>
				<td><xsl:value-of select="rr:analysis/rr:note"/></td>
				</tr>
			</xsl:for-each>
		</xsl:for-each>
		</table>
		<div class="bodytext"><b>Analysis: </b> <xsl:value-of select="//rr:files/rr:analysis/rr:note"/>
		</div>
		</div>


		<div class="sectiontitle">Cryptographic Support</div>

		<div class="sectiontitle">Protection of Security Functionality and Integrity</div>

		<div class="reqelement">
		<div class="reqelementtitle">
		  <span class="reqelementtitletext">Third Party Libraries</span>
		  <span class="reqelementtitleppref">
		  <a class="ppreflink" href="https://www.niap-ccevs.org/pp/pp_app_v1.1_table.htm#FPT_LIB_EXT.1.1">FPT_LIB_EXT.1.1</a></span>
		</div>
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
		<div class="bodytext"><b>Analysis:</b> These libraries raise concerns about use of ad networks and out-of-date software.  
		</div>

		</div>

		
		<div class="reqelement">
		<div class="reqelementtitle">
		  <span class="reqelementtitletext">Untrusted Updates to Binary Code</span>
		  <span class="reqelementtitleppref">
		  <a class="ppreflink" href="https://www.niap-ccevs.org/pp/pp_app_v1.1_table.htm#FPT_TUD_EXT.1.4">FPT_TUD_EXT.1.4</a></span>
		</div>
		<table>
		<tr>
		<th>Executable File Changed</th>
		<th>Metadata</th>
		</tr>
		<xsl:for-each select="//rr:untrustedupdate">
			<xsl:for-each select="rr:file">
				<tr>
				<td><xsl:value-of select="rr:path"/></td>
				<td>
				<table>
				<tr><td style="text-align:right; font-weight: bold;">Old Hash:</td><td><xsl:value-of select="rr:originalfilehash"/></td></tr>
				<tr><td style="text-align:right; font-weight: bold;">New Hash:</td><td><xsl:value-of select="rr:newfilehash"/></td></tr>
				<tr><td style="text-align:right; font-weight: bold;">Source:</td><td><xsl:value-of select="rr:source"/></td></tr>
				</table>
				</td>
				</tr>
			</xsl:for-each>
		</xsl:for-each>
		</table>
		</div>


		</body>
		</html>
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


	<xsl:template match="cc:aactivity">
		<xsl:apply-templates select="@*|node()" />
	</xsl:template>
	

</xsl:stylesheet>
