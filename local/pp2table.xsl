<?xml version="1.0"?>
<!-- 
    Stylesheet for Protection Profile Schema  
    Based on original work by Dennis Orth
    Subsequent modifications in support of US NIAP
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:cc="http://niap-ccevs.org/cc/v1"
  xmlns="http://www.w3.org/1999/xhtml"
  xmlns:htm="http://www.w3.org/1999/xhtml"  
  version="1.0">

  <xsl:import href="../transforms/pp2table.xsl"/>

  <xsl:import href="appcommon.xsl"/>

  <!-- release variable, overridden to "final" for release versions -->
  <xsl:param name="release" select="'draft'"/>

  <xsl:param name="appendicize" select="''"/>


  <!-- very important, for special characters and umlauts iso8859-1-->
  <xsl:output method="html" encoding="UTF-8" indent="yes"/>


  <xsl:template match="cc:subaactivity">
    <div class="subaact">
      <i>
        <b>For <xsl:call-template name="OSabbrev2name"><xsl:with-param name="osname"
              select="@platform"/></xsl:call-template>: </b>
      </i>
      <xsl:apply-templates/>
    </div>
  </xsl:template>


</xsl:stylesheet>
