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
		td.element, td.elementidstyle
		{ 
			padding-top: 1em;
			padding-bottom: 2em;
			padding-right: 1em;
		}
		td.elementidstyle
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
			Requirements from the 
			<br/><i>Protection Profile for Application Software</i>
			<br/>for Vetting Mobile Apps outside Common Criteria
			</div>
			<div class="intro">
			This document presents functional and assurance requirements from the 
			<i>Protection Profile for Application Software</i> which are appropriate for vetting
			mobile application software ("apps") outside formal Common Criteria (ISO/IEC 15408) evaluations.
			Common Criteria evaluation, facilitated in the U.S. by the National Information Assurance 
			Partnership (NIAP), is required for IA and IA-enabled products
			in National Security Systems according to CNSS Policy #11.  However, even apps without IA
			functionality may impose some security risks, and concern about these risks has motivated
			the vetting of such apps in government and industry.  
			<p/>In addition to providing security requirements for vetting
			apps, this document provides a basis for discussion and consideration
			of the vetting provided by commercially-available app stores.  
			This document does not imply to Authorizing Officials that the vetting provided by 
			commercially-available app stores is either adequate or inadequate for the context in which they
			must weigh risks.  Rather, it is intended to help inform their decision-making with regard to
			investment in app vetting processes.
			<p/>
			This representation of the Protection Profile includes all of its <i>Security Functional Requirements</i>,
			but excludes certain <i>Security Assurance Requirements</i> such as Functional Specification, 
			Operational User Guidance, Configuration Management Coverage, and Preparative Procedures.
			These assurance requirements were excluded because they are only likely to be provided by
			a cooperative developer who has chosen to pursue formal Common Criteria certification, and insisting upon
			them is not likely to be feasible in other evaluation scenarios.
			</div>
			<br/>

			<div class="tabletitle">
				Security Functional Requirements
			</div>
			<table>
			<xsl:apply-templates select="//cc:f-element[not(@status)]"/>
			</table>
			<!-- <xsl:apply-templates select="//cc:f-component[not(@status='sel-based')]"/> -->

			<div class="tabletitle">
				Security Assurance Requirements
			</div>
			<table>
			<xsl:apply-templates select="//cc:a-element[not(../@id='adv_fsp.1') and not(../@id='agd_pre.1') and not(../@id='alc_cms.1') and not(../@id='agd_ope.1') and not(../@id='alc_tsu_ext.1')]"/>
			</table>
	
			<div class="tabletitle">
				Selection-Based Security Functional Requirements
			</div>
			<table>
			<xsl:apply-templates select="//cc:f-element[@status='sel-based']"/>
			</table>


			<div class="tabletitle">
				Objective Security Functional Requirements
			</div>
			<table>
			<xsl:apply-templates select="//cc:f-element[@status='objective']"/>
			</table>

			<div class="tabletitle">
				Optional Security Functional Requirements
			</div>
			<table>
			<xsl:apply-templates select="//cc:f-element[@status='optional']"/>
			</table>

		</body>
		</html>
	</xsl:template>

	<xsl:template match="cc:f-component | cc:a-component">
		<xsl:variable name="componentid" select="translate(@id,$lower,$upper)" />	
		<div id="{$componentid}" class="componenttitle"><a class="abbr" href="#{$componentid}"><xsl:value-of select="@name"/></a></div>
		<table>
		<xsl:apply-templates select=".//cc:f-element | .//cc:a-element"/>
		</table>
	</xsl:template>

	<xsl:template match="cc:f-element | cc:a-element">
		<xsl:variable name="elementid" select="translate(@id,$lower,$upper)" />	
		<tr>
		    <td id="{$elementid}" class="elementidstyle"><a class="abbr" href="#{$elementid}"><xsl:value-of select="$elementid"/></a></td>
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
