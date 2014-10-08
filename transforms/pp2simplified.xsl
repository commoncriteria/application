<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<xsl:stylesheet version="1.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
xmlns:cc="http://common-criteria.rhcloud.com/ns/cc"
xmlns:dc="http://purl.org/dc/elements/1.1/" 
xmlns:xhtml="http://www.w3.org/1999/xhtml">

<!-- This style sheet takes as input a Protection Profile expressed in XML and
	outputs a table of the SFRs and SARs. -->
	

  <!-- Put all common templates into ProtectionProfileCommons -->
  <!-- They can be redefined/overridden  -->
  <xsl:include href="ppcommons.xsl"/>

  <xsl:template match="/">
    <html>
      <style type="text/css">
        table
        {
            border-collapse:collapse;
        }
        table, th, td
        {
            border: 2px solid #dcdcdc;
            border-left: none;
            border-right: none;
            vertical-align: top;
            padding: 2px;
            font-family: verdana,arial,sans-serif;
            font-size:14px;
        }
        td.indented
        {
            padding-left: 100px;
            padding-right: 150px;
        }
        pre {
            white-space: pre-wrap;
            white-space: -moz-pre-wrap !important;
            word-wrap:break-word;
        }
        /*table tr:nth-child(2n+2) { background-color: #f4f4f4; }*/
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
			<!--border-bottom: solid 1px gray; -->
			margin-left: 8%; margin-right: 8%; 
		}
		div.intro
		{ 
			text-align: left; font-size: normal; 
            font-family: verdana,arial,sans-serif;
			margin-left: 12%; margin-right: 12%; 
			padding-top: 1em;
		}
		div.tabletitle, div.componenttitle
		{ 
			text-align: left; font-size: x-large; font-weight:bold;
            font-family: verdana,arial,sans-serif;
			margin-top: 3em;
			border-top: solid 2px gray; 
			border-bottom: solid 2px gray; 
			padding-bottom: 0.25em; padding-top: 0.25em; }

		div.componenttitle
		{ 
            background-color: #dedede;
		}
	    div.appnote    { margin-left: 0%; margin-top: 1em; }
		td.tabletitle
		{ 
			text-align: left; font-size: x-large; font-weight:bold;
            font-family: verdana,arial,sans-serif;
			margin-top: 6em;
			border-top: solid 2px gray; 
			border-bottom: solid 2px gray; 
			padding-bottom: 0.25em; padding-top: 1.25em;
		}
		td.element, td.elementid
		{ 
			padding-top: 1em;
			padding-bottom: 2em;
			padding-right: 1em;
		}
		td.elementid
		{ 
			font-weight: bold;
            font-family: verdana,arial,sans-serif;
		}
		a.abbr:link {color:black; text-decoration:none;}
		a.abbr:visited {color:black; text-decoration:none;}
		a.abbr:hover {color:blue; text-decoration:none;}
		a.abbr:hover:visited {color:purple; text-decoration:none;}
		a.abbr:active {color:red; text-decoration:none;}

    	</style>

		<head>
			<title>Requirements from the Protection Profile for Application Software</title>
		</head>
		<body>
			<br/>
			<br/>
			<div class="title">
			Requirements from the <br/><i>Protection Profile for Application Software</i>
			</div>
			<div class="intro">
			This document presents the functional and assurance elements from the 
			Protection Profile.  These are grouped into component areas and each 
			features related requirements.
			Each component area addresses particular threats.
			This representation is provided for audiences whose interest lies in 
			the requirements from the Protection Profile and their use
			outside formal Common Criteria evaluation for IA and IA-enabled products.
			The Protection Profile itself remains the
			only complete and authoritative representation, and includes 
			discussion of assumptions, threats, and objectives.
			</div>
			<br/>

			<xsl:apply-templates select="//cc:f-component[not(@status='sel-based')]"/>

		</body>
		</html>
	</xsl:template>

	<xsl:template match="cc:f-component">

		<div class="componenttitle"><xsl:value-of select="@name"/> </div>
		<table>
		<xsl:apply-templates select=".//cc:f-element"/>
		</table>
	</xsl:template>

	<xsl:template match="cc:f-element | cc:a-element">
		<tr>
		    <td class="elementid"><xsl:value-of select="translate(@id, $lower, $upper)"/></td>
			<td class="element"><xsl:apply-templates select="cc:title"/><br/>
				 <xsl:choose>
				 <xsl:when test="@status='objective'">
       		        <p/><i><b>This is currently an objective requirement.
					<xsl:if test="@targetdate">It is targeted for <xsl:value-of select="@targetdate"/>.</xsl:if></b></i>
					<br/>
         		 </xsl:when>
       		     <xsl:when test="@status='sel-based'">
        		     <p/><b><i>This is a selection-based requirement.
					 Its inclusion depends upon selection in 
					<xsl:for-each select="cc:selection-depends">
        				<xsl:value-of select="translate(@req, $lower, $upper)" />
						<xsl:if test="position() != last()"><xsl:text>, </xsl:text></xsl:if>
					</xsl:for-each>.
			 		</i></b>
					<br/>
					<br/>
         		 </xsl:when>
				 </xsl:choose>

				<xsl:apply-templates select="cc:note[@role='application']"/>
			</td>
		</tr>
	</xsl:template>

	<xsl:template match="cc:title">
	      		<xsl:apply-templates />
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
