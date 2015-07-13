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
			margin-left: 7em; 
			margin-right: 7em; 
            border-collapse: collapse;
            border: 2px solid #dcdcdc;
            border-left: none;
            border-right: none;
            vertical-align: top;
            text-align: left;
            padding: 2px;
            font-family: verdana,arial,sans-serif;
            font-size:11px;
            padding-right: 20px;
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
        div.appnote
        {
            margin-left: 0%; margin-top: 1em;
        }
        div.tabletitle
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
	a.abbr:link {color:black; text-decoration:none;}
	a.abbr:visited {color:black; text-decoration:none;}
	a.abbr:hover {color:blue; text-decoration:none;}
	a.abbr:hover:visited {color:purple; text-decoration:none;}
	a.abbr:active {color:red; text-decoration:none;}

    	</style>

		<head>
			<title>App Vetting Reciprocity Report for 
			<xsl:value-of select="/rr:results/rr:identifier/rr:name" /></title>
		</head>
		<body>
		<h1 class="title"> App Vetting Reciprocity Report </h1>

		<div class="tabletitle">App Information</div>
		<br/>
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
		<tr>
		<td><b>Software ID</b></td><td></td>
		</tr>
		</table>


			<div class="tabletitle">
			User Data Protection
			</div>
			<table>
			</table>

			<div class="tabletitle">
			Cryptographic Support
			</div>

			<table>
			</table>
			<div class="tabletitle">
			Trusted Communication Path/Channels
			</div>

			<table>
	
			</table>
			<div class="tabletitle">
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


  <xsl:template match="cc:f-component | cc:a-component">
    <xsl:variable name="family" select="substring(@id,1,7)" />
    <xsl:variable name="component" select="substring(@id,1,9)" />
    <xsl:variable name="SFRID" select="@id" />
    <div class="comp">
      <h4>
		 <xsl:value-of select="concat(translate(@id, $lower, $upper), ' ')" />
         <xsl:value-of select="@name" />
      </h4>
      <xsl:apply-templates />
    </div>
  </xsl:template>




  <xsl:template match="cc:subaactivity">
    <div class="subaact">
      <i>
        <b>For <xsl:call-template name="OSabbrev2name"><xsl:with-param name="osname" select="@platform" /></xsl:call-template>:
	  </b>
      </i>
      <xsl:apply-templates />
    </div>
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
