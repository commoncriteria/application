<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<xsl:stylesheet version="1.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
xmlns:cc="http://common-criteria.rhcloud.com/ns/cc"
xmlns:dc="http://purl.org/dc/elements/1.1/" 
xmlns:xhtml="http://www.w3.org/1999/xhtml">

<!-- This style sheet takes as input a Protection Profile expressed in XML and
	outputs a table of the SFRs and SARs. -->
	
  <xsl:key name="abbr" match="cc:glossary/cc:entry/cc:term/cc:abbr" use="text()" />

  <xsl:variable name="lower" select="'abcdefghijklmnopqrstuvwxyz'" />
  <xsl:variable name="upper" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />

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
            font-size:11px;
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
		div.tabletitle
		{ 
			text-align: left; font-size: x-large; font-weight:bold;
            font-family: verdana,arial,sans-serif;
			margin-top: 2em;
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
			<title>Tabular Presentation of the <xsl:value-of select="/cc:PP/cc:PPReference/cc:ReferenceTable/cc:PPTitle" /></title>
		</head>
		<body>
			<br/>
			<br/>
			<div class="title">
			Tabular Presentation of the <br/><i><xsl:value-of select="/cc:PP/cc:PPReference/cc:ReferenceTable/cc:PPTitle" /></i>
			</div>
			<div class="intro">
			This document presents the Security Functional Requirements and 
			Security Assurance Requirements from the  
			<i><xsl:value-of select="/cc:PP/cc:PPReference/cc:ReferenceTable/cc:PPTitle"/></i>.
			This tabular representation is provided for those audiences whose interest primarily 
			lies in those portions of that document.  The Protection Profile itself remains the
			only complete and authoritative representation, and includes 
			discussion of assumptions, threats, and objectives.
			</div>
			<br/>

			<div class="tabletitle">
			Security Functional Requirements
			</div>
			<table>
				<thead>
					<td>ID</td>
					<td>Requirement</td>
					<td>Assurance Activity</td>
				</thead>
	
				<xsl:apply-templates select="//cc:f-element"/>
			</table>

			<div class="tabletitle">
			Security Assurance Requirements
			</div>

			<table>
				<thead>
					<td>ID</td>
					<td>Requirement</td>
					<td>Assurance Activity</td>
				</thead>
	
				<xsl:apply-templates select="//cc:a-element"/>
			</table>
		</body>
		</html>
	</xsl:template>


	<xsl:template match="cc:f-element | cc:a-element">
		<tr>
			<td><xsl:value-of select="translate(@id,$lower,$upper)"/></td> 
			<td><xsl:apply-templates select="cc:title"/><br/>
				 <xsl:choose>
				 <xsl:when test="@status='objective'">
       		        <br/><i><b>This is currently an objective requirement.
					<xsl:if test="@targetdate">It is targeted for <xsl:value-of select="@targetdate"/>.</xsl:if></b></i>
					<br/>
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


	<xsl:template match="cc:note[@role='application']">
				<br/>
				<b>Application Note: </b>
	      		<xsl:apply-templates />
	</xsl:template>

 <xsl:template match="cc:assignment">
		[<b>assignment:</b><xsl:value-of select="text()" />]
	</xsl:template>
  <xsl:template match="cc:component">
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


  <xsl:template match="cc:selectables">
		[<b>selection</b><xsl:if test="@exclusiv">, choose one of</xsl:if><xsl:if test="@atleastone">, at least one of</xsl:if>
		:
        <xsl:for-each select="cc:selectable"><xsl:choose><xsl:when test="../@linebreak"><p style="margin-left: 40px;"><i><xsl:apply-templates /></i><xsl:if test="position() != last()"><xsl:text>, </xsl:text></xsl:if></p></xsl:when><xsl:otherwise><i><xsl:apply-templates /></i><xsl:if test="position() != last()"><xsl:text>, </xsl:text></xsl:if></xsl:otherwise></xsl:choose></xsl:for-each>]
	</xsl:template>

  <xsl:template match="cc:assignment">
		[<b>assignment:</b><xsl:value-of select="text()" />]
	</xsl:template>
  <xsl:template match="cc:component">
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

  <xsl:template match="cc:testlist">
    <ul>
      <xsl:for-each select="cc:test">
        <li>
          <b>Test <xsl:value-of select="position()" />: </b>
          <xsl:apply-templates />
        </li>
      </xsl:for-each>
    </ul>
  </xsl:template>


  <xsl:template match="cc:aactivity">
    <xsl:variable name="aactID" select="concat('aactID-', generate-id())" />
    <div class="expandstyle">
      <a href="javascript:toggle('{$aactID}', 'link-{$aactID}');">
        <span class="expandstyle"> Assurance Activity </span>
        <img style="vertical-align:middle" id="link-{$aactID}" src="images/collapsed.png" height="15" width="15" />
      </a>
    </div>
    <div class="aacthidden" id="{$aactID}">
      <i>
        <xsl:apply-templates />
      </i>
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

  <xsl:template name="OSabbrev2name">
    <xsl:param name="osname" />
    <xsl:choose>
      <xsl:when test="$osname='windows'">Windows</xsl:when>
      <xsl:when test="$osname='blackberry'">BlackBerry</xsl:when>
      <xsl:when test="$osname='ios'">Apple iOS</xsl:when>
      <xsl:when test="$osname='android'">Android</xsl:when>
      <xsl:when test="$osname='selinux'">SELinux</xsl:when>
      <xsl:otherwise>
    Undefined operating system platform
  </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

	<!-- getting rid of XHTML namespace -->
	<xsl:template match="xhtml:*">
		<xsl:element name="{local-name()}">
 			<xsl:apply-templates select="node()|@*"/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="cc:aactivity">
		<xsl:apply-templates select="@*|node()" />
	</xsl:template>
	
	<xsl:template match="cc:abbr[@linkend]">
		<xsl:variable name="target" select="key('abbr', @linkend)" />
		<xsl:variable name="abbr" select="$target/text()" />
		
		<a class="abbr" href="#abbr_{$abbr}"><abbr title="{$target/@title}"><xsl:value-of select="$abbr" /></abbr></a>
	</xsl:template>

</xsl:stylesheet>
