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
        table.revisionhistory
        {
             margin: auto; margin-top: 1em; border-collapse:collapse;
        }
        tr.header
        {
             border-bottom: 3px solid gray; padding: 8px 8px; text-align:left; font-weight: bold;
        } 
        table, th, td
        {
            /*border-collapse: collapse; */
            border: 2px solid #dcdcdc;
            border-left: none;
            border-right: none;
            vertical-align: top;
            text-align: left;
            padding: 2px;
            font-family: verdana,arial,sans-serif;
            font-size: normal;
            padding-right: 20px;
        }

		td.checkboxon
		{
		    background-color: darkgray;
			border: 3px solid black;
			padding: 3px 3px;
			border-spacing: 5px;
			width: 20px;
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
        div.intro
        {
            text-align: left; font-size: normal;
            font-family: verdana,arial,sans-serif;
            margin-left: 12%; margin-right: 12%;
            padding-top: 1em;
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

		<div class="sectiontitle">App Information</div>
		<div class="reqelement">
		<div class="reqelementtitle">
		  <span class="reqelementtitletext">App Identity</span>
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
		<td><b>Platform</b></td>
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
		  <a class="ppreflink" href="https://www.niap-ccevs.org/pp/pp_app_v1.1_table.htm#FDP_DEC_EXT.1.1">FDP_DEC.1.1</a></span>
		</div>
		<p/>
		<table>
		<tr>
		<td><b>Network</b></td>
		<td class="checkboxon"></td>
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
		  <a class="ppreflink" href="https://www.niap-ccevs.org/pp/pp_app_v1.1_table.htm#FDP_DEC_EXT.1.2">FDP_DEC.1.2</a></span>
		</div>
		<p/>
		<table>
		<tr>
		<td><b>Address Book</b></td>
		<td class="checkboxon"> </td>
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
		<td class="checkboxon"></td>
		</tr>
		</table>
		</div>
		<div class="sectiontitle">
		Cryptographic Support
		</div>

		<table>
		</table>
		<div class="sectiontitle">
		Trusted Communication Path/Channels
		</div>

		<table>
		</table>

		<div class="sectiontitle">
		Protection of Security Functionality and Integrity
		</div>

		<table>
		</table>
		</body>
		</html>
	</xsl:template>


	<xsl:template match="cc:f-element | cc:a-element">
		<xsl:variable name="reqid" select="translate(@id,$lower,$upper)"/>
		<xsl:variable name="componentid" select="translate(../@id,$lower,$upper)"/>
		<tr id="{$componentid}">
			<td id="{$reqid}"><a class="abbr" href="#{$reqid}"><xsl:value-of select="$reqid"/></a></td> 
			<td><xsl:apply-templates select="cc:title"/><br/>
				 <xsl:choose>
				 <xsl:when test="@status='objective'">
       		        <br/><i><b>This is currently an objective requirement.
					<xsl:if test="@targetdate">It is targeted for <xsl:value-of select="@targetdate"/>.</xsl:if></b></i>
					<br/>
         		 </xsl:when>
			<xsl:when test="../@status='optional'">
				<div class="statustag">
             			<p/><i><b>This is an optional requirement.  It may be required by Extended Packages of this Protection Profile.</b></i>
				</div>
          		</xsl:when>

       		     <xsl:when test="@status='sel-based'">
        		     <br/><b><i>This is a selection-based requirement.
					 Its inclusion depends upon selection in 
					<xsl:for-each select="cc:selection-depends">
        				<xsl:value-of select="translate(@req, $lower, $upper)" />
						<xsl:if test="position() != last()"><xsl:text>, </xsl:text></xsl:if>
					</xsl:for-each>.
			 		</i></b>
					<br/>
         		 </xsl:when>
				 </xsl:choose>

				<xsl:apply-templates select="cc:note[@role='application']"/>
			</td>
			<td><xsl:apply-templates select="cc:aactivity"/> </td>
		</tr>
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
