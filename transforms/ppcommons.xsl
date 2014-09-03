<xsl:stylesheet version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:cc="http://common-criteria.rhcloud.com/ns/cc"
		xmlns:xhtml="http://www.w3.org/1999/xhtml">

  <xsl:key name="abbr" match="cc:glossary/cc:entry/cc:term/cc:abbr" use="text()" />
  
  <xsl:variable name="lower" select="'abcdefghijklmnopqrstuvwxyz'" />
  <xsl:variable name="upper" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />

  <xsl:template name="OSabbrev2name">
    <xsl:param name="osname" />
    <xsl:choose>
      <xsl:when test="$osname='windows'">Windows</xsl:when>
      <xsl:when test="$osname='blackberry'">BlackBerry</xsl:when>
      <xsl:when test="$osname='ios'">iOS</xsl:when>
      <xsl:when test="$osname='android'">Android</xsl:when>
      <xsl:when test="$osname='linux'">Linux</xsl:when>
      <xsl:when test="$osname='OS X'">Mac OS X</xsl:when>
      <xsl:when test="$osname='z/OS'">z/OS</xsl:when>
      <xsl:when test="$osname='Solaris'">Solaris</xsl:when>
      <xsl:otherwise>
	Undefined operating system platform
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


  <xsl:template match="cc:reqref">
    <xsl:variable name="linkend" select="translate(@linkend,$lower,$upper)" />
    <xsl:element name="a">
      <xsl:attribute name="href">
        <xsl:text>#</xsl:text>
        <xsl:value-of select="$linkend" />
      </xsl:attribute>
	  <xsl:value-of select="$linkend" />
	  </xsl:element>
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

  <xsl:template match="cc:abbr[@linkend]">
    <xsl:variable name="target" select="key('abbr', @linkend)" />
    <xsl:variable name="abbr" select="$target/text()" />
    
    <a class="abbr" href="#abbr_{$abbr}"><abbr title="{$target/@title}"><xsl:value-of select="$abbr" /></abbr></a>
  </xsl:template>

  <xsl:template match="cc:selectables">
    [<b>selection</b><xsl:if test="@exclusive">, choose one of</xsl:if><xsl:if test="@atleastone">, at least one of</xsl:if>: <xsl:for-each select="cc:selectable"><xsl:choose><xsl:when test="../@linebreak"><p style="margin-left: 40px;"><i><xsl:apply-templates /></i><xsl:if test="position() != last()"><xsl:text>, </xsl:text></xsl:if></p></xsl:when><xsl:otherwise><i><xsl:apply-templates /></i><xsl:if test="position() != last()"><xsl:text>, </xsl:text></xsl:if></xsl:otherwise></xsl:choose></xsl:for-each>]
  </xsl:template>
  <xsl:template match="cc:assignable">
    [<b>assignment</b>: <xsl:apply-templates />]
  </xsl:template>

  <xsl:template match="cc:note[@role='application']">
    <div class="appnote">
      <b>Application Note: </b>
      <xsl:apply-templates />
    </div>
  </xsl:template>

  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()" />
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>
