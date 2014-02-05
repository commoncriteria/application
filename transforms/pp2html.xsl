<?xml version="1.0"?>
<!-- 
    Stylesheet for Protection Profile Schema  
    Authors: Dennis Orth, Jeff Blank
    Version: 9 Jan 2014
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:htm="http://www.w3.org/1999/xhtml" xmlns:xhtml="http://www.w3.org/1999/xhtml" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:cc="http://secure.tuvit.de/schemata/" xmlns="http://www.w3.org/1999/xhtml" version="1.0">
  <!-- very important, for special characters and umlauts iso8859-1-->
  <xsl:output method="html" encoding="UTF-8" indent="yes"/>
  <!-- Variable contains the root element of the processed document -->
  <xsl:variable name="currentfile" select="current()"/>
  <!-- An XML representation of CC part 2, which has all of its SFRs. -->
  <xsl:variable name="ccfile" select="document('../input/cc.xml')"/>
  <xsl:variable name="lower" select="'abcdefghijklmnopqrstuvwxyz'"/>
  <xsl:variable name="upper" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'"/>
  <xsl:template match="/cc:PP">

    <html xmlns="http://www.w3.org/1999/xhtml">
      <head>
        <style type="text/css">
      /*       { background-color: #FFFFFF; } */
      body { margin-left: 8%; margin-right: 8%; foreground: black; }
      h1   { text-align: left; font-size: 200%;  margin-top: 2em; margin-bottom: 2em;
             font-family: verdana, arial, helvetica, sans-serif;
             margin-bottom: 1.0em; }
	  h1.title { text-align: center; }
      h2   { font-size: 125%;
             border-bottom: solid 1px gray; margin-bottom: 1.0em;
             margin-top: 2em; margin-bottom: 0.75em;
             font-family: verdana, arial, helvetica, sans-serif; }
      h3   { font-size: 110%; margin-bottom: 0.25em;
             font-family: verdana, arial, helvetica, sans-serif; }
      h4   { margin-left: 6%; font-size: 100%; margin-bottom: 0.75em;
             font-family: verdana, arial, helvetica, sans-serif; }
      h5,h6 { margin-left: 6%; font-size: 90%; margin-bottom: 0.5em;
              font-family: verdana, arial, helvetica, sans-serif; }
      p    { margin-bottom: 0.2em; margin-top: 0.2em; }
      pre  { margin-bottom: 0.5em; margin-top: 0.25em; margin-left: 3%;
             font-family: monospace; font-size: 90%; }
      ul   { margin-bottom: 0.5em; margin-top: 0.25em; }
      td   { vertical-align: top; }
      dl   { margin-bottom: 0.5em; margin-top: 0.25em; }
      dt   { margin-top: 0.7em; font-weight: bold; 
             font-family: verdana, arial, helvetica, sans-serif; }

      *.simpleText   { margin-left: 10%; }
      *.propertyText { margin-left: 10%; margin-top: 0.2em; margin-bottom: 0.2em }
      *.toc      { background: #FFFFFF; }
      *.toc2         { background: #FFFFFF; }
      div            { margin-top: 1em; margin-bottom: 1em; }
      div.req        { margin-left: 6%; margin-top: 1em; margin-bottom: 1em; }
      div.appnote    { margin-left: 0%; margin-top: 1em; margin-bottom: 1em; }
      div.aact       { margin-left: 6%; margin-top: 1em; margin-bottom: 1em; }
      div.toc        { margin-left: 6%; margin-bottom: 4em;
                       padding-bottom: 0.75em; padding-top: 1em;
                       padding-left: 2em; padding-right: 2em; }
      h2.toc         { border-bottom: none; margin-left: 0%; margin-top: 0em; }
      p.toc          { margin-left: 2em; margin-bottom: 0.2em; margin-top: 0.5em; }
      p.toc2         { margin-left: 5em; margin-bottom: 0.1em; margin-top: 0.1em; }
      table          { border-collapse:collapse; /*border: 1px solid black;*/ }
      table,th,td   { text-align: left; padding: 8px 8px; }
      table tr:nth-child(2n+2) { background-color: #F4F4F4; }
      th            { border-bottom: 3px solid gray; }
      div.center	{ display: block; margin-left: auto; margin-right: auto; text-align:center; }	
  </style>
      </head>
      <body>
        <xsl:apply-templates select="cc:content"/>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="cc:content">
    <h1 class="title">
      <xsl:value-of select="//cc:ReferenceTable/cc:PPTitle"/>
    </h1>
    <div class="center"><img src="images/niaplogodraft.png"/><p/>Version: <xsl:value-of select="//cc:ReferenceTable/cc:PPVersion"/><p/><xsl:value-of select="//cc:ReferenceTable/cc:PPPubDate"/><p/><xsl:value-of select="//cc:PPAuthor"/><!-- need image --></div>
    <h2>Revision History</h2>
    <table>
      <xsl:for-each select="cc:RevisionHistory/cc:entry">
        <tr>
          <td>
            <xsl:value-of select="cc:version"/>
          </td>
          <td>
            <xsl:value-of select="cc:date"/>
          </td>
          <td>
            <xsl:value-of select="cc:subject"/>
          </td>
        </tr>
      </xsl:for-each>
    </table>
    <!-- need table of contents generation -->
    <br/>
    <h2>Contents</h2>
    <div class="toc">
      <xsl:apply-templates mode="toc" select="./cc:chapter"/>
    </div>
    <!-- process each toplevel chapter -->
    <xsl:apply-templates select="//cc:content/cc:chapter"/>
  </xsl:template>

  <!-- Template for toc entries, for top 3 levels -->
  <xsl:template match="cc:chapter | cc:section | cc:class | cc:subsection" mode="toc">
    <xsl:param name="section-prefix"/>
    <xsl:param name="section-num" select="position()"/>
    <p xmlns="http://www.w3.org/1999/xhtml" class="toc2">
      <xsl:value-of select="$section-prefix"/>
      <xsl:value-of select="$section-num"/>
      <xsl:text>. </xsl:text>
      <a class="toc" href="#{@id}">
        <xsl:value-of select="@title"/>
      </a>
    </p>
    <xsl:if test="./cc:chapter | ./cc:section | ./cc:subsection">
      <xsl:apply-templates mode="toc" select="./cc:chapter | ./cc:section | ./cc:subsection">
        <xsl:with-param name="section-prefix" select="concat($section-prefix,$section-num,'.')"/>
      </xsl:apply-templates>
    </xsl:if>
  </xsl:template>

  <xsl:template match="cc:InsertGlossary">
    <!-- info handled in content template-->
    <table>
      <xsl:for-each select="//cc:glossary/cc:entry">
        <tr>
          <td>
            <xsl:value-of select="cc:term"/>
          </td>
          <td>
            <xsl:apply-templates select="cc:description"/>
          </td>
        </tr>
      </xsl:for-each>
    </table>
  </xsl:template>

  <xsl:template match="cc:InsertBibliography">
    <!-- info handled in content template-->
    <table>
      <xsl:for-each select="//cc:bibliography/cc:entry">
        <tr>
          <td>
            <xsl:element name="span">
              <xsl:attribute name="id">
                <xsl:value-of select="@id"/>
              </xsl:attribute>
              <xsl:value-of select="cc:tag"/>
            </xsl:element>
          </td>
          <td>
            <xsl:apply-templates select="cc:description"/>
          </td>
        </tr>
      </xsl:for-each>
    </table>
  </xsl:template>

  <xsl:template match="cc:ReferenceTable">
        PP-Title:<![CDATA[&]]><xsl:value-of select="cc:PPTitle"/>
        PP-Version:<![CDATA[&]]><xsl:value-of select="cc:PPVersion"/>
        PP-Author:<![CDATA[&]]><xsl:value-of select="cc:PPAuthor"/>
        PP-Puplication Date:<![CDATA[&]]><xsl:value-of select="cc:PPPubDate"/>   
        Certification-ID:<![CDATA[&]]><xsl:value-of select="cc:PPCertificationID"/>
        CC-Version:<![CDATA[&]]><xsl:value-of select="cc:CCVersion"/>
        Keywords:<![CDATA[&]]><xsl:value-of select="cc:Keywords"/>
        <xsl:for-each select="cc:entry"><xsl:value-of select="cc:name"/>:<![CDATA[&]]><xsl:value-of select="cc:description"/></xsl:for-each>
    </xsl:template>

  <xsl:template match="cc:ConformanceStatement"><h2>Conformance statement</h2>
        The PP requires <xsl:choose><xsl:when test="cc:strict">strict</xsl:when><xsl:when test="cc:demonstrable">demonstrable</xsl:when></xsl:choose> conformance of any PPs/STs to this PP.        
    </xsl:template>

  <xsl:template match="cc:AssumptionsPlacement">
    <dl>
      <xsl:for-each select="//cc:assumptions/child::node()/cc:description">
        <dt>
          <xsl:value-of select="../@id"/>
        </dt>
        <dd>
          <xsl:apply-templates/>
          <xsl:apply-templates select="../cc:appnote"/>
        </dd>
      </xsl:for-each>
    </dl>
  </xsl:template>

  <xsl:template match="cc:ThreatsPlacement">
    <dl>
      <xsl:for-each select="//cc:threats/cc:threat/cc:description">
        <dt>
          <xsl:value-of select="../@id"/>
        </dt>
        <dd>
          <xsl:apply-templates/>
          <xsl:apply-templates select="../cc:appnote"/>
        </dd>
      </xsl:for-each>
    </dl>
  </xsl:template>

  <xsl:template match="cc:OSPsPlacement">
    <dl>
      <xsl:for-each select="//cc:OSPs/cc:OSP/cc:description">
        <dt>
          <xsl:value-of select="../@id"/>
        </dt>
        <dd>
          <xsl:apply-templates/>
          <xsl:apply-templates select="../cc:appnote"/>
        </dd>
      </xsl:for-each>
    </dl>
  </xsl:template>

  <xsl:template match="cc:SOsPlacement">
    <dl>
      <xsl:for-each select="//cc:SOs/cc:SO">
        <dt>
          <xsl:value-of select="@id"/>
        </dt>
        <dd><xsl:apply-templates select="cc:description"/><p/>Achieved by:
			<xsl:for-each select="cc:component-refer"><xsl:value-of select="translate(@linkend,$lower,$upper)"/><xsl:if test="position() != last()"><xsl:text>, </xsl:text></xsl:if></xsl:for-each>
			<xsl:apply-templates select="cc:appnote"/>
			</dd>
      </xsl:for-each>
    </dl>
  </xsl:template>

  <xsl:template match="cc:SOEsPlacement">
    <dl>
      <xsl:for-each select="//cc:SOEs/cc:SOE/cc:description">
        <dt>
          <xsl:value-of select="../@id"/>
        </dt>
        <dd>
          <xsl:apply-templates/>
          <xsl:apply-templates select="../cc:appnote"/>
        </dd>
      </xsl:for-each>
    </dl>
  </xsl:template>

  <xsl:template match="cc:selection">
		[<b>selection</b>
		<xsl:if test="@exclusiv">, choose one of</xsl:if>:
        <xsl:for-each select="cc:selectionitem"><i><xsl:apply-templates/></i><xsl:if test="position() != last()"><xsl:text>, </xsl:text></xsl:if></xsl:for-each>]
	</xsl:template>

  <xsl:template match="cc:assignment">
		[<b>assignment:</b> <xsl:value-of select="text()"/>]
	</xsl:template>

  <xsl:template match="cc:component">
    <xsl:variable name="family" select="substring(@id,1,7)"/>
    <xsl:variable name="component" select="substring(@id,1,9)"/>
    <xsl:variable name="SFRID" select="@id"/>
    <xsl:choose>
      <xsl:when test="count(document('../input/cc.xml')//f-component[@id=$component]/@name)&gt;0">
        <!-- Component from CC standard -->
        <h4>
          <xsl:value-of select="translate(@id, $lower, $upper)"/>
          <xsl:text> </xsl:text>
          <xsl:value-of select="document('../input/cc.xml')/cc/f-class/f-family/f-component[@id=$component]/@name"/>
        </h4>
      </xsl:when>
      <xsl:otherwise>
        <!-- Is an extended Component -->
        <h4>
          <xsl:value-of select="translate(@id, $lower, $upper)"/>
          <xsl:text> </xsl:text>
          <xsl:value-of select="@name"/>
        </h4>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="cc:f-element">
    <div class="req">
      <xsl:value-of select="translate(@id, $lower, $upper)"/>
      <xsl:text> </xsl:text>
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <xsl:template match="cc:note[@role='application']">
    <div class="appnote">
      <b>Application Note: </b>
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <xsl:template match="cc:chapter">
    <xsl:variable name="chapter-num" select="concat(position(), '.')"/>
    <h1 id="{@id}">
      <xsl:value-of select="concat($chapter-num, ' ')"/>
      <xsl:value-of select="@title"/>
    </h1>
    <xsl:apply-templates>
      <xsl:with-param name="section-prefix" select="$chapter-num"/>
    </xsl:apply-templates>
  </xsl:template>

  <xsl:template match="cc:section">
    <xsl:param name="section-prefix"/>
    <xsl:variable name="section-num">
      <xsl:number/>
    </xsl:variable>
    <h2 id="{@id}">
      <xsl:value-of select="$section-prefix"/>
      <xsl:value-of select="concat($section-num,' ')"/>
      <xsl:value-of select="@title"/>
    </h2>
    <xsl:apply-templates>
      <xsl:with-param name="subsection-prefix" select="concat($section-prefix, $section-num, '.')"/>
    </xsl:apply-templates>
  </xsl:template>

  <xsl:template match="cc:subsection">
    <xsl:param name="subsection-prefix"/>
    <xsl:variable name="subsection-num">
      <xsl:number/>
    </xsl:variable>
    <h3 id="{@id}">
      <xsl:value-of select="$subsection-prefix"/>
      <xsl:value-of select="concat($subsection-num, ' ')"/>
      <xsl:value-of select="@title"/>
    </h3>
    <xsl:apply-templates>
      <xsl:with-param name="subsubsection-prefix" select="concat($subsection-prefix, $subsection-num, '.')"/>
    </xsl:apply-templates>
  </xsl:template>

  <xsl:template match="cc:subsubsection">
    <h4 id="{@id}">
      <xsl:value-of select="@title"/>
    </h4>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="cc:figure">
    <div class="center">
      <img>
        <xsl:attribute name="id">
          <xsl:value-of select="@id"/>
        </xsl:attribute>
        <xsl:attribute name="src">
          <xsl:value-of select="@entity"/>
        </xsl:attribute>
        <xsl:attribute name="width">
          <xsl:value-of select="@width"/>
        </xsl:attribute>
        <xsl:attribute name="height">
          <xsl:value-of select="@height"/>
        </xsl:attribute>
      </img>
      <p/>
      <b>
        <xsl:value-of select="@title"/>
      </b>
    </div>
  </xsl:template>

  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

  <!-- Assumes element with matching @id has a @title. -->
  <xsl:template match="cc:xref">
    <xsl:variable name="linkend" select="@linkend"/>
    <xsl:element name="a">
      <xsl:attribute name="href">
        <xsl:text>#</xsl:text>
        <xsl:value-of select="$linkend"/>
      </xsl:attribute>
      <xsl:value-of select="//*[@id=$linkend]/@title" />
    </xsl:element>
  </xsl:template>

  <xsl:template match="cc:cite">
    <xsl:variable name="linkend" select="@linkend"/>
    <xsl:element name="a">
      <xsl:attribute name="href">
        <xsl:text>#</xsl:text>
        <xsl:value-of select="$linkend"/>
      </xsl:attribute>
      <xsl:text>[</xsl:text>
      <xsl:value-of select="//cc:bibliography/cc:entry[@id=$linkend]/cc:tag" />
      <xsl:text>]</xsl:text>
    </xsl:element>
  </xsl:template>

</xsl:stylesheet>
