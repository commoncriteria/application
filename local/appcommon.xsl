<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:cc="https://niap-ccevs.org/cc/v1"
  xmlns="http://www.w3.org/1999/xhtml"
  xmlns:htm="http://www.w3.org/1999/xhtml"  
  version="1.0">


  <xsl:template name="OSabbrev2name">
    <xsl:param name="osname"/>
    <xsl:choose>
      <xsl:when test="$osname='windows'">Windows</xsl:when>
      <xsl:when test="$osname='blackberry'">BlackBerry</xsl:when>
      <xsl:when test="$osname='ios'">iOS</xsl:when>
      <xsl:when test="$osname='android'">Android</xsl:when>
      <xsl:when test="$osname='linux'">Linux</xsl:when>
      <xsl:when test="$osname='OS X'">macOS X</xsl:when>
      <xsl:when test="$osname='z/OS'">z/OS</xsl:when>
      <xsl:when test="$osname='Solaris'">Solaris</xsl:when>
      <xsl:when test="$osname='other'">All Other Platforms</xsl:when>
      <xsl:otherwise> Undefined operating system platform </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


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
